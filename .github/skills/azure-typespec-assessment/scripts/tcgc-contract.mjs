import fs from "node:fs";
import path from "node:path";
import { isAlias, parseDocument, visit } from "yaml";
import { canonicalJson, stableId } from "./stable-id.mjs";

/** @typedef {import("./runtime-types.js").NormalizedTcgcType} NormalizedTcgcType */
/** @typedef {import("./runtime-types.js").NormalizedTcgcContract} NormalizedTcgcContract */
/** @typedef {import("./runtime-types.js").NormalizedTcgcMethod} NormalizedTcgcMethod */
/** @typedef {import("./runtime-types.js").NormalizedTcgcNamedType} NormalizedTcgcNamedType */
/** @typedef {import("./runtime-types.js").NormalizedTcgcParameter} NormalizedTcgcParameter */
/** @typedef {NormalizedTcgcParameter & {serializedName?: unknown}} NormalizedTcgcTemplateParameter */
/** @typedef {import("./runtime-types.js").TcgcArtifact} TcgcArtifact */
/** @typedef {import("./runtime-types.js").TcgcCollection<unknown>} UnknownTcgcCollection */
/** @typedef {import("./runtime-types.js").TcgcContext} TcgcContext */
/** @typedef {import("./runtime-types.js").TcgcNode} TcgcNode */

const METHOD_KINDS = new Set(["basic", "paging", "lro", "lropaging"]);
/** @type {WeakMap<TcgcArtifact, {key: string, contract: NormalizedTcgcContract}>} */
const contractCache = new WeakMap();
/** @type {WeakMap<NormalizedTcgcContract, Map<string, Map<string, Map<string, Set<string>>>>>} */
const operationIndexCache = new WeakMap();
const SCALAR_KINDS = new Set([
  "any",
  "unknown",
  "never",
  "void",
  "boolean",
  "string",
  "url",
  "bytes",
  "int8",
  "int16",
  "int32",
  "int64",
  "integer",
  "uint8",
  "uint16",
  "uint32",
  "uint64",
  "safeint",
  "float",
  "float32",
  "float64",
  "decimal",
  "decimal128",
  "bigInteger",
  "numeric",
  "plainDate",
  "plainTime",
  "utcDateTime",
  "offsetDateTime",
  "duration",
]);
const PAGING_SEGMENT_FIELDS = [
  "pageItemsSegments",
  "nextLinkSegments",
  "pageSizeParameterSegments",
  "continuationTokenParameterSegments",
  "continuationTokenResponseSegments",
  "nextLinkReInjectedParametersSegments",
];

/** @param {string} message */
function unsupported(message) {
  return new Error(`Unsupported TCGC shape: ${message}`);
}

/**
 * @template T
 * @param {import("./runtime-types.js").TcgcCollection<T> | undefined} value
 * @returns {[unknown, T][]}
 */
function entries(value) {
  if (value instanceof Map) return [...value.entries()];
  return Object.entries(value ?? {});
}

/**
 * @param {unknown} value
 * @param {string} label
 * @returns {unknown[]}
 */
function array(value, label) {
  if (value === undefined) return [];
  if (!Array.isArray(value)) throw unsupported(`${label} must be an array`);
  return value;
}

/**
 * @param {unknown} value
 * @param {string} label
 * @returns {asserts value is TcgcNode}
 */
function assertObject(value, label) {
  if (!value || typeof value !== "object" || Array.isArray(value)) {
    throw unsupported(`${label} must be an object`);
  }
}

/**
 * @param {unknown} root
 * @param {number} limit
 */
function graphSize(root, limit) {
  const visited = new WeakSet();
  /** @type {unknown[]} */
  const pending = [root];
  let count = 0;
  while (pending.length) {
    const value = pending.pop();
    if (!value || typeof value !== "object" || visited.has(value)) continue;
    visited.add(value);
    count += 1;
    if (count > limit) throw unsupported(`object graph exceeds the ${limit} resource limit`);
    if (Array.isArray(value)) {
      for (const item of /** @type {unknown[]} */ (value)) pending.push(item);
    } else if (value instanceof Map) {
      for (const [key, item] of /** @type {Map<unknown, unknown>} */ (value)) {
        pending.push(key, item);
      }
    } else {
      for (const item of Object.values(/** @type {Record<string, unknown>} */ (value))) {
        pending.push(item);
      }
    }
  }
  return count;
}

/**
 * @param {string} source
 * @param {{maxAliasCount?: number, maxYamlNodes?: number, maxObjects?: number}} [options]
 * @returns {unknown}
 */
export function parseTcgcYaml(
  source,
  { maxAliasCount = 500000, maxYamlNodes = 5000000, maxObjects = 500000 } = {},
) {
  const document = parseDocument(source);
  if (document.errors.length) {
    throw unsupported(`invalid YAML: ${document.errors.map((item) => item.message).join("; ")}`);
  }
  let aliases = 0;
  let nodes = 0;
  visit(document, {
    Node(_key, node) {
      nodes += 1;
      if (isAlias(node)) aliases += 1;
      if (nodes > maxYamlNodes || aliases > maxAliasCount) return visit.BREAK;
    },
  });
  if (nodes > maxYamlNodes) {
    throw unsupported(`YAML AST exceeds the ${maxYamlNodes} node resource limit`);
  }
  if (aliases > maxAliasCount) {
    throw unsupported(`YAML AST exceeds the ${maxAliasCount} alias resource limit`);
  }
  /** @type {unknown} */
  let value;
  try {
    // Literal alias and expanded object limits are enforced separately. The
    // library's multiplicative alias heuristic is prohibitively expensive for
    // TCGC's intentionally shared, cyclic graph.
    value = document.toJS({ maxAliasCount: -1 });
  } catch (error) {
    const message = error instanceof Error ? error.message : String(error);
    throw unsupported(`YAML alias expansion failed: ${message}`);
  }
  graphSize(value, maxObjects);
  return value;
}

/**
 * @param {TcgcNode} raw
 * @param {string} fallback
 */
function identity(raw, fallback) {
  return raw?.crossLanguageDefinitionId || fallback;
}

