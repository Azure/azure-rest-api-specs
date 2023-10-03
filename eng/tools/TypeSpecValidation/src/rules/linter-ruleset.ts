import { readFile } from "fs/promises";
import { join } from "path";
import { parse } from "yaml";
import { checkFileExists } from "../utils.js";
import { Rule } from "../rule.js";
import { RuleResult } from "../rule-result.js";

export class LinterRulesetRule implements Rule {
  readonly name = "LinterRuleset";
  readonly description =
    "Ensures each spec includes the correct linter ruleset (data-plane or management-plane)";
  async execute(folder: string): Promise<RuleResult> {
    let success = true;
    let errorOutput = "";

    const configFile = join(folder, "tspconfig.yaml");

    // FolderStructure rule should ensure config file exists
    console.assert(checkFileExists(configFile));

    const configText = await readFile(configFile, "utf8");
    const config = parse(configText);

    try {
      const isDataPlane = this.isDataPlane(config);
      const requiredRuleset = isDataPlane
        ? "@azure-tools/typespec-azure-core/all"
        : "@azure-tools/typespec-azure-resource-manager/all";

      const linterExtends = config.linter?.extends;
      if (!linterExtends?.includes(requiredRuleset)) {
        success = false;
        errorOutput =
          "tspconfig.yaml must define the following property:\n" +
          "\n" +
          "linter:\n" +
          "  extends:\n" +
          `    - "${requiredRuleset}"`;
      }
    } catch (e) {
      success = false;
      errorOutput += e instanceof Error ? e.message : e;
    }

    return {
      success: success,
      errorOutput: errorOutput,
    };
  }

  private isDataPlane(config: any): boolean {
    const specType =
      config.options?.["@azure-tools/typespec-autorest"]?.["azure-resource-provider-folder"];

    if (specType == "data-plane") {
      return true;
    } else if (specType == "resource-manager") {
      return false;
    } else {
      throw new Error(
        "tspconfig.yaml must define the following property:\n" +
          "\n" +
          "options:\n" +
          '  "@azure-tools/typespec-autorest":\n' +
          '    azure-resource-provider-folder: "data-plane" | "resource-manager"',
      );
    }
  }
}
