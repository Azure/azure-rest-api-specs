import { jsonOutput } from "./jsonOutput.ts";

/**
 * Interface representing a value and the set of JSON paths where it appears
 */
export interface ValueChangeInfo {
  /** Map of JSON paths to their values where this key was found */
  // oxlint-disable-next-line typescript/no-explicit-any -- Existing lint debt
  paths: Map<string, any>;
}

/**
 * Information about a path that was added or deleted
 */
export interface PathChangeInfo {
  /** The path that was changed */
  path: string;
  /** The type of change (added or deleted) */
  changeType: "added" | "deleted";
}

/**
 * Information about a value that has been modified with old and new values
 */
export interface ModifiedValueInfo {
  /** The path to the modified value */
  path: string;
  /** The old value */
  // oxlint-disable-next-line typescript/no-explicit-any -- Existing lint debt
  oldValue: any;
  /** The new value */
  // oxlint-disable-next-line typescript/no-explicit-any -- Existing lint debt
  newValue: any;
}

/**
 * Finds all keys in a JSON object that end with "__added" or "__deleted" and returns a mapping
 * of keys to their paths
 * @param jsonObj The JSON object to search
 * @param currentPath The current path in the JSON object (used for recursion)
 * @returns A Map with keys as result keys and values as sets of JSON paths
 */
export function findDifferences(
  // oxlint-disable-next-line typescript/no-explicit-any -- Existing lint debt
  jsonObj: any,
  currentPath: string = "",
): Map<string, ValueChangeInfo> {
  const results = new Map<string, ValueChangeInfo>();

  if (!jsonObj || typeof jsonObj !== "object") {
    return results;
  }

  // Process the current object
  for (const key in jsonObj) {
    if (!Object.prototype.hasOwnProperty.call(jsonObj, key)) {
      continue;
    }

    // Use bracket notation for keys with dots
    const newPath = constructJsonPath(currentPath, key);
    // oxlint-disable-next-line typescript/no-unsafe-assignment, typescript/no-unsafe-member-access -- Existing lint debt
    const value = jsonObj[key];

    if (key.endsWith("__added") || key.endsWith("__deleted")) {
      if (!results.has(key)) {
        results.set(key, {
          // oxlint-disable-next-line typescript/no-explicit-any -- Existing lint debt
          paths: new Map<string, any>(),
        });
      }

      results.get(key)?.paths.set(newPath, value);
    }

    if (value !== null && typeof value === "object") {
      if (Array.isArray(value)) {
        // Handle arrays
        value.forEach((item, index) => {
          if (item !== null && typeof item === "object") {
            const arrayItemPath = `${newPath}[${index}]`;
            const nestedResults = findDifferences(item, arrayItemPath);

            // Merge nested results
            nestedResults.forEach((ValueChangeInfo, nestedKey) => {
              if (!results.has(nestedKey)) {
                results.set(nestedKey, {
                  // oxlint-disable-next-line typescript/no-explicit-any -- Existing lint debt
                  paths: new Map<string, any>(),
                });
              }

              ValueChangeInfo.paths.forEach((pathValue, path) => {
                results.get(nestedKey)?.paths.set(path, pathValue);
              });
            });
          }
        });
      } else {
        // Handle regular objects
        const nestedResults = findDifferences(value, newPath);

        // Merge nested results
        nestedResults.forEach((ValueChangeInfo, nestedKey) => {
          if (!results.has(nestedKey)) {
            results.set(nestedKey, {
              // oxlint-disable-next-line typescript/no-explicit-any -- Existing lint debt
              paths: new Map<string, any>(),
            });
          }

          ValueChangeInfo.paths.forEach((pathValue, path) => {
            results.get(nestedKey)?.paths.set(path, pathValue);
          });
        });
      }
    }
  }

  return results;
}

/**
 * Constructs a proper JSON path, using bracket notation for segments containing dots
 * and removes integer parts that follow array notation
 * @param currentPath Current path being processed
 * @param key The key to append to the path
 * @returns A properly formatted JSON path string
 */
export function constructJsonPath(currentPath: string, key: string): string {
  // Check if the key is an integer following an array notation
  const isArrayIndex = /^\d+$/.test(key) && currentPath.endsWith("]");

  // If this is an array index, we don't add it to the path
  if (isArrayIndex) {
    return currentPath;
  }

  // Check if key contains dots or special characters requiring bracket notation
  const needsBrackets = key.includes(".") || key.includes(" ") || key.includes("-");

  if (currentPath === "") {
    return needsBrackets ? `['${key.replace(/\\/g, "\\\\").replace(/'/g, "\\'")}']` : key;
  }

  return needsBrackets
    ? `${currentPath}['${key.replace(/\\/g, "\\\\").replace(/'/g, "\\'")}']`
    : `${currentPath}.${key}`;
}