/** @param {unknown} raw */
function referenceName(raw) {
  if (!raw || typeof raw !== "object" || Array.isArray(raw)) return undefined;
  const value = /** @type {TcgcNode} */ (raw);
  return value.crossLanguageDefinitionId ?? value.name;
}

/**
 * @param {unknown} item
 * @param {number} index
 */
function segmentIdentity(item, index) {
  if (typeof item === "string" || typeof item === "number") return String(item);
  if (!item || typeof item !== "object" || Array.isArray(item)) return `segment-${index}`;
  const value = /** @type {TcgcNode} */ (item);
  return referenceName(value) ?? value.serializedName ?? `${value.kind ?? "segment"}-${index}`;
}

/**
 * @param {TcgcContext} context
 * @param {string} code
 * @param {string} location
 * @param {unknown} current
 * @param {unknown} deprecated
 */
function conflict(context, code, location, current, deprecated) {
  if (
    current === undefined ||
    deprecated === undefined ||
    canonicalJson(current) === canonicalJson(deprecated)
  ) {
    return;
  }
  context.conflicts.push({ code, path: location, current, deprecated });
}

/** @param {unknown} value */
function normalizedPropertyIdentity(value) {
  if (!value || typeof value !== "object" || Array.isArray(value)) return referenceName(value);
  const item = /** @type {TcgcNode} */ (value);
  return referenceName(item) ?? item.serializedName ?? item.name;
}

/** @param {unknown} value */
function normalizeSerializationOptions(value) {
  if (value === undefined) return undefined;
  assertObject(value, "serializationOptions");
  return {
    json: value.json ? { name: value.json.name } : undefined,
    xml: value.xml
      ? {
          name: value.xml.name,
          attribute: value.xml.attribute,
          ns: value.xml.ns,
          unwrapped: value.xml.unwrapped,
          itemsName: value.xml.itemsName,
          itemsNs: value.xml.itemsNs,
        }
      : undefined,
    multipart: value.multipart
      ? {
          name: value.multipart.name,
          isFilePart: value.multipart.isFilePart,
          isMulti: value.multipart.isMulti,
          filename: normalizedPropertyIdentity(value.multipart.filename),
          contentType: normalizedPropertyIdentity(value.multipart.contentType),
          defaultContentTypes: value.multipart.defaultContentTypes ?? [],
          headers: (value.multipart.headers ?? []).map(normalizedPropertyIdentity),
        }
      : undefined,
    binary: value.binary
      ? {
          isFile: value.binary.isFile,
          isText: value.binary.isText,
          contentTypes: value.binary.contentTypes ?? [],
          filename: normalizedPropertyIdentity(value.binary.filename),
        }
      : undefined,
  };
}

/**
 * @param {TcgcNode} raw
 * @param {TcgcContext} context
 * @param {string} location
 */
function normalizeSerialization(raw, context, location) {
  const current = normalizeSerializationOptions(raw.serializationOptions);
  const deprecated =
    raw.serializedName === undefined &&
    raw.multipartOptions === undefined &&
    raw.isMultipartFileInput === undefined
      ? undefined
      : {
          serializedName: raw.serializedName,
          multipartOptions: raw.multipartOptions
            ? {
                name: raw.multipartOptions.name,
                isFilePart: raw.multipartOptions.isFilePart,
                isMulti: raw.multipartOptions.isMulti,
                filename: normalizedPropertyIdentity(raw.multipartOptions.filename),
                contentType: normalizedPropertyIdentity(raw.multipartOptions.contentType),
                defaultContentTypes: raw.multipartOptions.defaultContentTypes ?? [],
                headers: (raw.multipartOptions.headers ?? []).map(normalizedPropertyIdentity),
              }
            : undefined,
          isMultipartFileInput: raw.isMultipartFileInput,
        };
  if (current !== undefined && deprecated !== undefined) {
    const currentName = current.json?.name ?? current.multipart?.name;
    if (raw.serializedName !== undefined) {
      conflict(context, "serialization-name-conflict", location, currentName, raw.serializedName);
    }
    if (raw.multipartOptions !== undefined) {
      conflict(
        context,
        "serialization-multipart-conflict",
        location,
        current.multipart,
        deprecated.multipartOptions,
      );
    }
    if (raw.isMultipartFileInput !== undefined) {
      conflict(
        context,
        "serialization-file-input-conflict",
        location,
        current.multipart?.isFilePart,
        raw.isMultipartFileInput,
      );
    }
  }
  return current ?? deprecated;
}

/**
 * @param {unknown} value
 * @param {TcgcContext} context
 * @param {string} location
 */
function normalizeDiscriminatedOptions(value, context, location) {
  if (value === undefined) return undefined;
  assertObject(value, `${location}.discriminatedOptions`);
  if (value.envelope !== "object" && value.envelope !== "none") {
    throw unsupported(`${location}.discriminatedOptions.envelope must be object or none`);
  }
  if (typeof value.discriminatorPropertyName !== "string") {
    throw unsupported(`${location}.discriminatedOptions is missing discriminatorPropertyName`);
  }
  return {
    envelope: value.envelope,
    discriminatorPropertyName: value.discriminatorPropertyName,
    envelopePropertyName: value.envelopePropertyName,
  };
}

/**
 * @param {unknown} raw
 * @param {TcgcContext} [context]
 * @param {string} [location]
 * @param {WeakSet<object>} [stack]
 * @returns {NormalizedTcgcType}
 */
