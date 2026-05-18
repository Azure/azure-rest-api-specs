import { stat } from "node:fs/promises";
import { ParseArgsConfig, parseArgs } from "node:util";
import { Suppression } from "suppressions";
import { Rule } from "./rule.js";
import { CompileRule } from "./rules/compile.js";
import { EmitAutorestRule } from "./rules/emit-autorest.js";
import { FlavorAzureRule } from "./rules/flavor-azure.js";
import { FolderStructureRule } from "./rules/folder-structure.js";
import { FormatRule } from "./rules/format.js";
import { LinterRulesetRule } from "./rules/linter-ruleset.js";
import { NpmPrefixRule } from "./rules/npm-prefix.js";
import { SdkTspConfigValidationRule } from "./rules/sdk-tspconfig-validation.js";
import { fileExists, getSuppressions, normalizePath } from "./utils.js";

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
): Promise<RunRulesResult> {
  const result: RunRulesResult = { success: true, suppressed: [], executed: [], failed: [] };

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

    const ruleResult = await rule.execute(folder);
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
  };
  const parsedArgs = parseArgs({ args, options, allowPositionals: true } as ParseArgsConfig);
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
    new FlavorAzureRule(),
    new LinterRulesetRule(),
    new CompileRule(),
    new FormatRule(),
    new SdkTspConfigValidationRule(),
  ];

  const result = await runRules(rules, absolutePath, suppressions);

  if (!result.success) {
    process.exitCode = 1;
  }
}
