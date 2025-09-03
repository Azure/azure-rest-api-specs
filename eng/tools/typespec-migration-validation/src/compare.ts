import { HttpMethod, OpenAPI2Document, OpenAPI2Operation, OpenAPI2Response, OpenAPI2Schema, OpenAPI2SchemaProperty, Ref, Refable } from "@azure-tools/typespec-autorest";
import { getCommonTypeDefinition } from "./commonType.js";

interface Diff {
  before: any;
  after: any;
  level: "warning" | "error";
}

/**
 * path: path for the same operationId should be the same
 * parameters: parameters for the same operationId should have the same count
 * pageable: whether the operation is pageable or not for the same operationId should be the same
 * longrunning: whether the operation is long-running or not for the same operationId should be the same
 * finalstate: whether the final state of the long-running operation is the same for the same operationId
 * finalresult: the final result schema of the long-running operation should be the same as the schema of 200 response
 * responses: the response codes for the same operationId should have the same count and same response code
 * response: the response schema for the same response code should be the same
 */
interface PathDiff extends Diff {
  operationId: string;
  type: "path" | "parameters" | "pageable" | "longrunning" | "finalstate" | "finalresult" | "responses" | "response";
}

/**
 * properties: the property names of the definition should be the same
 * property: the property should have same schema
 * required: the required properties of the definition should be the same
 */
interface DefinitionDiff extends Diff {
  name: string;
  propertyName?: string;
  changeType?: string;
  type: "properties" | "property" | "required";
}

export function printDiff(diff: PathDiff | DefinitionDiff): string {
  if ("operationId" in diff) {
    return `| ${diff.type} | ${diff.level} | ${getPathDiffMessage(diff)} ${JSON.stringify(diff.before)} -> ${JSON.stringify(diff.after)} |\n`;
  } else {
    return `| ${diff.type} | ${diff.level} | ${getDefinitionDiffMessage(diff)} ${JSON.stringify(diff.before)} -> ${JSON.stringify(diff.after)} |\n`;
  }
}

function getPathDiffMessage(diff: PathDiff): string {
  switch (diff.type) {
    case "path":
      return `The path for operation "${diff.operationId}" changed:`;
    case "parameters":
      return `The number of parameters for operation "${diff.operationId}" changed:`;
    case "pageable":
      return `The pageable for operation "${diff.operationId}" changed:`;
    case "longrunning":
      return `The long-running status for operation "${diff.operationId}" changed:`;
    case "finalstate":
      return `The final state for operation "${diff.operationId}" changed:`;
    case "finalresult":
      return `The final result schema for operation "${diff.operationId}" changed:`;
    case "responses":
      return `The response codes for operation "${diff.operationId}" changed:`;
    case "response":
      return `The response schema for operation "${diff.operationId}" changed:`;
    default:
      return `The ${diff.type} for operation "${diff.operationId}" changed:`;
  }
}

function getDefinitionDiffMessage(diff: DefinitionDiff): string {
  switch (diff.type) {
    case "properties":
      return `The property names of definition "${diff.name}" changed:`;
    case "property":
      return `The ${diff.changeType} of property "${diff.propertyName}" in definition "${diff.name}" changed:`;
    case "required":
      return `The required properties of definition "${diff.name}" changed:`;
  }
}

export function compareDocuments(oldDocument: OpenAPI2Document, newDocument: OpenAPI2Document): (PathDiff | DefinitionDiff)[] {
  const diffs: (PathDiff | DefinitionDiff)[] = [];
  diffs.push(...comparePaths(oldDocument, newDocument));

  // If not exists in the new document, it might be an orphaned definition previously
  for (const definition in newDocument.definitions ?? {}) {
    // If not exists in old document, it might be an anonymous definition previously
    if (oldDocument.definitions?.[definition]) {
      diffs.push(...compareNamedDefinition(oldDocument.definitions[definition], oldDocument, newDocument.definitions![definition], newDocument, definition));
    }
  }
  return diffs;
}