export function normalizeType(
  raw,
  context = { conflicts: [] },
  location = "type",
  stack = new WeakSet(),
) {
  assertObject(raw, location);
  if (!raw.kind || typeof raw.kind !== "string") throw unsupported(`${location} is missing kind`);
  if (stack.has(raw)) {
    return {
      kind: "reference",
      id:
        referenceName(raw) ?? stableId("tcgc-cycle", { location, kind: raw.kind, name: raw.name }),
      cycle: true,
    };
  }
  stack.add(raw);
  /** @type {NormalizedTcgcType} */
  let result;
  if (SCALAR_KINDS.has(raw.kind)) {
    result = { kind: raw.kind };
    if (raw.encode !== undefined) result.encode = raw.encode;
    if (raw.wireType !== undefined) {
      result.wireType = normalizeType(raw.wireType, context, `${location}.wireType`, stack);
    }
  } else {
    switch (raw.kind) {
      case "array":
        result = {
          kind: "array",
          valueType: normalizeType(raw.valueType, context, `${location}.valueType`, stack),
        };
        break;
      case "tuple":
        result = {
          kind: "tuple",
          valueTypes: array(raw.valueTypes, `${location}.valueTypes`).map((item, index) =>
            normalizeType(item, context, `${location}.valueTypes[${index}]`, stack),
          ),
        };
        break;
      case "dict":
      case "dictionary":
        result = {
          kind: "dictionary",
          keyType: normalizeType(raw.keyType, context, `${location}.keyType`, stack),
          valueType: normalizeType(raw.valueType, context, `${location}.valueType`, stack),
        };
        break;
      case "nullable":
        result = {
          kind: "nullable",
          type: normalizeType(raw.type, context, `${location}.type`, stack),
        };
        break;
      case "union":
        result = {
          kind: "union",
          id: identity(raw, `union:${raw.name ?? location}`),
          name: raw.name,
          variantTypes: array(raw.variantTypes, `${location}.variantTypes`).map((item, index) =>
            normalizeType(item, context, `${location}.variantTypes[${index}]`, stack),
          ),
          discriminatedOptions: normalizeDiscriminatedOptions(
            raw.discriminatedOptions,
            context,
            location,
          ),
        };
        break;
      case "model":
        result = {
          kind: "model",
          id: identity(raw, `model:${raw.name ?? location}`),
          name: raw.name,
        };
        break;
      case "enum":
        result = {
          kind: "enum",
          id: identity(raw, `enum:${raw.name ?? location}`),
          name: raw.name,
        };
        break;
      case "enumvalue":
      case "enum-value":
        result = {
          kind: "enumvalue",
          name: raw.name,
          value: raw.value,
          enumType: raw.enumType
            ? normalizeType(raw.enumType, context, `${location}.enumType`, stack)
            : undefined,
        };
        break;
      case "constant":
        result = {
          kind: "constant",
          value: raw.value,
          valueType: normalizeType(raw.valueType, context, `${location}.valueType`, stack),
        };
        break;
      case "credential":
        result = {
          kind: "credential",
          scheme:
            typeof raw.scheme === "object" && raw.scheme !== null ? raw.scheme.type : raw.scheme,
        };
        break;
      case "endpoint":
        result = {
          kind: "endpoint",
          serverUrl: raw.serverUrl,
          templateArguments: array(raw.templateArguments, `${location}.templateArguments`).map(
            (item, index) =>
              normalizeParameter(
                item,
                context,
                `${location}.templateArguments[${index}]`,
                index,
                stack,
              ),
          ),
        };
        break;
      case "external":
        result = {
          kind: "external",
          id: identity(raw, `external:${raw.name ?? location}`),
          name: raw.name,
          packageName: raw.packageName,
        };
        break;
      default:
        throw unsupported(`${location} has unknown type kind ${raw.kind}`);
    }
  }
  if (raw.external !== undefined && result.kind !== "external") {
    result.external = {
      identity: raw.external.identity,
      package: raw.external.package,
      minVersion: raw.external.minVersion,
    };
  }
  stack.delete(raw);
  return result;
}

/**
 * @param {unknown} value
 * @param {string} location
 */
function normalizeSegments(value, location) {
  return array(value, location).map((segment, index) => {
    if (Array.isArray(segment)) {
      return segment.map((item, itemIndex) => segmentIdentity(item, itemIndex));
    }
    return segmentIdentity(segment, index);
  });
}

/**
 * @param {unknown} raw
 * @param {TcgcContext} context
 * @param {string} location
 * @param {number} position
 * @param {WeakSet<object>} [stack]
 * @returns {NormalizedTcgcTemplateParameter}
 */
function normalizeParameter(raw, context, location, position, stack = new WeakSet()) {
  assertObject(raw, location);
  const currentSegments = raw.methodParameterSegments;
  const deprecatedSegments = raw.correspondingMethodParams;
  const normalizedCurrentSegments =
    currentSegments === undefined
      ? undefined
      : normalizeSegments(currentSegments, `${location}.methodParameterSegments`);
  const normalizedDeprecatedSegments =
    deprecatedSegments === undefined
      ? undefined
      : normalizeSegments(deprecatedSegments, `${location}.correspondingMethodParams`);
  conflict(
    context,
    "method-parameter-segments-conflict",
    location,
    normalizedCurrentSegments,
    normalizedDeprecatedSegments,
  );
  /** @type {NormalizedTcgcTemplateParameter} */
  const result = {
    position,
    name: raw.name,
    serializedName: raw.serializedName,
    kind: raw.kind,
    type: normalizeType(raw.type, context, `${location}.type`, stack),
    optional: Boolean(raw.optional),
    onClient: Boolean(raw.onClient),
    isApiVersionParam: Boolean(raw.isApiVersionParam),
    access: raw.access,
    flatten: Boolean(raw.flatten),
    crossLanguageDefinitionId: raw.crossLanguageDefinitionId,
    serialization: normalizeSerialization(raw, context, location),
  };
  if (currentSegments !== undefined || deprecatedSegments !== undefined) {
    result.methodParameterSegments = normalizedCurrentSegments ?? normalizedDeprecatedSegments;
  }
  if (raw.collectionFormat !== undefined) result.collectionFormat = raw.collectionFormat;
  if (raw.explode !== undefined) result.explode = raw.explode;
  if (raw.style !== undefined) result.style = raw.style;
  if (raw.allowReserved !== undefined) result.allowReserved = raw.allowReserved;
  if (raw.kind === "endpoint" && raw.serializedName !== undefined) {
    const currentName = result.type.templateArguments?.[0]?.serializedName;
    conflict(
      context,
      "endpoint-serialized-name-conflict",
      location,
      currentName,
      raw.serializedName,
    );
  }
  return result;
}

