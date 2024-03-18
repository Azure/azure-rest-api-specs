import { parse as yamlParse } from "yaml";
import { Rule } from "../rule.js";
import { RuleResult } from "../rule-result.js";
import { TsvHost } from "../tsv-host.js";

export class FlavorAzureRule implements Rule {
  readonly name = "FlavorAzure";

  readonly description = "Client emitters must set 'flavor:azure'";

  async execute(host: TsvHost, folder: string): Promise<RuleResult> {
    let success = true;
    let stdOutput = "";
    let errorOutput = "";

    const configText = await host.readTspConfig(folder);
    const config = yamlParse(configText);

    const options = config?.options;
    for (const emitter in options) {
      if (this.isClientEmitter(emitter)) {
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

  isClientEmitter(name: string): boolean {
    const regex = new RegExp(
      "^(@azure-tools/typespec-(csharp|java|python|ts)|@typespec/http-client-.+)$",
    );

    return regex.test(name);
  }
}
