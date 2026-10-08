import {
  formatRuleStatus,
  formatRuleSummary,
  type RuleCounts,
} from "@azure-tools/specs-shared/diagnostics";
import { ConsoleLogger, type ILogger } from "@azure-tools/specs-shared/logger";
import type { Diagnostic } from "@azure-tools/specs-shared/rule-result";
import { createContext } from "./context.ts";
import { checkRequirements, type CheckUpstream } from "./typespec-requirement.ts";

export interface ValidationOptions {
  base: string;
  head?: string;
  cwd?: string;
  logger?: ILogger;
  checkUpstream?: CheckUpstream;
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
  const requirement = await checkRequirements(context, options.checkUpstream);
  const success = !requirement.diagnostics.some((diagnostic) => diagnostic.severity === "error");
  const status = !success
    ? "FAIL"
    : requirement.checked === 0
      ? "SKIP"
      : requirement.diagnostics.some((diagnostic) => diagnostic.severity === "warning")
        ? "WARN"
        : "PASS";
  const counts: RuleCounts = { PASS: 0, FAIL: 0, WARN: 0, SKIP: 0, SUPPRESSED: 0 };
  counts[status]++;
  logger.debug(formatRuleStatus("TypeSpecRequirement", status));

  return {
    success,
    diagnostics: requirement.diagnostics,
    brownfield: requirement.brownfield,
    summary:
      requirement.checked === 0 ? "No applicable spec PR policies." : formatRuleSummary(counts, 0),
  };
}
