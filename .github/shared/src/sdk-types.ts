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
