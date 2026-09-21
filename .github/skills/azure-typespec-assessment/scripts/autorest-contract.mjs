import fs from "node:fs";
import path from "node:path";
import { parse as parseYaml } from "yaml";
import { isRecord, readJsonObject } from "./cli.mjs";
import { canonicalJson, stableId } from "./stable-id.mjs";

/** @typedef {import("./runtime-types.js").AutorestArtifact} AutorestArtifact */
/** @typedef {import("./runtime-types.js").AutorestContext} AutorestContext */
/** @typedef {import("./runtime-types.js").AutorestDocument} AutorestDocument */
/** @typedef {import("./runtime-types.js").NormalizedSchema} NormalizedSchema */
/** @typedef {import("./runtime-types.js").NormalizedAutorestContract} NormalizedAutorestContract */
/** @typedef {import("./runtime-types.js").OpenApiDocument} OpenApiDocument */
/** @typedef {import("./runtime-types.js").OpenApiHeader} OpenApiHeader */
/** @typedef {import("./runtime-types.js").OpenApiOperation} OpenApiOperation */
/** @typedef {import("./runtime-types.js").OpenApiParameter} OpenApiParameter */
/** @typedef {import("./runtime-types.js").OpenApiPathItem} OpenApiPathItem */
/** @typedef {import("./runtime-types.js").OpenApiResponse} OpenApiResponse */
/** @typedef {import("./runtime-types.js").OpenApiSchema} OpenApiSchema */
/**
 * @typedef {{
 *   name: string,
 *   in: string,
 *   required: boolean,
 *   schema?: NormalizedSchema,
 *   reference?: string,
 *   unresolved?: boolean,
 *   collectionFormat?: unknown,
 *   allowEmptyValue?: unknown,
 *   skipUrlEncoding?: unknown
 * }} NormalizedParameter
 */
/**
 * @typedef {{
 *   identity: string,
 *   unresolved: true
 * } | {
 *   identity: string,
 *   unresolved: false,
 *   document: AutorestDocument,
 *   pointer: string,
 *   value: unknown
 * }} ResolvedReference
 */

const HTTP_METHODS = new Set(["get", "put", "post", "patch", "delete", "head", "options", "trace"]);
const SCHEMA_CONSTRAINTS = [
  "default",
  "example",
  "maximum",
  "exclusiveMaximum",
  "minimum",
  "exclusiveMinimum",
  "maxLength",
  "minLength",
  "pattern",
  "maxItems",
  "minItems",
  "uniqueItems",
  "maxProperties",
  "minProperties",
  "multipleOf",
  "readOnly",
];

/** @param {string} value */
function slash(value) {
  return value.replaceAll("\\", "/");
}

/** @param {unknown} value */
function comparableReference(value) {
  if (typeof value !== "string") return value;
  for (const marker of ["#/definitions/", "#/definitions~1"]) {
    const index = value.indexOf(marker);
    if (index >= 0) return value.slice(index);
  }
  return value;
}

/**
 * @param {unknown} value
 * @param {string} [key]
 * @returns {unknown}
 */
function comparableContractValue(value, key) {
  if (Array.isArray(value)) {
    const items = value.map((item) =>
      key === "references" ? comparableReference(item) : comparableContractValue(item),
    );
    return key === "references" ? [...new Set(items)].sort() : items;
  }
  if (!value || typeof value !== "object") {
    return key === "reference" || key === "ref" ? comparableReference(value) : value;
  }
  return Object.fromEntries(
    Object.entries(value).map(([childKey, childValue]) => [
      childKey,
      comparableContractValue(childValue, childKey),
    ]),
  );
}

/**
 * @param {unknown} left
 * @param {unknown} right
 */
export function sameAutorestContract(left, right) {
  return left === undefined || right === undefined
    ? left === right
    : canonicalJson(comparableContractValue(left)) ===
        canonicalJson(comparableContractValue(right));
}

/** @param {string} message */
function unsupported(message) {
  return new Error(`Unsupported AutoRest shape: ${message}`);
}

/**
 * @param {string} root
 * @param {(file: string) => boolean} predicate
 * @returns {string[]}
 */
