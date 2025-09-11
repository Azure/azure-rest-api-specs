import { join } from "path";
import { parse as yamlParse } from "yaml";
import { RuleResult } from "../rule-result.js";
import { Rule } from "../rule.js";
import { fileExists, readTspConfig } from "../utils.js";

// Maps deprecated rulesets to the replacement rulesets
const deprecatedRulesets = new Map<string, string>([
  ["@azure-tools/typespec-azure-core/all", "@azure-tools/typespec-azure-rulesets/data-plane"],
  [
    "@azure-tools/typespec-azure-resource-manager/all",
    "@azure-tools/typespec-azure-rulesets/resource-manager",
  ],
]);

export class LinterRulesetRule implements Rule {
  readonly name = "LinterRuleset";

  readonly description =
    "Ensures each spec includes the correct linter ruleset (data-plane or management-plane)";

  async execute(folder: string): Promise<RuleResult> {
    let success = true;
    let stdOutput = "";
    let errorOutput = "";

    const configText = await readTspConfig(folder);
    const config = yamlParse(configText);

    const rpFolder =
      config?.options?.["@azure-tools/typespec-autorest"]?.["azure-resource-provider-folder"];
    stdOutput += `azure-resource-provider-folder: ${JSON.stringify(rpFolder)}\n`;

    const mainTspExists = await fileExists(join(folder, "main.tsp"));
    const clientTspExists = await fileExists(join(folder, "client.tsp"));
    let files = [];
    if (mainTspExists) {
      files.push("main.tsp");
    }
    if (clientTspExists) {
      files.push("client.tsp");
    }
    stdOutput += `files: ${JSON.stringify(files)}\n`;

    const linterExtends: string[] = config?.linter?.extends;
    stdOutput += `linter.extends: ${JSON.stringify(linterExtends)}`;

    let requiredRuleset = "";
    if (rpFolder?.trim()?.endsWith("resource-manager")) {
      requiredRuleset = "@azure-tools/typespec-azure-rulesets/resource-manager";
    } else if (rpFolder?.trim()?.endsWith("data-plane")) {
      requiredRuleset = "@azure-tools/typespec-azure-rulesets/data-plane";
    } else if (clientTspExists && !mainTspExists) {
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

    if (linterExtends) {
      for (const ruleset of linterExtends) {
        if (deprecatedRulesets.has(ruleset)) {
          const newRuleset = deprecatedRulesets.get(ruleset);

          success = false;
          errorOutput +=
            "tspconfig.yaml references the following ruleset which is deprecated:\n" +
            "\n" +
            "linter:\n" +
            "  extends:\n" +
            `    - "${ruleset}"\n` +
            "\n" +
            "It should be replaced with the following:\n" +
            "\n" +
            "linter:\n" +
            "  extends:\n" +
            `    - "${newRuleset}"`;
        }
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