/**
 * @param {unknown} value
 * @param {boolean} exception
 * @param {string} location
 */
function normalizeStatusCodes(value, exception, location) {
  if (value === "*" && exception) return "*";
  if (Number.isInteger(value)) return value;
  if (value && typeof value === "object" && !Array.isArray(value)) {
    const range = /** @type {Record<string, unknown>} */ (value);
    if (
      Number.isInteger(range.start) &&
      Number.isInteger(range.end) &&
      /** @type {number} */ (range.start) <= /** @type {number} */ (range.end)
    ) {
      return { start: range.start, end: range.end };
    }
  }
  throw unsupported(
    `${location} must be one exact status, one {start,end} range${exception ? ", or *" : ""}`,
  );
}

/**
 * @param {unknown} raw
 * @param {TcgcContext} context
 * @param {string} location
 * @param {boolean} exception
 */
function normalizeHttpResponse(raw, context, location, exception) {
  assertObject(raw, location);
  return {
    statusCodes: normalizeStatusCodes(raw.statusCodes, exception, `${location}.statusCodes`),
    type: raw.type ? normalizeType(raw.type, context, `${location}.type`) : undefined,
    headers: array(raw.headers, `${location}.headers`).map((item, index) =>
      normalizeParameter(item, context, `${location}.headers[${index}]`, index),
    ),
    contentTypes: raw.contentTypes ?? [],
    defaultContentType: raw.defaultContentType,
  };
}

/**
 * @param {unknown} raw
 * @param {TcgcContext} context
 * @param {string} location
 */
function normalizeHttpOperation(raw, context, location) {
  if (raw === undefined) return undefined;
  assertObject(raw, location);
  if (raw.kind !== "http") throw unsupported(`${location}.kind must be http`);
  return {
    kind: "http",
    path: raw.path,
    uriTemplate: raw.uriTemplate,
    verb: raw.verb,
    parameters: array(raw.parameters, `${location}.parameters`).map((item, index) =>
      normalizeParameter(item, context, `${location}.parameters[${index}]`, index),
    ),
    bodyParam: raw.bodyParam
      ? normalizeParameter(raw.bodyParam, context, `${location}.bodyParam`, 0)
      : undefined,
    responses: array(raw.responses, `${location}.responses`).map((item, index) =>
      normalizeHttpResponse(item, context, `${location}.responses[${index}]`, false),
    ),
    exceptions: array(raw.exceptions, `${location}.exceptions`).map((item, index) =>
      normalizeHttpResponse(item, context, `${location}.exceptions[${index}]`, true),
    ),
  };
}

/**
 * @param {unknown} raw
 * @param {TcgcContext} context
 * @param {string} location
 */
function normalizePagingMetadata(raw, context, location) {
  if (raw === undefined) return undefined;
  assertObject(raw, location);
  /** @type {Record<string, unknown>} */
  const result = {};
  for (const field of PAGING_SEGMENT_FIELDS) {
    if (raw[field] !== undefined) {
      result[field] = normalizeSegments(raw[field], `${location}.${field}`);
    }
  }
  if (raw.nextLinkVerb !== undefined) result.nextLinkVerb = raw.nextLinkVerb;
  if (raw.nextLinkOperation !== undefined) {
    result.nextLinkOperation = referenceName(raw.nextLinkOperation) ?? raw.nextLinkOperation.name;
  }
  return result;
}

/**
 * @param {unknown} raw
 * @param {TcgcContext} context
 * @param {string} location
 */
function normalizeLroResult(raw, context, location) {
  if (raw === undefined) return undefined;
  return raw === "void" ? "void" : normalizeType(raw, context, location);
}

/**
 * @param {unknown} raw
 * @param {string} location
 */
function normalizeLroLink(raw, location) {
  assertObject(raw, location);
  if (raw.kind !== "link") throw unsupported(`${location}.kind must be link`);
  return {
    kind: "link",
    location: raw.location,
    property: referenceName(raw.property) ?? raw.property?.name,
  };
}

/**
 * @param {unknown} raw
 * @param {string} location
 */
function normalizeOperationReference(raw, location) {
  assertObject(raw, location);
  if (raw.kind !== "reference") throw unsupported(`${location}.kind must be reference`);
  const operationName = raw.operation
    ? [raw.operation.verb, raw.operation.path ?? raw.operation.name]
        .filter((item) => typeof item === "string")
        .join(" ")
    : undefined;
  return {
    kind: "reference",
    operation: raw.operation ? (referenceName(raw.operation) ?? operationName) : undefined,
    parameterMap: entries(raw.parameterMap)
      .sort(([left], [right]) => String(left).localeCompare(String(right)))
      .map(([name, source]) => ({
        name: String(name),
        source:
          typeof source === "string"
            ? source
            : {
                kind: source?.kind,
                name: source?.name,
                property: normalizedPropertyIdentity(source?.property),
              },
      })),
    parameters: entries(
      /** @type {import("./runtime-types.js").TcgcCollection<TcgcNode>} */ (raw.parameters),
    )
      .sort(([left], [right]) => String(left).localeCompare(String(right)))
      .map(([name, item]) => ({
        name: String(name),
        sourceKind: item.sourceKind,
        source: referenceName(item.source),
        target: referenceName(item.target) ?? item.target?.name,
      })),
    link: raw.link ? normalizeLroLink(raw.link, `${location}.link`) : undefined,
  };
}

/**
 * @param {unknown} raw
 * @param {TcgcContext} context
 * @param {string} location
 */
function normalizeLroStep(raw, context, location) {
  if (raw === undefined) return undefined;
  assertObject(raw, location);
  if (!raw.kind || typeof raw.kind !== "string")
    throw unsupported(`${location} is missing step kind`);
  const responseModel = normalizeLroResult(raw.responseModel, context, `${location}.responseModel`);
  switch (raw.kind) {
    case "nextOperationReference":
    case "finalOperationReference":
      return {
        kind: raw.kind,
        responseModel,
        target: normalizeOperationReference(raw.target, `${location}.target`),
      };
    case "nextOperationLink":
    case "finalOperationLink":
      return {
        kind: raw.kind,
        responseModel,
        target: normalizeLroLink(raw.target, `${location}.target`),
      };
    case "pollingSuccessProperty":
      return {
        kind: raw.kind,
        responseModel,
        target: referenceName(raw.target) ?? raw.target?.name,
        sourceProperty: referenceName(raw.sourceProperty) ?? raw.sourceProperty?.name,
      };
    case "noPollingResult":
      return { kind: raw.kind };
    default:
      throw unsupported(`${location} has unknown LRO step kind ${raw.kind}`);
  }
}

