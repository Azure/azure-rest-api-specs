import { checkPropertyAttributeDeleted } from "./helper.js";

export function checkDefault(jsonObj: any): string[] {
  const suggestedFixes: string[] = [];

  const deletedChanges = checkPropertyAttributeDeleted('default', jsonObj);
  if (deletedChanges.length > 0) {
    for (const change of deletedChanges) {
      const { path, value } = change;
      const pathParts = path.split('.');
      const definitionIndex = pathParts.findIndex(part => part === 'definitions');
      if (definitionIndex !== -1 && definitionIndex + 3 < pathParts.length) {
        const definitionName = pathParts[definitionIndex + 1];
        const propertyName = pathParts[definitionIndex + 3];
        suggestedFixes.push(`Find a model called "${definitionName}". Change its property "${propertyName}" by adding \` = ${typeof value === "string" ? `"${value}"` : value }\`.`);
      }
    }
  }

  return suggestedFixes;
}