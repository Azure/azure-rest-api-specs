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

/** Shared limits for producer and consumer validation of generated SDK review input. */
export const SDK_REVIEW_MAX_CHANGED_FILES_PER_PACKAGE = 2_048;
export const SDK_REVIEW_MAX_TOTAL_CHANGED_FILES = 4_096;
export const SDK_REVIEW_MAX_SNAPSHOT_FILES_PER_PACKAGE = 20_000;
export const SDK_REVIEW_MAX_TOTAL_SNAPSHOT_FILES = 40_000;
export const SDK_REVIEW_MAX_SNAPSHOT_BYTES_PER_PACKAGE = 32 * 1024 * 1024;
export const SDK_REVIEW_MAX_TOTAL_SNAPSHOT_BYTES = 64 * 1024 * 1024;

function containsControlCharacter(value: string): boolean {
  return [...value].some((character) => {
    const characterCode = character.charCodeAt(0);
    return characterCode <= 0x1f || characterCode === 0x7f;
  });
}

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
    containsControlCharacter(value) ||
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

const GitCommitShaSchema = z.string().regex(/^[0-9a-f]{40}$/i, "Expected a 40-char git SHA");

/*
 * Data for the API view request.
 */
export const APIViewRequestDataSchema = z
  .object({
    packageName: z.string(),
    filePath: z.string(),
    packageRootPath: SafeRelativePosixPathSchema.optional(),
    changedFiles: z
      .array(SafeRelativePosixPathSchema)
      .max(SDK_REVIEW_MAX_CHANGED_FILES_PER_PACKAGE)
      .optional(),
    sdkBaseCommitSha: GitCommitShaSchema.optional(),
    reviewInputPath: SafeRelativePosixPathSchema.optional(),
    reviewInputFileCount: z
      .number()
      .int()
      .positive()
      .max(SDK_REVIEW_MAX_SNAPSHOT_FILES_PER_PACKAGE)
      .optional(),
    reviewInputBytes: z
      .number()
      .int()
      .positive()
      .max(SDK_REVIEW_MAX_SNAPSHOT_BYTES_PER_PACKAGE)
      .optional(),
  })
  .superRefine((request, context) => {
    const reviewFields = [
      request.packageRootPath,
      request.changedFiles,
      request.sdkBaseCommitSha,
      request.reviewInputPath,
      request.reviewInputFileCount,
      request.reviewInputBytes,
    ];
    const definedReviewFields = reviewFields.filter((value) => value !== undefined).length;
    if (definedReviewFields !== 0 && definedReviewFields !== reviewFields.length) {
      context.addIssue({
        code: "custom",
        message: "SDK review input fields must be provided together",
      });
      return;
    }
    if (!request.packageRootPath || !request.changedFiles) {
      return;
    }

    const packagePrefix = `${request.packageRootPath}/`;
    const uniqueChangedFiles = new Set(request.changedFiles);
    if (uniqueChangedFiles.size !== request.changedFiles.length) {
      context.addIssue({
        code: "custom",
        path: ["changedFiles"],
        message: "changedFiles must not contain duplicates",
      });
    }
    for (const [index, changedFile] of request.changedFiles.entries()) {
      if (!changedFile.startsWith(packagePrefix)) {
        context.addIssue({
          code: "custom",
          path: ["changedFiles", index],
          message: `Changed file must be inside packageRootPath '${request.packageRootPath}'`,
        });
      }
    }
  });
export type APIViewRequestData = z.infer<typeof APIViewRequestDataSchema>;

/**
 * Represents the result of the spec-gen-sdk generation process.
 */
export const SpecGenSdkArtifactInfoSchema = z
  .object({
    language: SdkNameSchema,
    result: z.string(),
    headSha: z.string(),
    prNumber: z.string().optional(),
    labelAction: z.boolean().optional(),
    isSpecGenSdkCheckRequired: z.boolean(),
    apiViewRequestData: z.array(APIViewRequestDataSchema),
  })
  .superRefine((artifact, context) => {
    const totalChangedFiles = artifact.apiViewRequestData.reduce(
      (total, request) => total + (request.changedFiles?.length ?? 0),
      0,
    );
    if (totalChangedFiles > SDK_REVIEW_MAX_TOTAL_CHANGED_FILES) {
      context.addIssue({
        code: "custom",
        path: ["apiViewRequestData"],
        message: `Artifact has ${totalChangedFiles} changed files; maximum is ${SDK_REVIEW_MAX_TOTAL_CHANGED_FILES}`,
      });
    }

    const totalSnapshotBytes = artifact.apiViewRequestData.reduce(
      (total, request) => total + (request.reviewInputBytes ?? 0),
      0,
    );
    if (totalSnapshotBytes > SDK_REVIEW_MAX_TOTAL_SNAPSHOT_BYTES) {
      context.addIssue({
        code: "custom",
        path: ["apiViewRequestData"],
        message: `Artifact has ${totalSnapshotBytes} snapshot bytes; maximum is ${SDK_REVIEW_MAX_TOTAL_SNAPSHOT_BYTES}`,
      });
    }

    const totalSnapshotFiles = artifact.apiViewRequestData.reduce(
      (total, request) => total + (request.reviewInputFileCount ?? 0),
      0,
    );
    if (totalSnapshotFiles > SDK_REVIEW_MAX_TOTAL_SNAPSHOT_FILES) {
      context.addIssue({
        code: "custom",
        path: ["apiViewRequestData"],
        message: `Artifact has ${totalSnapshotFiles} snapshot files; maximum is ${SDK_REVIEW_MAX_TOTAL_SNAPSHOT_FILES}`,
      });
    }
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
