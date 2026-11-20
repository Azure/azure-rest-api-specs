import { ConsoleLogger } from "@azure-tools/specs-shared/logger";
import { getRootFolder } from "@azure-tools/specs-shared/simple-git";
import { findTypeSpecProjects } from "@azure-tools/specs-shared/typespec-projects";
import { getSuppressions } from "@azure-tools/suppressions";
import { spawn, type ChildProcess } from "node:child_process";
import { appendFile, stat } from "node:fs/promises";
import { relative, resolve } from "pathe";
import { fileURLToPath } from "node:url";
import pc from "picocolors";
import { simpleGit } from "simple-git";
import { formatRuleSummary, supportsColor, type RuleCounts } from "./diagnostics.ts";
import { findChangedProjects, type ChangedProjectsOptions } from "./find-projects.ts";

interface RunOptions {
  gitClean?: boolean;
  dryRun?: boolean;
  verbose?: boolean;
  summaryFile?: string;
  fix?: boolean;
  concurrency?: number;
}

interface RunContext {
  checkingAllSpecs: boolean;
  baseCommitish?: string;
  headCommitish?: string;
}

type ProjectStatus = "pass" | "fail" | "skip";

export type OutputStream = "stdout" | "stderr";
export interface OutputSegment {
  stream: OutputStream;
  text: string;
}

/** A project sent to a reusable `project-worker.ts --serve` process. */
export interface WorkerRequest {
  folder: string;
  context: RunContext;
}

export interface WorkerResponse {
  success: boolean;
  segments: OutputSegment[];
}

/** Thrown when a child is terminated by a signal; carries any output captured before termination. */
class ProjectTerminatedError extends Error {
  readonly segments: OutputSegment[];
  constructor(message: string, segments: OutputSegment[]) {
    super(message);
    this.name = "ProjectTerminatedError";
    this.segments = segments;
  }
}

// Cap captured output per project so a runaway diagnostic (e.g. a huge generated-file diff)
// can't grow runner memory without bound; excess output is dropped, not buffered.
export const MAX_CAPTURED_OUTPUT_BYTES = 10 * 1024 * 1024;

export async function runAll(
  folder: string,
  options: RunOptions & { shard?: string } = {},
): Promise<boolean> {
  const root = resolve(folder);
  if (!(await stat(root)).isDirectory()) {
    throw new Error(`Please run TypeSpec Validation on a directory path: ${root}`);
  }

  let projects = await findTypeSpecProjects(root);
  if (projects.length === 0) {
    console.error(`No TypeSpec projects found in ${root}`);
    return false;
  }

  if (options.shard !== undefined) {
    const total = projects.length;
    projects = selectShard(projects, options.shard);
    console.log(`Shard ${options.shard}: ${projects.length} of ${total} TypeSpec projects`);
  }

  return runProjects(root, projects, { checkingAllSpecs: true }, options);
}

export async function runChanged(
  folder: string,
  options: RunOptions & Partial<Omit<ChangedProjectsOptions, "logger">> = {},
): Promise<boolean> {
  const root = resolve(await getRootFolder(folder));
  const { baseCommitish = "HEAD^", headCommitish = "HEAD", ignoreCoreFiles } = options;
  const { projects, checkingAllSpecs } = await findChangedProjects(root, {
    baseCommitish,
    headCommitish,
    ignoreCoreFiles,
    logger: new ConsoleLogger(options.verbose),
  });
  if (projects.length === 0) {
    if (checkingAllSpecs) {
      console.error("TypeSpec Validation - All did not validate any specs");
      return false;
    }
    console.log("No impacted TypeSpec projects found");
    return true;
  }
  return runProjects(root, projects, { checkingAllSpecs, baseCommitish, headCommitish }, options);
}

