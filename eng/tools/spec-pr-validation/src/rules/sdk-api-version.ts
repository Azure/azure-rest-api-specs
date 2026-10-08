import { type TypeSpecMetadata } from "@azure-tools/specs-shared/typespec-metadata";
import { failure, warning, type RuleResult } from "@azure-tools/specs-shared/rule-result";
import { parseServiceYaml } from "@azure-tools/specs-shared/service-yaml";
import { join, relative } from "pathe";
import { readFileAtCommit, type PrContext } from "../context.ts";

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

export function reproduceLocallyHint(context: PrContext): string {
  const quote = (value: string) =>
    process.platform === "win32"
      ? `'${value.replaceAll("'", "''")}'`
      : `'${value.replaceAll("'", "'\"'\"'")}'`;
  return `To reproduce locally:\n    pnpm spec-pr-validation --base=${quote(context.baseCommitish)} --head=${quote(context.headCommitish)}`;
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
      result: warning(
        "sdk-api-version-skipped",
        "No SDK language emitters are configured; skipping API-version validation.",
      ),
    };
  }

  if (emitters.some((emitter) => emitter.apiVersion === MULTIPLE_SERVICE_API_VERSION)) {
    return {
      kind: "skip",
      result: warning(
        "sdk-api-version-skipped",
        "This rule does not support multiple-service project scenarios.",
      ),
    };
  }

  return { kind: "emitters", emitters };
}

export type ResolvedNewApiVersions =
  | { kind: "skip"; result: RuleResult }
  | { kind: "versions"; newApiVersions: string[] };

/** Diffs `service.yaml` between the configured commits to find newly added TypeSpec versions. */
export async function resolveNewApiVersions(
  folder: string,
  context: PrContext,
): Promise<ResolvedNewApiVersions> {
  const { baseCommitish, headCommitish } = context;
  const serviceYamlPath = join(folder, "service.yaml");
  const repositoryPath = relative(context.root, serviceYamlPath);
  let baseSource: string | undefined;
  let headSource: string | undefined;

  try {
    [baseSource, headSource] = await Promise.all([
      readFileAtCommit(context, baseCommitish, repositoryPath),
      readFileAtCommit(context, headCommitish, repositoryPath),
    ]);
  } catch (error) {
    return {
      kind: "skip",
      result: failure(
        "sdk-api-version",
        `Unable to compare service.yaml between ${baseCommitish} and ${headCommitish}: ${String(error)}`,
        { path: serviceYamlPath },
      ),
    };
  }

  if (headSource === undefined) {
    return {
      kind: "skip",
      result: warning(
        "sdk-api-version-skipped",
        `service.yaml does not exist at ${headCommitish}; validation skipped.`,
        { path: serviceYamlPath },
      ),
    };
  }

  const headService = parseServiceYaml(headSource);
  if (!headService.success) {
    return {
      kind: "skip",
      result: failure("sdk-api-version", `${headCommitish}: ${headService.error}`, {
        path: serviceYamlPath,
      }),
    };
  }

  const baseService = baseSource === undefined ? undefined : parseServiceYaml(baseSource);
  if (baseService && !baseService.success) {
    return {
      kind: "skip",
      result: failure("sdk-api-version", `${baseCommitish}: ${baseService.error}`, {
        path: serviceYamlPath,
      }),
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
      result: { success: true, skipped: "No new TypeSpec API versions were added." },
    };
  }

  return { kind: "versions", newApiVersions };
}
