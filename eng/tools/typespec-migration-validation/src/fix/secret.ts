import { checkPropertyAttributeDeleted, getPropertyName } from "./helper.js";

export function checkSecret(jsonObj: any): string[] {
  const suggestedFixes: string[] = [];

  const deletedChanges = checkPropertyAttributeDeleted('x-ms-secret', jsonObj);
  if (deletedChanges.length > 0) {
    for (const change of deletedChanges) {
      const { path, value } = change;
      if ((value as any) === false) continue;

      if (getPropertyName(path)) {
        const [definitionName, propertyName] = getPropertyName(path)!;
        suggestedFixes.push(`Find a model called "${definitionName}". Add \`@secret\` onto its property "${propertyName}". If the property cannot access directly, add \`@@secret(${definitionName}.${propertyName})\` right after the model.`);
      }
    }
  }

  return suggestedFixes;
}
