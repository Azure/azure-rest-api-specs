import { parseArgsWithHelp, type CliOption } from "@azure-tools/specs-shared/cli";
import { reportDiagnostics, exceptionDiagnostic } from "@azure-tools/specs-shared/diagnostics";
import { ConsoleLogger } from "@azure-tools/specs-shared/logger";
import type { Diagnostic } from "@azure-tools/specs-shared/rule-result";
import { appendFile } from "node:fs/promises";
import { validatePr } from "./index.ts";

export async function writeBrownfield(
  value: boolean | undefined,
  output = process.env.GITHUB_OUTPUT,
): Promise<void> {
  if (value !== undefined && output) await appendFile(output, `brownfield=${value}\n`);
}

export function reportPrDiagnostics(
  diagnostics: readonly Diagnostic[],
  logger: ConsoleLogger,
): void {
  reportDiagnostics(diagnostics, logger, "spec-pr-validation");
  const escape = (value: string) =>
    value.replaceAll("%", "%25").replaceAll("\r", "%0D").replaceAll("\n", "%0A");
  for (const diagnostic of diagnostics) {
    const message = escape(diagnostic.message);
    if (process.env.SYSTEM_TEAMPROJECTID) {
      console.log(
        `##vso[task.logissue type=${diagnostic.severity};${diagnostic.path ? `sourcepath=${escape(diagnostic.path)};` : ""}]${message}`,
      );
    } else if (process.env.GITHUB_ACTIONS) {
      const path = diagnostic.path
        ? ` file=${escape(diagnostic.path).replaceAll(":", "%3A").replaceAll(",", "%2C")},line=${diagnostic.location?.line ?? 1},col=${diagnostic.location?.column ?? 1}`
        : "";
      console.log(`::${diagnostic.severity}${path}::${message}`);
    }
  }
}

export async function main(args = process.argv.slice(2)): Promise<void> {
  let logger = new ConsoleLogger();
  try {
    const options = {
      base: {
        type: "string",
        description: "Required base revision to compare.",
        valueLabel: "<commit>",
      },
      head: {
        type: "string",
        description: "Head revision (default: HEAD).",
        valueLabel: "<commit>",
      },
      verbose: {
        type: "boolean",
        short: "v",
        description: "Include policy progress and discovery details.",
      },
    } satisfies Record<string, CliOption>;
    const parsed = parseArgsWithHelp({
      args,
      options,
      help: {
        command: "pnpm spec-pr-validation",
        title: "Spec PR Validation",
        description: "Validate policies for committed specification changes.",
        notes: [
          "--base is required. Comparisons use the supplied endpoints without computing a merge base.",
          "Validation uses the current checkout; --head does not check out another revision.",
          "TypeSpec Requirement determines existing OpenAPI versions against upstream main.",
        ],
        examples: [
          "--base=HEAD^ --head=HEAD",
          '--base="$(git merge-base origin/main HEAD)" --head=HEAD',
        ],
      },
    });
    if (!parsed) return;
    logger = new ConsoleLogger(parsed.values.verbose);
    if (!parsed.values.base) throw new Error("--base is required");
    const result = await validatePr({ base: parsed.values.base, head: parsed.values.head, logger });
    reportPrDiagnostics(result.diagnostics, logger);
    logger.info(result.summary);
    await writeBrownfield(result.brownfield);
    if (!result.success) process.exitCode = 1;
  } catch (error) {
    logger.debug(error instanceof Error ? (error.stack ?? error.message) : String(error));
    reportPrDiagnostics([exceptionDiagnostic(error)], logger);
    process.exitCode = 1;
  }
}
