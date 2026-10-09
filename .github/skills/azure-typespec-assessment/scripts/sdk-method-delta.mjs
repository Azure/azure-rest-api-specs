import { canonicalJson } from "./stable-id.mjs";

/**
 * @typedef {{
 *   kind?: string,
 *   crossLanguageDefinitionId?: string,
 *   identity?: string,
 *   id?: string,
 *   name?: string,
 *   valueType?: SdkType,
 *   keyType?: SdkType,
 *   valueTypes?: SdkType[],
 *   type?: SdkType
 * }} SdkType
 * @typedef {{
 *   name: string,
 *   optional?: boolean,
 *   onClient?: boolean,
 *   isApiVersionParam?: boolean,
 *   type?: SdkType
 * }} SdkParameter
 * @typedef {{kind?: string, responseBody?: {kind?: string}}} LroStep
 * @typedef {{
 *   name: string,
 *   optional: boolean,
 *   onClient: boolean,
 *   isApiVersionParam: boolean,
 *   type: unknown
 * }} PublicParameter
 * @typedef {{
 *   operation?: {kind?: unknown, path?: unknown, verb?: unknown},
 *   finalStateVia?: unknown,
 *   pollingStep?: LroStep,
 *   finalStep?: LroStep,
 *   statusMonitorStep?: LroStep,
 *   logicalResult?: SdkType | string,
 *   pollingInfo?: unknown,
 *   envelopeResult?: unknown,
 *   finalEnvelopeResult?: unknown,
 *   finalResult?: unknown,
 *   logicalPath?: unknown,
 *   finalResultPath?: unknown,
 *   finalResponse?: unknown
 * }} LongRunningOperation
 */

/**
 * @param {SdkType | string | undefined} value
 * @returns {string | undefined}
 */
export function typeIdentity(value) {
  if (typeof value === "string") return value;
  return (
    value?.crossLanguageDefinitionId ?? value?.identity ?? value?.id ?? value?.name ?? value?.kind
  );
}

/**
 * @param {SdkType | string | undefined} type
 * @returns {unknown}
 */
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

/**
 * @param {SdkParameter[]} [parameters]
 * @returns {PublicParameter[]}
 */
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

/**
 * @param {LongRunningOperation | undefined} lro
 */
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

/**
 * @param {PublicParameter} before
 * @param {PublicParameter} after
 * @returns {string[]}
 */
function changedParameterFields(before, after) {
  /** @type {(keyof Omit<PublicParameter, "name">)[]} */
  const fields = ["optional", "onClient", "isApiVersionParam", "type"];
  return fields.filter((field) => {
    const left = before[field];
    const right = after[field];
    return left === undefined || right === undefined
      ? left !== right
      : canonicalJson(left) !== canonicalJson(right);
  });
}

/**
 * @param {SdkParameter[]} [beforeParameters]
 * @param {SdkParameter[]} [afterParameters]
 */
export function diffPublicParameters(beforeParameters = [], afterParameters = []) {
  const before = publicParameterContract(beforeParameters);
  const after = publicParameterContract(afterParameters);
  const beforeByName = new Map(
    before.map((parameter, index) => [parameter.name, { parameter, index }]),
  );
  const afterByName = new Map(
    after.map((parameter, index) => [parameter.name, { parameter, index }]),
  );
  const retainedBefore = before.filter((parameter) => afterByName.has(parameter.name));
  const retainedAfter = after.filter((parameter) => beforeByName.has(parameter.name));
  const retainedBeforePositions = new Map(
    retainedBefore.map((parameter, index) => [parameter.name, index]),
  );
  const retainedAfterPositions = new Map(
    retainedAfter.map((parameter, index) => [parameter.name, index]),
  );

  const added = after.flatMap((parameter, index) =>
    beforeByName.has(parameter.name) ? [] : [{ parameter, index }],
  );
  const removed = before.flatMap((parameter, index) =>
    afterByName.has(parameter.name) ? [] : [{ parameter, index }],
  );
  const modified = retainedAfter.flatMap((parameter) => {
    const previous = beforeByName.get(parameter.name)?.parameter;
    if (!previous) return [];
    const changedFields = changedParameterFields(previous, parameter);
    return changedFields.length
      ? [{ name: parameter.name, before: previous, after: parameter, changedFields }]
      : [];
  });
  const reordered = retainedAfter.flatMap((parameter) => {
    const beforeIndex = retainedBeforePositions.get(parameter.name);
    const afterIndex = retainedAfterPositions.get(parameter.name);
    return beforeIndex === afterIndex ? [] : [{ name: parameter.name, beforeIndex, afterIndex }];
  });
  const modifiedNames = new Set(modified.map((item) => item.name));
  const reorderedNames = new Set(reordered.map((item) => item.name));
  const unchangedCount = retainedAfter.filter(
    (parameter) => !modifiedNames.has(parameter.name) && !reorderedNames.has(parameter.name),
  ).length;

  return { added, removed, modified, reordered, unchangedCount };
}
