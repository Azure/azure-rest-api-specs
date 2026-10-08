import { getSuppressionsForTools, type Suppression } from "@azure-tools/suppressions";
import type { PrContext } from "./context.ts";

export async function ruleSuppressions(
  context: PrContext,
  path: string,
  rule: string,
): Promise<Suppression[]> {
  const legacyTool = rule === "TypeSpecRequirement" ? "TypeSpecRequirement" : "TypeSpecValidation";
  const suppressions = await getSuppressionsForTools(["SpecPrValidation", legacyTool], path, {
    baseCommitish: context.baseCommitish,
    headCommitish: context.headCommitish,
    checkingAllSpecs: false,
  });
  return suppressions.filter(
    (suppression) =>
      suppression.tool === "TypeSpecRequirement" ||
      ((!suppression.rules?.length || suppression.rules.includes(rule)) &&
        !suppression.subRules?.length),
  );
}
