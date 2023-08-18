// import { readdir } from "fs/promises";
// import path from "path";
import { Rule } from "../rule.js";
import { RuleResult } from "../rule-result.js";
import { runCmd } from "../utils.js";

export class FileStructureRule implements Rule {
  readonly name = "FileStructure";
  readonly description = "Verify spec directory's file structure and naming conventions.";
  async execute(folder: string): Promise<RuleResult> {
    let success = true;
    let errorOutput = "";

    const tspConfig = (
      await runCmd(`(Get-ChildItem -path ${folder} tspconfig.* -Recurse).Name`, process.cwd())
    )[0].trim();

    tspConfig.split(/\s+/).forEach((file) => {
      if (file !== "tspconfig.yaml") {
        success = false;
        errorOutput += `Please ensure the file extension of tspconfig is .yaml, found file ${file} instead.\n`;
      }
    });

    return {
      success: success,
      errorOutput: errorOutput,
    };
  }
}
