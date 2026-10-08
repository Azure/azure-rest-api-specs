import type { TypeSpecMetadata } from "@azure-tools/specs-shared/typespec-metadata";
import { failure, type RuleResult } from "@azure-tools/specs-shared/rule-result";
import { compareApiVersionsAsc, resolveSdkEmitters, wikiLink } from "./sdk-api-version.ts";

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
    return failure(
      "multiple-new-api-versions",
      `This pull request adds multiple API versions, so the SDKs will be generated from ` +
        `API version ${latestNewApiVersion}. To generate and release the SDKs from ` +
        `${oldestNewApiVersion} first, every SDK language emitter must set "api-version" to ` +
        `${oldestNewApiVersion} in tspconfig.yaml:\n${details.join("\n")}`,
      { url: wikiLink("multiplenewapiversions") },
    );
  }

  return {
    success: true,
  };
}