function walkFiles(root, predicate) {
  if (!root || !fs.existsSync(root)) return [];
  /** @type {string[]} */
  const result = [];
  /** @param {string} directory */
  const visit = (directory) => {
    for (const entry of fs.readdirSync(directory, { withFileTypes: true })) {
      const fullPath = path.join(directory, entry.name);
      if (entry.isDirectory()) visit(fullPath);
      else if (predicate(fullPath)) result.push(fullPath);
    }
  };
  visit(root);
  return result.sort((left, right) => slash(left).localeCompare(slash(right)));
}

/**
 * @param {unknown} value
 * @param {string[]} [result]
 * @returns {string[]}
 */
function yamlJsonPaths(value, result = []) {
  if (typeof value === "string" && value.toLowerCase().endsWith(".json")) result.push(value);
  else if (Array.isArray(value)) {
    for (const item of value) yamlJsonPaths(item, result);
  } else if (value && typeof value === "object") {
    for (const item of Object.values(value)) yamlJsonPaths(item, result);
  }
  return result;
}

/**
 * @param {string} file
 * @param {string | undefined} suppliedRole
 * @returns {string}
 */
function roleFor(file, suppliedRole) {
  if (suppliedRole) return suppliedRole;
  const name = path.basename(file).toLowerCase();
  if (name.includes("common")) return "common";
  return name === "openapi.json" ? "primary" : "feature";
}

/**
 * @param {{workRoot?: string, artifact: AutorestArtifact}} options
 * @returns {AutorestDocument[]}
 */
export function discoverAutorestDocuments({ workRoot = process.cwd(), artifact }) {
  if (!artifact || (artifact.format && artifact.format !== "swagger-2.0")) {
    throw unsupported(`expected format swagger-2.0, received ${artifact?.format ?? "none"}`);
  }
  /** @type {Map<string, {absolutePath: string, documentRole: string}>} */
  const candidates = new Map();
  /**
   * @param {string} file
   * @param {string | undefined} [documentRole]
   */
  const add = (file, documentRole) => {
    const absolute = path.resolve(workRoot, file);
    if (fs.existsSync(absolute) && path.extname(absolute).toLowerCase() === ".json") {
      candidates.set(absolute, {
        absolutePath: absolute,
        documentRole: roleFor(absolute, documentRole),
      });
    }
  };

  for (const item of artifact.files ?? []) add(item.path, item.documentRole);

  if (artifact.serviceManifestPath) {
    const serviceManifest = path.resolve(workRoot, artifact.serviceManifestPath);
    if (fs.existsSync(serviceManifest)) {
      const content = /** @type {unknown} */ (
        parseYaml(fs.readFileSync(serviceManifest, "utf8"), { maxAliasCount: 100 })
      );
      for (const item of yamlJsonPaths(content))
        add(path.resolve(path.dirname(serviceManifest), item));
    }
  }

  if (!candidates.size) {
    const searchRoot = artifact.outputDirectory
      ? path.resolve(workRoot, artifact.outputDirectory)
      : artifact.serviceManifestPath
        ? path.dirname(path.resolve(workRoot, artifact.serviceManifestPath))
        : workRoot;
    for (const file of walkFiles(searchRoot, (item) => item.toLowerCase().endsWith(".json")))
      add(file);
  }

  return [...candidates.values()]
    .sort((left, right) => slash(left.absolutePath).localeCompare(slash(right.absolutePath)))
    .map((item) => {
      /** @type {OpenApiDocument} */
      let document;
      try {
        const value = readJsonObject(item.absolutePath);
        document = /** @type {OpenApiDocument} */ (value);
      } catch (error) {
        const message = error instanceof Error ? error.message : String(error);
        throw unsupported(
          `${slash(path.relative(workRoot, item.absolutePath))} is not valid JSON: ${message}`,
        );
      }
      if (document.swagger !== "2.0") {
        const version = document.openapi ?? document.swagger ?? "missing";
        throw unsupported(
          `${slash(path.relative(workRoot, item.absolutePath))} uses OpenAPI ${version}; Swagger 2.0 is required`,
        );
      }
      return {
        path: slash(path.relative(workRoot, item.absolutePath)),
        absolutePath: item.absolutePath,
        documentRole: item.documentRole,
        document,
      };
    });
}

/** @param {string} value */
function decodePointerPart(value) {
  return decodeURIComponent(value).replaceAll("~1", "/").replaceAll("~0", "~");
}

/**
 * @param {OpenApiDocument} document
 * @param {string} pointer
 * @returns {unknown}
 */
