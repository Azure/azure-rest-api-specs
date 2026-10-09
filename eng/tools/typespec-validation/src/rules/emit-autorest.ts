import type { ILogger } from "@azure-tools/specs-shared/logger";
import { join } from "pathe";
import { failure, type RuleResult } from "../rule-result.ts";
import { type Rule } from "../rule.ts";
import { parse } from "../tsp-config.ts";
import { fileExists, readTspConfig } from "../utils.ts";

export class EmitAutorestRule implements Rule {
  readonly name = "EmitAutorest";

  readonly description = 'Must emit "@azure-tools/typespec-autorest" by default';

  readonly suppressable = true;

  async execute(folder: string, logger: ILogger): Promise<RuleResult> {
    const mainTspExists = await fileExists(join(folder, "main.tsp"));
    logger.debug(`mainTspExists: ${mainTspExists}`);

    if (mainTspExists) {
      const configText = await readTspConfig(folder);
      const config = parse(configText, join(folder, "tspconfig.yaml"));

      const emit = config?.emit;
      logger.debug(`emit: ${JSON.stringify(emit)}`);
      if (!emit?.includes("@azure-tools/typespec-autorest")) {
        return failure(
          "emit-autorest",
          'The default emit list must include "@azure-tools/typespec-autorest".',
          {
            path: join(folder, "tspconfig.yaml"),
            help: 'Add "@azure-tools/typespec-autorest" to "emit".',
          },
        );
      }
    }
    return { success: true, ...(mainTspExists ? {} : { skipped: "main.tsp not found" }) };
  }
}
