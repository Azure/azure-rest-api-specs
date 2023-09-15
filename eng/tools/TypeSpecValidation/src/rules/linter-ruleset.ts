import { readFile } from "fs/promises";
import path from "path";
// import { parseDocument } from "yaml";
import { checkFileExists } from "../utils.js";
import { Rule } from "../rule.js";
import { RuleResult } from "../rule-result.js";

export class LinterRulesetRule implements Rule {
  readonly name = "LinterRuleset";
  readonly description =
    "Ensures each spec includes the correct linter ruleset (data-plane or management-plane)";
  async execute(folder: string): Promise<RuleResult> {
    let success = true;
    let stdOutput = "";
    let errorOutput = "";

    const configFile = path.join(folder, "tspconfig.yaml");

    // FolderStructure rule should ensure config file exists
    console.assert(checkFileExists(configFile));

    const file = await readFile(configFile);
    // parseDocument()

    return {
      success: success,
      stdOutput: stdOutput,
      errorOutput: errorOutput,
    };
  }
}