async function runProjects(
  root: string,
  projects: string[],
  context: RunContext,
  options: RunOptions,
): Promise<boolean> {
  const concurrency = options.concurrency ?? 1;
  if (!Number.isSafeInteger(concurrency) || concurrency < 1) {
    throw new Error("--concurrency must be a positive safe integer");
  }
  if (options.fix && concurrency > 1) {
    throw new Error("--fix requires --concurrency=1 because formatter scopes may overlap");
  }
  // Experimental: validate several projects per process to reuse loaded modules and cached reads.
  const projectsPerWorker = Number(process.env.TSV_PROJECTS_PER_WORKER ?? "1");
  if (!Number.isSafeInteger(projectsPerWorker) || projectsPerWorker < 1) {
    throw new Error("TSV_PROJECTS_PER_WORKER must be a positive safe integer");
  }
  const git = simpleGit({ baseDir: root, allowEnvironment: ["GIT_OPTIONAL_LOCKS"] }).env(
    "GIT_OPTIONAL_LOCKS",
    "0",
  );
  const gitClean = options.gitClean && !options.dryRun;
  const displayRoot = resolve(
    gitClean || (await git.checkIsRepo()) ? await getRootFolder(root) : process.cwd(),
  );
  const displayPath = (project: string) => relative(displayRoot, project) || ".";
  if (gitClean) {
    await git.cwd(displayRoot);
    await git.revparse(["--verify", "HEAD"]);
    if (!(await git.status(["--untracked-files=all"])).isClean()) {
      throw new Error("--git-clean requires a clean checkout, including untracked files");
    }
  }

  console.log(
    `Checking ${projects.length} TypeSpec folders:\n${projects.map(displayPath).join("\n")}`,
  );
  if (!options.dryRun && concurrency > 1) {
    console.log(`Running up to ${Math.min(concurrency, projects.length)} projects concurrently`);
  }
  const failedProjects = new Set<string>();
  const githubActions = process.env.GITHUB_ACTIONS === "true";
  const counts: RuleCounts = { PASS: 0, FAIL: 0, WARN: 0, SKIP: 0, SUPPRESSED: 0 };

  const controller = new AbortController();
  let nextProject = 0;
  let stopped = false;
  let fatalError: unknown;
  const stop = (error: unknown) => {
    if (stopped) return;
    stopped = true;
    fatalError = error;
    controller.abort();
  };
  const interrupt = (signal: NodeJS.Signals) =>
    stop(new Error(`TypeSpec Validation interrupted by ${signal}`));
  const onSigint = () => interrupt("SIGINT");
  const onSigterm = () => interrupt("SIGTERM");
  process.on("SIGINT", onSigint);
  process.on("SIGTERM", onSigterm);

  async function worker() {
    const reusable =
      projectsPerWorker > 1
        ? new ReusableProjectWorker(projectsPerWorker, { ...options, signal: controller.signal })
        : undefined;
    try {
      while (!stopped && nextProject < projects.length) {
        const project = projects[nextProject++];
        try {
          await runProject(project, reusable);
        } catch (error) {
          stop(error);
        }
      }
    } finally {
      await reusable?.close();
    }
  }

  async function runProject(project: string, reusable?: ReusableProjectWorker) {
    const name = displayPath(project);
    if (context.checkingAllSpecs) {
      const suppressions = await getSuppressions("TypeSpecValidationAll", project, {
        ...context,
      });
      const suppression = suppressions.find((s) => !s.rules?.length && !s.subRules?.length);
      if (suppression) {
        counts.SUPPRESSED++;
        printProjectGroup(githubActions, "skip", name, [
          { stream: "stdout", text: `Suppressed: ${suppression.reason}` },
        ]);
        return;
      }
    }
    if (options.dryRun) {
      console.log(`Dry run: would validate ${name} with context ${JSON.stringify(context)}`);
      return;
    }
    if (stopped) return;

    try {
      const { success, segments } = reusable
        ? await reusable.validate(project, context)
        : await validateProject(project, context, {
            ...options,
            signal: controller.signal,
          });
      if (success) {
        counts.PASS++;
        printProjectGroup(githubActions, "pass", name, segments);
      } else {
        counts.FAIL++;
        failedProjects.add(name);
        const message =
          `TypeSpec Validation failed for project ${name} run the following command locally to validate.\n` +
          getFailureInstructions([name]);
        if (githubActions) {
          const escaped = message
            .replaceAll("%", "%25")
            .replaceAll("\r", "%0D")
            .replaceAll("\n", "%0A");
          const lastSegment = segments.at(-1);
          const needsNewline = lastSegment !== undefined && !lastSegment.text.endsWith("\n");
          printProjectGroup(githubActions, "fail", name, [
            ...segments,
            { stream: "stdout", text: `${needsNewline ? "\n" : ""}::error::${escaped}` },
          ]);
        } else {
          printProjectGroup(githubActions, "fail", name, segments);
          console.error(message);
        }
      }
    } catch (error) {
      // A child terminated by a signal may have already written diagnostics; surface them
      // under a failed group instead of silently dropping the captured output.
      if (error instanceof ProjectTerminatedError) {
        printProjectGroup(githubActions, "fail", name, [
          ...error.segments,
          { stream: "stderr", text: error.message },
        ]);
      }
      throw error;
    }
  }

  try {
    await Promise.all(
      Array.from({ length: options.dryRun ? 1 : Math.min(concurrency, projects.length) }, () =>
        worker(),
      ),
    );
  } finally {
    process.removeListener("SIGINT", onSigint);
    process.removeListener("SIGTERM", onSigterm);
  }
  if (stopped) throw fatalError;
  const failed = projects.map(displayPath).filter((name) => failedProjects.has(name));

  if (!options.dryRun) {
    console.log("");
    console.log(formatRuleSummary(counts, 0));
  }

  if (failed.length > 0) {
    console.error(
      "TypeSpec Validation failed for some folder to fix run and address any errors:\n" +
        getFailureInstructions(failed),
    );
  }
  if (options.summaryFile) {
    await writeGithubSummary(options.summaryFile, counts, failed);
  }
  return failed.length === 0;
}

