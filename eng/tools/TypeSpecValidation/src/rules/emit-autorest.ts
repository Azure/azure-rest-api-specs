import { join } from "path";
import { parse as yamlParse } from "yaml";
import { Rule } from "../rule.js";
import { RuleResult } from "../rule-result.js";
import { TsvHost } from "../tsv-host.js";

export class EmitAutorestRule implements Rule {
  readonly name = "EmitAutorest";

  readonly description = 'Must emit "@azure-tools/typespec-autorest" by default';

  async execute(host: TsvHost, folder: string): Promise<RuleResult> {
    let success = true;
    let stdOutput = "";
    let errorOutput = "";

    const mainTspExists = await host.checkFileExists(join(folder, "main.tsp"));
    stdOutput += `mainTspExists: ${mainTspExists}\n`;

    if (mainTspExists) {
      const configText = await host.readTspConfig(folder);
      const config = yamlParse(configText);

      const emit = config?.emit;
      stdOutput += `emit: ${JSON.stringify(emit)}\n`;

      if (!emit?.includes("@azure-tools/typespec-autorest")) {
        success = false;
        errorOutput +=
          "tspconfig.yaml must include the following emitter by default:\n" +
          "\n" +
          "emit:\n" +
          '  - "@azure-tools/typespec-autorest"\n';
      }
    }

    return {
      success: success,
      stdOutput: stdOutput,
      errorOutput: errorOutput,
    };
  }
}
