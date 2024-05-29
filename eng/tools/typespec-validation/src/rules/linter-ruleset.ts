import { readFile } from "fs/promises";
import { join } from "path";
import { parse as yamlParse } from "yaml";
import { Rule } from "../rule.js";
import { RuleResult } from "../rule-result.js";
import { TsvHost } from "../tsv-host.js";

export class LinterRulesetRule implements Rule {
  readonly name = "LinterRuleset";

  readonly description = "Specs must select correct linter ruleset";

  async execute(host: TsvHost, folder: string): Promise<RuleResult> {
    let success = true;
    let stdOutput = "";
    let errorOutput = "";

    const configText = await host.readTspConfig(folder);
    const config = yamlParse(configText);

    const rpFolder =
      config.options?.["@azure-tools/typespec-autorest"]?.["azure-resource-provider-folder"];
    stdOutput += `azure-resource-provider-folder: ${JSON.stringify(rpFolder)}\n`;

    const linterExtends = config.linter?.extends;
    stdOutput += `linter.extends: ${JSON.stringify(linterExtends)}`;

    let requiredRuleset = "";
    if (rpFolder?.trim()?.endsWith("resource-manager")) {
      requiredRuleset = "@azure-tools/typespec-azure-rulesets/resource-manager";
    } else if (rpFolder?.trim()?.endsWith("data-plane")) {
      requiredRuleset = "@azure-tools/typespec-azure-rulesets/data-plane";
    } else {
      const clientTspExists = await host.checkFileExists(join(folder, "client.tsp"));
      const mainTspExists = await host.checkFileExists(join(folder, "main.tsp"));

      if (clientTspExists && !mainTspExists) {
        // Assume folders with no autorest setting, containing only "client.tsp" but no "main.tsp",
        // are data-plane (e.g. HealthInsights.TrialMatcher)
        requiredRuleset = "@azure-tools/typespec-azure-rulesets/data-plane";
      } else {
        // Cannot determine if spec is data-plane or resource-manager, so cannot know
        // which linter ruleset is required.
        success = false;
        errorOutput +=
          "tspconfig.yaml must define the following property:\n" +
          "\n" +
          "options:\n" +
          '  "@azure-tools/typespec-autorest":\n' +
          '    azure-resource-provider-folder: "data-plane" | "resource-manager"\n';
      }
    }

    if (requiredRuleset && !linterExtends?.includes(requiredRuleset)) {
      success = false;
      errorOutput +=
        "tspconfig.yaml must define the following property:\n" +
        "\n" +
        "linter:\n" +
        "  extends:\n" +
        `    - "${requiredRuleset}"`;
    }

    return {
      success: success,
      stdOutput: stdOutput,
      errorOutput: errorOutput,
    };
  }
}