function pointerValue(document, pointer) {
  if (pointer === "" || pointer === "#") return document;
  if (!pointer.startsWith("#/")) return undefined;
  /** @type {unknown} */
  let current = document;
  for (const part of pointer.slice(2).split("/").map(decodePointerPart)) {
    if (!isRecord(current) || !(part in current)) return undefined;
    current = current[part];
  }
  return current;
}

/**
 * @param {AutorestDocument | undefined} targetDocument
 * @param {string} pointer
 * @param {string} rawRef
 * @returns {string}
 */
function referenceIdentity(targetDocument, pointer, rawRef) {
  if (!targetDocument) return rawRef;
  const normalized = slash(targetDocument.path);
  const marker = "/autorest/";
  const index = normalized.lastIndexOf(marker);
  const documentPath =
    index >= 0 ? normalized.slice(index + marker.length) : path.basename(normalized);
  return `${documentPath}${pointer}`;
}

/**
 * @param {string} rawRef
 * @param {string} targetPath
 * @param {string} pointer
 * @returns {string}
 */
function stableExternalReference(rawRef, targetPath, pointer) {
  if (/^[a-z][a-z0-9+.-]*:/i.test(rawRef)) return rawRef;
  const normalized = slash(targetPath);
  for (const marker of ["/specification/", "/common-types/"]) {
    const index = normalized.lastIndexOf(marker);
    if (index >= 0) return `${normalized.slice(index + 1)}${pointer}`;
  }
  return `${slash(rawRef.split("#", 1)[0])}${pointer}`;
}

/**
 * @param {unknown} rawRef
 * @param {AutorestDocument} currentDocument
 * @param {Map<string, AutorestDocument>} registry
 * @returns {ResolvedReference}
 */
function resolveReference(rawRef, currentDocument, registry) {
  if (typeof rawRef !== "string") throw unsupported("$ref must be a string");
  const hash = rawRef.indexOf("#");
  const filePart = hash < 0 ? rawRef : rawRef.slice(0, hash);
  const pointer = hash < 0 ? "#" : rawRef.slice(hash);
  if (/^[a-z][a-z0-9+.-]*:/i.test(filePart)) {
    return { identity: rawRef, unresolved: true };
  }
  const targetPath = filePart
    ? path.resolve(path.dirname(currentDocument.absolutePath), filePart)
    : currentDocument.absolutePath;
  const targetDocument = registry.get(targetPath);
  if (!targetDocument) {
    return {
      identity: stableExternalReference(rawRef, targetPath, pointer),
      unresolved: true,
    };
  }
  const value = pointerValue(targetDocument.document, pointer);
  if (value === undefined) {
    return { identity: referenceIdentity(targetDocument, pointer, rawRef), unresolved: true };
  }
  return {
    identity: referenceIdentity(targetDocument, pointer, rawRef),
    document: targetDocument,
    pointer,
    value,
    unresolved: false,
  };
}

/**
 * @template T
 * @param {T[]} values
 * @returns {T[]}
 */
function scalarSort(values) {
  return [...values].sort((left, right) => canonicalJson(left).localeCompare(canonicalJson(right)));
}

/**
 * @param {unknown} value
 * @returns {value is string | number | boolean}
 */
function isEnumValue(value) {
  return typeof value === "string" || typeof value === "number" || typeof value === "boolean";
}

/**
 * @param {OpenApiSchema} schema
 * @param {AutorestContext} context
 * @param {Set<string>} stack
 * @returns {NormalizedSchema}
 */
