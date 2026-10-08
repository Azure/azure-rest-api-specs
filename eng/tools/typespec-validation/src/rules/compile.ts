import { filterAsync } from "@azure-tools/specs-shared/array";
import { untilLastSegmentWithParent } from "@azure-tools/specs-shared/path";
import { getRootFolder } from "@azure-tools/specs-shared/simple-git";
import type { ILogger } from "@azure-tools/specs-shared/logger";
import { readFile } from "node:fs/promises";
import { stripVTControlCharacters } from "node:util";
import path, { basename, dirname, normalize } from "pathe";
import { reportCommandOutput } from "../command-output.ts";
import { blocks, filePath, indent, lines, verbatim } from "../diagnostic-content.ts";
import { globFiles } from "../glob.ts";
import { type Diagnostic, type RuleResult } from "../rule-result.ts";
import { type Rule } from "../rule.ts";
import {
  allowGeneratedChanges,
  fileExists,
  getStructureVersion,
  getSuppressions,
  gitDiffTopSpecFolder,
  runNodeBin,
} from "../utils.ts";

export class CompileRule implements Rule {
  readonly name = "Compile";
  readonly description = "Compile TypeSpec";

  async execute(folder: string, logger: ILogger): Promise<RuleResult> {
    let success = true;
    const diagnostics: Diagnostic[] = [];

    const mainTspExists = await fileExists(path.join(folder, "main.tsp"));
    if (mainTspExists) {
      const [err, stdout, stderr] = await runNodeBin(
        "@typespec/compiler",
        // Capture the inventory even when quiet: ExtraSwagger validation depends on it.
        ["tsp", "compile", "--list-files", "--warn-as-error", folder],
        logger,
      );
      const compiled = reportCommandOutput(
        "compile",
        "TypeSpec compilation",
        [err, stdout, stderr],
        logger,
      );
      diagnostics.push(...(compiled.diagnostics ?? []));

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
          const outputLines = stripVTControlCharacters(stdout).split(/\r?\n/);

          // TODO: Use helpers in /.github once they support platform-specific paths
          // Header, footer, and empty lines should be excluded by JSON filter
          const outputSwaggers = outputLines
            // Remove leading and trailing whitespace
            .map((l) => l.trim())
            // Normalize separators to forward slashes
            .map((l) => normalize(l))
            // Filter to JSON files
            .filter((p) => basename(p).toLowerCase().endsWith(".json"))
            // Exclude examples
            .filter((p) => !p.split(path.sep).includes("examples"));

          logger.debug(`Generated Swaggers:\n${outputSwaggers.join("\n")}`);

          if (outputSwaggers.length === 0) {
            logger.debug("No generated swaggers found, skipping extra swagger check.");
          } else {
            // ../resource-manager/Microsoft.Contoso
            const outputFolder = dirname(dirname(dirname(outputSwaggers[0])));
            const outputFilename = basename(outputSwaggers[0]);

            logger.debug(`Output folder:\n${outputFolder}`);

            const gitRoot = await getRootFolder(folder);
            const relativeFolder = path.relative(gitRoot, folder).split(path.sep).join("/");

            if (getStructureVersion(relativeFolder) === 2) {
              // Projects may intentionally share emitted Swagger at their service's specification root.
              const allowedOutputFolderPath = untilLastSegmentWithParent(folder, "specification");
              if (!allowedOutputFolderPath) {
                throw new Error(`Could not determine the allowed output folder for '${folder}'`);
              }

              const allowedOutputFolder = path.relative(process.cwd(), allowedOutputFolderPath);
              const outputFolderRelativeToAllowed = path.relative(
                allowedOutputFolderPath,
                path.resolve(outputFolder),
              );

              logger.debug(`Allowed output folder:\n${allowedOutputFolder}`);

              if (
                outputFolderRelativeToAllowed === ".." ||
                outputFolderRelativeToAllowed.startsWith(`..${path.sep}`) ||
                path.isAbsolute(outputFolderRelativeToAllowed)
              ) {
                throw new Error(
                  `Output folder '${outputFolder}' must be under path '${allowedOutputFolder}'`,
                );
              }
            }

            // Filter to only specs matching the folder and filename extracted from the first output-file.
            // Necessary to handle multi-project specs like keyvault.
            //
            // Glob patterns use forward slashes on all platforms.
            const pattern = path.join(outputFolder, "**", outputFilename);
            const allSwaggers = (await globFiles(pattern, { exclude: ["**/examples/**"] })).map(
              (p) => normalize(p),
            );

            // Filter to files generated by TypeSpec
            const tspGeneratedSwaggers = await filterAsync(
              allSwaggers,
              async (swaggerPath: string) => {
                const swaggerText = await readFile(swaggerPath, { encoding: "utf8" });
                const swaggerObj = JSON.parse(swaggerText) as {
                  info?: Record<string, unknown>;
                };
                return (
                  swaggerObj["info"]?.["x-typespec-generated"] !== undefined ||
                  swaggerObj["info"]?.["x-cadl-generated"] !== undefined
                );
              },
            );

            logger.debug(
              `Swaggers matching output folder and filename:\n${tspGeneratedSwaggers.join("\n")}`,
            );

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

            logger.debug(
              `Swaggers excluded via suppressions.yaml:\n${suppressedSwaggers.join("\n")}`,
            );

            const remainingSwaggers = tspGeneratedSwaggers.filter(
              (s) => !suppressedSwaggers.includes(s),
            );

            logger.debug(`Remaining swaggers:\n${remainingSwaggers.join("\n")}`);

            const extraSwaggers = remainingSwaggers.filter((s) => !outputSwaggers.includes(s));

            if (extraSwaggers.length > 0) {
              // Helper function to extract version from swagger path
              const extractVersion = (swaggerPath: string): string | null => {
                const match = swaggerPath.match(/\/(preview|stable)\/([^/]+)\//);
                return match ? match[2] : null;
              };

              // Check if all extra swaggers are preview versions
              const allArePreview = extraSwaggers.every((s) => s.includes("/preview/"));

              let isOnlyOlderPreviews = false;
              if (allArePreview) {
                // Get all versions (preview and stable) from tspGeneratedSwaggers.
                // A later preview *or* stable version is allowed to supersede an older
                // preview, leaving the older preview's swagger in place.
                const generatedVersions = tspGeneratedSwaggers
                  .map(extractVersion)
                  .filter((v): v is string => v !== null);

                if (generatedVersions.length > 0) {
                  // Find the latest generated version (sort descending)
                  const sortedVersions = [...new Set(generatedVersions)].sort().reverse();
                  const latestGeneratedVersion = sortedVersions[0];

                  // Check if any extraSwagger is from the latest generated version
                  const hasLatestVersion = extraSwaggers.some((s) => {
                    const version = extractVersion(s);
                    return version === latestGeneratedVersion;
                  });

                  isOnlyOlderPreviews = !hasLatestVersion;
                }
              }

              if (!isOnlyOlderPreviews) {
                success = false;
                diagnostics.push({
                  severity: "error",
                  code: "extra-swagger",
                  path: outputFolder,
                  message:
                    "Found TypeSpec-generated Swagger files not generated from the current TypeSpec sources.",
                  help: "If a version was removed, delete its associated Swagger files.",
                  details: indent(lines(extraSwaggers.map(filePath))),
                });
              } else {
                logger.debug(
                  `Found extra preview swaggers from older versions (not the latest version). These are allowed to remain:\n${extraSwaggers.join("\n")}`,
                );
              }
            }
          }
        } else {
          success = false;
        }
      }
    }