const definitionNameCache: Set<string> = new Set();
function compareNamedDefinition(oldDefinition: OpenAPI2Schema, oldDocument: OpenAPI2Document, newDefinition: OpenAPI2Schema, newDocument: OpenAPI2Document, name: string): DefinitionDiff[] {
  if (definitionNameCache.has(name)) {
    console.warn(`Definition "${name}" has been compared before, skipping.`);
    return [];
  }
  definitionNameCache.add(name);

  const diffs: DefinitionDiff[] = [];

  const oldRequired = oldDefinition.required || [];
  const newRequired = newDefinition.required || [];

  if (oldRequired.length !== newRequired.length ||
    !oldRequired.every(item => newRequired.includes(item)) ||
    !newRequired.every(item => oldRequired.includes(item))) {
    diffs.push({
      before: oldRequired,
      after: newRequired,
      name,
      type: "required",
      level: "warning",
    });
  }

  const oldProperties = getAllProperties(oldDefinition, oldDocument);
  const sortedOldProperties = Object.keys(oldProperties).sort().reduce((obj: Record<string, OpenAPI2SchemaProperty>, key) => {
    obj[key] = oldProperties[key];
    return obj;
  }, {});

  const newProperties = getAllProperties(newDefinition, newDocument);
  const sortedNewProperties = Object.keys(newProperties).sort().reduce((obj: Record<string, OpenAPI2SchemaProperty>, key) => {
    obj[key] = newProperties[key];
    return obj;
  }, {});

  // First check if the properties are the same
  const oldKeys = Object.keys(sortedOldProperties);
  const newKeys = Object.keys(sortedNewProperties);
  if (oldKeys.length !== newKeys.length) {
    // Check if newKeys has exactly one more key and it's systemData
    const isSystemDataOnlyDifference = newKeys.length === oldKeys.length + 1 &&
      newKeys.filter(key => !oldKeys.includes(key)).length === 1 &&
      newKeys.filter(key => !oldKeys.includes(key))[0] === 'systemData';

    diffs.push({
      before: oldKeys,
      after: newKeys,
      name,
      type: "properties",
      level: isSystemDataOnlyDifference ? "warning" : "error"
    });
  }
  for (const key of oldKeys) {
    if (!newKeys.includes(key)) {
      diffs.push({
        before: oldKeys,
        after: newKeys,
        name,
        type: "properties",
        level: "error"
      });
    }
  }
  for (const key of newKeys) {
    if (!oldKeys.includes(key)) {
      // Check if the only additional key is systemData
      const additionalKeys = newKeys.filter(k => !oldKeys.includes(k));
      const isOnlySystemData = additionalKeys.length === 1 && additionalKeys[0] === 'systemData';

      diffs.push({
        before: oldKeys,
        after: newKeys,
        name,
        type: "properties",
        level: isOnlySystemData ? "warning" : "error"
      });
    }
  }

  // Then check if the property types are the same
  for (const key of oldKeys) {
    const oldProperty = sortedOldProperties[key];
    const newProperty = sortedNewProperties[key];
    if (oldProperty && newProperty) {
      diffs.push(...compareDefinitionProperty(oldProperty, newProperty, oldDocument, newDocument, key, name));
    }
  }

  return diffs;
}

function compareDefinitionProperty(oldProperty: OpenAPI2SchemaProperty, newProperty: OpenAPI2SchemaProperty, oldDocument: OpenAPI2Document, newDocument: OpenAPI2Document, propertyName: string, modelName: string): DefinitionDiff[] {
  const oldPropertySchema = resolveCommonType(oldProperty);
  const newPropertySchema = resolveCommonType(newProperty);
  if (isRef(oldPropertySchema) && isRef(newPropertySchema)) {
    if (oldPropertySchema.$ref !== newPropertySchema.$ref) {
      return [{
        before: oldPropertySchema.$ref,
        after: newPropertySchema.$ref,
        name: modelName,
        propertyName,
        type: "property",
        changeType: "reference",
        level: "warning"
      }];
    }
  }
  else if (!isRef(oldPropertySchema) && !isRef(newPropertySchema)) {
    return compareNamedDefinition(oldPropertySchema, oldDocument, newPropertySchema, newDocument, `${modelName}.${propertyName}`);
  }

  return [];
}

