import { isDeepStrictEqual } from "node:util";
import {
  NoTarget,
  createTypeSpecLibrary,
  emitFile,
  getNamespaceFullName,
  interpolatePath,
  paramMessage,
  sanitizePathSegment,
} from "@typespec/compiler";
import {
  $lib as openAPILibrary,
  getOpenAPI3,
  resolveOptions,
} from "@typespec/openapi3";
import { stringify } from "yaml";

export const $lib = createTypeSpecLibrary({
  name: "foundry-voice-events",
  diagnostics: {
    "invalid-event-bundle": {
      severity: "error",
      messages: {
        default: paramMessage`Unable to emit Foundry reference: ${"detail"}`,
      },
    },
  },
  emitter: {
    options: openAPILibrary.emitter.options,
  },
});

const REFERENCE_PREFIX = "#/components/schemas/";
const ANNOTATIONS = new Set([
  "example",
  "examples",
  "default",
  "const",
  "enum",
]);
const SCHEMA_MAPS = new Set([
  "properties",
  "patternProperties",
  "$defs",
  "definitions",
  "dependentSchemas",
]);

function collectReferences(value, references = new Set()) {
  if (!value || typeof value !== "object") return references;
  if (typeof value.$ref === "string") references.add(value.$ref);
  for (const reference of Object.values(value.discriminator?.mapping ?? {})) {
    if (typeof reference === "string") references.add(reference);
  }
  for (const [key, child] of Object.entries(value)) {
    if (SCHEMA_MAPS.has(key) && child && typeof child === "object") {
      for (const schema of Object.values(child))
        collectReferences(schema, references);
    } else if (!ANNOTATIONS.has(key) && !key.startsWith("x-")) {
      collectReferences(child, references);
    }
  }
  return references;
}

export function buildVoiceEventBundle(document) {
  const schemas = document.components?.schemas;
  if (!schemas || typeof schemas !== "object") {
    throw new Error("The Foundry document has no component schemas.");
  }
  const roots = Object.entries(schemas).filter(
    ([, schema]) => schema?.["x-foundry-event-direction"] !== undefined,
  );
  for (const direction of ["client", "server"]) {
    const matches = roots.filter(
      ([, schema]) => schema["x-foundry-event-direction"] === direction,
    );
    if (matches.length !== 1 || !matches[0][1].oneOf?.length) {
      throw new Error(`Expected one nonempty ${direction} event union.`);
    }
  }
  if (roots.length !== 2) {
    throw new Error("Only client and server event roots are supported.");
  }

  const selected = new Map();
  const pending = roots.map(([name]) => name);
  while (pending.length > 0) {
    const name = pending.pop();
    if (selected.has(name)) continue;
    if (!Object.hasOwn(schemas, name)) {
      throw new Error(`Missing referenced event schema: ${name}`);
    }
    const schema = schemas[name];
    selected.set(name, schema);
    for (const reference of collectReferences(schema)) {
      if (!reference.startsWith(REFERENCE_PREFIX)) {
        throw new Error(`Event schemas must be self-contained: ${reference}`);
      }
      const token = reference.slice(REFERENCE_PREFIX.length).split("/")[0];
      pending.push(
        decodeURIComponent(token).replace(/~1/g, "/").replace(/~0/g, "~"),
      );
    }
  }

  return {
    openapi: document.openapi,
    info: document.info,
    paths: {},
    components: {
      schemas: Object.fromEntries(
        [...selected.entries()].sort(([left], [right]) =>
          left.localeCompare(right),
        ),
      ),
    },
  };
}

