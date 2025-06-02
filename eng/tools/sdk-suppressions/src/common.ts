import { parse as yamlParse } from "yaml";
import { getChangedFiles } from "@azure-tools/specs-shared/changed-files";

/**
 * @returns {string[]}
 * @description get the changed files in the current PR
 */
export async function getSDKSuppressionsChangedFiles() {
  const changedFiles = await getChangedFiles();
  const sdkSuppressionsFiles = changedFiles.filter((file) =>
    file.endsWith("sdk-suppressions.yaml"),
  );
  return sdkSuppressionsFiles;
}

/**
 * @param yamlContent
 * @returns {result: string | object | undefined | null, message: string}
 * special return
 * if the content is empty, return {result: null, message: string
 * if the file parse error, return {result: undefined, message: string
 */
export function parseYamlContent(
  yamlContent: string,
  path: string,
): {
  result: string | object | undefined | null;
  message: string;
} {
  let content = undefined;
  // if yaml file is not a valid yaml, catch error and return undefined
  try {
    content = yamlParse(yamlContent);
  } catch (error) {
    console.error(`The file parsing failed in the ${path}. Details: ${error}`);
    return {
      result: content,
      message: `The file parsing failed in the ${path}. Details: ${error}`,
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
