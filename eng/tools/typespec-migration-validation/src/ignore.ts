/**
 * User could choose to ignore certain difference report
 */

import { type OpenAPI2Document } from "@azure-tools/typespec-autorest";

const ignoreList: Set<string> = new Set();

export function addIgnorePath(path: string): void {
  ignoreList.add(path);
}

export function processIgnoreList(
  sortedOldFile: OpenAPI2Document,
  sortedNewFile: OpenAPI2Document,
): void {
  // Process each path in the ignore list
  for (const path of ignoreList) {
    if (path.endsWith("__added")) {
      const realPath = path.replace(/__added$/, "");
      // Delete the added element from the new file
      deleteElementByJsonPath(sortedNewFile, realPath);
    } else if (path.endsWith("__deleted")) {
      const realPath = path.replace(/__deleted$/, "");
      deleteElementByJsonPath(sortedOldFile, realPath);
    } else {
      // oxlint-disable-next-line typescript/no-unsafe-assignment -- Existing lint debt
      const oldValue = getElementByJsonPath(sortedOldFile, path);
      if (oldValue !== undefined) {
        setElementByJsonPath(sortedNewFile, path, oldValue);
      }
    }
  }
}

/**
 * Parses a JSON path string that may contain segments with dots in bracket notation
 * Format can be either dot notation (a.b.c) or mixed with bracket notation for segments with dots (a['b.c.d'].e)
 * Also properly handles array references by keeping them with their parent segment
 * @param path The JSON path to parse
 * @returns Array of path segments
 */
function parseJsonPath(path: string): string[] {
  const segments: string[] = [];
  let currentSegment = "";
  let inBracket = false;
  let inArrayNotation = false;
  let bracketDepth = 0;

  for (let i = 0; i < path.length; i++) {
    const char = path[i];

    // Handle start of bracket notation for property access
    if ((char === "[" && !inBracket && path[i + 1] === "'") || path[i + 1] === '"') {
      // Start of bracket notation for property with special chars
      if (currentSegment) {
        segments.push(currentSegment);
        currentSegment = "";
      }
      inBracket = true;
      continue;
    }
    // Handle start of array index notation
    else if (char === "[" && !inBracket) {
      // This is an array index notation, keep it with the current segment
      inArrayNotation = true;
      bracketDepth++;
      currentSegment += char;
      continue;
    }
    // Handle quotes in bracket notation
    else if (inBracket && (char === "'" || char === '"')) {
      continue;
    }
    // Handle end of bracket notation for property access
    else if (char === "]" && inBracket) {
      // End of bracket notation
      segments.push(currentSegment);
      currentSegment = "";
      inBracket = false;
      continue;
    }
    // Handle end of array index notation
    else if (char === "]" && inArrayNotation) {
      // End of array bracket, keep it as part of the segment
      bracketDepth--;
      if (bracketDepth === 0) {
        inArrayNotation = false;
      }
      currentSegment += char;
      continue;
    }
    // Handle dot separator
    else if (char === "." && !inBracket && !inArrayNotation) {
      // Dot separator (only when not in bracket or array notation)
      if (currentSegment) {
        segments.push(currentSegment);
        currentSegment = "";
      }
      continue;
    }

    // Regular character, add to current segment
    currentSegment += char;
  }

  // Add the last segment if any
  if (currentSegment) {
    segments.push(currentSegment);
  }

  return segments;
}

/**
 * Deletes an element from an object using a parsed JSON path
 * @param obj The object to modify
 * @param path The path to the element to delete (e.g., "paths./users.get")
 */
// oxlint-disable-next-line typescript/no-explicit-any -- Existing lint debt
function deleteElementByJsonPath(obj: any, path: string): void {
  const segments = parseJsonPath(path);

  // oxlint-disable-next-line typescript/no-unsafe-assignment -- Existing lint debt
  let current = obj;

  // Navigate to the parent of the element to delete
  for (let i = 0; i < segments.length - 1; i++) {
    const segment = segments[i];

    // Handle array index notation [n]
    const arrayMatch = segment.match(/^(.*?)\[(\d+)\]$/);
    if (arrayMatch) {
      const arrayName = arrayMatch[1];
      const arrayIndex = parseInt(arrayMatch[2], 10);

      if (
        // oxlint-disable-next-line typescript/no-unsafe-member-access -- Existing lint debt
        !current[arrayName] ||
        // oxlint-disable-next-line typescript/no-unsafe-member-access -- Existing lint debt
        !Array.isArray(current[arrayName]) ||
        // oxlint-disable-next-line typescript/no-unsafe-member-access -- Existing lint debt
        arrayIndex >= current[arrayName].length
      ) {
        // Path doesn't exist, nothing to delete
        return;
      }
      // oxlint-disable-next-line typescript/no-unsafe-assignment, typescript/no-unsafe-member-access -- Existing lint debt
      current = current[arrayName][arrayIndex];
    } else {
      // oxlint-disable-next-line typescript/no-unsafe-member-access -- Existing lint debt
      if (!current[segment] || typeof current[segment] !== "object") {
        // Path doesn't exist, nothing to delete
        return;
      }
      // oxlint-disable-next-line typescript/no-unsafe-assignment, typescript/no-unsafe-member-access -- Existing lint debt
      current = current[segment];
    }
  }

  // Delete the element
  const lastSegment = segments[segments.length - 1];

  // Handle array index notation for the last part
  const arrayMatch = lastSegment.match(/^(.*?)\[(\d+)\]$/);
  if (arrayMatch) {
    const arrayName = arrayMatch[1];
    const arrayIndex = parseInt(arrayMatch[2], 10);

    if (
      // oxlint-disable-next-line typescript/no-unsafe-member-access -- Existing lint debt
      current[arrayName] &&
      // oxlint-disable-next-line typescript/no-unsafe-member-access -- Existing lint debt
      Array.isArray(current[arrayName]) &&
      // oxlint-disable-next-line typescript/no-unsafe-member-access -- Existing lint debt
      arrayIndex < current[arrayName].length
    ) {
      // oxlint-disable-next-line typescript/no-unsafe-member-access -- Existing lint debt
      current[arrayName].splice(arrayIndex, 1);
    }
  } else {
    // oxlint-disable-next-line typescript/no-unsafe-member-access -- Existing lint debt
    delete current[lastSegment];
  }
}

