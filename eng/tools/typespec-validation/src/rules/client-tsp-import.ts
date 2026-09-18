import { readFile } from "fs/promises";
import { join } from "path";
import { type RuleResult } from "../rule-result.ts";
import { type Rule } from "../rule.ts";
import { fileExists } from "../utils.ts";

export class ClientTspImportRule implements Rule {
  readonly name = "ClientTspImport";
  readonly description = "Validates that main.tsp imports client.tsp when client.tsp exists";
  readonly suppressable = true;

  async execute(folder: string): Promise<RuleResult> {
    const mainTspPath = join(folder, "main.tsp");
    const clientTspPath = join(folder, "client.tsp");

    const mainExists = await fileExists(mainTspPath);
    const clientExists = await fileExists(clientTspPath);

    if (!mainExists || !clientExists) {
      return { success: true, stdOutput: "Skipped: main.tsp or client.tsp not found" };
    }

    const mainContent = await readFile(mainTspPath, { encoding: "utf8" });

    // Match import statement for ./client.tsp with single or double quotes
    const importPattern = /^\s*import\s+['"]\.\/client\.tsp['"]\s*;\s*$/m;

    if (importPattern.test(mainContent)) {
      return { success: true, stdOutput: "main.tsp correctly imports client.tsp" };
    }

    return {
      success: false,
      errorOutput:
        `main.tsp does not import client.tsp. ` +
        `When a client.tsp file exists alongside main.tsp, the main.tsp must include:\n\n` +
        `  import "./client.tsp";\n\n` +
        `This ensures client customizations are included during compilation.`,
    };
  }
}
