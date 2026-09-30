import { ConsoleLogger, type ILogger } from "@azure-tools/specs-shared/logger";
import { type Suppression } from "@azure-tools/suppressions";
import debug from "debug";
import { stat } from "node:fs/promises";
import { type ParseArgsConfig, parseArgs } from "node:util";
import { exceptionDiagnostic, reportDiagnostics } from "./diagnostics.ts";
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
import { fileExists, getSuppressions, normalizePath } from "./utils.ts";

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

  for (const rule of rules) {
    console.log("\nExecuting rule: " + rule.name);

    if (rule.suppressable) {
      const ruleSuppressions = suppressions.filter(
        (s) => s.rules?.includes(rule.name) && (!s.subRules || s.subRules.length === 0),
      );
      if (ruleSuppressions.length > 0) {
        console.log(`  Suppressed: ${ruleSuppressions[0].reason}`);
        result.suppressed.push(rule.name);
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
    if (ruleResult.stdOutput) console.log(ruleResult.stdOutput);
    if (!ruleResult.success) {
      result.success = false;
      result.failed.push(rule.name);
      if (ruleResult.errorOutput) {
        console.log("Rule " + rule.name + " failed");
        console.log(ruleResult.errorOutput);
      } else if (!ruleResult.diagnostics?.some((diagnostic) => diagnostic.severity === "error")) {
        // Some unmigrated rules, including SDK config validation, report errors in stdout.
        if (ruleResult.stdOutput) {
          console.log("Rule " + rule.name + " failed");
        } else {
          diagnostics.push({
            severity: "error",
            code: "rule-failed",
            message: `Rule ${rule.name} failed without reporting an error.`,
            path: folder,
          });
        }
      }

      // Stop executing more rules, since the results are more likely to be confusing than helpful
      // Can add property like "RuleResult.ContinueOnError" if some rules want to continue
      break;
    }
  }

  reportDiagnostics(diagnostics, logger);
  return result;
}

export async function main() {
  const args = process.argv.slice(2);
  const options = {
    verbose: {
      type: "boolean",
      short: "v",
    },
    folder: {
      type: "string",
      short: "f",
    },
    context: {
      type: "string",
      short: "c",
    },
    all: {
      type: "boolean",
    },
    changed: {
      type: "boolean",
    },
    base: {
      type: "string",
    },
    head: {
      type: "string",
    },
    "ignore-core-files": {
      type: "boolean",
    },
    "dry-run": {
      type: "boolean",
    },
    shard: {
      type: "string",
    },
    "git-clean": {
      type: "boolean",
    },
  } satisfies ParseArgsConfig["options"];
  const parsedArgs = parseArgs({ args, options, allowPositionals: true });

  const { values } = parsedArgs;
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
      dryRun: values["dry-run"],
      verbose: values.verbose,
    });
    if (!success) process.exitCode = 1;
    return;
  }

  if (values.all) {
    if (parsedArgs.positionals.length > 1) {
      console.error(
        "Usage: tsv --all [folder] [--shard=<index>/<count>] [--git-clean] [--dry-run]",
      );
      process.exitCode = 1;
      return;
    }
    const success = await runAll(parsedArgs.positionals[0] ?? "specification", {
      gitClean: values["git-clean"],
      shard: values.shard,
      dryRun: values["dry-run"],
      verbose: values.verbose,
    });
    if (!success) process.exitCode = 1;
    return;
  }

  const folder = parsedArgs.positionals[0];

  if (parsedArgs.positionals[1]) {
    context = { ...context, ...(JSON.parse(parsedArgs.positionals[1]) as Record<string, unknown>) };
  }

  const absolutePath = normalizePath(folder);

  if (!(await fileExists(absolutePath))) {
    console.log(`Folder ${absolutePath} does not exist`);
    process.exit(1);
  }
  if (!(await stat(absolutePath)).isDirectory()) {
    console.log(`Please run TypeSpec Validation on a directory path`);
    process.exit(1);
  }
  console.log("Running TypeSpecValidation on folder: ", absolutePath);

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

  const result = await runRules(
    rules,
    absolutePath,
    suppressions,
    new ConsoleLogger(values.verbose),
  );

  if (!result.success) {
    process.exitCode = 1;
  }
}
