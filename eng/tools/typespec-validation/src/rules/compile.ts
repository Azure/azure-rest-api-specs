import { filterAsync } from "@azure-tools/specs-shared/array";
import { example, json } from "@azure-tools/specs-shared/changed-files";
import { readFile } from "fs/promises";
import { globby } from "globby";
import { basename, dirname, join, posix, relative, resolve, win32 } from "path";
import pc from "picocolors";
import stripAnsi from "strip-ansi";
import { RuleResult } from "../rule-result.js";
import { Rule } from "../rule.js";
import { fileExists, getSuppressions, gitDiffTopSpecFolder, runNpm } from "../utils.js";

export class CompileRule implements Rule {
  readonly name = "Compile";
  readonly description = "Compile TypeSpec";

  untilLastParentSegment(path: string, segment: string): string {
    let current = resolve(path);

    while (true) {
      const parent = dirname(current);

      if (basename(parent) === segment) {
        // Found the target parent.  Return current.
        return current;
      } else if (parent === current) {
        // Reached the filesystem root (folder not found).  Return empty string.
        return "";
      } else {
        // Keep walking upward
        current = parent;
      }
    }
  }

  /**
   * @param folder absolute path to folder containing tspconfig.yaml
   */
  async execute(folder: string): Promise<RuleResult> {
    let success = true;
    let stdOutput = "";
    let errorOutput = "";

    if (await fileExists(join(folder, "main.tsp"))) {
      const [err, stdout, stderr] = await runNpm([
        "exec",
        "--no",
        "--",
        "tsp",
        "compile",
        "--list-files",
        "--warn-as-error",
        folder,
      ]);

      stdOutput += stdout;

      // Rule output is easier to read if "tsp compile" stderr is redirected to stdOutput
      stdOutput += stderr;

      if (
        stdout.toLowerCase().includes("no emitter was configured") ||
        stdout.toLowerCase().includes("no output was generated")
      ) {
        success = false;
        errorOutput += "No emitter was configured and/or no output was generated.";
      }

      if (success) {
        if (!err) {
          // Check for *extra* typespec-generated swagger files under the output folder, which
          // indicates a mismatch between TypeSpec and swaggers.

          // Example 'stdout':
          //
          // TypeSpec compiler v0.67.2
          //
          // ../resource-manager/Microsoft.Contoso/stable/2021-11-01/contoso.json
          // ../resource-manager/Microsoft.Contoso/stable/2021-11-01/examples/Operations_List.json
          //
          // Compilation completed successfully.

          // Remove ANSI color codes, handle windows and linux line endings
          const lines = stripAnsi(stdout).split(/\r?\n/);

          // TODO: Use helpers in /.github once they support platform-specific paths
          // Header, footer, and empty lines should be excluded by JSON filter
          const outputSwaggers = lines
            // Remove leading and trailing whitespace
            .map((l) => l.trim())
            .map((l) => resolve(l))
            // Filter to JSON files, excluding examples
            .filter((s) => json(s) && !example(s));

          stdOutput += "\nGenerated Swaggers:\n";
          stdOutput += outputSwaggers.map((s) => relative("", s)).join("\n") + "\n";

          if (outputSwaggers.length === 0) {
            throw new Error("No generated swaggers found in output of 'tsp compile'");
          }

          // /specs/specification/contosowidgetmanager/resource-manager/Microsoft.Contoso
          const outputFolder = dirname(dirname(dirname(outputSwaggers[0])));
          stdOutput += "\nOutput folder:\n";
          stdOutput += relative("", outputFolder) + "\n";

          const structureVersion =
            basename(dirname(folder)) === "data-plane" ||
            basename(dirname(folder)) === "resource-manager" ||
            basename(dirname(dirname(folder))) === "data-plane" ||
            basename(dirname(dirname(folder))) === "resource-manager"
              ? 2
              : 1;

          const allowedOutputFolder =
            structureVersion === 2 ? folder : this.untilLastParentSegment(folder, "specification");

          stdOutput += "\nAllowed output folder:\n";
          stdOutput += relative("", allowedOutputFolder) + "\n";

          if (!outputFolder.startsWith(allowedOutputFolder)) {
            throw new Error(
              `Output folder '${relative("", outputFolder)}' must be under path '${relative("", allowedOutputFolder)}'`,
            );
          }

          const outputFilename = basename(outputSwaggers[0]);

          // Filter to only specs matching the folder and filename extracted from the first output-file.
          // Necessary to handle multi-project specs like keyvault.
          //
          // Globby only accepts patterns like posix paths.
          const pattern = posix.join(...outputFolder.split(win32.sep), "**", outputFilename);
          const allSwaggers = (await globby(pattern, { ignore: ["**/examples/**"] })).map(
            // Globby always returns posix paths
            (p) => resolve(p),
          );

          // Filter to files generated by TypeSpec
          const tspGeneratedSwaggers = await filterAsync(
            allSwaggers,
            async (swaggerPath: string) => {
              const swaggerText = await readFile(swaggerPath, { encoding: "utf8" });
              const swaggerObj = JSON.parse(swaggerText);
              return (
                swaggerObj["info"]?.["x-typespec-generated"] ||
                swaggerObj["info"]?.["x-cadl-generated"]
              );
            },
          );

          stdOutput += `\nSwaggers matching output folder and filename:\n`;
          stdOutput += tspGeneratedSwaggers.map((s) => relative("", s)).join("\n") + "\n";

          const suppressedSwaggers = await filterAsync(
            tspGeneratedSwaggers,
            async (swaggerPath: string) => {
              const suppressions = await getSuppressions(swaggerPath);

              const extraSwaggerSuppressions = suppressions.filter(
                (s) => s.rules?.includes(this.name) && s.subRules?.includes("ExtraSwagger"),
              );

              // Each path must specify a single version (without wildcards) under "preview|stable"
              //
              // Allowed:    data-plane/Azure.Contoso.WidgetManager/preview/2022-11-01-preview/**/*.json
              // Disallowed: data-plane/Azure.Contoso.WidgetManager/preview/**/*.json
              // Disallowed: data-plane/**/*.json
              //
              // Include "." since a few specs use versions like "X.Y" instead of "YYYY-MM-DD"
              const singleVersionPattern = "/(preview|stable)/[A-Za-z0-9._-]+/";

              for (const suppression of extraSwaggerSuppressions) {
                for (const p of suppression.paths) {
                  if (!p.match(singleVersionPattern)) {
                    throw new Error(
                      `Invalid path '${p}'. Path must only include one version per suppression.`,
                    );
                  }
                }
              }

              return extraSwaggerSuppressions.length > 0;
            },
          );

          stdOutput += `\nSwaggers excluded via suppressions.yaml:\n`;
          stdOutput += suppressedSwaggers.map((s) => relative("", s)).join("\n") + "\n";

          const remainingSwaggers = tspGeneratedSwaggers.filter(
            (s) => !suppressedSwaggers.includes(s),
          );

          stdOutput += `\nRemaining swaggers:\n`;
          stdOutput += remainingSwaggers.map((s) => relative("", s)).join("\n") + "\n";

          const extraSwaggers = remainingSwaggers.filter((s) => !outputSwaggers.includes(s));

          if (extraSwaggers.length > 0) {
            success = false;
            errorOutput += pc.red(
              `\nOutput folder '${relative("", outputFolder)}' appears to contain TypeSpec-generated ` +
                `swagger files, not generated from the current TypeSpec sources. ` +
                `Perhaps you deleted a version from your TypeSpec, but didn't delete ` +
                `the associated swaggers?\n\n`,
            );
            errorOutput += pc.red(extraSwaggers.map((s) => relative("", s)).join("\n") + "\n");
          }
        } else {
          success = false;
          errorOutput += err.message;
        }
      }
    }

    const clientTsp = join(folder, "client.tsp");
    if (await fileExists(clientTsp)) {
      const [err, stdout, stderr] = await runNpm([
        "exec",
        "--no",
        "--",
        "tsp",
        "compile",
        "--no-emit",
        "--warn-as-error",
        clientTsp,
      ]);
      if (err) {
        success = false;
        errorOutput += err.message;
      }
      stdOutput += stdout;
      errorOutput += stderr;
    }

    if (success) {
      const gitDiffResult = await gitDiffTopSpecFolder(folder);
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
