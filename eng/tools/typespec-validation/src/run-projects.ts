import { ConsoleLogger } from "@azure-tools/specs-shared/logger";
import { getRootFolder } from "@azure-tools/specs-shared/simple-git";
import { getSuppressions } from "@azure-tools/suppressions";
import { spawn } from "node:child_process";
import { appendFile, stat } from "node:fs/promises";
import { relative, resolve } from "pathe";
import { fileURLToPath } from "node:url";
import pc from "picocolors";
import { simpleGit } from "simple-git";
import { formatRuleSummary, supportsColor, type RuleCounts } from "./diagnostics.ts";
import { findChangedProjects, findProjects, type ChangedProjectsOptions } from "./find-projects.ts";

interface RunOptions {
  gitClean?: boolean;
  dryRun?: boolean;
  verbose?: boolean;
  summaryFile?: string;
}

interface RunContext {
  checkingAllSpecs: boolean;
  baseCommitish?: string;
  headCommitish?: string;
}

type ProjectStatus = "pass" | "fail" | "skip";

type OutputStream = "stdout" | "stderr";
interface OutputSegment {
  stream: OutputStream;
  text: string;
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
const MAX_CAPTURED_OUTPUT_BYTES = 10 * 1024 * 1024;

export async function runAll(
  folder: string,
  options: RunOptions & { shard?: string } = {},
): Promise<boolean> {
  const root = resolve(folder);
  if (!(await stat(root)).isDirectory()) {
    throw new Error(`Please run TypeSpec Validation on a directory path: ${root}`);
  }

  let projects = await findProjects(root);
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
  const git = simpleGit(root);
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
  const failed: string[] = [];
  const githubActions = process.env.GITHUB_ACTIONS === "true";
  const counts: RuleCounts = { PASS: 0, FAIL: 0, WARN: 0, SKIP: 0, SUPPRESSED: 0 };

  for (const project of projects) {
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
        continue;
      }
    }
    if (options.dryRun) {
      console.log(`Dry run: would validate ${name} with context ${JSON.stringify(context)}`);
      continue;
    }

    try {
      const { success, segments } = await validateProject(project, context, options.verbose);
      if (success) {
        counts.PASS++;
        printProjectGroup(githubActions, "pass", name, segments);
      } else {
        counts.FAIL++;
        failed.push(name);
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
    } finally {
      if (gitClean) {
        await git.raw(["restore", "--worktree", "--", "."]);
        await git.clean("f", ["-d"]);
      }
    }
  }

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
  verbose = false,
): Promise<{ success: boolean; segments: OutputSegment[] }> {
  return new Promise((resolvePromise, reject) => {
    const env = { ...process.env };
    if (supportsColor()) {
      delete env.NO_COLOR;
      env.FORCE_COLOR = "1";
    } else {
      delete env.FORCE_COLOR;
      env.NO_COLOR = "1";
    }
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
        fileURLToPath(new URL("../cmd/tsv.js", import.meta.url)),
        folder,
        JSON.stringify(context),
        ...(verbose ? ["--verbose"] : []),
      ],
      { stdio: ["ignore", "pipe", "pipe"], env },
    );
    child.stdout?.on("data", (chunk: Buffer) => capture("stdout", chunk));
    child.stderr?.on("data", (chunk: Buffer) => capture("stderr", chunk));
    child.once("error", reject);
    child.once("close", (code, signal) => {
      if (signal) {
        reject(
          new ProjectTerminatedError(
            `TypeSpec Validation for ${folder} terminated by ${signal}`,
            segments,
          ),
        );
      } else {
        resolvePromise({ success: code === 0, segments });
      }
    });
  });
}
