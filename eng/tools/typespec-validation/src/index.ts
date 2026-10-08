import { parseArgsWithHelp, type CliOption } from "@azure-tools/specs-shared/cli";
import { ConsoleLogger, type ILogger } from "@azure-tools/specs-shared/logger";
import { type Suppression } from "@azure-tools/suppressions";
import debug from "debug";
import { stat } from "node:fs/promises";
import { resolve } from "pathe";
import {
  exceptionDiagnostic,
  formatRuleStatus,
  formatRuleSummary,
  reportDiagnostics,
  type RuleCounts,
  type RuleStatus,
} from "./diagnostics.ts";
import type { Diagnostic, RuleResult } from "./rule-result.ts";
import { type Rule } from "./rule.ts";
import { runAll, runChanged } from "./run-projects.ts";
import { ClientTspImportRule } from "./rules/client-tsp-import.ts";
import { CompileRule } from "./rules/compile.ts";
import { EmitAutorestRule } from "./rules/emit-autorest.ts";
import { FlavorAzureRule } from "./rules/flavor-azure.ts";
import { FolderStructureRule } from "./rules/folder-structure.ts";
import { FormatRule } from "./rules/format.ts";
import { LinterRulesetRule } from "./rules/linter-ruleset.ts";
import { MultipleNewApiVersionsRule } from "./rules/multiple-new-api-versions.ts";
import { NpmPrefixRule } from "./rules/npm-prefix.ts";
import { SdkTspConfigValidationRule } from "./rules/sdk-tspconfig-validation.ts";
import { ServiceYamlRule } from "./rules/service-yaml.ts";
import { StaleApiVersionPinRule } from "./rules/stale-api-version-pin.ts";
import { fileExists, getSuppressions } from "./utils.ts";

// Context argument may add new properties or override checkingAllSpecs
export let context: Record<string, unknown> = { checkingAllSpecs: false };

export interface RunRulesResult {
  success: boolean;
  suppressed: string[];
  executed: string[];
  failed: string[];
}

/**
 * Runs the given rules against a folder, handling per-rule suppressions
 * for rules that opt in via `suppressable: true`.
 */
export async function runRules(
  rules: Rule[],
  folder: string,
  suppressions: Suppression[],
  logger: ILogger,
): Promise<RunRulesResult> {
  const result: RunRulesResult = { success: true, suppressed: [], executed: [], failed: [] };
  const diagnostics: Diagnostic[] = [];
  const counts: RuleCounts = { PASS: 0, FAIL: 0, WARN: 0, SKIP: 0, SUPPRESSED: 0 };
  const reportStatus = (name: string, status: RuleStatus) => {
    counts[status]++;
    logger.debug(formatRuleStatus(name, status));
  };

  for (const rule of rules) {
    if (rule.suppressable) {
      const ruleSuppressions = suppressions.filter(
        (s) => s.rules?.includes(rule.name) && (!s.subRules || s.subRules.length === 0),
      );
      if (ruleSuppressions.length > 0) {
        logger.debug(`  Suppressed: ${ruleSuppressions[0].reason}`);
        result.suppressed.push(rule.name);
        reportStatus(rule.name, "SUPPRESSED");
        continue;
      }
    }

    let ruleResult: RuleResult;
    try {
      ruleResult = await rule.execute(folder, logger);
    } catch (error) {
      logger.debug(error instanceof Error ? (error.stack ?? error.message) : String(error));
      ruleResult = { success: false, diagnostics: [exceptionDiagnostic(error, folder)] };
    }
    result.executed.push(rule.name);
    diagnostics.push(...(ruleResult.diagnostics ?? []));
    if (ruleResult.skipped) logger.debug(`  Skipped: ${ruleResult.skipped}`);
    if (ruleResult.suppressed) logger.debug(`  Suppressed: ${ruleResult.suppressed}`);
    reportStatus(
      rule.name,
      !ruleResult.success
        ? "FAIL"
        : ruleResult.suppressed !== undefined
          ? "SUPPRESSED"
          : ruleResult.diagnostics?.some((diagnostic) => diagnostic.severity === "warning")
            ? "WARN"
            : ruleResult.skipped !== undefined
              ? "SKIP"
              : "PASS",
    );
    if (!ruleResult.success) {
      result.success = false;
      result.failed.push(rule.name);
      if (!ruleResult.diagnostics?.some((diagnostic) => diagnostic.severity === "error")) {
        diagnostics.push({
          severity: "error",
          code: "rule-failed",
          message: `Rule ${rule.name} failed without reporting an error.`,
          path: folder,
        });
      }

      // Stop executing more rules, since the results are more likely to be confusing than helpful
      // Can add property like "RuleResult.ContinueOnError" if some rules want to continue
      break;
    }
  }

  reportDiagnostics(diagnostics, logger);
  const completed = Object.values(counts).reduce((total, count) => total + count, 0);
  if (diagnostics.length > 0 || (logger.isDebug() && completed > 0)) logger.info("");
  logger.info(formatRuleSummary(counts, rules.length - completed));
  return result;
}

