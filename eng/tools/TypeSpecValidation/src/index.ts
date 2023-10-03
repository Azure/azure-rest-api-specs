import { parseArgs, ParseArgsConfig } from "node:util";
import { CompileRule } from "./rules/compile.js";
import { FolderStructureRule } from "./rules/folder-structure.js";
import { FormatRule } from "./rules/format.js";
import { GitDiffRule } from "./rules/git-diff.js";
import { LinterRulesetRule } from "./rules/linter-ruleset.js";
import { NpmPrefixRule } from "./rules/npm-prefix.js";

export async function main() {
  const args = process.argv.slice(2);
  const options = {
    folder: {
      type: "string",
      short: "f",
    },
  };
  const parsedArgs = parseArgs({ args, options, allowPositionals: true } as ParseArgsConfig);
  const folder = parsedArgs.positionals[0];
  console.log("Running TypeSpecValidation on folder:", folder);

  let rules = [
    new FolderStructureRule(),
    new NpmPrefixRule(),
    new LinterRulesetRule(),
    new CompileRule(),
    new FormatRule(),
    new GitDiffRule(),
  ];
  let success = true;
  for (let i = 0; i < rules.length; i++) {
    const rule = rules[i];
    console.log("\nExecuting rule: " + rule.name);
    const result = await rule.execute(folder);
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
