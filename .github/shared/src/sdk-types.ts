import * as z from "zod";

/**
 * Represents supported SDK language identifiers.
 */
export const SdkName = Object.freeze({
  Go: "azure-sdk-for-go",
  Java: "azure-sdk-for-java",
  Js: "azure-sdk-for-js",
  Net: "azure-sdk-for-net",
  Python: "azure-sdk-for-python",
  Rust: "azure-sdk-for-rust",
});
export type SdkName = (typeof SdkName)[keyof typeof SdkName];

export const SdkNameSchema: import("zod").ZodType<SdkName> = z.enum(Object.values(SdkName));

/*
 * Data for the API view request.
 */
export const APIViewRequestDataSchema = z.object({ packageName: z.string(), filePath: z.string() });
export type APIViewRequestData = z.infer<typeof APIViewRequestDataSchema>;

/**
 * Represents the result of the spec-gen-sdk generation process.
 */
export const SpecGenSdkArtifactInfoSchema = z.object({
  language: SdkNameSchema,
  result: z.string(),
  headSha: z.string(),
  prNumber: z.string().optional(),
  labelAction: z.boolean().optional(),
  isSpecGenSdkCheckRequired: z.boolean(),
  apiViewRequestData: z.array(APIViewRequestDataSchema),
});
export type SpecGenSdkArtifactInfo = import("zod").infer<typeof SpecGenSdkArtifactInfoSchema>;

export type SdkLabelInfo = {
  breakingChange: string | undefined;
  breakingChangeApproved: string | undefined;
  breakingChangeSuppression: string | undefined;
  breakingChangeSuppressionApproved: string | undefined;
  buildFailed: string | undefined;
};

export type SdkLabels = Record<SdkName, SdkLabelInfo>;

/**
 * SDK labels mapping for breaking change and build-failure labels
 */
export const sdkLabels: SdkLabels = {
  "azure-sdk-for-go": {
    breakingChange: "BreakingChange-Go-Sdk",
    breakingChangeApproved: "BreakingChange-Go-Sdk-Approved",
    breakingChangeSuppression: "BreakingChange-Go-Sdk-Suppression",
    breakingChangeSuppressionApproved: "BreakingChange-Go-Sdk-Suppression-Approved",
    buildFailed: undefined,
  },
  "azure-sdk-for-java": {
    breakingChange: undefined,
    breakingChangeApproved: undefined,
    breakingChangeSuppression: undefined,
    breakingChangeSuppressionApproved: undefined,
    buildFailed: undefined,
  },
  "azure-sdk-for-js": {
    breakingChange: "BreakingChange-JavaScript-Sdk",
    breakingChangeApproved: "BreakingChange-JavaScript-Sdk-Approved",
    breakingChangeSuppression: "BreakingChange-JavaScript-Sdk-Suppression",
    breakingChangeSuppressionApproved: "BreakingChange-JavaScript-Sdk-Suppression-Approved",
    buildFailed: undefined,
  },
  "azure-sdk-for-net": {
    breakingChange: undefined,
    breakingChangeApproved: undefined,
    breakingChangeSuppression: undefined,
    breakingChangeSuppressionApproved: undefined,
    buildFailed: "auto-sdk-build-fix",
  },
  "azure-sdk-for-python": {
    breakingChange: "BreakingChange-Python-Sdk",
    breakingChangeApproved: "BreakingChange-Python-Sdk-Approved",
    breakingChangeSuppression: "BreakingChange-Python-Sdk-Suppression",
    breakingChangeSuppressionApproved: "BreakingChange-Python-Sdk-Suppression-Approved",
    buildFailed: undefined,
  },
  "azure-sdk-for-rust": {
    breakingChange: undefined,
    breakingChangeApproved: undefined,
    breakingChangeSuppression: undefined,
    breakingChangeSuppressionApproved: undefined,
    buildFailed: undefined,
  },
};

export const SDK_REVIEW_BUNDLE_ARTIFACT_NAME = "sdk-review-bundle" as const;
export const SDK_REVIEW_BUNDLE_MANIFEST_FILE_NAME = "sdk-review-bundle.json" as const;
export const SDK_REVIEW_BUNDLE_SCHEMA_VERSION = "1.0" as const;

const sha40Schema = z.string().regex(/^[0-9a-f]{40}$/i, "Expected a 40-char git SHA");
const sha256HexSchema = z
  .string()
  .regex(/^[0-9a-f]{64}$/i, "Expected a 64-char SHA-256 hex digest");
const numericIdSchema = z.string().regex(/^[1-9]\d*$/, "Expected a positive numeric identifier");

/**
 * Validates that a relative POSIX path has no root prefix, parent traversal (`..`),
 * current-dir segments (`.`), empty segments, backslashes, or control characters.
 */
export function isSafeRelativePosixPath(value: string): boolean {
  if (
    typeof value !== "string" ||
    value.length === 0 ||
    value.length > 512 ||
    value.startsWith("/") ||
    value.endsWith("/") ||
    value.includes("\\") ||
    value.includes("\0") ||
    /^[A-Za-z]:/.test(value)
  ) {
    return false;
  }
  const segments = value.split("/");
  return segments.every((segment) => segment.length > 0 && segment !== "." && segment !== "..");
}

export const SafeRelativePosixPathSchema = z
  .string()
  .refine(isSafeRelativePosixPath, "Expected a safe normalized relative POSIX path");

const SafePatchFileNameSchema = SafeRelativePosixPathSchema.refine(
  (value) => !value.includes("/") && value.endsWith(".patch"),
  "Expected a single-segment .patch file name",
);

export const SdkReviewBundleEntrySchema = z.object({
  entryId: z.string().regex(/^[A-Za-z0-9._-]+$/, "Expected a safe bundle entry identifier"),
  tspConfigPath: SafeRelativePosixPathSchema.optional(),
  readmePath: SafeRelativePosixPathSchema.optional(),
  serviceName: z.string().optional(),
  packageName: z.string().min(1),
  packageRootPath: SafeRelativePosixPathSchema,
  sdkBaseCommitSha: sha40Schema,
  executionResult: z.string().min(1),
  hasBreakingChange: z.boolean().optional(),
  patchFile: SafePatchFileNameSchema,
  patchSha256: sha256HexSchema,
  patchBytes: z.number().int().nonnegative(),
  changedFileCount: z.number().int().nonnegative(),
  changedFiles: z.array(SafeRelativePosixPathSchema),
});
export type SdkReviewBundleEntry = import("zod").infer<typeof SdkReviewBundleEntrySchema>;

export const SdkReviewBundleManifestSchema = z.object({
  schemaVersion: z.literal(SDK_REVIEW_BUNDLE_SCHEMA_VERSION),
  buildId: numericIdSchema.optional(),
  specPrNumber: numericIdSchema,
  specHeadSha: sha40Schema,
  specRepoUrl: z.string().min(1),
  sdkLanguage: SdkNameSchema,
  sdkRepoName: z.string().min(1),
  entries: z.array(SdkReviewBundleEntrySchema),
});
export type SdkReviewBundleManifest = import("zod").infer<typeof SdkReviewBundleManifestSchema>;
