import { Suggestion } from "../jsonOutput.js";
import { constructJsonPath } from "../summary.js";
import { checkPropertyAttributeDeleted, getPropertyName } from "./helper.js";

export function checkReadOnly(jsonObj: any): Suggestion[] {
  const suggestedFixes: Suggestion[] = [];

  const deletedChanges = checkPropertyAttributeDeleted('readOnly', jsonObj);
  if (deletedChanges.length > 0) {
    for (const change of deletedChanges) {
      const { path, value } = change;
      if ((value as any) === false) continue;

      if (getPropertyName(path)) {
        const [definitionName, propertyName] = getPropertyName(path)!;
        suggestedFixes.push({
          suggestion: `Find a model called "${definitionName}". Add \`@visibility(Lifecycle.Read)\` onto its property "${propertyName}". If the property cannot access directly, add \`@@visibility(${definitionName}.${propertyName}, Lifecycle.Read);\` RIGHT AFTER the end bracket of the model.`,
          path: constructJsonPath(path, change.key)
        });
      }
    }
  }

  return suggestedFixes;
}
