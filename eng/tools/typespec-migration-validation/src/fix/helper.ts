export function checkElementAddedOrDeleted(
  jsonObj: any,
  currentPath: string = "",
): Array<{ path: string; value: string; key: string }> {
  const results: Array<{ path: string; value: string; key: string }> = [];

  if (!jsonObj || typeof jsonObj !== "object") {
    return results;
  }

  for (const key in jsonObj) {
    if (!Object.prototype.hasOwnProperty.call(jsonObj, key)) {
      continue;
    }

    const newPath = currentPath ? `${currentPath}.${key}` : key;

    if (key.endsWith("__deleted") || key.endsWith("__added")) {
      // Store both the path and the value
      results.push({
        path: currentPath, // Use parent path since we're interested in the property that has this extension
        value: jsonObj[key],
        key: key,
      });
    }

    // If value is an object or array, recursively search it
    if (jsonObj[key] && typeof jsonObj[key] === "object") {
      const nestedResults = checkElementAddedOrDeleted(jsonObj[key], newPath);
      results.push(...nestedResults);
    }
  }

  return results;
}

export function checkElementChanged(
  jsonObj: any,
  currentPath: string = "",
): Array<{ path: string; oldValue: string; newValue: string; key: string }> {
  const results: Array<{ path: string; oldValue: string; newValue: string; key: string }> = [];

  if (!jsonObj || typeof jsonObj !== "object") {
    return results;
  }

  for (const key in jsonObj) {
    if (!Object.prototype.hasOwnProperty.call(jsonObj, key)) {
      continue;
    }

    const newPath = currentPath ? `${currentPath}.${key}` : key;

    if (
      typeof jsonObj[key] === "object" &&
      jsonObj[key]["__old"] !== undefined &&
      jsonObj[key]["__new"] !== undefined
    ) {
      // Store the path, old value and new value
      results.push({
        path: currentPath, // Use parent path since we're interested in the property that has this extension
        oldValue: jsonObj[key]["__old"],
        newValue: jsonObj[key]["__new"],
        key: key,
      });
    }

    // If value is an object or array, recursively search it
    if (jsonObj[key] && typeof jsonObj[key] === "object") {
      const nestedResults = checkElementChanged(jsonObj[key], newPath);
      results.push(...nestedResults);
    }
  }

  return results;
}

export function checkPropertyAttributeDeleted(
  checkKey: string,
  jsonObj: any,
  currentPath: string = "",
): Array<{ path: string; value: string; key: string }> {
  const results: Array<{ path: string; value: string; key: string }> = [];

  if (!jsonObj || typeof jsonObj !== "object") {
    return results;
  }

  for (const key in jsonObj) {
    if (!Object.prototype.hasOwnProperty.call(jsonObj, key)) {
      continue;
    }

    const newPath = currentPath ? `${currentPath}.${key}` : key;

    if (key === `${checkKey}__deleted`) {
      // Store both the path and the value
      results.push({
        path: currentPath, // Use parent path since we're interested in the property that has this extension
        value: jsonObj[key],
        key: key,
      });
    }

    // If value is an object or array, recursively search it
    if (jsonObj[key] && typeof jsonObj[key] === "object") {
      const nestedResults = checkPropertyAttributeDeleted(checkKey, jsonObj[key], newPath);
      results.push(...nestedResults);
    }
  }

  return results;
}

export function checkPropertyAttributeAdded(
  checkKey: string,
  jsonObj: any,
  currentPath: string = "",
): Array<{ path: string; value: string; key: string }> {
  const results: Array<{ path: string; value: string; key: string }> = [];
  if (!jsonObj || typeof jsonObj !== "object") {
    return results;
  }
  for (const key in jsonObj) {
    if (!Object.prototype.hasOwnProperty.call(jsonObj, key)) {
      continue;
    }
    const newPath = currentPath ? `${currentPath}.${key}` : key;
    if (key === `${checkKey}__added`) {
      // Store both the path and the value
      results.push({
        path: currentPath, // Use parent path since we're interested in the property that has this extension
        value: jsonObj[key],
        key: key,
      });
    }

    if (jsonObj[key] && typeof jsonObj[key] === "object") {
      const nestedResults = checkPropertyAttributeAdded(checkKey, jsonObj[key], newPath);
      results.push(...nestedResults);
    }
  }
  return results;
}

export function checkPropertyAttributeChanged(
  checkKey: string,
  jsonObj: any,
  currentPath: string = "",
): Array<{ path: string; oldValue: string; newValue: string }> {
  const results: Array<{ path: string; oldValue: string; newValue: string }> = [];

  if (!jsonObj || typeof jsonObj !== "object") {
    return results;
  }

  for (const key in jsonObj) {
    if (!Object.prototype.hasOwnProperty.call(jsonObj, key)) {
      continue;
    }

    const newPath = currentPath ? `${currentPath}.${key}` : key;

    if (
      key === checkKey &&
      typeof jsonObj[key] === "object" &&
      jsonObj[key]["__old"] !== undefined &&
      jsonObj[key]["__new"] !== undefined
    ) {
      // Store the path, old value and new value
      results.push({
        path: currentPath, // Use parent path since we're interested in the property that has this extension
        oldValue: jsonObj[key]["__old"],
        newValue: jsonObj[key]["__new"],
      });
    }

    // If value is an object or array, recursively search it
    if (jsonObj[key] && typeof jsonObj[key] === "object") {
      const nestedResults = checkPropertyAttributeChanged(checkKey, jsonObj[key], newPath);
      results.push(...nestedResults);
    }
  }

  return results;
}

export function getPropertyName(
  jsonPath: string,
): [definitionName: string, propertyName: string] | undefined {
  const pathParts = jsonPath.split(".");
  const definitionIndex = pathParts.findIndex((part) => part === "definitions");
  if (definitionIndex !== -1 && definitionIndex + 3 < pathParts.length) {
    const definitionName = pathParts[definitionIndex + 1];
    const propertyName = pathParts[definitionIndex + 3];
    return [definitionName, propertyName];
  }
  return undefined;
}
