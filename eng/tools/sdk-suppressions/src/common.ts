import { getChangedFiles } from "@azure-tools/specs-shared/changed-files";
import { parse as yamlParse } from "yaml";

/**
 * @returns {string[]}
 * @description get the changed files in the current PR
 */
export async function getSDKSuppressionsChangedFiles() {
  const changedFiles = await getChangedFiles({ paths: ["specification"] });
  const sdkSuppressionsFiles = changedFiles.filter((file) =>
    file.endsWith("sdk-suppressions.yaml"),
  );
  return sdkSuppressionsFiles;
}

/**
 * Parses YAML for subsequent schema validation.
 * Returns null for empty content and undefined when parsing fails.
 */
export function parseYamlContent(
  yamlContent: string,
  path: string,
): {
  result: unknown;
  message: string;
} {
  let content: unknown;
  // if yaml file is not a valid yaml, catch error and return undefined
  try {
    content = yamlParse(yamlContent);
  } catch (error) {
    const message = `The file parsing failed in the ${path}. Details: ${String(error)}`;
    console.error(message);
    return {
      result: content,
      message,
    };
  }

  // if yaml file is empty, run yaml.safeload success but get undefined
  // to identify whether it is empty return null to distinguish.
  if (!content) {
    console.info(`The file in the ${path} has been successfully parsed, but it is an empty file.`);
    return {
      result: null,
      message: `The file in the ${path} has been successfully parsed, but it is an empty file.`,
    };
  }

  return {
    result: content,
    message: "The file has been successfully parsed.",
  };
}
