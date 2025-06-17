import { Suggestion } from "../jsonOutput.js";
import { constructJsonPath } from "../summary.js";
import { checkPropertyAttributeDeleted, getPropertyName } from "./helper.js";

export function checkDefault(jsonObj: any): Suggestion[] {
  const suggestedFixes: Suggestion[] = [];

  const deletedChanges = checkPropertyAttributeDeleted('default', jsonObj);
  if (deletedChanges.length > 0) {
    for (const change of deletedChanges) {
      const { path, value } = change;
      if (getPropertyName(path)) {
        const [definitionName, propertyName] = getPropertyName(path)!;
        suggestedFixes.push({
          suggestion: `Find a model called "${definitionName}". Change its property "${propertyName}" by adding \` = ${typeof value === "string" ? `"${value}"` : value }\`.`,
          path: constructJsonPath(path, change.key)
        });
      }
    }
  }

  return suggestedFixes;
}