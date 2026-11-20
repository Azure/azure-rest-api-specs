import { globFiles } from "@azure-tools/specs-shared/glob";
import type { ILogger } from "@azure-tools/specs-shared/logger";
import { readdir } from "node:fs/promises";
import { extname, join } from "pathe";
import { failure, type Diagnostic, type RuleResult } from "../rule-result.ts";
import type { Rule } from "../rule.ts";
import { fileExists, getSuppressions } from "../utils.ts";

export class UnifiedExamplesRule implements Rule {
  readonly name = "UnifiedExamples";
  readonly description = "Require unified YAML authoring instead of legacy JSON examples.";

  async execute(folder: string, logger: ILogger): Promise<RuleResult> {
    const suppression = (await getSuppressions(folder)).find(
      (entry) => entry.rules?.includes(this.name) && !entry.subRules?.length,
    );
    if (suppression) {
      const yamlFiles = await globFiles(["examples.yaml", "examples/*.yaml"], { cwd: folder });
      if (yamlFiles.length > 0) {
        return failure(
          "unified-examples-suppression",
          "A project with unified YAML examples must not retain its legacy JSON example suppression.",
          {
            path: folder,
            help: "Remove this project's UnifiedExamples suppression so JSON examples cannot be reintroduced.",
          },
        );
      }
      logger.debug(`Legacy JSON examples suppressed: ${suppression.reason}`);
      return { success: true, suppressed: suppression.reason };
    }

    const examplesFolder = join(folder, "examples");
    const folders = (await fileExists(examplesFolder)) ? [examplesFolder] : [];
    const jsonFiles: string[] = [];
    for (const current of folders) {
      for (const entry of await readdir(current, { withFileTypes: true })) {
        const path = join(current, entry.name);
        if (entry.isDirectory()) {
          if (entry.name !== "node_modules" && entry.name !== ".git") folders.push(path);
        } else if (extname(entry.name).toLowerCase() === ".json") {
          jsonFiles.push(path);
        }
      }
    }
    const diagnostics: Diagnostic[] = jsonFiles.sort().map((file) => ({
      severity: "error",
      code: "json-examples",
      path: file,
      message: "Authored JSON examples are not allowed in this project.",
      help:
        'Author examples in "examples.yaml" or "examples/<Interface>.yaml" instead. ' +
        "Keep generated JSON examples in the versioned Swagger output folders.",
    }));
    return { success: diagnostics.length === 0, diagnostics };
  }
}
