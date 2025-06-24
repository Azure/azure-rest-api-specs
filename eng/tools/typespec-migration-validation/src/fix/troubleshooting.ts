import { jsonOutput, Suggestion } from "../jsonOutput.js";
import { constructJsonPath } from "../summary.js";
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
      const s = `@@clientName(${definitionName}.${propertyName}, "${value}");`
      suggestedFixes.push(s);
      jsonOutput.suggestions.push({
        suggestion: `Find file "back-compatible.tsp" or "client.tsp" and add the following statement exactly as it is::
\`\`\`typespec
${s}
\`\`\``,
        path: constructJsonPath(path, statement.key)
      });
    }
  }

  const flatternStatement = checkPropertyAttributeDeleted('x-ms-client-flatten', jsonObj).filter(entry => (entry.value as any) === true);
  for (const statement of flatternStatement) {
    const { path, value } = statement;
    if ((value as any) === false) continue;

    if (getPropertyName(path)) {
      const [definitionName, propertyName] = getPropertyName(path)!;
      const s = `@@flattenProperty(${definitionName}.${propertyName});`;
      suggestedFixes.push(s);
      jsonOutput.suggestions.push({
        suggestion: `Find file "back-compatible.tsp" or "client.tsp" and add the following statement exactly as it is::
\`\`\`typespec
${s}
\`\`\``,
        path: constructJsonPath(path, statement.key)
      });
    }
  }

  if (suggestedFixes.length > 0) {
    suggestedFixes.unshift(
      `Add the following clientName statements to back-compatible.tsp or client.tsp:`,
    );
  }
  return suggestedFixes;
}

export function suggestPrompt(jsonObj: any): string[] {
  const suggestedFixes: Suggestion[] = [];

  const clientNameChanges = checkPropertyAttributeChanged('x-ms-client-name', jsonObj);
  for (const change of clientNameChanges) {
    const { path, oldValue, newValue } = change;
    if (getPropertyName(path)) {
      const [definitionName, propertyName] = getPropertyName(path)!;
      suggestedFixes.push({
        suggestion: `Find this TypeSpec statement @@clientName(${definitionName}.${propertyName}, "${newValue}") in file back-compatible.tsp or client.tsp. Change it to @@clientName(${definitionName}.${propertyName}, "${oldValue})"`,
        path: path
      });
    }
  }

  const clientNameAdded = checkPropertyAttributeAdded('x-ms-client-name', jsonObj);
  for (const change of clientNameAdded) {
    const { path, value } = change;
    if (getPropertyName(path)) {
      const [definitionName, propertyName] = getPropertyName(path)!;
      suggestedFixes.push({
        suggestion: `Find this TypeSpec statement @@clientName(${definitionName}.${propertyName}, "${value}") in file back-compatible.tsp or client.tsp. Delete this statement.`,
        path: constructJsonPath(path, change.key)
      });
    }
  }

  suggestedFixes.push(...checkMinMax(jsonObj));
  suggestedFixes.push(...checkReadOnly(jsonObj));
  suggestedFixes.push(...checkDefault(jsonObj));
  suggestedFixes.push(...checkNullable(jsonObj));
  suggestedFixes.push(...checkSecret(jsonObj));

  const suggestionsAsString = suggestedFixes.map(s => s.suggestion);
  if (suggestedFixes.length > 0) {
    jsonOutput.suggestions.push(...suggestedFixes);
    suggestionsAsString.unshift(`You are an expert in TypeSpec. Follow the prompt exactly as written. Do not add any additional suggestions or modifications unless explicitly requested.`);
    for (let i = 1; i < suggestionsAsString.length; i++) {
      suggestionsAsString[i] = `${i}. ${suggestionsAsString[i]}`;
    }
  }
  return suggestionsAsString;
}
