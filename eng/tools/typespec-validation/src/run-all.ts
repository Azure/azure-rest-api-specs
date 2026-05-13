import { cpus } from "os";
import { dirname, relative, resolve } from "path";
import { globby } from "globby";
import pc from "picocolors";
import { simpleGit } from "simple-git";
import { getSuppressions as getSuppressionsRaw, Suppression } from "suppressions";
import { runWithConcurrency } from "./concurrency.js";
import { RuleResult } from "./rule-result.js";
import { Rule } from "./rule.js";
import { CompileRule } from "./rules/compile.js";
import { EmitAutorestRule } from "./rules/emit-autorest.js";
import { FlavorAzureRule } from "./rules/flavor-azure.js";
import { FolderStructureRule } from "./rules/folder-structure.js";
import { FormatRule } from "./rules/format.js";
import { LinterRulesetRule } from "./rules/linter-ruleset.js";
import { NpmPrefixRule } from "./rules/npm-prefix.js";
import { SdkTspConfigValidationRule } from "./rules/sdk-tspconfig-validation.js";
import { TaskRunner } from "./runner.js";
import { getSuppressions, normalizePath } from "./utils.js";

const CONCURRENCY = cpus().length;

export interface ShardConfig {
  /** 1-based shard index */
  index: number;
  /** Total number of shards */
  count: number;
}

export interface RunAllOptions {
  shard?: ShardConfig;
  gitClean?: boolean;
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

  const concurrency = options.gitClean ? 1 : CONCURRENCY;

  const results = await runWithConcurrency(projectDirs, concurrency, async (projectDir) => {
    const result = await validateProject(projectDir);
    const name = relative(absoluteSpecDir, projectDir);
    runner.reportTaskWithDetails(result.status, name, result.output);

    if (options.gitClean) {
      const git = simpleGit();
      await git.checkout(["--", "."]);
      await git.clean("f", ["-d"]);
    }

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
  const allSuppressions: Suppression[] = await getSuppressionsRaw(
    "TypeSpecValidationAll",
    folder,
    { checkingAllSpecs: true },
  );
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

  // Check TypeSpecValidation suppression
  const suppressions: Suppression[] = await getSuppressions(folder);
  const toolSuppressions = suppressions.filter((s) => !s.rules?.length && !s.subRules?.length);
  if (toolSuppressions.length > 0) {
    return {
      name,
      status: "skip",
      output: `Suppressed: ${toolSuppressions[0].reason}`,
    };
  }

  const rules: Rule[] = [
    new FolderStructureRule(),
    new NpmPrefixRule(),
    new EmitAutorestRule(),
    new FlavorAzureRule(),
    new LinterRulesetRule(),
    new CompileRule(),
    new FormatRule(),
    new SdkTspConfigValidationRule(),
  ];

  let output = "";
  for (const rule of rules) {
    let result: RuleResult;
    try {
      result = await rule.execute(folder);
    } catch (error) {
      return {
        name,
        status: "fail",
        output: output + `\nRule ${rule.name} threw: ${String(error)}`,
      };
    }

    if (result.stdOutput) output += result.stdOutput + "\n";

    if (!result.success) {
      if (result.errorOutput) output += result.errorOutput + "\n";
      return { name, status: "fail", output: output + `Rule ${rule.name} failed` };
    }
  }

  return { name, status: "pass", output };
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
