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

export class MultipleNewApiVersionsRule implements Rule {
  readonly name = "MultipleNewApiVersions";
  readonly description = "Require SDK emitters to target the oldest of several new API versions";
  readonly suppressable = true;

  async execute(folder: string, logger: ILogger): Promise<RuleResult> {
    const resolved = await resolveNewApiVersions(folder);
    if (resolved.kind === "skip") return resolved.result;

    if (resolved.newApiVersions.length < 2) {
      return { success: true, skipped: "Only one new API version was added; skipping." };
    }

    try {
      const metadata = await generateTypeSpecMetadata(folder, { logger });
      const result = evaluateMultipleNewApiVersions(metadata, resolved.newApiVersions);
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