async function writeGithubSummary(
  summaryFile: string,
  counts: RuleCounts,
  failed: string[],
): Promise<void> {
  const completed = counts.PASS + counts.FAIL + counts.SUPPRESSED;
  const lines =
    failed.length > 0
      ? [
          `❌ **${failed.length} of ${completed} projects failed.**`,
          "",
          "### Failed projects",
          "",
          ...failed.map((project) => `- \`${project}\``),
        ]
      : [`✅ **No projects failed (${counts.PASS} passed, ${counts.SUPPRESSED} suppressed).**`];
  await appendFile(summaryFile, ["## TypeSpec Validation", "", ...lines, ""].join("\n"));
}

/**
 * Print a project's result as a GitHub Actions group (or a plain heading locally), titled with its
 * status. GitHub group markers and captured output use stdout so independently flushed stderr cannot
 * appear after the end marker. Local runs preserve each segment's original stream.
 */
function printProjectGroup(
  githubActions: boolean,
  status: ProjectStatus,
  name: string,
  segments: OutputSegment[],
): void {
  const c = pc.createColors(supportsColor());
  const label =
    status === "pass" ? c.green("pass") : status === "fail" ? c.red("fail") : c.gray("skip");
  const title = `${label} ${name}`;
  console.log(githubActions ? `::group::${title}` : `\n${title}`);
  // Merge consecutive same-stream segments into a single write, trimming only the very last
  // segment's trailing newlines so no stray blank line is left before ::endgroup::.
  const merged: OutputSegment[] = [];
  for (const segment of segments) {
    const previous = merged.at(-1);
    if (previous && previous.stream === segment.stream) {
      previous.text += segment.text;
    } else {
      merged.push({ ...segment });
    }
  }
  const last = merged.at(-1);
  if (last) last.text = last.text.replace(/\n+$/, "");
  for (const segment of merged) {
    if (!segment.text) continue;
    (githubActions || segment.stream === "stdout" ? console.log : console.error)(segment.text);
  }
  if (githubActions) console.log("::endgroup::");
}

function getFailureInstructions(projects: string[]): string {
  return [
    " > pnpm install",
    ...projects.map((project) => ` > pnpm tsv ${project}`),
    "For more detailed docs see https://aka.ms/azsdk/specs/typespec-validation",
  ].join("\n");
}

