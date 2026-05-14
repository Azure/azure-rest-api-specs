import { join } from "path";
import { RuleResult } from "../rule-result.js";
import { Rule } from "../rule.js";
import { parse } from "../tsp-config.js";
import { fileExists, getSuppressions, readTspConfig } from "../utils.js";

export class EmitAutorestRule implements Rule {
  readonly name = "EmitAutorest";

  readonly description = 'Must emit "@azure-tools/typespec-autorest" by default';

  async execute(folder: string): Promise<RuleResult> {
    const suppressions = (await getSuppressions(folder)).filter((s) =>
      s.rules?.includes(this.name),
    );
    const suppressAll = suppressions.find(
      (s) => s.subRules === undefined || s.subRules.length === 0,
    );
    if (suppressAll) {
      return { success: true, stdOutput: `suppressed: ${suppressAll.reason}` };
    }

    let success = true;
    let stdOutput = "";
    let errorOutput = "";

    const mainTspExists = await fileExists(join(folder, "main.tsp"));
    stdOutput += `mainTspExists: ${mainTspExists}\n`;

    if (mainTspExists) {
      const configText = await readTspConfig(folder);
      const config = parse(configText);

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
