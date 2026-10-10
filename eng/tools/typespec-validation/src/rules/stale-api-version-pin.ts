import type { ILogger } from "@azure-tools/specs-shared/logger";
import {
  generateTypeSpecMetadata,
  type TypeSpecMetadata,
} from "@azure-tools/specs-shared/typespec-metadata";
import { join } from "pathe";
import { failure, type RuleResult } from "../rule-result.ts";
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

export class StaleApiVersionPinRule implements Rule {
  readonly name = "StaleApiVersionPin";
  readonly description = "Detect SDK emitters pinned to an API version older than the new one";
  readonly suppressable = true;

  async execute(folder: string, logger: ILogger): Promise<RuleResult> {
    const resolved = await resolveNewApiVersions(folder);
    if (resolved.kind === "skip") return resolved.result;

    if (resolved.newApiVersions.length !== 1) {
      return { success: true, skipped: "Multiple new API versions were added; skipping." };
    }

    try {
      const metadata = await generateTypeSpecMetadata(folder, { logger });
      const result = evaluateStaleApiVersionPin(metadata, resolved.newApiVersions[0]);
      if (result.success) {
        return result;
      }

      return {
        ...result,
        diagnostics: result.diagnostics?.map((diagnostic) => ({
          ...diagnostic,
          path: join(folder, "tspconfig.yaml"),
          help: reproduceLocallyHint(folder),
        })),
      };
    } catch (error) {
      logger.debug(error instanceof Error ? (error.stack ?? error.message) : String(error));
      return failure("sdk-metadata", error instanceof Error ? error.message : String(error), {
        path: folder,
      });
    }
  }
}
