import {
  formatRuleStatus,
  formatRuleSummary,
  exceptionDiagnostic,
  type RuleCounts,
} from "@azure-tools/specs-shared/diagnostics";
import { ConsoleLogger, type ILogger } from "@azure-tools/specs-shared/logger";
import { failure, type Diagnostic, type RuleResult } from "@azure-tools/specs-shared/rule-result";
import { generateTypeSpecMetadata } from "@azure-tools/specs-shared/typespec-metadata";
import { join } from "pathe";
import { createContext, findChangedProjects } from "./context.ts";
import { evaluateMultipleNewApiVersions } from "./rules/multiple-new-api-versions.ts";
import { reproduceLocallyHint, resolveNewApiVersions } from "./rules/sdk-api-version.ts";
import { evaluateStaleApiVersionPin } from "./rules/stale-api-version-pin.ts";
import { ruleSuppressions } from "./suppressions.ts";
import { checkRequirements, type CheckUpstream } from "./typespec-requirement.ts";

export interface ValidationOptions {
  base: string;
  head?: string;
  cwd?: string;
  logger?: ILogger;
  checkUpstream?: CheckUpstream;
  metadata?: typeof generateTypeSpecMetadata;
}

export interface ValidationResult {
  readonly success: boolean;
  readonly diagnostics: Diagnostic[];
  readonly brownfield: boolean | undefined;
  readonly summary: string;
}

export async function validatePr(options: ValidationOptions): Promise<ValidationResult> {
  const logger = options.logger ?? new ConsoleLogger();
  const context = await createContext(
    options.cwd ?? process.cwd(),
    options.base,
    options.head ?? "HEAD",
    logger,
  );
  const diagnostics: Diagnostic[] = [];
  const counts: RuleCounts = { PASS: 0, FAIL: 0, WARN: 0, SKIP: 0, SUPPRESSED: 0 };
  const addResult = (name: string, result: RuleResult) => {
    diagnostics.push(...(result.diagnostics ?? []));
    const status = !result.success
      ? "FAIL"
      : result.suppressed !== undefined
        ? "SUPPRESSED"
        : result.diagnostics?.some((diagnostic) => diagnostic.severity === "warning")
          ? "WARN"
          : result.skipped !== undefined
            ? "SKIP"
            : "PASS";
    counts[status]++;
    logger.debug(formatRuleStatus(name, status));
    if (result.skipped) logger.debug(result.skipped);
    if (result.suppressed) logger.debug(`Suppressed: ${result.suppressed}`);
  };

  const requirement = await checkRequirements(context, options.checkUpstream);
  addResult("TypeSpecRequirement", {
    success: !requirement.diagnostics.some((diagnostic) => diagnostic.severity === "error"),
    diagnostics: requirement.diagnostics,
    skipped: requirement.checked === 0 ? "No OpenAPI files found to check" : undefined,
  });

  let projects: string[];
  try {
    projects = await findChangedProjects(context);
  } catch (error) {
    addResult("SDK project discovery", {
      success: false,
      diagnostics: [exceptionDiagnostic(error, context.root)],
    });
    return result();
  }

  for (const folder of projects) {
    logger.debug(`Checking SDK-version policies in ${folder}`);
    try {
      const names = ["MultipleNewApiVersions", "StaleApiVersionPin"] as const;
      const suppressions = await Promise.all(
        names.map((name) => ruleSuppressions(context, folder, name)),
      );
      if (suppressions.every((entries) => entries.length > 0)) {
        names.forEach((name, index) =>
          addResult(name, { success: true, suppressed: suppressions[index][0].reason }),
        );
        continue;
      }
      const versions = await resolveNewApiVersions(folder, context);
      if (versions.kind === "skip") {
        addResult("SDK API versions", versions.result);
        continue;
      }
      const multiple = versions.newApiVersions.length > 1;
      const index = multiple ? 0 : 1;
      const name = names[index];
      addResult(names[1 - index], {
        success: true,
        skipped: multiple ? "Multiple API versions were added." : "Only one API version was added.",
      });
      const suppression = suppressions[index][0];
      if (suppression) {
        addResult(name, { success: true, suppressed: suppression.reason });
        continue;
      }
      let metadata: Awaited<ReturnType<typeof generateTypeSpecMetadata>>;
      try {
        metadata = await (options.metadata ?? generateTypeSpecMetadata)(folder, { logger });
      } catch (error) {
        logger.debug(error instanceof Error ? (error.stack ?? error.message) : String(error));
        addResult(
          name,
          failure("sdk-metadata", error instanceof Error ? error.message : String(error), {
            path: folder,
          }),
        );
        continue;
      }
      const evaluated = multiple
        ? evaluateMultipleNewApiVersions(metadata, versions.newApiVersions)
        : evaluateStaleApiVersionPin(metadata, versions.newApiVersions[0]);
      addResult(name, {
        ...evaluated,
        diagnostics: evaluated.diagnostics?.map((diagnostic) => ({
          ...diagnostic,
          path: join(folder, "tspconfig.yaml"),
          help: reproduceLocallyHint(context),
        })),
      });
    } catch (error) {
      logger.debug(error instanceof Error ? (error.stack ?? error.message) : String(error));
      addResult("SDK-version policies", {
        success: false,
        diagnostics: [exceptionDiagnostic(error, folder)],
      });
    }
  }

  return result();

  function result(): ValidationResult {
    return {
      success: !diagnostics.some((diagnostic) => diagnostic.severity === "error"),
      diagnostics,
      brownfield: requirement.brownfield,
      summary:
        counts.PASS + counts.FAIL + counts.WARN + counts.SUPPRESSED === 0
          ? "No applicable spec PR policies."
          : formatRuleSummary(counts, 0),
    };
  }
}