/**
 * Finds paths in the jsonObject["paths"] property that end with __added or __deleted
 * and returns them sorted alphabetically (case insensitive)
 *
 * @param jsonObject The JSON object containing a "paths" property to search
 * @returns Array of PathChangeInfo objects sorted alphabetically by path
 */
// oxlint-disable-next-line typescript/no-explicit-any -- Existing lint debt
export function findChangedPaths(jsonObject: any): PathChangeInfo[] {
  const results: PathChangeInfo[] = [];

  // Check if jsonObject and paths property exist
  // oxlint-disable-next-line typescript/no-unsafe-member-access -- Existing lint debt
  if (!jsonObject || !jsonObject.paths || typeof jsonObject.paths !== "object") {
    return results;
  }

  // Iterate through all keys in the paths object
  // oxlint-disable-next-line typescript/no-unsafe-member-access -- Existing lint debt
  for (const pathKey in jsonObject.paths) {
    // oxlint-disable-next-line typescript/no-unsafe-member-access -- Existing lint debt
    if (!Object.prototype.hasOwnProperty.call(jsonObject.paths, pathKey)) {
      continue;
    }

    // Check if the key ends with __added or __deleted
    if (pathKey.endsWith("__added")) {
      results.push({
        path: pathKey.replace(/__added$/, ""),
        changeType: "added",
      });
    } else if (pathKey.endsWith("__deleted")) {
      results.push({
        path: pathKey.replace(/__deleted$/, ""),
        changeType: "deleted",
      });
    }
  }

  // Sort results alphabetically by path (case insensitive)
  return results.sort((a, b) => a.path.toLowerCase().localeCompare(b.path.toLowerCase()));
}

/**
 * Returns a formatted Markdown table representation of the added/deleted keys for reporting in README files
 * Organizes output by key, with each key having its own table of values
 * @param keyPathsMap Map of keys to paths from findDifferences
 * @returns A formatted Markdown with tables organized by keys
 */
export function formatDifferenceReport(keyPathsMap: Map<string, ValueChangeInfo>): string {
  if (keyPathsMap.size === 0) {
    return "";
  }

  let report = "## Swagger Changes\n\n";

  // Group by keys
  // oxlint-disable-next-line typescript/no-explicit-any -- Existing lint debt
  const keyGroups: Map<string, Map<string, ["added" | "deleted", any]>> = new Map();

  keyPathsMap.forEach((valueChangeInfo, key) => {
    const baseKey = key.replace(/__added$|__deleted$/, "");
    const changeType = key.endsWith("__added") ? "added" : "deleted";

    if (!keyGroups.has(baseKey)) {
      keyGroups.set(baseKey, new Map());
    }

    valueChangeInfo.paths.forEach((value, path) => {
      keyGroups.get(baseKey)?.set(path, [changeType, value]);
    });
  });

  // Generate a table for each key
  keyGroups.forEach((pathsMap, key) => {
    report += `### Changes for \`${key}\`\n\n`;
    report += "| Path | Change Type | Value |\n";
    report += "|------|------------|-------|\n";

    // Sort paths alphabetically
    const sortedPaths = Array.from(pathsMap.keys()).sort((a, b) =>
      a.toLowerCase().localeCompare(b.toLowerCase()),
    );

    sortedPaths.forEach((path) => {
      // oxlint-disable-next-line typescript/no-unsafe-assignment -- Existing lint debt
      const [changeType, value] = pathsMap.get(path)!;
      const formattedValue =
        typeof value === "object"
          ? JSON.stringify(value).substring(0, 100) +
            (JSON.stringify(value).length > 100 ? "..." : "")
          : String(value);

      report += `| \`${path}\` | ${changeType} | \`${formattedValue.replace(/\\/g, "\\\\").replace(/\|/g, "\\|")}\` |\n`;
      jsonOutput.apiChanges.push({
        category: "added-or-deleted",
        key: key,
        path: path,
        type: changeType,
        value: formattedValue,
      });
    });

    report += "\n";
  });

  return report;
}

/**
 * Returns a formatted string representation of the changed paths
 * @param changedPaths Array of PathChangeInfo objects from findChangedPaths
 * @returns A formatted string with paths and their change types
 */