/**
 * @param {unknown} raw
 * @param {TcgcContext} context
 * @param {string} location
 */
function normalizePollingInfo(raw, context, location) {
  assertObject(raw, location);
  if (raw.kind !== "pollingOperationStep") {
    throw unsupported(`${location}.kind must be pollingOperationStep`);
  }
  const termination = raw.terminationStatus;
  assertObject(termination, `${location}.terminationStatus`);
  let terminationStatus;
  if (termination.kind === "status-code") {
    terminationStatus = { kind: "status-code" };
  } else if (termination.kind === "model-property") {
    terminationStatus = {
      kind: "model-property",
      property: referenceName(termination.property) ?? termination.property?.name,
      succeededState: termination.succeededState ?? [],
      failedState: termination.failedState ?? [],
      canceledState: termination.canceledState ?? [],
    };
  } else {
    throw unsupported(`${location}.terminationStatus has unknown kind ${termination.kind}`);
  }
  return {
    kind: raw.kind,
    responseModel: normalizeType(raw.responseModel, context, `${location}.responseModel`),
    terminationStatus,
    resultProperty: referenceName(raw.resultProperty) ?? raw.resultProperty?.name,
    errorProperty: referenceName(raw.errorProperty) ?? raw.errorProperty?.name,
  };
}

/**
 * @param {unknown} raw
 * @param {TcgcContext} context
 * @param {string} location
 */
function normalizeLroMetadata(raw, context, location) {
  if (raw === undefined) return undefined;
  assertObject(raw, location);
  for (const field of [
    "finalStateVia",
    "pollingStep",
    "operation",
    "logicalResult",
    "pollingInfo",
    "envelopeResult",
  ]) {
    if (raw[field] === undefined) throw unsupported(`${location} is missing ${field}`);
  }
  /** @type {Record<string, unknown>} */
  const result = {
    finalStateVia: raw.finalStateVia,
    pollingStep: raw.pollingStep
      ? {
          responseBody: normalizeLroResult(
            raw.pollingStep.responseBody,
            context,
            `${location}.pollingStep.responseBody`,
          ),
        }
      : undefined,
    finalStep: normalizeLroStep(raw.finalStep, context, `${location}.finalStep`),
    statusMonitorStep: normalizeLroStep(
      raw.statusMonitorStep,
      context,
      `${location}.statusMonitorStep`,
    ),
    operation: raw.operation
      ? {
          kind: raw.operation.kind,
          path: raw.operation.path,
          verb: raw.operation.verb,
          uriTemplate: raw.operation.uriTemplate,
        }
      : undefined,
    logicalResult: raw.logicalResult
      ? normalizeType(raw.logicalResult, context, `${location}.logicalResult`)
      : undefined,
    pollingInfo: raw.pollingInfo
      ? normalizePollingInfo(raw.pollingInfo, context, `${location}.pollingInfo`)
      : undefined,
    envelopeResult: raw.envelopeResult
      ? normalizeType(raw.envelopeResult, context, `${location}.envelopeResult`)
      : undefined,
    finalEnvelopeResult: raw.finalEnvelopeResult
      ? normalizeLroResult(raw.finalEnvelopeResult, context, `${location}.finalEnvelopeResult`)
      : undefined,
    finalResult: normalizeLroResult(raw.finalResult, context, `${location}.finalResult`),
    logicalPath: raw.logicalPath,
    finalResultPath: raw.finalResultPath,
  };
  if (raw.finalResponse) {
    const finalResponse = {
      envelopeResult: raw.finalResponse.envelopeResult
        ? normalizeType(
            raw.finalResponse.envelopeResult,
            context,
            `${location}.finalResponse.envelopeResult`,
          )
        : undefined,
      result: raw.finalResponse.result
        ? normalizeType(raw.finalResponse.result, context, `${location}.finalResponse.result`)
        : undefined,
      resultSegments: raw.finalResponse.resultSegments?.map(segmentIdentity),
    };
    result.finalResponse = finalResponse;
    conflict(
      context,
      "lro-final-envelope-conflict",
      location,
      finalResponse.envelopeResult,
      result.finalEnvelopeResult,
    );
  }
  return result;
}

/**
 * @param {unknown} raw
 * @param {{identity: string, name?: string}} client
 * @param {TcgcContext} context
 * @param {number} index
 */
function normalizeMethod(raw, client, context, index) {
  const location = `client:${client.identity}.methods[${index}]`;
  assertObject(raw, location);
  if (typeof raw.kind !== "string" || !METHOD_KINDS.has(raw.kind)) {
    throw unsupported(`${location} has method kind ${raw.kind}`);
  }
  if (!raw.name) throw unsupported(`${location} is missing name`);
  const methodIdentity = identity(raw, `${client.identity}.${raw.name}`);
  const responseType = raw.response?.type
    ? normalizeType(raw.response.type, context, `${location}.response.type`)
    : undefined;
  /** @type {NormalizedTcgcMethod} */
  const result = {
    id: stableId("sdk-method", methodIdentity),
    identity: methodIdentity,
    crossLanguageDefinitionId: raw.crossLanguageDefinitionId,
    client: client.identity,
    clientName: client.name,
    name: raw.name,
    kind: raw.kind,
    access: raw.access,
    parameters: array(raw.parameters, `${location}.parameters`).map((item, parameterIndex) =>
      normalizeParameter(
        item,
        context,
        `${location}.parameters[${parameterIndex}]`,
        parameterIndex,
      ),
    ),
    responseType,
    apiVersions: array(raw.apiVersions, `${location}.apiVersions`),
    generateConvenient: raw.generateConvenient,
    generateProtocol: raw.generateProtocol,
    isOverride: Boolean(raw.isOverride),
    operation: normalizeHttpOperation(raw.operation, context, `${location}.operation`),
    paging: normalizePagingMetadata(raw.pagingMetadata, context, `${location}.pagingMetadata`),
    lro: normalizeLroMetadata(raw.lroMetadata, context, `${location}.lroMetadata`),
  };
  return result;
}