function ownSchema(schema, context, stack) {
  /** @type {NormalizedSchema} */
  const result = { kind: "any" };
  const type =
    schema.type ??
    (schema.properties || schema.required ? "object" : schema.enum ? "string" : undefined);
  if (schema.enum) {
    if (!Array.isArray(schema.enum))
      throw unsupported(`enum at ${context.pointer} must be an array`);
    const values = schema.enum.filter(isEnumValue);
    if (values.length !== schema.enum.length) {
      throw unsupported(`enum at ${context.pointer} must contain only scalar values`);
    }
    result.kind = "enum";
    result.type = type;
    result.values = scalarSort(values);
  } else if (type === "array") {
    if (!schema.items) throw unsupported(`array at ${context.pointer} is missing items`);
    result.kind = "array";
    result.items = normalizeSchema(
      schema.items,
      { ...context, pointer: `${context.pointer}/items` },
      stack,
    );
    if (schema.collectionFormat !== undefined) result.collectionFormat = schema.collectionFormat;
  } else if (type === "object" || schema.properties || schema.additionalProperties !== undefined) {
    result.kind = "object";
    const required = new Set(schema.required ?? []);
    result.properties = Object.entries(schema.properties ?? {})
      .sort(([left], [right]) => left.localeCompare(right))
      .map(([name, property]) => ({
        name,
        required: required.has(name),
        schema: normalizeSchema(
          property,
          {
            ...context,
            pointer: `${context.pointer}/properties/${name.replaceAll("~", "~0").replaceAll("/", "~1")}`,
          },
          stack,
        ),
      }));
    if (schema.additionalProperties !== undefined) {
      result.additionalProperties =
        schema.additionalProperties === true
          ? { kind: "any" }
          : schema.additionalProperties === false
            ? false
            : normalizeSchema(
                schema.additionalProperties,
                {
                  ...context,
                  pointer: `${context.pointer}/additionalProperties`,
                },
                stack,
              );
    }
  } else if (type) {
    result.kind = "scalar";
    result.type = type;
    if (schema.format !== undefined) result.format = schema.format;
  } else {
    result.kind = "any";
  }
  if (schema["x-nullable"] !== undefined) result.nullable = Boolean(schema["x-nullable"]);
  if (schema.discriminator !== undefined) {
    if (typeof schema.discriminator !== "string") {
      throw unsupported(`discriminator at ${context.pointer} must be a string`);
    }
    result.discriminator = schema.discriminator;
  }
  if (schema["x-ms-discriminator-value"] !== undefined) {
    result.discriminatorValue = schema["x-ms-discriminator-value"];
  }
  if (schema["x-ms-mutability"] !== undefined) result.mutability = schema["x-ms-mutability"];
  if (schema["x-ms-client-default"] !== undefined) {
    result.clientDefault = schema["x-ms-client-default"];
  }
  if (schema["x-ms-enum"] !== undefined) {
    const enumName = schema["x-ms-enum"].name;
    if (enumName !== undefined && typeof enumName !== "string") {
      throw unsupported(`x-ms-enum name at ${context.pointer} must be a string`);
    }
    result.enumMetadata = {
      name: enumName,
      modelAsString: Boolean(schema["x-ms-enum"].modelAsString),
    };
  }
  for (const field of SCHEMA_CONSTRAINTS) {
    if (schema[field] !== undefined) result[field] = schema[field];
  }
  return result;
}

/**
 * @param {NormalizedSchema[]} parts
 * @param {NormalizedSchema} own
 * @returns {NormalizedSchema}
 */
function mergeAllOf(parts, own) {
  const references = new Set(own.references ?? []);
  for (const part of parts) for (const item of part.references ?? []) references.add(item);
  if ([...parts, own].every((item) => item.kind === "object" || item.kind === "any")) {
    /** @type {Map<string, NonNullable<NormalizedSchema["properties"]>[number]>} */
    const properties = new Map();
    /** @type {boolean | NormalizedSchema | undefined} */
    let additionalProperties;
    for (const item of [...parts, own]) {
      for (const property of item.properties ?? []) properties.set(property.name, property);
      if (item.additionalProperties !== undefined) additionalProperties = item.additionalProperties;
    }
    const result = {
      ...own,
      kind: "object",
      properties: [...properties.values()].sort((left, right) =>
        left.name.localeCompare(right.name),
      ),
    };
    if (additionalProperties !== undefined) result.additionalProperties = additionalProperties;
    if (references.size) result.references = [...references].sort();
    return result;
  }
  const result = { ...own, kind: "intersection", allOf: parts };
  if (references.size) result.references = [...references].sort();
  return result;
}

/**
 * @param {unknown} schema
 * @param {AutorestContext} context
 * @param {Set<string>} [stack]
 * @returns {NormalizedSchema}
 */
