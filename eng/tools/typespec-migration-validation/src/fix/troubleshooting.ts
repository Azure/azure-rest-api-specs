import { checkDefault } from "./default.js";
import { checkPropertyAttributeChanged, checkPropertyAttributeDeleted, getPropertyName } from "./helper.js";
import { checkMinMax } from "./minMax.js";
import { checkNullable } from "./nullable.js";
import { checkReadOnly } from "./readonly.js";
import { checkSecret } from "./secret.js";

export function suggestFix(jsonObj: any): string[] {
  const suggestedFixes: string[] = [];

  const clientNameStatement = checkPropertyAttributeDeleted('x-ms-client-name', jsonObj);
  for (const statement of clientNameStatement) {
    const { path, value } = statement;
    if (getPropertyName(path)) {
      const [definitionName, propertyName] = getPropertyName(path)!; 
      suggestedFixes.push(`@@clientName(${definitionName}.${propertyName}, "${value}");`);
    }
  }

  const flatternStatement = checkPropertyAttributeDeleted('x-ms-client-flatten', jsonObj).filter(entry => (entry.value as any) === true);
  for (const statement of flatternStatement) {
    const { path, value } = statement;
    if ((value as any) === false) continue;

    if (getPropertyName(path)) {
      const [definitionName, propertyName] = getPropertyName(path)!; 
      suggestedFixes.push(`@@flattenProperty(${definitionName}.${propertyName});`);
    }
  }

  if (suggestedFixes.length > 0) {
    suggestedFixes.unshift(`Add the following clientName statements to back-compatible.tsp or client.tsp:`);
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
      suggestedFixes.push(`Find this TypeSpec statement @@clientName(${realPath}, "${newValue}") in file back-compatible.tsp or client.tsp. Change it to @@clientName(${realPath}, "${oldValue})"`);
    }
  }

  suggestedFixes.push(...checkMinMax(jsonObj));
  suggestedFixes.push(...checkReadOnly(jsonObj));
  suggestedFixes.push(...checkDefault(jsonObj));
  suggestedFixes.push(...checkNullable(jsonObj));
  suggestedFixes.push(...checkSecret(jsonObj));

  if (suggestedFixes.length > 0) {
    suggestedFixes.unshift(`You are an expert in TypeSpec. Do the following changes to the TypeSpec file:`);
    for (let i = 1; i < suggestedFixes.length; i++) {
      suggestedFixes[i] = `${i}. ${suggestedFixes[i]}`;
    }
  }
  return suggestedFixes;
}