const help = {
  command: "pnpm tsv",
  title: "TypeSpec Validation",
  description: "Validate Azure TypeSpec projects.",
  positionals: [
    { name: "folder", description: "Project folder." },
    {
      name: "context-json",
      optional: true,
      description: "Optional JSON context for rules and suppressions in single-project mode.",
    },
  ],
  notes: [
    "Run from the repository root after installing dependencies with pnpm install.",
    "Validation may update generated files and formatting. Changes are retained unless --git-clean is used.",
    "Do not use --git-clean while other work is in progress.",
  ],
  examples: [
    "specification/<service>/<project>",
    "--all",
    "--changed --base=origin/main --head=HEAD --dry-run",
  ],
  documentation: "https://aka.ms/azsdk/specs/typespec-validation",
};

export async function main() {
  const args = process.argv.slice(2);
  const options = {
    verbose: {
      type: "boolean",
      short: "v",
      description: "Include rule progress, debug details, and Git traces.",
    },
    all: {
      type: "boolean",
      description: "Validate all projects under the discovery root.",
    },
    changed: {
      type: "boolean",
      description:
        "Validate projects affected by committed changes using the current checkout. " +
        "--all and --changed cannot be combined.",
    },
    base: {
      type: "string",
      valueLabel: "<commit>",
      group: "Options for --changed",
      description: "Base revision (default: HEAD^).",
    },
    head: {
      type: "string",
      valueLabel: "<commit>",
      group: "Options for --changed",
      description: "Head revision (default: HEAD).",
    },
    "ignore-core-files": {
      type: "boolean",
      group: "Options for --changed",
      description: "Disable all-project fallback for core-file changes.",
    },
    shard: {
      type: "string",
      valueLabel: "<index>/<count>",
      group: "Options for --all",
      description:
        "Select a shard using one-based indices. Each shard requires a separate checkout.",
    },
    "github-summary": {
      type: "boolean",
      group: "Options for --all",
      description: "Append failed project paths to the GitHub job summary.",
    },
    "dry-run": {
      type: "boolean",
      group: "Options for --all or --changed",
      description:
        "List selected projects and context without validation or cleanup; disables --git-clean.",
    },
    "git-clean": {
      type: "boolean",
      group: "Options for --all or --changed",
      description:
        "Restore tracked files and remove untracked files and directories across the entire repository " +
        "after each project. Requires a clean, disposable checkout; " +
        "ignored files are retained.",
    },
    "allow-generated-changes": {
      type: "boolean",
      description:
        "Report generated-file and formatting changes as warnings instead of failing. " +
        "Use when validating an upcoming TypeSpec release.",
    },
  } satisfies Record<string, CliOption>;
  const parsedArgs = parseArgsWithHelp({ args, options, allowPositionals: true, help });
  if (!parsedArgs) return;

  const { values } = parsedArgs;
  const logger = new ConsoleLogger(values.verbose);
  if (values.verbose) {
    debug.enable([process.env.DEBUG, "simple-git"].filter(Boolean).join(","));
  }
  if (values.all && values.changed) {
    console.error("--all and --changed cannot be combined");
    process.exitCode = 1;
    return;
  }
  if ((values["git-clean"] || values["dry-run"]) && !values.all && !values.changed) {
    console.error("--git-clean and --dry-run require --all or --changed");
    process.exitCode = 1;
    return;
  }
  if (
    (values.base !== undefined || values.head !== undefined || values["ignore-core-files"]) &&
    !values.changed
  ) {
    console.error("--base, --head and --ignore-core-files require --changed");
    process.exitCode = 1;
    return;
  }

  if (values.shard !== undefined && !values.all) {
    console.error("--shard requires --all");
    process.exitCode = 1;
    return;
  }
  if (values["github-summary"] && !values.all) {
    console.error("--github-summary requires --all");
    process.exitCode = 1;
    return;
  }
  const summaryFile = values["github-summary"] ? process.env.GITHUB_STEP_SUMMARY : undefined;
  if (values["github-summary"] && !summaryFile) {
    console.error("--github-summary requires the GITHUB_STEP_SUMMARY environment variable");
    process.exitCode = 1;
    return;
  }

  if (values.changed) {
    if (parsedArgs.positionals.length > 0) {
      console.error(
        "Usage: tsv --changed [--base=<commit>] [--head=<commit>] [--ignore-core-files] [--git-clean] [--dry-run]",
      );
      process.exitCode = 1;
      return;
    }
    const success = await runChanged(process.cwd(), {
      baseCommitish: values.base,
      headCommitish: values.head,
      ignoreCoreFiles: values["ignore-core-files"],
      gitClean: values["git-clean"],
      allowGeneratedChanges: values["allow-generated-changes"],
      dryRun: values["dry-run"],
      verbose: values.verbose,
    });
    if (!success) process.exitCode = 1;
    return;
  }

  if (values.all) {
    if (parsedArgs.positionals.length > 1) {
      console.error(
        "Usage: tsv --all [folder] [--shard=<index>/<count>] [--github-summary] [--git-clean] [--dry-run]",
      );
      process.exitCode = 1;
      return;
    }
    const success = await runAll(parsedArgs.positionals[0] ?? "specification", {
      gitClean: values["git-clean"],
      allowGeneratedChanges: values["allow-generated-changes"],
      shard: values.shard,
      dryRun: values["dry-run"],
      verbose: values.verbose,
      summaryFile,
    });
    if (!success) process.exitCode = 1;
    return;
  }

  const folder = parsedArgs.positionals[0];
  if (folder === undefined) {
    console.error("A project folder is required. Use --help for usage.");
    process.exitCode = 1;
    return;
  }

  if (parsedArgs.positionals[1]) {
    context = { ...context, ...(JSON.parse(parsedArgs.positionals[1]) as Record<string, unknown>) };
  }
  if (values["allow-generated-changes"]) context = { ...context, allowGeneratedChanges: true };

  const absolutePath = resolve(folder);

  if (!(await fileExists(absolutePath))) {
    console.log(`Folder ${absolutePath} does not exist`);
    process.exit(1);
  }
  if (!(await stat(absolutePath)).isDirectory()) {
    console.log(`Please run TypeSpec Validation on a directory path`);
    process.exit(1);
  }
  logger.debug(`Running TypeSpecValidation on folder: ${absolutePath}`);

  const suppressions: Suppression[] = await getSuppressions(absolutePath);

  // Suppressions for the whole tool must have no rules or sub-rules
  const toolSuppressions = suppressions.filter((s) => !s.rules?.length && !s.subRules?.length);

  if (toolSuppressions && toolSuppressions[0]) {
    // Use reason from first matching suppression and ignore rest
    console.log(`  Suppressed: ${suppressions[0].reason}`);
    return;
  }

  const rules: Rule[] = [
    new FolderStructureRule(),
    new NpmPrefixRule(),
    new EmitAutorestRule(),
    new ServiceYamlRule(),
    new FlavorAzureRule(),
    new LinterRulesetRule(),
    new ClientTspImportRule(),
    new CompileRule(),
    new FormatRule(),
    new SdkTspConfigValidationRule(),
    new MultipleNewApiVersionsRule(),
    new StaleApiVersionPinRule(),
  ];

  const result = await runRules(rules, absolutePath, suppressions, logger);

  if (!result.success) {
    process.exitCode = 1;
  }
}