export function normalizeSchema(schema, context, stack = new Set()) {
  if (!schema || typeof schema !== "object" || Array.isArray(schema)) {
    throw unsupported(`schema at ${context.pointer} must be an object`);
  }
  const schemaObject = /** @type {OpenApiSchema} */ (schema);
  if (schemaObject.$ref) {
    const resolved = resolveReference(schemaObject.$ref, context.document, context.registry);
    if (resolved.unresolved) return { kind: "reference", ref: resolved.identity, unresolved: true };
    if (stack.has(resolved.identity))
      return { kind: "reference", ref: resolved.identity, cycle: true };
    stack.add(resolved.identity);
    const normalized = normalizeSchema(
      resolved.value,
      {
        ...context,
        document: resolved.document,
        pointer: resolved.pointer,
      },
      stack,
    );
    stack.delete(resolved.identity);
    const sibling = { ...schemaObject };
    delete sibling.$ref;
    const siblingSchema = ownSchema(sibling, context, stack);
    const siblingFields =
      siblingSchema.kind === "any"
        ? Object.fromEntries(Object.entries(siblingSchema).filter(([key]) => key !== "kind"))
        : siblingSchema;
    return {
      ...normalized,
      ...siblingFields,
      reference: resolved.identity,
      references: [...new Set([resolved.identity, ...(normalized.references ?? [])])].sort(),
    };
  }
  const own = ownSchema(schemaObject, context, stack);
  if (!schemaObject.allOf) return own;
  if (!Array.isArray(schemaObject.allOf))
    throw unsupported(`allOf at ${context.pointer} must be an array`);
  const parts = schemaObject.allOf.map((part, index) =>
    normalizeSchema(part, { ...context, pointer: `${context.pointer}/allOf/${index}` }, stack),
  );
  return mergeAllOf(parts, own);
}

/**
 * @param {OpenApiParameter} parameter
 * @param {AutorestContext} context
 * @returns {NormalizedParameter}
 */
function normalizeParameter(parameter, context) {
  let raw = parameter;
  let reference;
  if (parameter?.$ref) {
    const resolved = resolveReference(parameter.$ref, context.document, context.registry);
    reference = resolved.identity;
    if (resolved.unresolved) {
      return {
        name: decodePointerPart(resolved.identity.split("/").at(-1) ?? resolved.identity),
        in: "unresolved",
        required: false,
        reference: resolved.identity,
        unresolved: true,
      };
    }
    if (!isRecord(resolved.value)) {
      throw unsupported(`parameter at ${context.pointer} must resolve to an object`);
    }
    raw = /** @type {OpenApiParameter} */ (resolved.value);
    context = { ...context, document: resolved.document, pointer: resolved.pointer };
  }
  if (!raw || typeof raw !== "object" || !raw.name || !raw.in) {
    throw unsupported(`parameter at ${context.pointer} must have name and in`);
  }
  /** @type {NormalizedParameter} */
  const normalized = {
    name: raw.name,
    in: raw.in,
    required: raw.in === "path" ? true : Boolean(raw.required),
  };
  if (reference) normalized.reference = reference;
  if (raw.in === "body") {
    if (!raw.schema) throw unsupported(`body parameter ${raw.name} is missing schema`);
    normalized.schema = normalizeSchema(raw.schema, {
      ...context,
      pointer: `${context.pointer}/schema`,
    });
  } else {
    normalized.schema = normalizeSchema(
      raw.schema ?? {
        type: raw.type,
        format: raw.format,
        items: raw.items,
        enum: raw.enum,
        default: raw.default,
        allOf: raw.allOf,
        "x-nullable": raw["x-nullable"],
        "x-ms-enum": raw["x-ms-enum"],
      },
      context,
    );
    if (raw.collectionFormat !== undefined) normalized.collectionFormat = raw.collectionFormat;
  }
  if (raw.allowEmptyValue !== undefined) normalized.allowEmptyValue = raw.allowEmptyValue;
  if (raw["x-ms-skip-url-encoding"] !== undefined) {
    normalized.skipUrlEncoding = raw["x-ms-skip-url-encoding"];
  }
  return normalized;
}

/**
 * @param {Record<string, OpenApiHeader> | undefined} headers
 * @param {AutorestContext} context
 */
function normalizeHeaders(headers, context) {
  return Object.entries(headers ?? {})
    .sort(([left], [right]) => left.toLowerCase().localeCompare(right.toLowerCase()))
    .map(([name, header]) => {
      /** @type {{name: string, schema: NormalizedSchema, collectionFormat?: unknown}} */
      const result = {
        name,
        schema: normalizeSchema(
          {
            type: header.type,
            format: header.format,
            items: header.items,
            enum: header.enum,
            default: header.default,
            "x-nullable": header["x-nullable"],
            "x-ms-enum": header["x-ms-enum"],
          },
          { ...context, pointer: `${context.pointer}/${name}` },
        ),
      };
      if (header.collectionFormat !== undefined) result.collectionFormat = header.collectionFormat;
      return result;
    });
}

