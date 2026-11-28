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
import {
  OutputCapture,
  type OutputSegment,
  type RunContext,
  type WorkerMessage,
  type WorkerRequest,
} from "./worker-protocol.ts";

interface RunOptions {
  gitClean?: boolean;
  dryRun?: boolean;
  verbose?: boolean;
  summaryFile?: string;
  fix?: boolean;
  concurrency?: number;
}

type ProjectStatus = "pass" | "fail" | "skip";

/** Thrown when a child is terminated by a signal; carries any output captured before termination. */
class ProjectTerminatedError extends Error {
  readonly segments: OutputSegment[];
  constructor(message: string, segments: OutputSegment[]) {
    super(message);
    this.name = "ProjectTerminatedError";
    this.segments = segments;
  }
}

const MAX_PROJECTS_PER_WORKER = 20;

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
    const projectWorker = new ProjectWorker({ ...options, signal: controller.signal });
    try {
      while (!stopped && nextProject < projects.length) {
        const project = projects[nextProject++];
        try {
          await runProject(project, projectWorker);
        } catch (error) {
          stop(error);
        }
      }
    } finally {
      await projectWorker.close();
    }
  }

  async function runProject(project: string, projectWorker: ProjectWorker) {
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
      const { success, segments } = await projectWorker.validate(project, context);
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
 * A worker validates projects one at a time and is recycled to bound cached data and memory.
 */
class ProjectWorker {
  #child: ChildProcess | undefined;
  #validated = 0;
  #output = new OutputCapture();
  readonly #options: Pick<RunOptions, "verbose" | "fix"> & { signal: AbortSignal };

  constructor(options: Pick<RunOptions, "verbose" | "fix"> & { signal: AbortSignal }) {
    this.#options = options;
  }

  async validate(
    folder: string,
    context: RunContext,
  ): Promise<{ success: boolean; segments: OutputSegment[] }> {
    if (this.#validated >= MAX_PROJECTS_PER_WORKER) await this.close();
    const child = (this.#child ??= this.#start());
    this.#validated++;
    return new Promise((resolvePromise, reject) => {
      let settled = false;
      const cleanup = () => {
        child.off("message", onMessage);
        child.off("exit", onExit);
        child.off("error", onError);
      };
      const finish = () => {
        if (settled) return false;
        settled = true;
        cleanup();
        return true;
      };
      const onMessage = (message: WorkerMessage) => {
        if (message.kind === "output") {
          for (const segment of message.segments) this.#output.append(segment.stream, segment.text);
        } else if (message.kind === "result" && finish()) {
          resolvePromise({ success: message.success, segments: this.#output.take() });
        }
      };
      const onError = (error: Error) => {
        if (finish()) reject(error);
      };
      const onExit = (code: number | null, signal: NodeJS.Signals | null) => {
        if (!finish()) return;
        if (signal) {
          reject(
            new ProjectTerminatedError(
              `TypeSpec Validation for ${folder} terminated by ${signal}`,
              this.#output.take(),
            ),
          );
        } else {
          resolvePromise({
            success: false,
            segments: [
              ...this.#output.take(),
              { stream: "stderr", text: `TypeSpec Validation worker exited with code ${code}` },
            ],
          });
        }
      };
      child.on("message", onMessage);
      child.once("exit", onExit);
      child.once("error", onError);
      try {
        child.send({ folder, context } satisfies WorkerRequest, (error) => {
          if (error) onError(error);
        });
      } catch (error) {
        if (finish()) reject(error instanceof Error ? error : new Error(String(error)));
      }
    });
  }

  async close(): Promise<void> {
    const child = this.#child;
    this.#child = undefined;
    this.#validated = 0;
    if (!child || child.exitCode !== null || child.signalCode !== null) return;
    await new Promise<void>((resolveExit) => {
      const finish = () => {
        child.off("exit", finish);
        child.off("close", finish);
        child.off("error", onError);
        resolveExit();
      };
      const onError = () => {
        if (child.pid === undefined) finish();
      };
      child.once("exit", finish);
      child.once("close", finish);
      child.on("error", onError);
      if (child.connected) child.disconnect();
      else if (child.pid === undefined) finish();
    });
  }

  #start(): ChildProcess {
    const { verbose = false, fix = false, signal } = this.#options;
    const child = spawn(
      process.execPath,
      [workerPath, ...(verbose ? ["--verbose"] : []), ...(fix ? ["--fix"] : [])],
      { stdio: ["ignore", "pipe", "pipe", "ipc"], env: childEnv() },
    );
    child.stdout?.on("data", (chunk: Buffer) => this.#output.append("stdout", chunk));
    child.stderr?.on("data", (chunk: Buffer) => this.#output.append("stderr", chunk));
    let forceKill: NodeJS.Timeout | undefined;
    const abort = () => {
      if (child.pid === undefined || child.exitCode !== null || child.signalCode !== null) return;
      forceKill = setTimeout(() => child.kill("SIGKILL"), 5_000);
      forceKill.unref();
      child.kill("SIGTERM");
    };
    signal.addEventListener("abort", abort, { once: true });
    if (signal.aborted) abort();
    const cleanup = () => {
      clearTimeout(forceKill);
      signal.removeEventListener("abort", abort);
      if (this.#child === child) {
        this.#child = undefined;
        this.#validated = 0;
      }
    };
    child.once("exit", cleanup);
    child.once("close", cleanup);
    child.on("error", () => {
      if (child.pid === undefined) cleanup();
    });
    return child;
  }
}
