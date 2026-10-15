import type { ILogger } from "@azure-tools/specs-shared/logger";
import { join } from "pathe";
import { type Diagnostic, type RuleResult } from "../rule-result.ts";
import { type Rule } from "../rule.ts";
import { parse } from "../tsp-config.ts";
import { fileExists, readTspConfig } from "../utils.ts";

const deprecatedRulesets = new Set([
  "@azure-tools/typespec-azure-core/all",
  "@azure-tools/typespec-azure-resource-manager/all",
]);

const rulesetPackage = "@azure-tools/specs-typespec-rulesets";
const sdkCompatibleRulesetPackage = "@azure-tools/typespec-azure-rulesets";

function hasRuleset(linterExtends: string[] | undefined, ruleset: string): boolean {
  return [rulesetPackage, sdkCompatibleRulesetPackage].some((packageName) =>
    linterExtends?.includes(`${packageName}/${ruleset}`),
  );
}

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

  async execute(folder: string, logger: ILogger): Promise<RuleResult> {
    const diagnostics: Diagnostic[] = [];

    const configText = await readTspConfig(folder);
    const config = parse(configText, join(folder, "tspconfig.yaml"));

    const mainTspExists = await fileExists(join(folder, "main.tsp"));
    const clientTspExists = await fileExists(join(folder, "client.tsp"));
    const files = [];
    if (mainTspExists) {
      files.push("main.tsp");
    }
    if (clientTspExists) {
      files.push("client.tsp");
    }
    const linterExtends = config?.linter?.extends;
    logger.debug(
      `files: ${JSON.stringify(files)}\nlinter.extends: ${JSON.stringify(linterExtends)}`,
    );

    // Normalize path separators
    const normalizedFolder = folder.replace(/\\/g, "/");

    let requiredRulesetName: "resource-manager" | "data-plane";
    if (
      normalizedFolder.includes("/resource-manager/") ||
      normalizedFolder.trim().endsWith(".Management")
    ) {
      requiredRulesetName = "resource-manager";
    } else if (clientTspExists && !mainTspExists) {
      // Assume folders with no autorest setting, containing only "client.tsp" but no "main.tsp",
      // are data-plane (e.g. HealthInsights.TrialMatcher)
      requiredRulesetName = "data-plane";
    } else {
      requiredRulesetName = "data-plane";
    }
    const requiredRuleset = `${rulesetPackage}/${requiredRulesetName}`;

    if (linterExtends) {
      for (const ruleset of linterExtends) {
        if (deprecatedRulesets.has(ruleset)) {
          diagnostics.push({
            severity: "error",
            code: "deprecated-ruleset",
            path: join(folder, "tspconfig.yaml"),
            message: `Linter ruleset "${ruleset}" is deprecated.`,
            help: `Replace it with "${requiredRuleset}" in linter.extends.`,
          });
        }
      }
    }

    if (!hasRuleset(linterExtends, requiredRulesetName)) {
      diagnostics.push({
        severity: "error",
        code: "linter-ruleset",
        path: join(folder, "tspconfig.yaml"),
        message: `Missing required linter ruleset "${requiredRuleset}".`,
        help: `Add "${requiredRuleset}" to linter.extends.`,
      });
    }

    // If any client (language) emitter has options defined, the client-sdk ruleset is required.
    const emittersWithOptions = clientEmitters.filter(
      (emitter) => config?.options?.[emitter] !== undefined,
    );
    const clientSdkRuleset = `${rulesetPackage}/client-sdk`;
    if (emittersWithOptions.length > 0 && !hasRuleset(linterExtends, "client-sdk")) {
      diagnostics.push({
        severity: "error",
        code: "client-sdk-ruleset",
        path: join(folder, "tspconfig.yaml"),
        message: `Client emitters require the "${clientSdkRuleset}" ruleset: ${emittersWithOptions.join(", ")}.`,
        help: `Add "${clientSdkRuleset}" to linter.extends.`,
      });
    }

    return {
      success: diagnostics.length === 0,
      diagnostics,
    };
  }
}
