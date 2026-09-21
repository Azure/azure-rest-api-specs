import { canonicalJson } from "./stable-id.mjs";

export function typeIdentity(value) {
  if (typeof value === "string") return value;
  return value?.crossLanguageDefinitionId ??
    value?.identity ??
    value?.id ??
    value?.name ??
    value?.kind;
}

function parameterTypeContract(type) {
  if (!type || typeof type !== "object") return typeIdentity(type);
  switch (type.kind) {
    case "array":
      return {
        kind: "array",
        valueType: parameterTypeContract(type.valueType),
      };
    case "dictionary":
    case "dict":
      return {
        kind: "dictionary",
        keyType: parameterTypeContract(type.keyType),
        valueType: parameterTypeContract(type.valueType),
      };
    case "tuple":
      return {
        kind: "tuple",
        valueTypes: (type.valueTypes ?? []).map(parameterTypeContract),
      };
    case "nullable":
      return {
        kind: "nullable",
        type: parameterTypeContract(type.type),
      };
    default:
      return typeIdentity(type);
  }
}

export function publicParameterContract(parameters = []) {
  return parameters
    .filter((parameter) => parameter.type?.kind !== "constant")
    .map((parameter) => ({
      name: parameter.name,
      optional: Boolean(parameter.optional),
      onClient: Boolean(parameter.onClient),
      isApiVersionParam: Boolean(parameter.isApiVersionParam),
      type: parameterTypeContract(parameter.type),
    }));
}

export function semanticLroContract(lro) {
  if (!lro) return undefined;
  const operation = lro.operation
    ? {
        kind: lro.operation.kind,
        path: lro.operation.path,
        verb: lro.operation.verb,
      }
    : undefined;
  return {
    finalStateVia: lro.finalStateVia,
    pollingStep: lro.pollingStep,
    finalStep: lro.finalStep,
    statusMonitorStep: lro.statusMonitorStep,
    operation,
    logicalResult: lro.logicalResult,
    pollingInfo: lro.pollingInfo,
    envelopeResult: lro.envelopeResult,
    finalEnvelopeResult: lro.finalEnvelopeResult,
    finalResult: lro.finalResult,
    logicalPath: lro.logicalPath,
    finalResultPath: lro.finalResultPath,
    finalResponse: lro.finalResponse,
  };
}

function changedParameterFields(before, after) {
  return ["optional", "onClient", "isApiVersionParam", "type"]
    .filter((field) => {
      const left = before[field];
      const right = after[field];
      return left === undefined || right === undefined
        ? left !== right
        : canonicalJson(left) !== canonicalJson(right);
    });
}

export function diffPublicParameters(beforeParameters = [], afterParameters = []) {
  const before = publicParameterContract(beforeParameters);
  const after = publicParameterContract(afterParameters);
  const beforeByName = new Map(before.map((parameter, index) => [parameter.name, { parameter, index }]));
  const afterByName = new Map(after.map((parameter, index) => [parameter.name, { parameter, index }]));
  const retainedBefore = before.filter((parameter) => afterByName.has(parameter.name));
  const retainedAfter = after.filter((parameter) => beforeByName.has(parameter.name));
  const retainedBeforePositions = new Map(
    retainedBefore.map((parameter, index) => [parameter.name, index]),
  );
  const retainedAfterPositions = new Map(
    retainedAfter.map((parameter, index) => [parameter.name, index]),
  );

  const added = after.flatMap((parameter, index) =>
    beforeByName.has(parameter.name) ? [] : [{ parameter, index }]);
  const removed = before.flatMap((parameter, index) =>
    afterByName.has(parameter.name) ? [] : [{ parameter, index }]);
  const modified = retainedAfter.flatMap((parameter) => {
    const previous = beforeByName.get(parameter.name).parameter;
    const changedFields = changedParameterFields(previous, parameter);
    return changedFields.length
      ? [{ name: parameter.name, before: previous, after: parameter, changedFields }]
      : [];
  });
  const reordered = retainedAfter.flatMap((parameter) => {
    const beforeIndex = retainedBeforePositions.get(parameter.name);
    const afterIndex = retainedAfterPositions.get(parameter.name);
    return beforeIndex === afterIndex
      ? []
      : [{ name: parameter.name, beforeIndex, afterIndex }];
  });
  const modifiedNames = new Set(modified.map((item) => item.name));
  const reorderedNames = new Set(reordered.map((item) => item.name));
  const unchangedCount = retainedAfter.filter((parameter) =>
    !modifiedNames.has(parameter.name) && !reorderedNames.has(parameter.name)).length;

  return { added, removed, modified, reordered, unchangedCount };
}
