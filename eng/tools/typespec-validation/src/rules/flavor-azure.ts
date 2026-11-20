import type { ILogger } from "@azure-tools/specs-shared/logger";
import { join } from "pathe";
import { type Diagnostic, type RuleResult } from "../rule-result.ts";
import { type Rule } from "../rule.ts";
import { parse } from "../tsp-config.ts";
import { readTspConfig } from "../utils.ts";

export class FlavorAzureRule implements Rule {
  readonly name = "FlavorAzure";

  readonly description = "Client emitters must set 'flavor:azure'";

  async execute(folder: string, logger: ILogger): Promise<RuleResult> {
    const diagnostics: Diagnostic[] = [];

    const configText = await readTspConfig(folder);
    const config = parse(configText, join(folder, "tspconfig.yaml"));

    const options = config?.options;
    for (const emitter in options) {
      if (this.requiresAzureFlavor(emitter)) {
        const flavor = options[emitter]?.flavor;
        logger.debug(`${emitter}.flavor: ${JSON.stringify(flavor)}`);

        if (flavor !== "azure") {
          diagnostics.push({
            severity: "error",
            code: "flavor-azure",
            path: join(folder, "tspconfig.yaml"),
            message: `Emitter "${emitter}" must use the Azure flavor.`,
            help: `Set options.${emitter}.flavor to "azure".`,
          });
        }
      }
    }

    return {
      success: diagnostics.length === 0,
      diagnostics,
    };
  }

  requiresAzureFlavor(name: string): boolean {
    if (name === "@typespec/http-client-csharp") {
      // C# emitters do not require flavor:azure. Instead, there
      // is a separate emitter for Azure - @azure-typespec/http-client-csharp
      return false;
    }
    const regex = new RegExp(
      "^(@azure-tools/typespec-(csharp|java|python|ts)|@typespec/http-client-.+)$",
    );

    return regex.test(name);
  }
}