function comparePaths(oldDocument: OpenAPI2Document, newDocument: OpenAPI2Document): PathDiff[] {
  const oldOperations = organizeOperationById(oldDocument);
  const newOperations = organizeOperationById(newDocument);

  const pathDiffs: PathDiff[] = [];
  for (const operationId in oldOperations) {
    if (!newOperations[operationId]) {
      pathDiffs.push({
        before: oldOperations[operationId][0],
        after: null,
        operationId,
        type: "path",
        level: "error"
      });
    }
    else {
      pathDiffs.push(...compareOperation(oldOperations[operationId][1], newOperations[operationId][1], operationId));
    }
  }
  for (const operationId in newOperations) {
    if (!oldOperations[operationId]) {
      pathDiffs.push({
        before: null,
        after: newOperations[operationId][0],
        operationId,
        type: "path",
        level: "error"
      });
    }
  }
  return pathDiffs;
}

function compareOperation(oldOperation: OpenAPI2Operation, newOperation: OpenAPI2Operation, operationId: string): PathDiff[] {
  const pathDiffs: PathDiff[] = [];

  if (oldOperation.parameters.length !== newOperation.parameters.length) {
    pathDiffs.push({
      before: oldOperation.parameters.length,
      after: newOperation.parameters.length,
      operationId: operationId,
      type: "parameters",
      level: "error"
    });
  }

  pathDiffs.push(...comparePagination(oldOperation, newOperation, operationId));
  pathDiffs.push(...compareLongRunning(oldOperation, newOperation, operationId));
  pathDiffs.push(...compareResponses(oldOperation, newOperation, operationId));

  // TO-DO: Compare parameters in detail
  return pathDiffs;
}

function compareResponses(oldOperation: OpenAPI2Operation, newOperation: OpenAPI2Operation, operationId: string): PathDiff[] {
  const pathDiffs: PathDiff[] = [];

  const oldResponseCodes = Object.keys(oldOperation.responses ?? {}).filter(code => !code.startsWith("x-"));
  const newResponseCodes = Object.keys(newOperation.responses ?? {}).filter(code => !code.startsWith("x-"));

  let sameResponseCodes = true;
  for (const code of oldResponseCodes) {
    if (!newResponseCodes.includes(code)) {
      sameResponseCodes = false;
      break;
    }
  }
  for (const code of newResponseCodes) {
    if (!oldResponseCodes.includes(code)) {
      sameResponseCodes = false;
      break;
    }
  }

  if (!sameResponseCodes) {
    pathDiffs.push({
      before: oldResponseCodes,
      after: newResponseCodes,
      operationId: operationId,
      type: "responses",
      level: "error"
    });
  }

  for (const code of oldResponseCodes) {
    pathDiffs.push(...compareResponse(oldOperation.responses?.[code], newOperation.responses?.[code], operationId));
  }

  return pathDiffs;
}

function compareResponse(oldResponse: Refable<OpenAPI2Response> | undefined, newResponse: Refable<OpenAPI2Response> | undefined, operationId: string): PathDiff[] {
  let oldSchema = getResponseSchema(oldResponse);
  let newSchema = getResponseSchema(newResponse);
  if (oldSchema !== newSchema) {
    return [{
      before: oldResponse,
      after: newResponse,
      operationId: operationId,
      type: "response",
      level: "error"
    }];
  }

  return [];
}

function comparePagination(oldOperation: OpenAPI2Operation, newOperation: OpenAPI2Operation, operationId: string): PathDiff[] {
  if ((oldOperation["x-ms-pageable"] === undefined && newOperation["x-ms-pageable"] !== undefined) || (oldOperation["x-ms-pageable"] !== undefined && newOperation["x-ms-pageable"] === undefined)) {
    return [{
      before: oldOperation["x-ms-pageable"],
      after: newOperation["x-ms-pageable"],
      operationId: operationId,
      type: "pageable",
      level: "error"
    }];
  }

  return [];
}

