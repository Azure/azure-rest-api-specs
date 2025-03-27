import path, { basename, dirname, normalize } from "path";
import { setEquals } from "../../../../../.github/src/equality.js";
import { RuleResult } from "../rule-result.js";
import { Rule } from "../rule.js";
import { TsvHost } from "../tsv-host.js";

export class CompileRule implements Rule {
  readonly name = "Compile";
  readonly description = "Compile TypeSpec";

  async execute(host: TsvHost, folder: string): Promise<RuleResult> {
    let success = true;
    let stdOutput = "";
    let errorOutput = "";

    if (await host.checkFileExists(path.join(folder, "main.tsp"))) {
      let [err, stdout, stderr] = await host.runCmd(
        `npm exec --no -- tsp compile --list-files --warn-as-error ${folder}`,
      );

      if (
        stdout.toLowerCase().includes("no emitter was configured") ||
        stdout.toLowerCase().includes("no output was generated")
      ) {
        success = false;
        errorOutput += "No emitter was configured and/or no output was generated.";
      }

      if (!err) {
        // Example:
        //
        // TypeSpec compiler v0.67.2
        //
        // ../resource-manager/Microsoft.Contoso/stable/2021-11-01/contoso.json
        // ../resource-manager/Microsoft.Contoso/stable/2021-11-01/examples/Operations_List.json
        //
        // Compilation completed successfully.

        // Handle windows and linux line endings
        const lines = stdout.split(/\r?\n/);

        console.log(stdout);

        // TODO: Use helpers in /.github once they support platform-specific paths
        const outputSwaggers = lines
          // Remove leading and trailing whitespace
          .map((l) => l.trim())
          // Skip blank lines
          .filter((l) => l !== "")
          // Skip first and last lines (version and success messages)
          .slice(1, -1)
          // Normalize to platform-specific path
          .map((l) => normalize(l))
          // Filter to JSON files
          .filter((p) => basename(p).toLowerCase().endsWith(".json"))
          // Exclude examples
          .filter((p) => !p.split(path.sep).includes("examples"));

        console.log(JSON.stringify(outputSwaggers));

        // ../resource-manager/Microsoft.Contoso
        const outputFolder = dirname(dirname(dirname(outputSwaggers[0])));
        console.log(outputFolder);

        // Globby only accepts patterns like posix paths
        const pattern = path.posix.join(...outputFolder.split(path.win32.sep), "**", "*.json");
        console.log(pattern);

        const tspGeneratedSwaggers = await host.globby(pattern, { ignore: ["**/examples/**"] });
        // TODO: Check if each file contains x-typespec-generated
        console.log(JSON.stringify(tspGeneratedSwaggers));

        if (!setEquals(new Set(outputSwaggers), new Set(tspGeneratedSwaggers))) {
          success = false;
          errorOutput +=
            `Output folder '${outputFolder}' appears to contain TypeSpec-generated ` +
            `swagger files, not generated from the current TypeSpec sources.`;
        }
      } else {
        success = false;
        errorOutput += err.message;
      }

      stdOutput += stdout;
      errorOutput += stderr;
    }

    const clientTsp = path.join(folder, "client.tsp");
    if (await host.checkFileExists(clientTsp)) {
      let [err, stdout, stderr] = await host.runCmd(
        `npm exec --no -- tsp compile --no-emit --warn-as-error ${clientTsp}`,
      );
      if (err) {
        success = false;
        errorOutput += err.message;
      }
      stdOutput += stdout;
      errorOutput += stderr;
    }

    if (success) {
      const gitDiffResult = await host.gitDiffTopSpecFolder(host, folder);
      stdOutput += gitDiffResult.stdOutput;
      if (!gitDiffResult.success) {
        success = false;
        errorOutput += gitDiffResult.errorOutput;
        errorOutput += `\nFiles have been changed after \`tsp compile\`. Run \`tsp compile\` and ensure all files are included in your change.`;
      }
    }

    return {
      success: success,
      stdOutput: stdOutput,
      errorOutput: errorOutput,
    };
  }
}
