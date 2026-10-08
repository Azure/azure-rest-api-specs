import type { TypeSpecMetadata } from "@azure-tools/specs-shared/typespec-metadata";
import { failure, type RuleResult } from "@azure-tools/specs-shared/rule-result";
import {
  compareApiVersionsAsc,
  parseApiVersion,
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
    return failure(
      "stale-api-version-pin",
      `This pull request adds API version ${newApiVersion}, but the SDK language ` +
        `emitters below are pinned to an older API version, so their SDKs will be generated ` +
        `from the pinned version instead. To generate and release the SDKs from ` +
        `${newApiVersion}, remove the "api-version" setting from these emitters in ` +
        `tspconfig.yaml:\n${details.join("\n")}`,
      { url: wikiLink("staleapiversionpin") },
    );
  }

  return {
    success: true,
  };
}
