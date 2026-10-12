import { join } from "path";
import { type RuleResult } from "../rule-result.ts";
import { type Rule } from "../rule.ts";
import { parse } from "../tsp-config.ts";
import { fileExists, readTspConfig } from "../utils.ts";

const deprecatedRulesets = new Set([
  "@azure-tools/typespec-azure-core/all",
  "@azure-tools/typespec-azure-resource-manager/all",
]);

const rulesetPackage = "@azure-tools/specs-typespec-rulesets";

// Known client (language) emitters. When any of these has options defined in tspconfig.yaml,
// the client-sdk ruleset must be enabled. Excludes non-client emitters such as
// "@azure-tools/typespec-autorest" (swagger) and "@azure-tools/typespec-client-generator-cli".
const clientEmitters = [
  "@azure-tools/typespec-csharp",
  "@azure-typespec/http-client-csharp",
  "@azure-typespec/http-client-csharp-mgmt",
  "@azure-tools/typespec-python",
  "@azure-tools/typespec-java",
  "@azure-tools/typespec-ts",
  "@azure-tools/typespec-go",
  "@azure-tools/typespec-rust",
];

export class LinterRulesetRule implements Rule {
  readonly name = "LinterRuleset";

  readonly description =
    "Ensures each spec includes the repository-owned rulesets for its API plane and SDK emitters";

  async execute(folder: string): Promise<RuleResult> {
    let success = true;
    let stdOutput = "";
    let errorOutput = "";

    const configText = await readTspConfig(folder);
    const config = parse(configText);

    const mainTspExists = await fileExists(join(folder, "main.tsp"));
    const clientTspExists = await fileExists(join(folder, "client.tsp"));
    const files = [];
    if (mainTspExists) {
      files.push("main.tsp");
    }
    if (clientTspExists) {
      files.push("client.tsp");
    }
    stdOutput += `files: ${JSON.stringify(files)}\n`;

    const linterExtends = config?.linter?.extends;
    stdOutput += `linter.extends: ${JSON.stringify(linterExtends)}`;

    // Normalize path separators
    const normalizedFolder = folder.replace(/\\/g, "/");

    let requiredRuleset;
    if (
      normalizedFolder.includes("/resource-manager/") ||
      normalizedFolder.trim().endsWith(".Management")
    ) {
      requiredRuleset = `${rulesetPackage}/resource-manager`;
    } else if (clientTspExists && !mainTspExists) {
      // Assume folders with no autorest setting, containing only "client.tsp" but no "main.tsp",
      // are data-plane (e.g. HealthInsights.TrialMatcher)
      requiredRuleset = `${rulesetPackage}/data-plane`;
    } else {
      requiredRuleset = `${rulesetPackage}/data-plane`;
    }

    if (linterExtends) {
      for (const ruleset of linterExtends) {
        if (deprecatedRulesets.has(ruleset)) {
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
            `    - "${requiredRuleset}"`;
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

    // If any client (language) emitter has options defined, the client-sdk ruleset is required.
    const emittersWithOptions = clientEmitters.filter(
      (emitter) => config?.options?.[emitter] !== undefined,
    );
    const clientSdkRuleset = `${rulesetPackage}/client-sdk`;
    if (emittersWithOptions.length > 0 && !linterExtends?.includes(clientSdkRuleset)) {
      success = false;
      if (errorOutput) {
        errorOutput += "\n\n";
      }
      errorOutput +=
        "tspconfig.yaml defines options for the following client emitter(s):\n" +
        "\n" +
        emittersWithOptions.map((emitter) => `    - "${emitter}"`).join("\n") +
        "\n" +
        "\n" +
        "so it must define the following property:\n" +
        "\n" +
        "linter:\n" +
        "  extends:\n" +
        `    - "${clientSdkRuleset}"`;
    }

    return {
      success: success,
      stdOutput: stdOutput,
      errorOutput: errorOutput,
    };
  }
}
