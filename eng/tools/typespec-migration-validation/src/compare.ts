import { HttpMethod, OpenAPI2Document, OpenAPI2Operation, OpenAPI2Response, Ref } from "@azure-tools/typespec-autorest";

interface Diff {
  before: any;
  after: any;
}

/**
 * path: path for the same operationId should be the same
 * parameters: parameters for the same operationId should have the same count
 * pageable: whether the operation is pageable or not for the same operationId should be the same
 * longrunning: whether the operation is long-running or not for the same operationId should be the same
 * finalstate: whether the final state of the long-running operation is the same for the same operationId
 * finalresult: the final result schema of the long-running operation should be the same as the schema of 200 response
 */
interface PathDiff extends Diff {
  operationId: string;
  type: "path" | "parameters" | "pageable" | "longrunning" | "finalstate" | "finalresult";
}

export function printPathDiff(diff: PathDiff): string {
  return `| ${diff.type} | The ${diff.type} of operation "${diff.operationId}" changed: ${JSON.stringify(diff.before)} -> ${JSON.stringify(diff.after)} |\n`;
}

export function compareDocuments(oldDocument: OpenAPI2Document, newDocument: OpenAPI2Document) {
  const diffs: PathDiff[] = [];
  diffs.push(...comparePaths(oldDocument, newDocument));
  return diffs;
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
      });
    }
    pathDiffs.push(...compareOperations(oldOperations[operationId][1], newOperations[operationId][1], operationId));
  }
  for (const operationId in newOperations) {
    if (!oldOperations[operationId]) {
      pathDiffs.push({
        before: null,
        after: newOperations[operationId][0],
        operationId,
        type: "path",
      });
    }
  }
  return pathDiffs;
}

function compareOperations(oldOperation: OpenAPI2Operation, newOperation: OpenAPI2Operation, operationId: string): PathDiff[] {
  const pathDiffs: PathDiff[] = [];

  if (oldOperation.parameters.length !== newOperation.parameters.length) {
    pathDiffs.push({
      before: oldOperation.parameters.length,
      after: newOperation.parameters.length,
      operationId: operationId,
      type: "parameters",
    });
  }

  pathDiffs.push(...comparePaginations(oldOperation, newOperation, operationId));
  pathDiffs.push(...compareLongRunnings(oldOperation, newOperation, operationId));

  // TO-DO: Compare parameters in detail
  return pathDiffs;
}

function comparePaginations(oldOperation: OpenAPI2Operation, newOperation: OpenAPI2Operation, operationId: string): PathDiff[] {
  if ((oldOperation["x-ms-pageable"] === undefined && newOperation["x-ms-pageable"] !== undefined) || (oldOperation["x-ms-pageable"] !== undefined && newOperation["x-ms-pageable"] === undefined)) {
    return [{
      before: oldOperation["x-ms-pageable"],
      after: newOperation["x-ms-pageable"],
      operationId: operationId,
      type: "pageable",
    }];
  }

  return [];
}

function compareLongRunnings(oldOperation: OpenAPI2Operation, newOperation: OpenAPI2Operation, operationId: string): PathDiff[] {
  const pathDiffs: PathDiff[] = [];

  const oldLongRunning = oldOperation["x-ms-long-running-operation"] === true;
  const newLongRunning = newOperation["x-ms-long-running-operation"] === true;
  if (oldLongRunning !== newLongRunning) {
    pathDiffs.push({
      before: oldLongRunning,
      after: newLongRunning,
      operationId: operationId,
      type: "longrunning",
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
    });
  }

  const newFinalResult = newOperation["x-ms-long-running-operation-options"]?.["final-state-schema"];
  if (newFinalResult !== get200ResponseSchema(oldOperation)) {
    pathDiffs.push({
      before: get200ResponseSchema(oldOperation),
      after: newFinalResult,
      operationId: operationId,
      type: "finalresult",
    });
  }

  return pathDiffs;
}

function get200ResponseSchema(operation: OpenAPI2Operation): string | undefined {
  const response = operation.responses?.["200"];
  if (response && (response as Ref<OpenAPI2Response>).$ref) {
    const refPath = (response as Ref<OpenAPI2Response>).$ref;
    if (refPath.startsWith("#/definitions/")) {
      return refPath.substring("#/definitions/".length);
    }
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

