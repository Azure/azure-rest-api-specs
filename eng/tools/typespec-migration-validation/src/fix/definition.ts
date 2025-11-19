import { Suggestion } from "../jsonOutput.js";
import { constructJsonPath } from "../summary.js";
import { getPropertyName } from "./helper.js";

const knownPropertyDecoratorMapping: { [key: string]: string } = {
  minimum: "minValue",
  maximum: "maxValue",
  minLength: "minLength",
  maxLength: "maxLength",
};

const addedKey = "__added";
const deletedKey = "__deleted";

export function handleAdded(diff: {
  path: string;
  value: string;
  key: string;
}): Suggestion | undefined {
  const { path, value, key } = diff;
  if (key.endsWith(addedKey)) {
    const originalKey = key.slice(0, addedKey.length); // Remove '__added' suffix
    const property = getPropertyName(path);

    if (originalKey === "x-ms-client-name") {
      if (property) {
        const [definitionName, propertyName] = property;
        return {
          suggestion: `Find this TypeSpec statement @@clientName(${definitionName}.${propertyName}, "${value}") in file back-compatible.tsp or client.tsp. Delete this statement.`,
          path: constructJsonPath(path, key),
        };
      }
    }
  }

  return undefined;
}

export function handleDeleted(diff: {
  path: string;
  value: string;
  key: string;
}): Suggestion | undefined {
  const { path, value, key } = diff;
  if (key.endsWith(deletedKey)) {
    const originalKey = key.slice(0, deletedKey.length); // Remove '__deleted' suffix
    const property = getPropertyName(path);

    if (originalKey === "x-ms-client-name") {
      if (property) {
        const [definitionName, propertyName] = property;
        const suggestion = `@@clientName(${definitionName}.${propertyName}, "${value}");`;
        return {
          suggestion: `Find file "back-compatible.tsp" or "client.tsp" and add the following statement exactly as it is::
  \`\`\`typespec
  ${suggestion}
  \`\`\``,
          path: constructJsonPath(path, key),
        };
      }
    } else if (originalKey === "x-ms-client-flatten") {
      if ((value as any) === true && property) {
        const [definitionName, propertyName] = property;
        const suggestion = `@@flattenProperty(${definitionName}.${propertyName});`;
        return {
          suggestion: `Find file "back-compatible.tsp" or "client.tsp" and add the following statement exactly as it is::
  \`\`\`typespec
  ${suggestion}
  \`\`\``,
          path: constructJsonPath(path, key),
        };
      }
    } else if (Object.keys(knownPropertyDecoratorMapping).includes(originalKey)) {
      const decoratorName = knownPropertyDecoratorMapping[originalKey];
      if (property) {
        const [definitionName, propertyName] = property;
        return {
          suggestion: `Find a model called "${definitionName}". Add \`@${decoratorName}(${value})\` onto its property "${propertyName}". If the property cannot access directly, add \`@@${decoratorName}(${definitionName}.${propertyName}, ${value});\` right after the model.`,
          path: constructJsonPath(path, key),
        };
      }
    } else if (originalKey === "x-nullable") {
      if ((value as any) === true && property) {
        const [definitionName, propertyName] = property;
        return {
          suggestion: `Find a model called "${definitionName}". Change its property "${propertyName}" by adding \` | null\` to its property type.`,
          path: constructJsonPath(path, key),
        };
      }
    } else if (originalKey === "readOnly") {
      if ((value as any) === true && property) {
        const [definitionName, propertyName] = property;
        return {
          suggestion: `Find a model called "${definitionName}". Add \`@visibility(Lifecycle.Read)\` onto its property "${propertyName}". If the property cannot access directly, add \`@@visibility(${definitionName}.${propertyName}, Lifecycle.Read);\` RIGHT AFTER the end bracket of the model.`,
          path: constructJsonPath(path, key),
        };
      }
    } else if (originalKey === "x-ms-secret") {
      if ((value as any) === true && property) {
        const [definitionName, propertyName] = property;
        return {
          suggestion: `Find a model called "${definitionName}". Add \`@secret\` onto its property "${propertyName}". If the property cannot access directly, add \`@@secret(${definitionName}.${propertyName});\` right after the model.`,
          path: constructJsonPath(path, key),
        };
      }
    } else if (originalKey === "default") {
      if (property) {
        const [definitionName, propertyName] = property;
        return {
          suggestion: `Find a model called "${definitionName}". Change its property "${propertyName}" by adding \` = ${typeof value === "string" ? `"${value}"` : value}\`.`,
          path: constructJsonPath(path, key),
        };
      }
    }
  }

  return undefined;
}

export function handleChanged(diff: {
  path: string;
  oldValue: string;
  newValue: string;
  key: string;
}): Suggestion | undefined {
  const { path, oldValue, newValue, key } = diff;
  const property = getPropertyName(path);
  if (key === "x-ms-client-name") {
    if (property) {
      const [definitionName, propertyName] = property;
      return {
        suggestion: `Find this TypeSpec statement @@clientName(${definitionName}.${propertyName}, "${newValue}") in file back-compatible.tsp or client.tsp. Change it to @@clientName(${definitionName}.${propertyName}, "${oldValue}")`,
        path: path,
      };
    }
  }
  return undefined;
}
