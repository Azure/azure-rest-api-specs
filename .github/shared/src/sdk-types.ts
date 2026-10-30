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

export const SDK_REVIEW_MAX_CHANGED_FILES_PER_PACKAGE = 2_048;
export const SDK_REVIEW_MAX_TOTAL_CHANGED_FILES = 4_096;

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
        /[\u0000-\u001f\u007f]/.test(value) ||
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
    })
    .superRefine((request, context) => {
        if ((request.packageRootPath === undefined) !== (request.changedFiles === undefined)) {
            context.addIssue({
                code: "custom",
                message: "packageRootPath and changedFiles must be provided together",
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
