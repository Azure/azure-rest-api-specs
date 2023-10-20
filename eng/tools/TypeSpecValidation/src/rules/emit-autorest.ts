import { readFile } from "fs/promises";
import { join } from "path";
import { parse as yamlParse } from "yaml";
import { Rule } from "../rule.js";
import { RuleResult } from "../rule-result.js";

export class EmitAutorestRule implements Rule {
  readonly name = "EmitAutorest";

  readonly description = "Ensures spec emits @azure-tools/typespec-autorest by default";

  async execute(folder: string): Promise<RuleResult> {
    let success = true;
    let stdOutput = "";
    let errorOutput = "";

    const configFile = join(folder, "tspconfig.yaml");
    const configText = await readFile(configFile, "utf8");
    const config = yamlParse(configText);

    const emit = config.emit;
    stdOutput += `emit: ${JSON.stringify(emit)}\n`;

    if (!emit?.includes("@azure-tools/typespec-autorest")) {
      success = false;
      errorOutput +=
        "tspconfig.yaml must include the following emitter by default:\n" +
        "\n" +
        "emit:\n" +
        '  - "@azure-tools/typespec-autorest"\n';
    }

    return {
      success: success,
      stdOutput: stdOutput,
      errorOutput: errorOutput,
    };
  }
}