/**
 * @param {unknown} raw
 * @param {{identity: string}} model
 * @param {TcgcContext} context
 * @param {number} index
 */
function normalizeProperty(raw, model, context, index) {
  const location = `model:${model.identity}.properties[${index}]`;
  assertObject(raw, location);
  if (raw.kind !== "property") throw unsupported(`${location}.kind must be property`);
  if (typeof raw.discriminator !== "boolean") {
    throw unsupported(`${location}.discriminator must be a boolean`);
  }
  return {
    name: raw.name,
    serializedName: raw.serializedName,
    type: normalizeType(raw.type, context, `${location}.type`),
    optional: Boolean(raw.optional),
    flatten: Boolean(raw.flatten),
    access: raw.access,
    discriminator: Boolean(raw.discriminator),
    usage: raw.usage,
    visibility: raw.visibility ?? [],
    serialization: normalizeSerialization(raw, context, location),
    crossLanguageDefinitionId: raw.crossLanguageDefinitionId,
  };
}

/**
 * @param {unknown} raw
 * @param {TcgcContext} context
 * @param {number} index
 */
function normalizeModel(raw, context, index) {
  assertObject(raw, `models[${index}]`);
  const modelIdentity = identity(raw, `model:${raw.name ?? index}`);
  /** @type {NormalizedTcgcNamedType} */
  const model = {
    id: stableId("sdk-model", modelIdentity),
    identity: modelIdentity,
    crossLanguageDefinitionId: raw.crossLanguageDefinitionId,
    name: raw.name,
    access: raw.access,
    usage: raw.usage,
    properties: [],
    baseModel: raw.baseModel ? (referenceName(raw.baseModel) ?? raw.baseModel.name) : undefined,
    additionalProperties: raw.additionalProperties
      ? normalizeType(
          raw.additionalProperties,
          context,
          `model:${modelIdentity}.additionalProperties`,
        )
      : undefined,
    discriminatorProperty: raw.discriminatorProperty
      ? (referenceName(raw.discriminatorProperty) ?? raw.discriminatorProperty.name)
      : undefined,
    discriminatorValue: raw.discriminatorValue,
    discriminatedSubtypes: entries(raw.discriminatedSubtypes)
      .sort(([left], [right]) => String(left).localeCompare(String(right)))
      .map(([name, item]) => ({ name: String(name), type: referenceName(item) ?? item?.name })),
    serialization: normalizeSerialization(raw, context, `model:${modelIdentity}`),
  };
  model.properties = array(raw.properties, `model:${modelIdentity}.properties`).map(
    (item, propertyIndex) => normalizeProperty(item, model, context, propertyIndex),
  );
  return model;
}

/**
 * @param {unknown} raw
 * @param {TcgcContext} context
 * @param {number} index
 */
function normalizeEnum(raw, context, index) {
  assertObject(raw, `enums[${index}]`);
  const enumIdentity = identity(raw, `enum:${raw.name ?? index}`);
  return {
    id: stableId("sdk-enum", enumIdentity),
    identity: enumIdentity,
    crossLanguageDefinitionId: raw.crossLanguageDefinitionId,
    name: raw.name,
    access: raw.access,
    usage: raw.usage,
    isFixed: Boolean(raw.isFixed),
    isFlags: Boolean(raw.isFlags),
    isUnionAsEnum: Boolean(raw.isUnionAsEnum),
    valueType: raw.valueType
      ? normalizeType(raw.valueType, context, `enum:${enumIdentity}.valueType`)
      : undefined,
    values: array(raw.values, `enum:${enumIdentity}.values`)
      .map((item, valueIndex) => {
        assertObject(item, `enum:${enumIdentity}.values[${valueIndex}]`);
        return { name: item.name, value: item.value };
      })
      .sort((left, right) =>
        `${canonicalJson(left.value)}:${String(left.name)}`.localeCompare(
          `${canonicalJson(right.value)}:${String(right.name)}`,
        ),
      ),
  };
}

/**
 * @param {unknown} raw
 * @param {TcgcContext} context
 * @param {number} index
 */
function normalizeUnion(raw, context, index) {
  assertObject(raw, `unions[${index}]`);
  const unionIdentity = identity(raw, `union:${raw.name ?? index}`);
  if (raw.kind === "nullable") {
    return {
      id: stableId("sdk-union", unionIdentity),
      identity: unionIdentity,
      crossLanguageDefinitionId: raw.crossLanguageDefinitionId,
      name: raw.name,
      kind: "nullable",
      access: raw.access,
      usage: raw.usage,
      type: normalizeType(raw.type, context, `union:${unionIdentity}.type`),
    };
  }
  if (raw.kind !== "union") throw unsupported(`union:${unionIdentity} has kind ${raw.kind}`);
  return {
    id: stableId("sdk-union", unionIdentity),
    identity: unionIdentity,
    crossLanguageDefinitionId: raw.crossLanguageDefinitionId,
    name: raw.name,
    access: raw.access,
    usage: raw.usage,
    variantTypes: array(raw.variantTypes, `union:${unionIdentity}.variantTypes`).map(
      (item, variantIndex) =>
        normalizeType(item, context, `union:${unionIdentity}.variantTypes[${variantIndex}]`),
    ),
    discriminatedOptions: normalizeDiscriminatedOptions(
      raw.discriminatedOptions,
      context,
      `union:${unionIdentity}`,
    ),
  };
}