/**
 * @param {string} status
 * @returns {"normal" | "exception"}
 */
export function responseStatusKind(status) {
  if (status === "default") return "exception";
  if (/^[1-5]XX$/i.test(status)) return status[0] === "2" ? "normal" : "exception";
  if (/^\d{3}$/.test(status)) return status[0] === "2" ? "normal" : "exception";
  throw unsupported(`response status ${status} is not exact, default, or nXX`);
}

/**
 * @param {OpenApiOperation} operation
 * @param {AutorestContext & {route: string, routeSource: string, method: string}} operationContext
 * @param {OpenApiParameter[] | undefined} inheritedParameters
 */
function normalizeOperation(operation, operationContext, inheritedParameters) {
  if (!operation.operationId || typeof operation.operationId !== "string") {
    throw unsupported(`operation at ${operationContext.pointer} is missing operationId`);
  }
  const allParameters = [...(inheritedParameters ?? []), ...(operation.parameters ?? [])];
  const normalizedParameters = allParameters.map((parameter, index) =>
    normalizeParameter(parameter, {
      ...operationContext,
      pointer: `${operationContext.pointer}/parameters/${index}`,
    }),
  );
  /** @type {Map<string, NormalizedParameter>} */
  const overriddenParameters = new Map();
  for (const parameter of normalizedParameters) {
    overriddenParameters.set(`${parameter.in}:${parameter.name}`, parameter);
  }
  const effectiveParameters = [...overriddenParameters.values()];
  const body = effectiveParameters.filter((item) => item.in === "body");
  if (body.length > 1) throw unsupported(`${operation.operationId} has multiple body parameters`);
  const formData = effectiveParameters.filter((item) => item.in === "formData");
  const parameters = effectiveParameters
    .filter((item) => item.in !== "body" && item.in !== "formData")
    .sort((left, right) => `${left.in}:${left.name}`.localeCompare(`${right.in}:${right.name}`));
  let request;
  if (body.length) {
    request = {
      kind: "body",
      name: body[0].name,
      required: body[0].required,
      schema: body[0].schema,
    };
  } else if (formData.length) {
    request = {
      kind: "multipart",
      required: formData.some((item) => item.required),
      members: formData.sort((left, right) => left.name.localeCompare(right.name)),
    };
  }
  const responses = Object.entries(operation.responses ?? {})
    .sort(([left], [right]) => left.localeCompare(right))
    .map(([status, rawResponse]) => {
      let response = rawResponse;
      let responseContext = {
        ...operationContext,
        pointer: `${operationContext.pointer}/responses/${status}`,
      };
      if (rawResponse?.$ref) {
        const resolved = resolveReference(
          rawResponse.$ref,
          operationContext.document,
          operationContext.registry,
        );
        if (resolved.unresolved) {
          return {
            status,
            statusKind: responseStatusKind(status),
            headers: [],
            unresolvedReference: resolved.identity,
          };
        }
        if (!isRecord(resolved.value)) {
          throw unsupported(
            `response ${status} for ${operation.operationId} must resolve to an object`,
          );
        }
        response = /** @type {OpenApiResponse} */ (resolved.value);
        responseContext = {
          ...responseContext,
          document: resolved.document,
          pointer: resolved.pointer,
        };
      }
      if (!response || typeof response !== "object") {
        throw unsupported(`response ${status} for ${operation.operationId} must be an object`);
      }
      /** @type {{
       *   status: string,
       *   statusKind: "normal" | "exception",
       *   headers: ReturnType<typeof normalizeHeaders>,
       *   schema?: NormalizedSchema
       * }} */
      const normalized = {
        status,
        statusKind:
          response["x-ms-error-response"] === true ? "exception" : responseStatusKind(status),
        headers: normalizeHeaders(response.headers, {
          ...responseContext,
          pointer: `${responseContext.pointer}/headers`,
        }),
      };
      if (response.schema) {
        normalized.schema = normalizeSchema(response.schema, {
          ...responseContext,
          pointer: `${responseContext.pointer}/schema`,
        });
      }
      return normalized;
    });
  return {
    operationId: operation.operationId,
    apiVersion: operationContext.document.document.info?.version,
    path: operationContext.route,
    method: operationContext.method,
    routeSource: operationContext.routeSource,
    documentId: operationContext.document.id,
    documentRole: operationContext.document.documentRole,
    pointer: `${operationContext.document.path}${operationContext.pointer}`,
    parameters,
    request,
    responses,
    consumes: operation.consumes ?? operationContext.document.document.consumes ?? [],
    produces: operation.produces ?? operationContext.document.document.produces ?? [],
    paging: operation["x-ms-pageable"] ?? undefined,
    lro: operation["x-ms-long-running-operation"]
      ? {
          enabled: true,
          options: operation["x-ms-long-running-operation-options"] ?? {},
        }
      : undefined,
  };
}

