import { readdir } from "node:fs/promises";
import { join, dirname } from "node:path";
import { ParseArgsConfig, parseArgs } from "node:util";
import { Suppression, getSuppressions } from "suppressions";
import { TsvRunnerHost } from "./tsv-runner-host.js";
import { fileURLToPath } from "url";
import { Rule } from "./rule.js";

export async function main() {
  const host = new TsvRunnerHost();
  const args = process.argv.slice(2);
  const options = {
    folder: {
      type: "string",
      short: "f",
    },
  };
  const parsedArgs = parseArgs({ args, options, allowPositionals: true } as ParseArgsConfig);
  const folder = parsedArgs.positionals[0];
  const absolutePath = host.normalizePath(folder);

  if (!(await host.checkFileExists(absolutePath))) {
    console.log(`Folder ${absolutePath} does not exist`);
    process.exit(1);
  }
  if (!(await host.isDirectory(absolutePath))) {
    console.log(`Please run TypeSpec Validation on a directory path`);
    process.exit(1);
  }
  console.log("Running TypeSpecValidation on folder: ", absolutePath);

  const suppressions: Suppression[] = await getSuppressions("TypeSpecValidation", absolutePath);
  if (suppressions && suppressions[0]) {
    // Use reason from first matching suppression and ignore rest
    console.log(`  Suppressed: ${suppressions[0].reason}`);
  }

  const ruleMap = await loadRules();
  const subRuleMap = getSubRules(ruleMap, suppressions);
  const rules = [...ruleMap.values()];

  let success = true;
  for (let i = 0; i < rules.length; i++) {
    const rule = rules[i];
    console.log("\nExecuting rule: " + rule.name);
    const result = await rule.execute(host, absolutePath, subRuleMap.get(rule.name));
    if (result.stdOutput) console.log(result.stdOutput);
    if (!result.success) {
      success = false;
      console.log("Rule " + rule.name + " failed");
      if (result.errorOutput) console.log(result.errorOutput);

      // Stop executing more rules, since the results are more likely to be confusing than helpful
      // Can add property like "RuleResult.ContinueOnError" if some rules want to continue
      break;
    }
  }

  if (!success) {
    process.exitCode = 1;
  }
}

async function loadRules(): Promise<Map<string, Rule>> {
  const currentPath = fileURLToPath(import.meta.url);
  const currentDir = dirname(currentPath);
  const ruleFileNames = (await readdir(join(currentDir, "rules"))).filter((p) => p.endsWith(".js"));
  const ruleMap = new Map<string, Rule>();
  for (const ruleFileName of ruleFileNames) {
    const module = await import(join("file://", currentDir, "rules", ruleFileName));
    const rule = new module.default() as Rule;
    ruleMap.set(rule.name, rule);
  }
  return ruleMap;
}

function getSubRules(ruleMap: Map<string, Rule>, suppressions: Suppression[]) {
  const subRuleMap = new Map<string, Set<string>>();
  for (const suppression of suppressions) {
    if (
      ruleMap.has(suppression.rule) &&
      (!suppression["subRules"] || suppression["subRules"].length == 0)
    ) {
      ruleMap.delete(suppression.rule);
    }
    const subRules = suppression["subRules"];
    if (subRules && subRules.length > 0)
      subRuleMap.set(suppression.rule, new Set<string>([...subRules]));
  }
  return subRuleMap;
}
