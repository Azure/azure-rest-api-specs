import { type Suppression } from "@azure-tools/suppressions";
import { stat } from "node:fs/promises";
import { type ParseArgsConfig, parseArgs } from "node:util";
import { type Rule } from "./rule.ts";
import { runAll } from "./run-all.ts";
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
import { createTelemetry, type TsvTelemetry } from "./telemetry.ts";
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
  telemetry?: TsvTelemetry,
): Promise<RunRulesResult> {
  const result: RunRulesResult = { success: true, suppressed: [], executed: [], failed: [] };
  if (telemetry) telemetry.command.ruleCount = rules.length;

  for (const rule of rules) {
    console.log("\nExecuting rule: " + rule.name);
    const span = telemetry?.startRule(rule.name);

    if (rule.suppressable) {
      const ruleSuppressions = suppressions.filter(
        (s) => s.rules?.includes(rule.name) && (!s.subRules || s.subRules.length === 0),
      );
      if (ruleSuppressions.length > 0) {
        console.log(`  Suppressed: ${ruleSuppressions[0].reason}`);
        result.suppressed.push(rule.name);
        span?.end("suppressed");
        continue;
      }
    }

    let ruleResult;
    try {
      ruleResult = await rule.execute(folder);
    } catch (error) {
      span?.end("error");
      throw error;
    }
    span?.end(!ruleResult.success ? "failure" : ruleResult.suppressed ? "suppressed" : "success");
    result.executed.push(rule.name);
    if (ruleResult.stdOutput) console.log(ruleResult.stdOutput);
    if (!ruleResult.success) {
      result.success = false;
      result.failed.push(rule.name);
      console.log("Rule " + rule.name + " failed");
      if (ruleResult.errorOutput) console.log(ruleResult.errorOutput);

      // Stop executing more rules, since the results are more likely to be confusing than helpful
      // Can add property like "RuleResult.ContinueOnError" if some rules want to continue
      break;
    }
  }

  return result;
}

export async function main() {
  const telemetry = await createTelemetry();
  let completed = false;
  try {
    await runCommand(telemetry);
    completed = true;
  } finally {
    await telemetry?.shutdown(completed ? Number(process.exitCode ?? 0) : 1);
  }
}

async function runCommand(telemetry?: TsvTelemetry) {
  const args = process.argv.slice(2);
  const options = {
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
    shard: {
      type: "string",
    },
    "git-clean": {
      type: "boolean",
    },
  } satisfies ParseArgsConfig["options"];
  const parsedArgs = parseArgs({ args, options, allowPositionals: true });
  if (telemetry) telemetry.command.mode = parsedArgs.values.all ? "all" : "project";

  if (parsedArgs.values["git-clean"] && !parsedArgs.values.all) {
    console.error("--git-clean requires --all");
    process.exitCode = 1;
    return;
  }

  if (parsedArgs.values.shard !== undefined && !parsedArgs.values.all) {
    console.error("--shard requires --all");
    process.exitCode = 1;
    return;
  }

  if (parsedArgs.values.all) {
    if (parsedArgs.positionals.length > 1) {
      console.error("Usage: tsv --all [folder] [--shard=<index>/<count>] [--git-clean]");
      process.exitCode = 1;
      return;
    }
    if (telemetry) {
      telemetry.command.outcome = "error";
      telemetry.command.checkingAllSpecs = true;
    }
    const success = await runAll(
      parsedArgs.positionals[0] ?? "specification",
      {
        gitClean: parsedArgs.values["git-clean"] === true,
        shard: parsedArgs.values.shard,
      },
      telemetry,
    );
    if (!success) process.exitCode = 1;
    if (telemetry) {
      telemetry.command.outcome = !success
        ? "validation_failed"
        : telemetry.batch?.launched === 0
          ? "suppressed"
          : "success";
    }
    return;
  }

  const folder = parsedArgs.positionals[0];

  if (parsedArgs.positionals[1]) {
    context = { ...context, ...(JSON.parse(parsedArgs.positionals[1]) as Record<string, unknown>) };
  }

  const absolutePath = normalizePath(folder);

  if (!(await fileExists(absolutePath))) {
    console.log(`Folder ${absolutePath} does not exist`);
    process.exitCode = 1;
    return;
  }
  if (!(await stat(absolutePath)).isDirectory()) {
    console.log(`Please run TypeSpec Validation on a directory path`);
    process.exitCode = 1;
    return;
  }
  console.log("Running TypeSpecValidation on folder: ", absolutePath);
  if (telemetry) {
    telemetry.command.outcome = "error";
    telemetry.command.checkingAllSpecs = context.checkingAllSpecs === true;
    await telemetry.setProject(absolutePath);
  }

  const suppressions: Suppression[] = await getSuppressions(absolutePath);

  // Suppressions for the whole tool must have no rules or sub-rules
  const toolSuppressions = suppressions.filter((s) => !s.rules?.length && !s.subRules?.length);

  if (toolSuppressions && toolSuppressions[0]) {
    // Use reason from first matching suppression and ignore rest
    console.log(`  Suppressed: ${suppressions[0].reason}`);
    if (telemetry) telemetry.command.outcome = "suppressed";
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

  const result = await runRules(rules, absolutePath, suppressions, telemetry);
  if (telemetry) {
    telemetry.command.outcome = result.success ? "success" : "validation_failed";
  }

  if (!result.success) {
    process.exitCode = 1;
  }
}
