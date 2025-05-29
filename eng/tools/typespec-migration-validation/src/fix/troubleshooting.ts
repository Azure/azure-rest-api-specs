import { jsonOutput } from "../index.js";
import { checkDefault } from "./default.js";
import { checkPropertyAttributeAdded, checkPropertyAttributeChanged, checkPropertyAttributeDeleted, getPropertyName } from "./helper.js";
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
    suggestedFixes.forEach((fix) => {
      jsonOutput.suggestions.push(
        `Find file "back-compatible.tsp" or "client.tsp" and add the following statement exactly as it is:":
\`\`\`typespec
${fix}
\`\`\``,
      );
    });
    suggestedFixes.unshift(
      `Add the following clientName statements to back-compatible.tsp or client.tsp:`,
    );
  }
  return suggestedFixes;
}

export function suggestPrompt(jsonObj: any): string[] {
  const suggestedFixes: string[] = [];

  const clientNameChanges = checkPropertyAttributeChanged('x-ms-client-name', jsonObj);
  for (const change of clientNameChanges) {
    const { path, oldValue, newValue } = change;
    if (getPropertyName(path)) {
      const [definitionName, propertyName] = getPropertyName(path)!;
      suggestedFixes.push(`Find this TypeSpec statement @@clientName(${definitionName}.${propertyName}, "${newValue}") in file back-compatible.tsp or client.tsp. Change it to @@clientName(${definitionName}.${propertyName}, "${oldValue})"`);
    }
  }

  const clientNameAdded = checkPropertyAttributeAdded('x-ms-client-name', jsonObj);
  for (const change of clientNameAdded) {
    const { path, value } = change;
    if (getPropertyName(path)) {
      const [definitionName, propertyName] = getPropertyName(path)!; 
      suggestedFixes.push(`Find this TypeSpec statement @@clientName(${definitionName}.${propertyName}, "${value}") in file back-compatible.tsp or client.tsp. Delete this statement.`);
    }
  }

  suggestedFixes.push(...checkMinMax(jsonObj));
  suggestedFixes.push(...checkReadOnly(jsonObj));
  suggestedFixes.push(...checkDefault(jsonObj));
  suggestedFixes.push(...checkNullable(jsonObj));
  suggestedFixes.push(...checkSecret(jsonObj));

  if (suggestedFixes.length > 0) {
    jsonOutput.suggestions.push(...suggestedFixes);
    suggestedFixes.unshift(`You are an expert in TypeSpec. Follow the prompt exactly as written. Do not add any additional suggestions or modifications unless explicitly requested.`);
    for (let i = 1; i < suggestedFixes.length; i++) {
      suggestedFixes[i] = `${i}. ${suggestedFixes[i]}`;
    }
  }
  return suggestedFixes;
}
