import { checkPropertyAttributeDeleted, getPropertyName } from "./helper.js";

export function  checkNullable(jsonObj: any): string[] {
  const suggestedFixes: string[] = [];

  const deletedChanges = checkPropertyAttributeDeleted('x-nullable', jsonObj);
  if (deletedChanges.length > 0) {
    for (const change of deletedChanges) {
      const { path, value } = change;
      if ((value as any) === false) continue;

      if (getPropertyName(path)) {
        const [definitionName, propertyName] = getPropertyName(path)!;
        suggestedFixes.push(`Find a model called "${definitionName}". Change its property "${propertyName}" by adding \` | null\` to its property type.`);
      }
    }
  }

  return suggestedFixes;
}