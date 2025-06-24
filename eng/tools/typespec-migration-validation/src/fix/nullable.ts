import { Suggestion } from "../jsonOutput.js";
import { constructJsonPath } from "../summary.js";
import { checkPropertyAttributeDeleted, getPropertyName } from "./helper.js";

export function  checkNullable(jsonObj: any): Suggestion[] {
  const suggestedFixes: Suggestion[] = [];

  const deletedChanges = checkPropertyAttributeDeleted('x-nullable', jsonObj);
  if (deletedChanges.length > 0) {
    for (const change of deletedChanges) {
      const { path, value } = change;
      if ((value as any) === false) continue;

      if (getPropertyName(path)) {
        const [definitionName, propertyName] = getPropertyName(path)!;
        suggestedFixes.push({
          suggestion: `Find a model called "${definitionName}". Change its property "${propertyName}" by adding \` | null\` to its property type.`,
          path: constructJsonPath(path, change.key)
        });
      }
    }
  }

  return suggestedFixes;
}