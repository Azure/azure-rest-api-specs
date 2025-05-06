import { checkDefault } from "./default.js";
import { checkPropertyAttributeChanged, checkPropertyAttributeDeleted } from "./helper.js";
import { checkMinMax } from "./minMax.js";
import { checkReadOnly } from "./readonly.js";

export function suggestFix(jsonObj: any): string[] {
  const suggestedFixes: string[] = [];

  const clientNameStatement = checkPropertyAttributeDeleted('x-ms-client-name', jsonObj);
  if (clientNameStatement.length > 0) {
    suggestedFixes.push(...clientNameStatement.map(entry => `@@clientName(${entry.path.split('.').filter(part => !['definitions', 'properties', 'x-ms-client-name__deleted'].includes(part)).join('.')}, "${entry.value}")`));
  }

  const flatternStatement = checkPropertyAttributeDeleted('x-ms-client-flatten', jsonObj).filter(entry => (entry.value as any) === true);
  if (flatternStatement.length > 0) {
    suggestedFixes.push(...flatternStatement.map(entry => `#suppress "deprecated" "@flattenProperty decorator is not recommended to use."\n@@flattenProperty(${entry.path.split('.').filter(part => !['definitions', 'properties', 'x-ms-client-flatten__deleted'].includes(part)).join('.')})`));
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

  if (suggestedFixes.length > 0) {
    suggestedFixes.unshift(`You are an expert in TypeSpec. Do the following changes to the TypeSpec file:`);
    for (let i = 1; i < suggestedFixes.length; i++) {
      suggestedFixes[i] = `${i}. ${suggestedFixes[i]}`;
    }
  }
  return suggestedFixes;
}
