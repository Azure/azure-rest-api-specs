import { parse as yamlParse } from "yaml";
import { RuleResult } from "../rule-result.js";
import { Rule } from "../rule.js";
import { readTspConfig } from "../utils.js";

export class FlavorAzureRule implements Rule {
  readonly name = "FlavorAzure";

  readonly description = "Client emitters must set 'flavor:azure'";

  async execute(folder: string): Promise<RuleResult> {
    let success = true;
    let stdOutput = "";
    let errorOutput = "";

    const configText = await readTspConfig(folder);
    const config = yamlParse(configText);

    const options = config?.options;
    for (const emitter in options) {
      if (this.requiresAzureFlavor(emitter)) {
        const flavor = options[emitter]?.flavor;

        stdOutput += `"${emitter}":\n`;
        stdOutput += `  flavor: ${flavor}\n`;

        if (flavor !== "azure") {
          success = false;
          errorOutput +=
            "tspconfig.yaml must define the following property:\n" +
            "\n" +
            "options:\n" +
            `  "${emitter}":\n` +
            "    flavor: azure\n\n";
        }
      }
    }

    return {
      success: success,
      stdOutput: stdOutput,
      errorOutput: errorOutput,
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
