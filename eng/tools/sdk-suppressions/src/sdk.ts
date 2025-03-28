/**
 * This file is the single source of truth for the labels used by the SDK generation tooling
 * in the Azure/azure-rest-api-specs and Azure/azure-rest-api-specs-pr repositories.
 *
 * For additional context, see:
 * - https://gist.github.com/raych1/353949d19371b69fb82a10dd70032a51
 * - https://github.com/Azure/azure-sdk-tools/issues/6327
 * - https://microsoftapc-my.sharepoint.com/:w:/g/personal/raychen_microsoft_com/EbOAA9SkhQhGlgxtf7mc0kUB-25bFue0EFbXKXS3TFLTQA
 */
export type SdkName =
  | "azure-sdk-for-go"
  | "azure-sdk-for-java"
  | "azure-sdk-for-js"
  | "azure-sdk-for-net"
  | "azure-sdk-for-python"

export const sdkLabels: {
  [sdkName in SdkName]: {
    breakingChange: string | undefined;
    breakingChangeApproved: string | undefined;
    breakingChangeSuppression: string | undefined;
    breakingChangeSuppressionApproved: string | undefined;
  };
} = {
  "azure-sdk-for-go": {
    breakingChange: "BreakingChange-Go-Sdk",
    breakingChangeApproved: "BreakingChange-Go-Sdk-Approved",
    breakingChangeSuppression: "BreakingChange-Go-Sdk-Suppression",
    breakingChangeSuppressionApproved:
      "BreakingChange-Go-Sdk-Suppression-Approved",
  },
  "azure-sdk-for-java": {
    breakingChange: "BreakingChange-Java-Sdk",
    breakingChangeApproved: "BreakingChange-Java-Sdk-Approved",
    breakingChangeSuppression: "BreakingChange-Java-Sdk-Suppression",
    breakingChangeSuppressionApproved:
      "BreakingChange-Java-Sdk-Suppression-Approved"
  },
  "azure-sdk-for-js": {
    breakingChange: "BreakingChange-JavaScript-Sdk",
    breakingChangeApproved: "BreakingChange-JavaScript-Sdk-Approved",
    breakingChangeSuppression: "BreakingChange-JavaScript-Sdk-Suppression",
    breakingChangeSuppressionApproved:
      "BreakingChange-JavaScript-Sdk-Suppression-Approved"
  },
  "azure-sdk-for-net": {
    breakingChange: undefined,
    breakingChangeApproved: undefined,
    breakingChangeSuppression: undefined,
    breakingChangeSuppressionApproved: undefined
  },
  "azure-sdk-for-python": {
    breakingChange: "BreakingChange-Python-Sdk",
    breakingChangeApproved: "BreakingChange-Python-Sdk-Approved",
    breakingChangeSuppression: "BreakingChange-Python-Sdk-Suppression",
    breakingChangeSuppressionApproved:
      "BreakingChange-Python-Sdk-Suppression-Approved"
  }
};