/**
 * Gets an element from an object using a dot-notation JSON path
 * @param obj The object to query
 * @param path The path to the element (e.g., "paths./users.get")
 * @returns The value at the specified path or undefined if not found
 */
// oxlint-disable-next-line typescript/no-explicit-any -- Existing lint debt
function getElementByJsonPath(obj: any, path: string): any {
  const parts = parseJsonPath(path);
  // oxlint-disable-next-line typescript/no-unsafe-assignment -- Existing lint debt
  let current = obj;

  for (const part of parts) {
    // Handle array index notation
    const arrayMatch = part.match(/^(.*)\[(\d+)\]$/);
    if (arrayMatch) {
      const arrayName = arrayMatch[1];
      const arrayIndex = parseInt(arrayMatch[2], 10);

      if (
        // oxlint-disable-next-line typescript/no-unsafe-member-access -- Existing lint debt
        !current[arrayName] ||
        // oxlint-disable-next-line typescript/no-unsafe-member-access -- Existing lint debt
        !Array.isArray(current[arrayName]) ||
        // oxlint-disable-next-line typescript/no-unsafe-member-access -- Existing lint debt
        arrayIndex >= current[arrayName].length
      ) {
        return undefined;
      }
      // oxlint-disable-next-line typescript/no-unsafe-assignment, typescript/no-unsafe-member-access -- Existing lint debt
      current = current[arrayName][arrayIndex];
    } else {
      // oxlint-disable-next-line typescript/no-unsafe-member-access -- Existing lint debt
      if (current[part] === undefined) {
        return undefined;
      }
      // oxlint-disable-next-line typescript/no-unsafe-assignment, typescript/no-unsafe-member-access -- Existing lint debt
      current = current[part];
    }
  }

  return current;
}

/**
 * Sets an element in an object using a dot-notation JSON path
 * @param obj The object to modify
 * @param path The path where to set the element (e.g., "paths./users.get")
 * @param value The value to set
 */
// oxlint-disable-next-line typescript/no-explicit-any -- Existing lint debt
function setElementByJsonPath(obj: any, path: string, value: any): void {
  const parts = parseJsonPath(path);
  // oxlint-disable-next-line typescript/no-unsafe-assignment -- Existing lint debt
  let current = obj;

  // Navigate to the parent of where we want to set the value
  for (let i = 0; i < parts.length - 1; i++) {
    const part = parts[i];

    // Handle array index notation
    const arrayMatch = part.match(/^(.*)\[(\d+)\]$/);
    if (arrayMatch) {
      const arrayName = arrayMatch[1];
      const arrayIndex = parseInt(arrayMatch[2], 10);

      // Ensure the array exists
      // oxlint-disable-next-line typescript/no-unsafe-member-access -- Existing lint debt
      if (!current[arrayName]) {
        // oxlint-disable-next-line typescript/no-unsafe-member-access -- Existing lint debt
        current[arrayName] = [];
      }

      // Ensure the array is long enough
      // oxlint-disable-next-line typescript/no-unsafe-member-access -- Existing lint debt
      while (current[arrayName].length <= arrayIndex) {
        // oxlint-disable-next-line typescript/no-unsafe-call, typescript/no-unsafe-member-access -- Existing lint debt
        current[arrayName].push({});
      }

      // oxlint-disable-next-line typescript/no-unsafe-assignment, typescript/no-unsafe-member-access -- Existing lint debt
      current = current[arrayName][arrayIndex];
    } else {
      // Ensure the object exists
      // oxlint-disable-next-line typescript/no-unsafe-member-access -- Existing lint debt
      if (!current[part]) {
        // oxlint-disable-next-line typescript/no-unsafe-member-access -- Existing lint debt
        current[part] = {};
      }
      // oxlint-disable-next-line typescript/no-unsafe-assignment, typescript/no-unsafe-member-access -- Existing lint debt
      current = current[part];
    }
  }

  // Set the value
  const lastPart = parts[parts.length - 1];

  // Handle array index notation for the last part
  const arrayMatch = lastPart.match(/^(.*)\[(\d+)\]$/);
  if (arrayMatch) {
    const arrayName = arrayMatch[1];
    const arrayIndex = parseInt(arrayMatch[2], 10);

    // Ensure the array exists
    // oxlint-disable-next-line typescript/no-unsafe-member-access -- Existing lint debt
    if (!current[arrayName]) {
      // oxlint-disable-next-line typescript/no-unsafe-member-access -- Existing lint debt
      current[arrayName] = [];
    }

    // Ensure the array is long enough
    // oxlint-disable-next-line typescript/no-unsafe-member-access -- Existing lint debt
    while (current[arrayName].length <= arrayIndex) {
      // oxlint-disable-next-line typescript/no-unsafe-call, typescript/no-unsafe-member-access -- Existing lint debt
      current[arrayName].push(undefined);
    }

    // oxlint-disable-next-line typescript/no-unsafe-assignment, typescript/no-unsafe-member-access -- Existing lint debt
    current[arrayName][arrayIndex] = value;
  } else {
    // oxlint-disable-next-line typescript/no-unsafe-assignment, typescript/no-unsafe-member-access -- Existing lint debt
    current[lastPart] = value;
  }
}
