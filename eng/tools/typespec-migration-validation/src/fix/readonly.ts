import { checkPropertyAttributeDeleted } from "./helper.js";

export function checkReadOnly(jsonObj: any): string[] {
  const suggestedFixes: string[] = [];

  const deletedChanges = checkPropertyAttributeDeleted('readOnly', jsonObj);
  if (deletedChanges.length > 0) {
    for (const change of deletedChanges) {
      const { path, value } = change;
      if ((value as any) === false) continue;

      const pathParts = path.split('.');
      const definitionIndex = pathParts.findIndex(part => part === 'definitions');
      if (definitionIndex !== -1 && definitionIndex + 3 < pathParts.length) {
        const definitionName = pathParts[definitionIndex + 1];
        const propertyName = pathParts[definitionIndex + 3];
        suggestedFixes.push(`Find a model called "${definitionName}". Add \`@visibility(Lifecycle.Read)\` onto its property "${propertyName}". If the property cannot access directly, add \`@@visibility(${definitionName}.${propertyName}, Lifecycle.Read)\` right after the model.`);
      }
    }
  }

  return suggestedFixes;
}