/** Select a one-based shard, distributing extra projects to the first shards. */
function selectShard(projects: string[], shard: string): string[] {
  const match = /^(\d+)\/(\d+)$/.exec(shard);
  const index = Number(match?.[1]);
  const count = Number(match?.[2]);
  if (
    match?.[0] !== shard ||
    !Number.isSafeInteger(index) ||
    !Number.isSafeInteger(count) ||
    index < 1 ||
    index > count
  ) {
    throw new Error(
      `Invalid --shard "${shard}". Expected positive safe integers <index>/<count> ` +
        "with index <= count (for example, 1/3).",
    );
  }
  if (count > projects.length) {
    throw new Error(
      `Shard count (${count}) exceeds the number of TypeSpec projects (${projects.length})`,
    );
  }

  const size = Math.floor(projects.length / count);
  const remainder = projects.length % count;
  const start = (index - 1) * size + Math.min(index - 1, remainder);
  const end = start + size + (index <= remainder ? 1 : 0);
  return projects.slice(start, end);
}

/** Run a project's validation as a child process, capturing its output to attribute it to a titled group. */
function validateProject(
  folder: string,
  context: RunContext,
  {
    verbose = false,
    fix = false,
    signal,
  }: Pick<RunOptions, "verbose" | "fix"> & {
    signal?: AbortSignal;
  } = {},
): Promise<{ success: boolean; segments: OutputSegment[] }> {
  return new Promise((resolvePromise, reject) => {
    const env = childEnv();
    // Segments are recorded in capture order (not grouped by stream) so interleaved
    // stdout/stderr writes from the child can be replayed in their real relative order.
    const segments: OutputSegment[] = [];
    let capturedBytes = 0;
    let truncated = false;
    const capture = (stream: OutputStream, chunk: Buffer) => {
      // Keep draining the pipe even once truncated, so a chatty child can't stall on backpressure.
      if (truncated) return;
      capturedBytes += chunk.length;
      if (capturedBytes > MAX_CAPTURED_OUTPUT_BYTES) {
        truncated = true;
        segments.push({
          stream,
          text: `\n[output truncated: exceeded ${MAX_CAPTURED_OUTPUT_BYTES / (1024 * 1024)} MiB]\n`,
        });
        return;
      }
      segments.push({ stream, text: chunk.toString("utf8") });
    };
    // A child process keeps each project's context and exit status independent.
    const child = spawn(
      process.execPath,
      [
        workerPath,
        folder,
        JSON.stringify(context),
        ...(verbose ? ["--verbose"] : []),
        ...(fix ? ["--fix"] : []),
      ],
      { stdio: ["ignore", "pipe", "pipe"], env },
    );
    child.stdout?.on("data", (chunk: Buffer) => capture("stdout", chunk));
    child.stderr?.on("data", (chunk: Buffer) => capture("stderr", chunk));
    let launchError: Error | undefined;
    let forceKill: NodeJS.Timeout | undefined;
    const abort = () => {
      forceKill = setTimeout(() => child.kill("SIGKILL"), 5_000);
      forceKill.unref();
      child.kill("SIGTERM");
    };
    signal?.addEventListener("abort", abort, { once: true });
    if (signal?.aborted) abort();
    child.once("error", (error) => {
      launchError = error;
    });
    child.once("close", (code, terminationSignal) => {
      clearTimeout(forceKill);
      // Wait for close, not just error, so peers have exited before the batch returns.
      if (launchError) {
        reject(launchError);
      } else if (terminationSignal) {
        reject(
          new ProjectTerminatedError(
            `TypeSpec Validation for ${folder} terminated by ${terminationSignal}`,
            segments,
          ),
        );
      } else {
        resolvePromise({ success: code === 0, segments });
      }
    });
    child.once("close", () => signal?.removeEventListener("abort", abort));
  });
}

const workerPath = fileURLToPath(new URL("./project-worker.ts", import.meta.url));

