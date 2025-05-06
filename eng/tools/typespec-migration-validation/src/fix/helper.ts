export function checkPropertyAttributeDeleted(checkKey: string, jsonObj: any, currentPath: string = ''): Array<{path: string, value: string}> {
  const results: Array<{path: string, value: string}> = [];

  if (!jsonObj || typeof jsonObj !== 'object') {
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
        value: jsonObj[key]
      });
    }

    // If value is an object or array, recursively search it
    if (jsonObj[key] && typeof jsonObj[key] === 'object') {
      const nestedResults = checkPropertyAttributeDeleted(checkKey, jsonObj[key], newPath);
      results.push(...nestedResults);
    }
  }

  return results;
}

export function checkPropertyAttributeChanged(checkKey: string, jsonObj: any, currentPath: string = ''): Array<{path: string, oldValue: string, newValue: string}> {
  const results: Array<{path: string, oldValue: string, newValue: string}> = [];

  if (!jsonObj || typeof jsonObj !== 'object') {
    return results;
  }

  for (const key in jsonObj) {
    if (!Object.prototype.hasOwnProperty.call(jsonObj, key)) {
      continue;
    }

    const newPath = currentPath ? `${currentPath}.${key}` : key;

    // Check if this is an x-ms-client-name with __old and __new properties
    if (key === checkKey && 
        typeof jsonObj[key] === 'object' && 
        jsonObj[key]['__old'] !== undefined && 
        jsonObj[key]['__new'] !== undefined) {
      // Store the path, old value and new value
      results.push({
        path: currentPath, // Use parent path since we're interested in the property that has this extension
        oldValue: jsonObj[key]['__old'],
        newValue: jsonObj[key]['__new']
      });
    }

    // If value is an object or array, recursively search it
    if (jsonObj[key] && typeof jsonObj[key] === 'object') {
      const nestedResults = checkPropertyAttributeChanged(checkKey, jsonObj[key], newPath);
      results.push(...nestedResults);
    }
  }

  return results;
}