export function formatChangedPathsReport(changedPaths: PathChangeInfo[]): string {
  let report = "";
  if (changedPaths.length === 0) return report;

  report += "## Changed Paths\n\n";
  changedPaths.forEach(({ path, changeType }) => {
    report += `Path: ${path}\nChange Type: ${changeType}\n\n`;
    jsonOutput.apiChanges.push({
      category: "path-changed",
      path: path,
      type: changeType,
    });
  });
  return report;
}

/**
 * Finds all pairs of keys with "__old" and "__new" suffixes in the JSON object
 * @param jsonObj The JSON object to search
 * @param currentPath The current path in the JSON object (used for recursion)
 * @returns Array of ModifiedValueInfo objects containing paths and old/new values
 */
// oxlint-disable-next-line typescript/no-explicit-any -- Existing lint debt
export function findModifiedValues(jsonObj: any, currentPath: string = ""): ModifiedValueInfo[] {
  // oxlint-disable-next-line typescript/no-explicit-any -- Existing lint debt
  const oldValues = new Map<string, { path: string; value: any }>();
  // oxlint-disable-next-line typescript/no-explicit-any -- Existing lint debt
  const newValues = new Map<string, { path: string; value: any }>();
  const results: ModifiedValueInfo[] = [];

  if (!jsonObj || typeof jsonObj !== "object") {
    return results;
  }

  // Process the current level
  for (const key in jsonObj) {
    if (!Object.prototype.hasOwnProperty.call(jsonObj, key)) {
      continue;
    }

    // oxlint-disable-next-line typescript/no-unsafe-assignment, typescript/no-unsafe-member-access -- Existing lint debt
    const value = jsonObj[key];
    const newPath = constructJsonPath(currentPath, key);

    // Check for __old and __new keys
    if (key.endsWith("__old")) {
      const basePath = newPath.replace(/.__old$/, "");
      // oxlint-disable-next-line typescript/no-unsafe-assignment -- Existing lint debt
      oldValues.set(basePath, { path: newPath, value });
    } else if (key.endsWith("__new")) {
      const basePath = newPath.replace(/.__new$/, "");
      // oxlint-disable-next-line typescript/no-unsafe-assignment -- Existing lint debt
      newValues.set(basePath, { path: newPath, value });
    }

    // Recursively process objects and arrays
    if (value !== null && typeof value === "object") {
      if (Array.isArray(value)) {
        value.forEach((item, index) => {
          if (item !== null && typeof item === "object") {
            const arrayItemPath = `${newPath}[${index}]`;
            results.push(...findModifiedValues(item, arrayItemPath));
          }
        });
      } else {
        results.push(...findModifiedValues(value, newPath));
      }
    }
  }

  // Match old and new value pairs
  for (const [basePath, oldInfo] of oldValues.entries()) {
    const newInfo = newValues.get(basePath);
    if (newInfo) {
      results.push({
        path: basePath,
        // oxlint-disable-next-line typescript/no-unsafe-assignment -- Existing lint debt
        oldValue: oldInfo.value,
        // oxlint-disable-next-line typescript/no-unsafe-assignment -- Existing lint debt
        newValue: newInfo.value,
      });
    }
  }

  return results;
}

/**
 * Returns a formatted Markdown table of the modified values
 * @param modifiedValues Array of ModifiedValueInfo objects
 * @returns A formatted Markdown table with old and new values
 */
export function formatModifiedValuesReport(modifiedValues: ModifiedValueInfo[]): string {
  if (modifiedValues.length === 0) {
    return "";
  }

  let report = "## Modified Values\n\n";
  report += "| Path | Old Value | New Value |\n";
  report += "|------|-----------|----------|\n";

  modifiedValues.sort((a, b) => a.path.toLowerCase().localeCompare(b.path.toLowerCase()));

  modifiedValues.forEach(({ path, oldValue, newValue }) => {
    // oxlint-disable-next-line typescript/no-explicit-any -- Existing lint debt
    const formatValue = (value: any): string => {
      if (value === undefined) return "`undefined`";
      if (value === null) return "`null`";

      const valueStr =
        typeof value === "object"
          ? JSON.stringify(value).substring(0, 100) +
            (JSON.stringify(value).length > 100 ? "..." : "")
          : String(value);

      return `\`${valueStr.replace(/\\/g, "\\\\").replace(/\|/g, "\\|").replace(/`/g, "\\`")}\``;
    };

    report += `| \`${path}\` | ${formatValue(oldValue)} | ${formatValue(newValue)} |\n`;
    jsonOutput.apiChanges.push({
      category: "value-changed",
      path: path,
      oldValue: formatValue(oldValue),
      newValue: formatValue(newValue),
    });
  });

  report += "\n";
  return report;
}
