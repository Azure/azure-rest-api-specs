import debug from "debug";
import { parseArgs, ParseArgsConfig } from "node:util";
import { CompileRule } from "./TSVRules/CompileRule.js";
import { FormatRule } from "./TSVRules/FormatRule.js";
import { GitDiffRule } from "./TSVRules/GitDiffRule.js";
import { NpmPrefixRule } from "./TSVRules/NpmPrefixRule.js";

debug.enable("simple-git");

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

  let TSVRules = [new NpmPrefixRule(), new CompileRule(), new FormatRule(), new GitDiffRule()];
  let success = true;
  for (let i = 0; i < TSVRules.length; i++) {
    const rule = TSVRules[i];
    console.log("\nExecuting rule: " + rule.name);
    const result = await rule.execute(folder);
    if (result.stdOutput) console.log(result.stdOutput);
    if (!result.success) {
      success = false;
      console.log("Rule " + rule.name + " failed");
      if (result.errorOutput) console.log(result.errorOutput);
    }
  }

  if (!success) {
    return process.exit(1);
  }
  return;
}
