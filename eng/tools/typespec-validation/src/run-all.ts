import { execFile } from "child_process";
import { globby } from "globby";
import { cpus } from "os";
import { dirname, relative, resolve } from "path";
import pc from "picocolors";
import { getSuppressions as getSuppressionsRaw, Suppression } from "suppressions";
import { promisify } from "util";
import { runWithConcurrency } from "./concurrency.js";
import { TaskRunner } from "./runner.js";
import { normalizePath } from "./utils.js";

const execFileAsync = promisify(execFile);

// Double cpu as there should be a lot of IO wait
const CONCURRENCY = cpus().length * 2;

export interface ShardConfig {
  /** 1-based shard index */
  index: number;
  /** Total number of shards */
  count: number;
}

export interface RunAllOptions {
  shard?: ShardConfig;
}

export async function runAll(specDir: string, options: RunAllOptions = {}): Promise<void> {
  const runner = new TaskRunner();
  const absoluteSpecDir = normalizePath(specDir);
  let projectDirs = await findTspProjects(absoluteSpecDir);

  if (projectDirs.length === 0) {
    console.log("No TypeSpec projects found");
    process.exitCode = 1;
    return;
  }

  if (options.shard) {
    projectDirs = shardArray(projectDirs, options.shard.index, options.shard.count);
    console.log(
      `Shard ${pc.yellow(String(options.shard.index))}/${pc.yellow(String(options.shard.count))}: ${pc.yellow(String(projectDirs.length))} projects`,
    );
  }

  runner.group(
    `Found ${pc.yellow(String(projectDirs.length))} TypeSpec projects`,
    projectDirs.map((dir) => pc.bold(relative(absoluteSpecDir, dir))).join("\n"),
  );

  const concurrency = CONCURRENCY;
  console.log(`Running with concurrency: ${pc.yellow(String(concurrency))}`);

  const results = await runWithConcurrency(projectDirs, concurrency, async (projectDir) => {
    const result = await validateProject(projectDir);
    const name = relative(absoluteSpecDir, projectDir);
    runner.reportTaskWithDetails(result.status, name, result.output);

    return { ...result, name };
  });

  // Summary
  let successCount = 0;
  let failureCount = 0;
  let skippedCount = 0;
  const failedProjects: string[] = [];

  for (const result of results) {
    switch (result.status) {
      case "pass":
        successCount++;
        break;
      case "fail":
        failureCount++;
        failedProjects.push(result.name);
        break;
      case "skip":
        skippedCount++;
        break;
    }
  }

  console.log(`\n=== Summary ===`);
  const passed = pc.bold(pc.green(`${successCount} passed`));
  const failed = failureCount > 0 ? pc.bold(pc.red(`${failureCount} failed`)) : undefined;
  const skipped = skippedCount > 0 ? pc.bold(pc.gray(`${skippedCount} skipped`)) : undefined;
  console.log(
    [passed, failed, skipped].filter(Boolean).join(pc.gray(" | ")),
    pc.gray(`(${projectDirs.length})`),
  );

  if (failureCount > 0) {
    console.log("\nFailed folders:");
    failedProjects.forEach((x) => console.log(`  - ${x}`));
    process.exitCode = 1;
  }
}

interface ProjectResult {
  name: string;
  status: "pass" | "fail" | "skip";
  output: string;
}

async function validateProject(folder: string): Promise<ProjectResult> {
  const name = folder;

  // Check TypeSpecValidationAll suppression (used to skip specs in the "all" run)
  const allSuppressions: Suppression[] = await getSuppressionsRaw("TypeSpecValidationAll", folder, {
    checkingAllSpecs: true,
  });
  const allToolSuppressions = allSuppressions.filter(
    (s) => !s.rules?.length && !s.subRules?.length,
  );
  if (allToolSuppressions.length > 0) {
    return {
      name,
      status: "skip",
      output: `Suppressed (TypeSpecValidationAll): ${allToolSuppressions[0].reason}`,
    };
  }

  // Run tsv as a child process to fully isolate stdout/stderr per project
  const context = JSON.stringify({ checkingAllSpecs: true });
  try {
    const { stdout, stderr } = await execFileAsync(
      process.execPath,
      ["--no-warnings", resolve(import.meta.dirname, "../../cmd/tsv.js"), folder, context],
      { maxBuffer: 64 * 1024 * 1024 },
    );
    const output = (stdout + stderr).trim();
    return { name, status: "pass", output };
  } catch (error: unknown) {
    const execError = error as { stdout?: string; stderr?: string; code?: number };
    const output = ((execError.stdout ?? "") + (execError.stderr ?? "")).trim();
    return { name, status: "fail", output };
  }
}

async function findTspProjects(specDir: string): Promise<string[]> {
  const files = await globby("**/tspconfig.yaml", {
    cwd: specDir,
    ignore: ["**/node_modules/**"],
  });
  const result = files.map((file) => dirname(resolve(specDir, file)));
  result.sort();
  return result;
}

/** Shard an array using 1-based index (like Jest/Vitest/Playwright) */
function shardArray<T>(array: T[], index: number, count: number): T[] {
  if (count < 2) {
    return array;
  }
  if (index < 1 || index > count) {
    throw new Error(`Shard index (${index}) must be between 1 and ${count}`);
  }
  if (count > array.length) {
    throw new Error("Cannot shard array into more pieces than there are elements");
  }
  const shardSize = Math.ceil(array.length / count);
  const start = (index - 1) * shardSize;
  const end = Math.min(start + shardSize, array.length);
  return array.slice(start, end);
}
