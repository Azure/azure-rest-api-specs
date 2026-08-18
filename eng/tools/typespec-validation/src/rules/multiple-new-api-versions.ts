import {
  generateTypeSpecMetadata,
  type TypeSpecMetadata,
} from "@azure-tools/specs-shared/typespec-metadata";
import { join } from "node:path";
import { type RuleResult } from "../rule-result.ts";
import { type Rule } from "../rule.ts";
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

type ReadFileAtCommit = typeof readFileAtCommit;
type GenerateMetadata = (folder: string) => Promise<TypeSpecMetadata>;

export interface MultipleNewApiVersionsRuleOptions {
  baseCommitish?: string;
  headCommitish?: string;
  readFileAtCommit?: ReadFileAtCommit;
  generateMetadata?: GenerateMetadata;
}

function parseApiVersion(version: string) {
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

function getSdkLanguageMetadata(metadata: TypeSpecMetadata) {
  return Object.values(metadata.languages)
    .flat()
    .filter((language) => SDK_EMITTERS.has(language.emitterName));
}

export function evaluateApiVersionPolicy(
  metadata: TypeSpecMetadata,
  newApiVersions: string[],
): RuleResult {
  const sdkEmitters = getSdkLanguageMetadata(metadata);

  if (sdkEmitters.some((emitter) => emitter.apiVersion === MULTIPLE_SERVICE_API_VERSION)) {
    return {
      success: true,
      stdOutput: "This rule does not support multiple-service project scenarios.",
    };
  }

  if (newApiVersions.length === 1) {
    const newApiVersion = newApiVersions[0];
    const warnings = sdkEmitters
      .filter(
        (emitter) =>
          emitter.apiVersion !== undefined &&
          parseApiVersion(emitter.apiVersion) !== undefined &&
          compareApiVersionsAsc(emitter.apiVersion, newApiVersion) < 0,
      )
      .map(
        (emitter) =>
          `Warning: ${emitter.emitterName} targets API version ${emitter.apiVersion}, which is ` +
          `older than newly added API version ${newApiVersion}.`,
      );

    return {
      success: true,
      stdOutput:
        warnings.length > 0
          ? warnings.join("\n")
          : `No SDK emitter targets an API version older than ${newApiVersion}.`,
    };
  }

  const oldestNewApiVersion = [...newApiVersions].sort(compareApiVersionsAsc)[0];
  if (sdkEmitters.length === 0) {
    return {
      success: false,
      errorOutput: "TypeSpec metadata did not report any configured SDK language emitters.",
    };
  }

  // Known gap: an emitter pinned to "all" is reported here as invalid; no spec uses that value yet.
  const invalidEmitters = sdkEmitters.filter(
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
        `This pull request adds multiple API versions. Every SDK language emitter must target ` +
        `the oldest newly added version, ${oldestNewApiVersion}:\n${details.join("\n")}`,
    };
  }

  return {
    success: true,
    stdOutput: `All SDK language emitters target ${oldestNewApiVersion}.`,
  };
}

export class MultipleNewApiVersionsRule implements Rule {
  readonly name = "MultipleNewApiVersions";
  readonly description = "Validate SDK API-version selection when a PR adds API versions";

  private readonly baseCommitish: string;
  private readonly headCommitish: string;
  private readonly readFileAtCommit: ReadFileAtCommit;
  private readonly generateMetadata: GenerateMetadata;

  constructor(options: MultipleNewApiVersionsRuleOptions = {}) {
    this.baseCommitish = options.baseCommitish ?? "HEAD^";
    this.headCommitish = options.headCommitish ?? "HEAD";
    this.readFileAtCommit = options.readFileAtCommit ?? readFileAtCommit;
    this.generateMetadata = options.generateMetadata ?? generateTypeSpecMetadata;
  }

  async execute(folder: string): Promise<RuleResult> {
    const serviceYamlPath = join(folder, "service.yaml");
    let baseSource: string | undefined;
    let headSource: string | undefined;

    try {
      [baseSource, headSource] = await Promise.all([
        this.readFileAtCommit(folder, this.baseCommitish, serviceYamlPath),
        this.readFileAtCommit(folder, this.headCommitish, serviceYamlPath),
      ]);
    } catch (error) {
      return {
        success: false,
        errorOutput:
          `Unable to compare service.yaml between ${this.baseCommitish} and ` +
          `${this.headCommitish}: ${String(error)}`,
      };
    }

    if (headSource === undefined) {
      return {
        success: true,
        stdOutput: `service.yaml does not exist at ${this.headCommitish}; validation skipped.`,
      };
    }

    const headService = parseServiceYaml(headSource);
    if (!headService.success) {
      return { success: false, errorOutput: `${this.headCommitish}: ${headService.error}` };
    }

    const baseService = baseSource === undefined ? undefined : parseServiceYaml(baseSource);
    if (baseService && !baseService.success) {
      return { success: false, errorOutput: `${this.baseCommitish}: ${baseService.error}` };
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
      return { success: true, stdOutput: "No new TypeSpec API versions were added." };
    }

    try {
      const metadata = await this.generateMetadata(folder);
      return evaluateApiVersionPolicy(metadata, newApiVersions);
    } catch (error) {
      return { success: false, errorOutput: String(error) };
    }
  }
}
