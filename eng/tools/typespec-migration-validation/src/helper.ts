import { OpenAPI2Document } from "@azure-tools/typespec-autorest";
import fs from "fs";
import path from "path";
import { logWarning } from "./log.js";

/**
 * Reads all files in a directory recursively, excluding paths containing a specified string
 * @param directoryPath The directory to read files from
 * @param excludePattern String pattern to exclude from paths (case insensitive)
 * @returns Array of file paths
 */
function readFilesFromDirectory(
  directoryPath: string,
  excludePattern: string = "example",
): string[] {
  const results: string[] = [];

  function traverseDirectory(currentPath: string): void {
    const files = fs.readdirSync(currentPath);

    for (const file of files) {
      const filePath = path.join(currentPath, file);
      const stats = fs.statSync(filePath);

      // Skip paths containing the exclude pattern
      if (filePath.toLowerCase().includes(excludePattern.toLowerCase())) {
        continue;
      }

      // Skip paths that are not json files
      if (!filePath.endsWith(".json")) {
        continue;
      }

      if (stats.isDirectory()) {
        traverseDirectory(filePath);
      } else {
        results.push(filePath);
      }
    }
  }

  traverseDirectory(directoryPath);
  return results;
}

/**
 * Reads the contents of a file
 * @param filePath Path to the file
 * @returns File contents as string
 */
export function readFileContent(filePath: string): string {
  return fs.readFileSync(filePath, "utf8");
}

export function mergeFiles(folderPath: string): OpenAPI2Document {
  const files = readFilesFromDirectory(folderPath, "example");
  const mergedContent: OpenAPI2Document = {
    swagger: "2.0",
    info: { title: "placeholder", version: "placeholder" },
    paths: {},
  };

  for (const file of files) {
    const fileContent = readFileContent(file);
    const jsonContent: OpenAPI2Document = JSON.parse(fileContent);
    mergedContent.info = jsonContent.info;

    for (const consumer of jsonContent.consumes ?? []) {
      if (!mergedContent.consumes) {
        mergedContent.consumes = [];
      }
      if (!mergedContent.consumes.includes(consumer)) {
        mergedContent.consumes.push(consumer);
      }
    }
    for (const producer of jsonContent.produces ?? []) {
      if (!mergedContent.produces) {
        mergedContent.produces = [];
      }
      if (!mergedContent.produces.includes(producer)) {
        mergedContent.produces.push(producer);
      }
    }

    for (const pathKey in jsonContent.paths) {
      const pathValue = jsonContent.paths[pathKey];
      if (!mergedContent.paths[pathKey]) {
        mergedContent.paths[pathKey] = pathValue!;
      } else {
        // Merge the paths if they already exist
        mergedContent.paths[pathKey] = { ...mergedContent.paths[pathKey], ...pathValue };
      }
    }

    for (const parameterKey in jsonContent.parameters) {
      if (!mergedContent.parameters) {
        mergedContent.parameters = {};
      }
      if (!mergedContent.parameters[parameterKey]) {
        mergedContent.parameters[parameterKey] = jsonContent.parameters[parameterKey]!;
      } else {
        logWarning(`Duplicate parameter key found: ${parameterKey}. Keeping the first one.`);
      }
    }

    for (const definitionKey in jsonContent.definitions) {
      if (!mergedContent.definitions) {
        mergedContent.definitions = {};
      }
      if (!mergedContent.definitions[definitionKey]) {
        mergedContent.definitions[definitionKey] = jsonContent.definitions[definitionKey]!;
      } else {
        logWarning(`Duplicate definition key found: ${definitionKey}. Keeping the first one.`);
      }
    }
  }

  return mergedContent;
}