function compareLongRunning(oldOperation: OpenAPI2Operation, newOperation: OpenAPI2Operation, operationId: string): PathDiff[] {
  const pathDiffs: PathDiff[] = [];

  const oldLongRunning = oldOperation["x-ms-long-running-operation"] === true;
  const newLongRunning = newOperation["x-ms-long-running-operation"] === true;
  if (oldLongRunning !== newLongRunning) {
    pathDiffs.push({
      before: oldLongRunning,
      after: newLongRunning,
      operationId: operationId,
      type: "longrunning",
      level: "error"
    });
  }

  const oldFinalState = oldOperation["x-ms-long-running-operation-options"]?.["final-state-via"] ?? "location";
  const newFinalState = newOperation["x-ms-long-running-operation-options"]?.["final-state-via"] ?? "location";
  if (oldFinalState !== newFinalState) {
    pathDiffs.push({
      before: oldFinalState,
      after: newFinalState,
      operationId: operationId,
      type: "finalstate",
      level: "error"
    });
  }

  if (oldLongRunning) {
    const newFinalResult = newOperation["x-ms-long-running-operation-options"]?.["final-state-schema"];
    const newFinalResultSchema = newFinalResult?.split("/").pop();
    if (newFinalResultSchema !== getResponseSchema(oldOperation.responses?.["200"])) {
      pathDiffs.push({
        before: getResponseSchema(oldOperation.responses?.["200"]),
        after: newFinalResultSchema,
        operationId: operationId,
        type: "finalresult",
        level: "error"
      });
    }
  }

  return pathDiffs;
}

function getResponseSchema(response: Refable<OpenAPI2Response> | undefined): string | undefined {
  if (response && (response as OpenAPI2Response).schema && ((response as OpenAPI2Response).schema as any).$ref) {
    const refPath = ((response as OpenAPI2Response).schema as any).$ref;
    return refPath.split("/").pop();
  }

  return undefined;
}


function organizeOperationById(document: OpenAPI2Document): Record<string, [string, OpenAPI2Operation]> {
  function isHttpMethod(key: string): key is HttpMethod {
    const httpMethods: HttpMethod[] = [
      "get",
      "put",
      "post",
      "delete",
      "options",
      "head",
      "patch",
      "trace",
    ];
    return httpMethods.includes(key as HttpMethod);
  }

  const operationMap: Record<string, [string, OpenAPI2Operation]> = {};
  if (!document.paths) {
    return operationMap;
  }

  for (const route in document.paths) {
    const pathItem = document.paths[route];
    for (const verb in pathItem) {
      if (isHttpMethod(verb)) {
        const operation = pathItem[verb];
        if (operation && operation.operationId) {
          operationMap[operation.operationId] = [route, operation];
        }
      }
    }
  }

  return operationMap;
}

function getAllProperties(schema: OpenAPI2Schema, document: OpenAPI2Document, properties: Record<string, OpenAPI2SchemaProperty> = {}): Record<string, OpenAPI2SchemaProperty> {
  for (const baseSchema of schema.allOf ?? []) {
    if (isRef(baseSchema)) {
      const refPath = baseSchema.$ref;
      const commonTypeDefinition = getCommonTypeDefinition(refPath);
      if (commonTypeDefinition) {
        getAllProperties(commonTypeDefinition[0], commonTypeDefinition[1], properties);
      }
      else {
        const baseDefinition = getLocalDefinition(refPath, document);
        if (baseDefinition) {
          getAllProperties(baseDefinition, document, properties);
        }
      }
    }
    else {
      if (baseSchema.properties) {
        for (const key in baseSchema.properties) {
          properties[key] = baseSchema.properties[key];
        }
      }
    }
  }

  if (schema.properties) {
    for (const key in schema.properties) {
      properties[key] = schema.properties[key];
    }
  }
  return properties;
}

function resolveCommonType(property: OpenAPI2SchemaProperty): OpenAPI2SchemaProperty {
  if (isRef(property)) {
    const { $ref, ...propertyWithoutRef } = property;
    const commonTypeDefinition = getCommonTypeDefinition($ref);
    if (commonTypeDefinition) {
      return { ...propertyWithoutRef, ...commonTypeDefinition[0] };
    }
  }

  return property;
}

function getLocalDefinition(refPath: string, document: OpenAPI2Document): OpenAPI2Schema | undefined {
  const definitionName = refPath.split("/").pop();
  if (!document.definitions || !document.definitions[definitionName!]) {
    console.warn(`Reference to ${definitionName} cannot be found, skipping.`);
  }
  return document.definitions?.[definitionName!];
}

export function isRef<T>(value: Refable<T>): value is Ref<T> {
  return (value as Ref<T>).$ref !== undefined;
}