    const clientTsp = path.join(folder, "client.tsp");
    if (!mainTspExists && (await fileExists(clientTsp))) {
      const [err, stdout, stderr] = await runNodeBin(
        "@typespec/compiler",
        ["tsp", "compile", "--no-emit", "--warn-as-error", clientTsp],
        logger,
      );
      const compiled = reportCommandOutput(
        "compile",
        "Client TypeSpec compilation",
        [err, stdout, stderr],
        logger,
      );
      diagnostics.push(...(compiled.diagnostics ?? []));
      if (err) {
        success = false;
      }
    }

    if (success) {
      const gitDiffResult = await gitDiffTopSpecFolder(folder, logger);
      if (!gitDiffResult.success) {
        const allowed = allowGeneratedChanges();
        if (!allowed) success = false;
        diagnostics.push({
          severity: allowed ? "warning" : "error",
          code: "generated-files-changed",
          path: folder,
          message: "Files changed after TypeSpec compilation:",
          details: blocks(
            indent(lines(gitDiffResult.files.map(filePath))),
            verbatim(gitDiffResult.diff ?? ""),
          ),
          help: "Run `pnpm exec tsp compile .` from the project folder and include the generated files in your change.",
        });
      }
    }

    return {
      success: success,
      diagnostics,
    };
  }
}
