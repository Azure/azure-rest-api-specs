/* v8 ignore start */

// @ts-check

/**
 * @typedef {'azure-sdk-for-go' | 'azure-sdk-for-java' | 'azure-sdk-for-js' | 'azure-sdk-for-net' | 'azure-sdk-for-python'} SdkName
 */

/**
 * @typedef {{
 *   breakingChange: string | undefined,
 *   breakingChangeApproved: string | undefined,
 *   breakingChangeSuppression: string | undefined,
 *   breakingChangeSuppressionApproved: string | undefined
 * }} SdkLabelInfo
 */

/**
 * @typedef {Record<SdkName, SdkLabelInfo>} SdkLabels
 */

/**
 * SDK labels mapping for breaking change labels
 * @type {SdkLabels}
 * */
export const sdkLabels = {
  "azure-sdk-for-go": {
    breakingChange: "BreakingChange-Go-Sdk",
    breakingChangeApproved: "BreakingChange-Go-Sdk-Approved",
    breakingChangeSuppression: "BreakingChange-Go-Sdk-Suppression",
    breakingChangeSuppressionApproved:
      "BreakingChange-Go-Sdk-Suppression-Approved",
  },
  "azure-sdk-for-java": {
    breakingChange: undefined,
    breakingChangeApproved: undefined,
    breakingChangeSuppression: undefined,
    breakingChangeSuppressionApproved: undefined,
  },
  "azure-sdk-for-js": {
    breakingChange: "BreakingChange-JavaScript-Sdk",
    breakingChangeApproved: "BreakingChange-JavaScript-Sdk-Approved",
    breakingChangeSuppression: "BreakingChange-JavaScript-Sdk-Suppression",
    breakingChangeSuppressionApproved:
      "BreakingChange-JavaScript-Sdk-Suppression-Approved",
  },
  "azure-sdk-for-net": {
    breakingChange: undefined,
    breakingChangeApproved: undefined,
    breakingChangeSuppression: undefined,
    breakingChangeSuppressionApproved: undefined,
  },
  "azure-sdk-for-python": {
    breakingChange: "BreakingChange-Python-Sdk",
    breakingChangeApproved: "BreakingChange-Python-Sdk-Approved",
    breakingChangeSuppression: "BreakingChange-Python-Sdk-Suppression",
    breakingChangeSuppressionApproved:
      "BreakingChange-Python-Sdk-Suppression-Approved",
  },
};
