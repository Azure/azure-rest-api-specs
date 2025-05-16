import { checkPropertyAttributeDeleted, getPropertyName } from "./helper.js";

export function checkDefault(jsonObj: any): string[] {
  const suggestedFixes: string[] = [];

  const deletedChanges = checkPropertyAttributeDeleted('default', jsonObj);
  if (deletedChanges.length > 0) {
    for (const change of deletedChanges) {
      const { path, value } = change;
      if (getPropertyName(path)) {
        const [definitionName, propertyName] = getPropertyName(path)!;
        suggestedFixes.push(`Find a model called "${definitionName}". Change its property "${propertyName}" by adding \` = ${typeof value === "string" ? `"${value}"` : value }\`.`);
      }
    }
  }

  return suggestedFixes;
}