/** @param {TcgcNode} root */
function collectNamespaces(root) {
  /** @type {{namespace: TcgcNode, identity: string}[]} */
  const result = [];
  const visited = new WeakSet();
  /**
   * @param {unknown} namespace
   * @param {string} parent
   */
  const visit = (namespace, parent) => {
    if (!namespace || typeof namespace !== "object" || visited.has(namespace)) return;
    visited.add(namespace);
    const item = /** @type {TcgcNode} */ (namespace);
    const namespaceIdentity = identity(
      item,
      item.fullName ?? `${parent ? `${parent}.` : ""}${item.name ?? "namespace"}`,
    );
    result.push({ namespace: item, identity: namespaceIdentity });
    for (const child of array(item.namespaces, `namespace:${namespaceIdentity}.namespaces`)) {
      visit(child, namespaceIdentity);
    }
  };
  for (const namespace of array(root.namespaces, "package.namespaces")) visit(namespace, "");
  return result;
}

/**
 * @param {unknown[]} values
 * @returns {TcgcNode[]}
 */
function uniqueObjects(values) {
  /** @type {TcgcNode[]} */
  const result = [];
  const visited = new WeakSet();
  for (const value of values) {
    if (!value || typeof value !== "object" || visited.has(value)) continue;
    visited.add(value);
    result.push(/** @type {TcgcNode} */ (value));
  }
  return result;
}

/**
 * @param {NormalizedTcgcType | undefined} type
 * @param {Set<string>} result
 */
function collectTypeReferences(type, result) {
  if (!type) return;
  if (["model", "enum", "union", "external", "reference"].includes(type.kind) && type.id)
    result.add(type.id);
  if (type.valueType) collectTypeReferences(type.valueType, result);
  if (type.keyType) collectTypeReferences(type.keyType, result);
  if (type.type) collectTypeReferences(type.type, result);
  for (const item of type.valueTypes ?? []) collectTypeReferences(item, result);
  for (const item of type.variantTypes ?? []) collectTypeReferences(item, result);
  if (Array.isArray(type.discriminatedOptions)) {
    for (const item of /** @type {unknown[]} */ (type.discriminatedOptions)) {
      if (item && typeof item === "object" && !Array.isArray(item)) {
        collectTypeReferences(/** @type {{type?: NormalizedTcgcType}} */ (item).type, result);
      }
    }
  }
}

/** @param {NormalizedTcgcContract} contract */
function markReachable(contract) {
  /** @type {Map<string, import("./runtime-types.js").NormalizedTcgcNamedType>} */
  const named = new Map(
    [...contract.models, ...contract.enums, ...contract.unions].map((item) => [
      item.identity,
      item,
    ]),
  );
  /** @type {Set<string>} */
  const reachable = new Set();
  for (const method of contract.methods.filter((item) => item.access === "public")) {
    for (const parameter of method.parameters) collectTypeReferences(parameter.type, reachable);
    collectTypeReferences(method.responseType, reachable);
  }
  const pending = [...reachable];
  while (pending.length) {
    const identity = pending.pop();
    if (identity === undefined) continue;
    const current = named.get(identity);
    if (!current) continue;
    const before = reachable.size;
    if (current.properties) {
      for (const property of current.properties) collectTypeReferences(property.type, reachable);
      if (current.baseModel) reachable.add(current.baseModel);
      collectTypeReferences(current.additionalProperties, reachable);
    }
    if (current.variantTypes)
      for (const type of current.variantTypes) collectTypeReferences(type, reachable);
    if (current.valueType) collectTypeReferences(current.valueType, reachable);
    if (reachable.size !== before) {
      for (const item of reachable) if (!named.get(item)?.reachable) pending.push(item);
    }
    current.reachable = true;
  }
  for (const item of named.values()) {
    item.reachable = item.reachable || item.access === "public" || reachable.has(item.identity);
  }
}

/**
 * @param {unknown} root
 * @returns {NormalizedTcgcContract}
 */
