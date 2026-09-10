import { type TypeSpecMetadata } from "@azure-tools/specs-shared/typespec-metadata";
import { join } from "node:path";
import { context } from "../index.ts";
import { type RuleResult } from "../rule-result.ts";
import { parseServiceYaml } from "../service-yaml.ts";
import { readFileAtCommit } from "../utils.ts";

// Scoped to management-plane SDK emitters for now.
const SDK_EMITTERS = new Set([
  "@azure-tools/typespec-python",
  "@azure-tools/typespec-java",
  "@azure-tools/typespec-ts",
  "@azure-tools/typespec-go",
  "@azure-typespec/http-client-csharp-mgmt",
]);

// For multiple-service projects, the typespec-metadata emitter reports "multiple-versions" for
// every emitter, overriding the api-version each emitter is actually configured with.
const MULTIPLE_SERVICE_API_VERSION = "multiple-versions";

const WIKI_BASE = "https://github.com/Azure/azure-rest-api-specs/wiki/TypeSpec-Validation";

export function wikiLink(anchor: string): string {
  return `${WIKI_BASE}#${anchor}`;
}

export function reproduceLocallyHint(folder: string): string {
  return (
    `To reproduce locally:\n  npx tsv ${folder} '{"baseCommitish":"{commitShaOfMain}",` +
    `"headCommitish":"{commitShaOfPRHead}"}'`
  );
}

export function parseApiVersion(version: string) {
  const match = version.match(/^(\d{4})-(\d{2})-(\d{2})(-preview)?$/);
  if (!match) return undefined;
  return {
    year: Number(match[1]),
    month: Number(match[2]),
    day: Number(match[3]),
    isPreview: match[4] !== undefined,
  };
}

/** Compares API versions oldest first, with preview preceding stable on the same date. */
export function compareApiVersionsAsc(left: string, right: string): number {
  const leftVersion = parseApiVersion(left);
  const rightVersion = parseApiVersion(right);

  if (!leftVersion || !rightVersion) return left.localeCompare(right);
  if (leftVersion.year !== rightVersion.year) return leftVersion.year - rightVersion.year;
  if (leftVersion.month !== rightVersion.month) return leftVersion.month - rightVersion.month;
  if (leftVersion.day !== rightVersion.day) return leftVersion.day - rightVersion.day;
  if (leftVersion.isPreview !== rightVersion.isPreview) {
    return leftVersion.isPreview ? -1 : 1;
  }
  return left.localeCompare(right);
}

export type SdkEmitter = TypeSpecMetadata["languages"][string][number];

export type ResolvedSdkEmitters =
  | { kind: "skip"; result: RuleResult }
  | { kind: "emitters"; emitters: SdkEmitter[] };

/** Returns the configured SDK language emitters, or a skip result when they cannot be compared. */
export function resolveSdkEmitters(metadata: TypeSpecMetadata): ResolvedSdkEmitters {
  const emitters = Object.values(metadata.languages)
    .flat()
    .filter((language) => SDK_EMITTERS.has(language.emitterName));

  if (emitters.length === 0) {
    return {
      kind: "skip",
      result: {
        success: true,
        stdOutput:
          "Warning: No SDK language emitters are configured; skipping API-version validation.",
      },
    };
  }

  if (emitters.some((emitter) => emitter.apiVersion === MULTIPLE_SERVICE_API_VERSION)) {
    return {
      kind: "skip",
      result: {
        success: true,
        stdOutput: "Warning: This rule does not support multiple-service project scenarios.",
      },
    };
  }

  return { kind: "emitters", emitters };
}

export type ResolvedNewApiVersions =
  | { kind: "skip"; result: RuleResult }
  | { kind: "versions"; newApiVersions: string[] };

/** Diffs `service.yaml` between the configured commits to find newly added TypeSpec versions. */
export async function resolveNewApiVersions(folder: string): Promise<ResolvedNewApiVersions> {
  // Validating all specs has no pull request to diff, and runs on a shallow clone without HEAD^.
  if (context.checkingAllSpecs === true) {
    return {
      kind: "skip",
      result: {
        success: true,
        stdOutput: "Validating all specs; skipping comparison of newly added API versions.",
      },
    };
  }

  // Only the pull request check supplies commits; a bare "npx tsv <folder>" has nothing to diff.
  const { baseCommitish, headCommitish } = context;
  if (typeof baseCommitish !== "string" || typeof headCommitish !== "string") {
    return {
      kind: "skip",
      result: {
        success: true,
        stdOutput:
          "No commits to compare; skipping. To run this rule locally, pass the commits to " +
          `compare:\n  npx tsv ${folder} '{"baseCommitish":"{commitShaOfMain}",` +
          `"headCommitish":"{headShaOfLocalBranch}"}'`,
      },
    };
  }

  const serviceYamlPath = join(folder, "service.yaml");
  let baseSource: string | undefined;
  let headSource: string | undefined;

  try {
    [baseSource, headSource] = await Promise.all([
      readFileAtCommit(folder, baseCommitish, serviceYamlPath),
      readFileAtCommit(folder, headCommitish, serviceYamlPath),
    ]);
  } catch (error) {
    return {
      kind: "skip",
      result: {
        success: false,
        errorOutput:
          `ERROR: Unable to compare service.yaml between ${baseCommitish} and ` +
          `${headCommitish}: ${String(error)}`,
      },
    };
  }

  if (headSource === undefined) {
    return {
      kind: "skip",
      result: {
        success: true,
        stdOutput: `Warning: service.yaml does not exist at ${headCommitish}; validation skipped.`,
      },
    };
  }

  const headService = parseServiceYaml(headSource);
  if (!headService.success) {
    return {
      kind: "skip",
      result: { success: false, errorOutput: `ERROR: ${headCommitish}: ${headService.error}` },
    };
  }

  const baseService = baseSource === undefined ? undefined : parseServiceYaml(baseSource);
  if (baseService && !baseService.success) {
    return {
      kind: "skip",
      result: { success: false, errorOutput: `ERROR: ${baseCommitish}: ${baseService.error}` },
    };
  }

  const baseVersions = new Set(
    baseService?.value.versions
      .filter((entry) => entry.source === "typespec")
      .map((entry) => entry.version) ?? [],
  );
  const newApiVersions = [
    ...new Set(
      headService.value.versions
        .filter((entry) => entry.source === "typespec" && !baseVersions.has(entry.version))
        .map((entry) => entry.version),
    ),
  ];

  if (newApiVersions.length === 0) {
    return {
      kind: "skip",
      result: { success: true, stdOutput: "No new TypeSpec API versions were added." },
    };
  }

  return { kind: "versions", newApiVersions };
}
