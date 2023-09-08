import { globby } from "globby";
import { Rule } from "../rule.js";
import { RuleResult } from "../rule-result.js";

export class FolderStructureRule implements Rule {
  readonly name = "FolderStructure";
  readonly description = "Verify spec directory's folder structure and naming conventions.";
  async execute(folder: string): Promise<RuleResult> {
    let success = true;
    let errorOutput = "";

    let stdOutput = "Verify tspconfig file extension";
    const tspConfig = await globby([`${folder}/**tspconfig.*`]);
    tspConfig.forEach((file: string) => {
      if (!file.endsWith("tspconfig.yaml")) {
        success = false;
        errorOutput += `Invalid config file '${file}'.  Must be named 'tspconfig.yaml'.\n`;
      }
    });

    return {
      success: success,
      stdOutput: stdOutput,
      errorOutput: errorOutput,
    };
  }
}