/**
 * @param {unknown[]} entries
 * @returns {NormalizedAutorestContract}
 */
export function normalizeAutorestDocuments(entries) {
  const documents = entries.map((entry, index) => {
    if (!isRecord(entry)) {
      throw unsupported(`document ${index} must be an object`);
    }
    const embedded = isRecord(entry.document) ? entry.document : entry;
    const document = /** @type {OpenApiDocument} */ (embedded);
    const documentPath = slash(
      typeof entry.path === "string" ? entry.path : `document-${index}.json`,
    );
    const absolutePath = path.resolve(
      typeof entry.absolutePath === "string" ? entry.absolutePath : documentPath,
    );
    if (document.swagger !== "2.0") {
      const version = document.openapi ?? document.swagger ?? "an unknown version";
      throw unsupported(`${documentPath} uses OpenAPI ${version}; Swagger 2.0 is required`);
    }
    return {
      path: documentPath,
      absolutePath,
      documentRole:
        typeof entry.documentRole === "string"
          ? entry.documentRole
          : roleFor(documentPath, undefined),
      document,
      id: stableId("autorest-document", {
        path: documentPath,
        apiVersion: document.info?.version,
        role:
          typeof entry.documentRole === "string"
            ? entry.documentRole
            : roleFor(documentPath, undefined),
      }),
    };
  });
  /** @type {Map<string, AutorestDocument>} */
  const registry = new Map(documents.map((item) => [item.absolutePath, item]));
  /** @type {ReturnType<typeof normalizeOperation>[]} */
  const operations = [];
  for (const document of documents.sort((left, right) => left.path.localeCompare(right.path))) {
    if (!document.document.info?.version)
      throw unsupported(`${document.path} is missing info.version`);
    for (const routeSource of /** @type {const} */ (["paths", "x-ms-paths"])) {
      const routes = document.document[routeSource] ?? {};
      for (const [route, pathItem] of Object.entries(routes).sort(([left], [right]) =>
        left.localeCompare(right),
      )) {
        if (!isRecord(pathItem)) throw unsupported(`${routeSource}.${route} must be an object`);
        const typedPathItem = /** @type {OpenApiPathItem} */ (pathItem);
        for (const [method, operation] of Object.entries(pathItem)
          .filter(([name]) => HTTP_METHODS.has(name.toLowerCase()))
          .sort(([left], [right]) => left.localeCompare(right))) {
          if (!isRecord(operation)) {
            throw unsupported(`${routeSource}.${route}.${method} must be an object`);
          }
          operations.push(
            normalizeOperation(
              /** @type {OpenApiOperation} */ (operation),
              {
                document,
                registry,
                route,
                routeSource,
                method: method.toLowerCase(),
                pointer: `#/${routeSource}/${route.replaceAll("~", "~0").replaceAll("/", "~1")}/${method}`,
              },
              typedPathItem.parameters,
            ),
          );
        }
      }
    }
  }
  operations.sort((left, right) =>
    `${left.apiVersion}:${left.operationId}:${left.method}:${left.path}:${left.documentId}`.localeCompare(
      `${right.apiVersion}:${right.operationId}:${right.method}:${right.path}:${right.documentId}`,
    ),
  );
  return {
    schemaVersion: 1,
    documents: documents.map((item) => ({
      path: item.path,
      documentRole: item.documentRole,
      id: item.id,
    })),
    operations,
  };
}

/**
 * @param {{workRoot?: string, artifact: AutorestArtifact}} options
 * @returns {NormalizedAutorestContract}
 */
export function normalizeAutorestContract({ workRoot = process.cwd(), artifact }) {
  return normalizeAutorestDocuments(discoverAutorestDocuments({ workRoot, artifact }));
}

export const normalizeAutoRestContract = normalizeAutorestContract;
export const loadAutorestContract = normalizeAutorestContract;
