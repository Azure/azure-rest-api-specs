import {
  generateTypeSpecMetadata,
  type TypeSpecMetadata,
} from "@azure-tools/specs-shared/typespec-metadata";
import { type RuleResult } from "../rule-result.ts";
import { type Rule } from "../rule.ts";
import {
  compareApiVersionsAsc,
  reproduceLocallyHint,
  resolveNewApiVersions,
  resolveSdkEmitters,
  wikiLink,
} from "./sdk-api-version.ts";

export function evaluateMultipleNewApiVersions(
  metadata: TypeSpecMetadata,
  newApiVersions: string[],
): RuleResult {
  const resolved = resolveSdkEmitters(metadata);
  if (resolved.kind === "skip") return resolved.result;

  const sortedNewApiVersions = [...newApiVersions].sort(compareApiVersionsAsc);
  const oldestNewApiVersion = sortedNewApiVersions[0];
  const latestNewApiVersion = sortedNewApiVersions[sortedNewApiVersions.length - 1];

  // Known gap: an emitter pinned to "all" is reported here as invalid; no spec uses that value yet.
  const invalidEmitters = resolved.emitters.filter(
    (emitter) => emitter.apiVersion !== oldestNewApiVersion,
  );
  if (invalidEmitters.length > 0) {
    const details = invalidEmitters.map(
      (emitter) =>
        `  - ${emitter.emitterName}: ${emitter.apiVersion ?? "<not set>"} ` +
        `(expected ${oldestNewApiVersion})`,
    );
    return {
      success: false,
      errorOutput:
        `ERROR: This pull request adds multiple API versions, so the SDKs will be generated from ` +
        `API version ${latestNewApiVersion}. To generate and release the SDKs from ` +
        `${oldestNewApiVersion} first, every SDK language emitter must set "api-version" to ` +
        `${oldestNewApiVersion} in tspconfig.yaml:\n${details.join("\n")}\n` +
        `\nPlease refer to ${wikiLink("multiplenewapiversions")} for detailed guidance.`,
    };
  }

  return {
    success: true,
    stdOutput: `All SDK language emitters target ${oldestNewApiVersion}.`,
  };
}

export class MultipleNewApiVersionsRule implements Rule {
  readonly name = "MultipleNewApiVersions";
  readonly description = "Require SDK emitters to target the oldest of several new API versions";
  readonly suppressable = true;

  async execute(folder: string): Promise<RuleResult> {
    const resolved = await resolveNewApiVersions(folder);
    if (resolved.kind === "skip") return resolved.result;

    if (resolved.newApiVersions.length < 2) {
      return { success: true, stdOutput: "Only one new API version was added; skipping." };
    }

    try {
      const metadata = await generateTypeSpecMetadata(folder);
      const result = evaluateMultipleNewApiVersions(metadata, resolved.newApiVersions);
      if (result.success) {
        return result;
      }

      return {
        ...result,
        errorOutput: `${result.errorOutput}\n\n${reproduceLocallyHint(folder)}`,
      };
    } catch (error) {
      return { success: false, errorOutput: String(error) };
    }
  }
}