export function buildCombinedReference(document, eventDocument) {
  if (
    document.openapi !== eventDocument.openapi ||
    !isDeepStrictEqual(document.info, eventDocument.info)
  ) {
    throw new Error(
      "REST and event projections must describe the same API version.",
    );
  }
  const eventSchemas = buildVoiceEventBundle(eventDocument).components.schemas;
  const schemas = { ...document.components?.schemas };
  for (const [name, schema] of Object.entries(eventSchemas)) {
    if (Object.hasOwn(schemas, name)) {
      if (!isDeepStrictEqual(schemas[name], schema)) {
        throw new Error(`Conflicting REST and event schema: ${name}`);
      }
    } else {
      schemas[name] = schema;
    }
  }
  return {
    ...document,
    components: {
      ...document.components,
      schemas: sortObjectByKeys(schemas),
    },
  };
}

function sortObjectByKeys(value) {
  return Object.fromEntries(
    Object.keys(value)
      .sort()
      .map((key) => [key, value[key]]),
  );
}

export function serializeReferenceDocument(document, fileType) {
  const sorted = {
    ...document,
    paths: sortObjectByKeys(document.paths),
    ...(document.components && {
      components: {
        ...document.components,
        ...(document.components.schemas && {
          schemas: sortObjectByKeys(document.components.schemas),
        }),
        ...(document.components.parameters && {
          parameters: sortObjectByKeys(document.components.parameters),
        }),
      },
    }),
  };
  switch (fileType) {
    case "json":
      return `${JSON.stringify(sorted, null, 2)}\n`;
    case "yaml":
      return stringify(sorted, {
        singleQuote: true,
        aliasDuplicateObjects: false,
        lineWidth: 0,
        compat: "yaml-1.1",
      });
    default:
      throw new Error(`Unsupported reference format: ${fileType}`);
  }
}

export async function $onEmit(context) {
  try {
    const options = resolveOptions(context);
    const records = await getOpenAPI3(context.program, context.options);
    const eventRecords = await getOpenAPI3(context.program, {
      ...context.options,
      "omit-unreachable-types": false,
    });
    const eventDocuments = eventRecords.flatMap((record) =>
      record.versioned ? record.versions : [record],
    );
    const matches = eventDocuments.filter(
      ({ document }) => document.info.version === "v1",
    );
    if (matches.length !== options.openapiVersions.length) {
      throw new Error(
        `Expected one v1 Foundry document per OpenAPI version; found ${matches.length}.`,
      );
    }
    const files = [];
    for (const serviceRecord of records) {
      const documents = serviceRecord.versioned
        ? serviceRecord.versions
        : [serviceRecord];
      for (const record of documents) {
        context.program.reportDiagnostics(record.diagnostics);
        let document = record.document;
        if (document.info.version === "v1") {
          const events = matches.filter(
            ({ document: candidate }) => candidate.openapi === document.openapi,
          );
          if (events.length !== 1) {
            throw new Error(
              `Expected one matching event projection for OpenAPI ${document.openapi}.`,
            );
          }
          context.program.reportDiagnostics(events[0].diagnostics);
          document = buildCombinedReference(document, events[0].document);
        }
        for (const fileType of options.fileTypes) {
          files.push({
            path: interpolatePath(options.outputFile, {
              "openapi-version": document.openapi,
              "service-name-if-multiple":
                records.length > options.openapiVersions.length
                  ? sanitizePathSegment(
                      getNamespaceFullName(serviceRecord.service.type),
                    )
                  : undefined,
              "service-name": sanitizePathSegment(
                getNamespaceFullName(serviceRecord.service.type),
              ),
              "file-type": fileType,
              version: serviceRecord.versioned
                ? sanitizePathSegment(record.version)
                : undefined,
            }),
            content: serializeReferenceDocument(document, fileType),
            newLine: options.newLine,
          });
        }
      }
    }
    if (context.program.compilerOptions.dryRun || context.program.hasError())
      return;
    for (const file of files) await emitFile(context.program, file);
  } catch (error) {
    $lib.reportDiagnostic(context.program, {
      code: "invalid-event-bundle",
      format: {
        detail: error instanceof Error ? error.message : String(error),
      },
      target: NoTarget,
    });
  }
}
