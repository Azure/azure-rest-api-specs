import type { ILogger } from "@azure-tools/specs-shared/logger";
import { join } from "pathe";
import { type Diagnostic, type RuleResult } from "../rule-result.ts";
import { type Rule } from "../rule.ts";
import { parse } from "../tsp-config.ts";
import { fileExists, readTspConfig } from "../utils.ts";

// Maps deprecated rulesets to the replacement rulesets
const deprecatedRulesets = new Map<string, string>([
  ["@azure-tools/typespec-azure-core/all", "@azure-tools/typespec-azure-rulesets/data-plane"],
  [
    "@azure-tools/typespec-azure-resource-manager/all",
    "@azure-tools/typespec-azure-rulesets/resource-manager",
  ],
]);

// Ruleset required when any client (language) emitter has options defined
const clientSdkRuleset = "@azure-tools/typespec-azure-rulesets/client-sdk";

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
    "Ensures each spec includes the correct linter ruleset (data-plane or management-plane)";

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

    let requiredRuleset;
    if (
      normalizedFolder.includes("/resource-manager/") ||
      normalizedFolder.trim().endsWith(".Management")
    ) {
      requiredRuleset = "@azure-tools/typespec-azure-rulesets/resource-manager";
    } else if (clientTspExists && !mainTspExists) {
      // Assume folders with no autorest setting, containing only "client.tsp" but no "main.tsp",
      // are data-plane (e.g. HealthInsights.TrialMatcher)
      requiredRuleset = "@azure-tools/typespec-azure-rulesets/data-plane";
    } else {
      requiredRuleset = "@azure-tools/typespec-azure-rulesets/data-plane";
    }

    if (linterExtends) {
      for (const ruleset of linterExtends) {
        if (deprecatedRulesets.has(ruleset)) {
          const newRuleset = deprecatedRulesets.get(ruleset);

          diagnostics.push({
            severity: "error",
            code: "deprecated-ruleset",
            path: join(folder, "tspconfig.yaml"),
            message: `Linter ruleset "${ruleset}" is deprecated.`,
            help: `Replace it with "${newRuleset}" in linter.extends.`,
          });
        }
      }
    }

    if (requiredRuleset && !linterExtends?.includes(requiredRuleset)) {
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
    if (emittersWithOptions.length > 0 && !linterExtends?.includes(clientSdkRuleset)) {
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