export function normalizeTcgcPackage(root) {
  assertObject(root, "SdkPackage");
  for (const field of ["crossLanguagePackageId", "crossLanguageVersion", "metadata"]) {
    if (root[field] === undefined) throw unsupported(`SdkPackage is missing ${field}`);
  }
  assertObject(root.metadata, "SdkPackage.metadata");
  /** @type {TcgcContext} */
  const context = { conflicts: [] };
  const currentVersions = root.metadata.apiVersions;
  const deprecatedVersion = root.metadata.apiVersion;
  const normalizedCurrentVersions =
    currentVersions === undefined
      ? undefined
      : Array.isArray(currentVersions)
        ? [...currentVersions]
        : entries(currentVersions)
            .sort(([left], [right]) => String(left).localeCompare(String(right)))
            .map(([service, version]) => ({ service: String(service), version }));
  const deprecatedVersions = deprecatedVersion === undefined ? undefined : [deprecatedVersion];
  const currentVersionValues = normalizedCurrentVersions?.map((item) =>
    typeof item === "string"
      ? item
      : item && typeof item === "object" && !Array.isArray(item)
        ? /** @type {TcgcNode} */ (item).version
        : undefined,
  );
  conflict(
    context,
    "api-version-conflict",
    "metadata",
    currentVersionValues,
    deprecatedVersions && currentVersionValues?.every((item) => item === deprecatedVersion)
      ? currentVersionValues
      : deprecatedVersions,
  );
  const namespaces = collectNamespaces(root);
  const clientObjects = uniqueObjects([
    ...array(root.clients, "package.clients"),
    ...namespaces.flatMap(({ namespace, identity: namespaceIdentity }) =>
      array(namespace.clients, `namespace:${namespaceIdentity}.clients`),
    ),
  ]);
  /** @type {NormalizedTcgcContract["clients"]} */
  const clients = [];
  /** @type {NormalizedTcgcContract["methods"]} */
  const methods = [];
  const clientVisited = new WeakSet();
  /**
   * @param {unknown} raw
   * @param {string | undefined} [owner]
   */
  const visitClient = (raw, owner) => {
    if (!raw || typeof raw !== "object" || clientVisited.has(raw)) return;
    clientVisited.add(raw);
    const item = /** @type {TcgcNode} */ (raw);
    if (item.kind !== "client")
      throw unsupported(`client ${item.name ?? "unknown"} has kind ${item.kind}`);
    const clientIdentity = item.name
      ? `${item.crossLanguageDefinitionId ?? owner ?? "client"}.${item.name}`
      : identity(item, `${owner ? `${owner}.` : ""}client`);
    const client = {
      id: stableId("sdk-client", clientIdentity),
      identity: clientIdentity,
      crossLanguageDefinitionId: item.crossLanguageDefinitionId,
      name: item.name,
      parent: item.parent ? (referenceName(item.parent) ?? item.parent.name) : undefined,
      owner,
      access: item.access,
    };
    clients.push(client);
    for (const [index, method] of array(
      item.methods,
      `client:${clientIdentity}.methods`,
    ).entries()) {
      methods.push(normalizeMethod(method, client, context, index));
    }
    for (const child of array(item.children, `client:${clientIdentity}.children`)) {
      visitClient(child, clientIdentity);
    }
  };
  for (const client of clientObjects) visitClient(client);

  const modelObjects = uniqueObjects([
    ...array(root.models, "package.models"),
    ...namespaces.flatMap(({ namespace, identity: namespaceIdentity }) =>
      array(namespace.models, `namespace:${namespaceIdentity}.models`),
    ),
  ]);
  const enumObjects = uniqueObjects([
    ...array(root.enums, "package.enums"),
    ...namespaces.flatMap(({ namespace, identity: namespaceIdentity }) =>
      array(namespace.enums, `namespace:${namespaceIdentity}.enums`),
    ),
  ]);
  const unionObjects = uniqueObjects([
    ...array(root.unions, "package.unions"),
    ...namespaces.flatMap(({ namespace, identity: namespaceIdentity }) =>
      array(namespace.unions, `namespace:${namespaceIdentity}.unions`),
    ),
  ]);
  /** @type {NormalizedTcgcContract} */
  const contract = {
    schemaVersion: 1,
    package: {
      crossLanguagePackageId: root.crossLanguagePackageId,
      crossLanguageVersion: root.crossLanguageVersion,
      apiVersions: normalizedCurrentVersions ?? deprecatedVersions ?? [],
    },
    clients: clients.sort((left, right) => left.identity.localeCompare(right.identity)),
    methods: methods.sort((left, right) => left.identity.localeCompare(right.identity)),
    models: modelObjects
      .map((item, index) => normalizeModel(item, context, index))
      .sort((left, right) => left.identity.localeCompare(right.identity)),
    enums: enumObjects
      .map((item, index) => normalizeEnum(item, context, index))
      .sort((left, right) => left.identity.localeCompare(right.identity)),
    unions: unionObjects
      .map((item, index) => normalizeUnion(item, context, index))
      .sort((left, right) => left.identity.localeCompare(right.identity)),
    conflicts: context.conflicts.sort((left, right) =>
      `${left.code}:${left.path}`.localeCompare(`${right.code}:${right.path}`),
    ),
  };
  markReachable(contract);
  return contract;
}

/**
 * @param {{workRoot?: string, artifact: TcgcArtifact, maxAliasCount?: number, maxObjects?: number}} options
 * @returns {NormalizedTcgcContract}
 */
export function normalizeTcgcContract({
  workRoot = process.cwd(),
  artifact,
  maxAliasCount,
  maxObjects,
}) {
  if (!artifact || (artifact.format && artifact.format !== "tcgc-yaml")) {
    throw unsupported(`expected format tcgc-yaml, received ${artifact?.format ?? "none"}`);
  }
  const files = (artifact.files ?? [])
    .map((item) => path.resolve(workRoot, item.path))
    .sort((left, right) => left.localeCompare(right));
  if (files.length !== 1) {
    throw unsupported(`expected exactly one tcgc-output.yaml, received ${files.length}`);
  }
  if (!fs.existsSync(files[0])) throw unsupported(`${files[0]} does not exist`);
  const stat = fs.statSync(files[0], { bigint: true });
  const key = [files[0], stat.size, stat.mtimeNs, stat.ctimeNs, maxAliasCount, maxObjects].join(
    "\0",
  );
  const cached = contractCache.get(artifact);
  if (cached?.key === key) return cached.contract;
  const contract = normalizeTcgcPackage(
    parseTcgcYaml(fs.readFileSync(files[0], "utf8"), { maxAliasCount, maxObjects }),
  );
  contractCache.set(artifact, { key, contract });
  return contract;
}

/**
 * @param {NormalizedTcgcContract} contract
 * @param {string} apiVersion
 * @returns {Map<string, Map<string, Set<string>>>}
 */
export function indexTcgcOperations(contract, apiVersion) {
  let versions = operationIndexCache.get(contract);
  if (!versions) {
    versions = new Map();
    operationIndexCache.set(contract, versions);
  }
  const cached = versions.get(apiVersion);
  if (cached) return cached;
  /** @type {Map<string, Set<string>>} */
  const byIdentity = new Map();
  for (const method of contract.methods) {
    const identity = method.crossLanguageDefinitionId;
    if (!identity || (method.apiVersions.length && !method.apiVersions.includes(apiVersion)))
      continue;
    let routes = byIdentity.get(identity);
    if (!routes) byIdentity.set(identity, (routes = new Set()));
    const { verb, path: route } = method.operation ?? {};
    if (verb && route) routes.add(`${verb.toLowerCase()}\0${route}`);
  }
  /** @type {Map<string, Map<string, Set<string>>>} */
  const index = new Map();
  for (const [identity, routes] of byIdentity) {
    // Source indexes use owner.member or top-level names. Share route sets
    // between these exact identities instead of copying the method graph.
    const segments = identity.split(".");
    const names = [identity, segments.slice(-2).join("."), segments.at(-1)].filter(
      (item) => item !== undefined,
    );
    for (const name of new Set(names)) {
      let identities = index.get(name);
      if (!identities) {
        identities = new Map();
        index.set(name, identities);
      }
      identities.set(identity, routes);
    }
  }
  versions.set(apiVersion, index);
  return index;
}

export const normalizeTCGCContract = normalizeTcgcContract;
export const loadTcgcContract = normalizeTcgcContract;
