import type { ILogger } from "@azure-tools/specs-shared/logger";
import { readFile } from "node:fs/promises";
import { join } from "pathe";
import { failure, type RuleResult } from "../rule-result.ts";
import { type Rule } from "../rule.ts";
import { fileExists } from "../utils.ts";

export class ClientTspImportRule implements Rule {
  readonly name = "ClientTspImport";
  readonly description = "Validates that main.tsp imports client.tsp when client.tsp exists";
  readonly suppressable = true;

  async execute(folder: string, logger: ILogger): Promise<RuleResult> {
    const mainTspPath = join(folder, "main.tsp");
    const clientTspPath = join(folder, "client.tsp");

    const mainExists = await fileExists(mainTspPath);
    const clientExists = await fileExists(clientTspPath);

    if (!mainExists || !clientExists) {
      return { success: true, skipped: "main.tsp or client.tsp not found" };
    }

    const mainContent = await readFile(mainTspPath, { encoding: "utf8" });

    // Match import statement for ./client.tsp with single or double quotes
    const importPattern = /^\s*import\s+['"]\.\/client\.tsp['"]\s*;\s*$/m;

    if (importPattern.test(mainContent)) {
      logger.debug("main.tsp correctly imports client.tsp");
      return { success: true };
    }

    return failure("client-tsp-import", "main.tsp does not import client.tsp.", {
      path: mainTspPath,
      help: 'Add import "./client.tsp"; so client customizations are included during compilation.',
    });
  }
}
