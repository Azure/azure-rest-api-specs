import {
  generateTypeSpecMetadata,
  type TypeSpecMetadata,
} from "@azure-tools/specs-shared/typespec-metadata";
import { type RuleResult } from "../rule-result.ts";
import { type Rule } from "../rule.ts";
import {
  compareApiVersionsAsc,
  parseApiVersion,
  reproduceLocallyHint,
  resolveNewApiVersions,
  resolveSdkEmitters,
  wikiLink,
} from "./sdk-api-version.ts";

export function evaluateStaleApiVersionPin(
  metadata: TypeSpecMetadata,
  newApiVersion: string,
): RuleResult {
  const resolved = resolveSdkEmitters(metadata);
  if (resolved.kind === "skip") return resolved.result;

  // Values such as "all" are not dates, so they cannot be compared against the new version.
  const staleEmitters = resolved.emitters.filter(
    (emitter) =>
      emitter.apiVersion !== undefined &&
      parseApiVersion(emitter.apiVersion) !== undefined &&
      compareApiVersionsAsc(emitter.apiVersion, newApiVersion) < 0,
  );

  if (staleEmitters.length > 0) {
    const details = staleEmitters.map(
      (emitter) => `  - ${emitter.emitterName}: ${emitter.apiVersion}`,
    );
    return {
      success: false,
      errorOutput:
        `ERROR: This pull request adds API version ${newApiVersion}, but the SDK language ` +
        `emitters below are pinned to an older API version, so their SDKs will be generated ` +
        `from the pinned version instead. To generate and release the SDKs from ` +
        `${newApiVersion}, remove the "api-version" setting from these emitters in ` +
        `tspconfig.yaml:\n${details.join("\n")}\n` +
        `\nPlease refer to ${wikiLink("staleapiversionpin")} for detailed guidance.`,
    };
  }

  return {
    success: true,
    stdOutput: `No SDK emitter targets an API version older than ${newApiVersion}.`,
  };
}

export class StaleApiVersionPinRule implements Rule {
  readonly name = "StaleApiVersionPin";
  readonly description = "Detect SDK emitters pinned to an API version older than the new one";
  readonly suppressable = true;

  async execute(folder: string): Promise<RuleResult> {
    const resolved = await resolveNewApiVersions(folder);
    if (resolved.kind === "skip") return resolved.result;

    if (resolved.newApiVersions.length !== 1) {
      return { success: true, stdOutput: "Multiple new API versions were added; skipping." };
    }

    try {
      const metadata = await generateTypeSpecMetadata(folder);
      const result = evaluateStaleApiVersionPin(metadata, resolved.newApiVersions[0]);
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
