const knownPropertyDecoratorMapping: { [key: string]: string } = {
  'minimum': 'minValue',
  'maximum': 'maxValue',
  'minLength': 'minLength',
  'maxLength': 'maxLength'
};

export function suggestFix(jsonObj: any): string[] {
  const suggestedFixes: string[] = [];

  const clientNameStatement = checkPropertyAttributeDeleted('x-ms-client-name', jsonObj);
  if (clientNameStatement.length > 0) {
    suggestedFixes.push('Add the following clientName statements to back-compatible.tsp or client.tsp:');
    suggestedFixes.push(...clientNameStatement.map(entry => `@@clientName(${entry.path.split('.').filter(part => !['definitions', 'properties', 'x-ms-client-name__deleted'].includes(part)).join('.')}, "${entry.value}")`));
  }
  return suggestedFixes;
}

export function suggestPrompt(jsonObj: any): string[] {
  const suggestedFixes: string[] = [];

  const clientNameChanges = checkPropertyAttributeChanged('x-ms-client-name', jsonObj);
  if (clientNameChanges.length > 0) {
    for (const change of clientNameChanges) {
      const { path, oldValue, newValue } = change;
      const realPath = path.split('.').filter(part => !['definitions', 'properties', 'x-ms-client-name'].includes(part)).join('.');
      suggestedFixes.push(`Find this TypeSpec statement @@clientName(${realPath}, "${newValue}"). Change it to @@clientName(${realPath}, "${oldValue})"`);
    }
  }

  for (const [key, decoratorName] of Object.entries(knownPropertyDecoratorMapping)) {
    const deletedChanges = checkPropertyAttributeDeleted(key, jsonObj);
    if (deletedChanges.length > 0) {
      for (const change of deletedChanges) {
        const { path, value } = change;
        const pathParts = path.split('.');
        const definitionIndex = pathParts.findIndex(part => part === 'definitions');
        if (definitionIndex !== -1 && definitionIndex + 3 < pathParts.length) {
          const definitionName = pathParts[definitionIndex + 1];
          const propertyName = pathParts[definitionIndex + 3];
          suggestedFixes.push(`Find a model called ${definitionName}. Add @${decoratorName}(${value}) onto its property ${propertyName}.`);
        }
      }
    }
  }

  if (suggestedFixes.length > 0) {
    suggestedFixes.unshift(`You are an expert in TypeSpec. Do the following changes to the TypeSpec file:`);
    for (let i = 1; i < suggestedFixes.length; i++) {
      suggestedFixes[i] = `${i}. ${suggestedFixes[i]}`;
    }
  }
  return suggestedFixes;
}

function checkPropertyAttributeChanged(checkKey: string, jsonObj: any, currentPath: string = ''): Array<{path: string, oldValue: string, newValue: string}> {
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

function checkPropertyAttributeDeleted(checkKey: string, jsonObj: any, currentPath: string = ''): Array<{path: string, value: string}> {
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
