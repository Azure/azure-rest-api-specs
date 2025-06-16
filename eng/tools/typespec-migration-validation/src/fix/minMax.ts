import { Suggestion } from "../jsonOutput.js";
import { constructJsonPath } from "../summary.js";
import { checkPropertyAttributeDeleted, getPropertyName } from "./helper.js";

const knownPropertyDecoratorMapping: { [key: string]: string } = {
  'minimum': 'minValue',
  'maximum': 'maxValue',
  'minLength': 'minLength',
  'maxLength': 'maxLength'
};

export function checkMinMax(jsonObj: any): Suggestion[] {
  const suggestedFixes: Suggestion[] = [];

  for (const [key, decoratorName] of Object.entries(knownPropertyDecoratorMapping)) {
    const deletedChanges = checkPropertyAttributeDeleted(key, jsonObj);
    if (deletedChanges.length > 0) {
      for (const change of deletedChanges) {
        const { path, value } = change;
        if (getPropertyName(path)) {
          const [definitionName, propertyName] = getPropertyName(path)!;
          suggestedFixes.push({
            suggestion: `Find a model called "${definitionName}". Add \`@${decoratorName}(${value})\` onto its property "${propertyName}". If the property cannot access directly, add \`@@${decoratorName}(${definitionName}.${propertyName}, ${value});\` right after the model.`,
            path: constructJsonPath(path, change.key)
          });
        }
      }
    }
  }

  return suggestedFixes;
}