function childEnv(): NodeJS.ProcessEnv {
  const env: NodeJS.ProcessEnv = { ...process.env, GIT_OPTIONAL_LOCKS: "0" };
  if (supportsColor()) {
    delete env.NO_COLOR;
    env.FORCE_COLOR = "1";
  } else {
    delete env.FORCE_COLOR;
    env.NO_COLOR = "1";
  }
  return env;
}

/**
 * A worker process that validates projects one at a time over IPC and is replaced after a fixed
 * number of projects, bounding memory retained by loaded programs and cached reads.
 */
class ReusableProjectWorker {
  #child: ChildProcess | undefined;
  #validated = 0;
  #stray: OutputSegment[] = [];
  readonly #limit: number;
  readonly #options: Pick<RunOptions, "verbose" | "fix"> & { signal: AbortSignal };

  constructor(
    limit: number,
    options: Pick<RunOptions, "verbose" | "fix"> & { signal: AbortSignal },
  ) {
    this.#limit = limit;
    this.#options = options;
  }

  async validate(
    folder: string,
    context: RunContext,
  ): Promise<{ success: boolean; segments: OutputSegment[] }> {
    if (this.#validated >= this.#limit) await this.close();
    const child = (this.#child ??= this.#start());
    this.#validated++;
    return new Promise((resolvePromise, reject) => {
      const takeOutput = () => this.#stray.splice(0);
      const cleanup = () => {
        child.off("message", onMessage);
        child.off("exit", onExit);
        child.off("error", onError);
      };
      const onMessage = (response: WorkerResponse) => {
        cleanup();
        resolvePromise({
          success: response.success,
          segments: [...takeOutput(), ...response.segments],
        });
      };
      const onError = (error: Error) => {
        cleanup();
        reject(error);
      };
      const onExit = (code: number | null, signal: NodeJS.Signals | null) => {
        cleanup();
        if (signal) {
          reject(
            new ProjectTerminatedError(
              `TypeSpec Validation for ${folder} terminated by ${signal}`,
              takeOutput(),
            ),
          );
        } else {
          resolvePromise({
            success: false,
            segments: [
              ...takeOutput(),
              { stream: "stderr", text: `TypeSpec Validation worker exited with code ${code}` },
            ],
          });
        }
      };
      child.on("message", onMessage);
      child.once("exit", onExit);
      child.once("error", onError);
      child.send({ folder, context } satisfies WorkerRequest);
    });
  }

  /** Let the current process exit after its last project, and wait until it has. */
  async close(): Promise<void> {
    const child = this.#child;
    this.#child = undefined;
    this.#validated = 0;
    if (!child || child.exitCode !== null || child.signalCode !== null) return;
    // Wait for "exit": "close" may never fire once the IPC channel has been disconnected.
    const exited = new Promise((resolveExit) => child.once("exit", resolveExit));
    if (child.connected) child.disconnect();
    await exited;
  }

  #start(): ChildProcess {
    const { verbose = false, fix = false, signal } = this.#options;
    const child = spawn(
      process.execPath,
      [workerPath, "--serve", ...(verbose ? ["--verbose"] : []), ...(fix ? ["--fix"] : [])],
      { stdio: ["ignore", "pipe", "pipe", "ipc"], env: childEnv() },
    );
    // Output written outside a project's capture, e.g. by a crash, is attributed to the next result.
    child.stdout?.on("data", (chunk: Buffer) =>
      this.#stray.push({ stream: "stdout", text: chunk.toString("utf8") }),
    );
    child.stderr?.on("data", (chunk: Buffer) =>
      this.#stray.push({ stream: "stderr", text: chunk.toString("utf8") }),
    );
    let forceKill: NodeJS.Timeout | undefined;
    const abort = () => {
      forceKill = setTimeout(() => child.kill("SIGKILL"), 5_000);
      forceKill.unref();
      child.kill("SIGTERM");
    };
    signal.addEventListener("abort", abort, { once: true });
    if (signal.aborted) abort();
    child.once("exit", () => {
      clearTimeout(forceKill);
      signal.removeEventListener("abort", abort);
      if (this.#child === child) this.#child = undefined;
    });
    return child;
  }
}
