import path from "node:path";
import {
  NoTarget,
  createTypeSpecLibrary,
  emitFile,
  paramMessage,
} from "@typespec/compiler";
import { getOpenAPI3 } from "@typespec/openapi3";

export const $lib = createTypeSpecLibrary({
  name: "foundry-voice-events",
  diagnostics: {
    "invalid-event-bundle": {
      severity: "error",
      messages: {
        default: paramMessage`Unable to emit voice-agent event schemas: ${"detail"}`,
      },
    },
  },
  emitter: {
    options: {
      type: "object",
      properties: {},
      additionalProperties: false,
    },
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

/** Keep the wire-aware OpenAPI projection without publishing unrelated types. */
export async function $onEmit(context) {
  try {
    const configured =
      context.program.compilerOptions.options?.["@typespec/openapi3"] ?? {};
    const options = Object.fromEntries(
      Object.entries(configured).filter(
        ([key]) =>
          ![
            "file-type",
            "output-file",
            "new-line",
            "emitter-output-dir",
          ].includes(key),
      ),
    );
    const records = await getOpenAPI3(context.program, {
      ...options,
      "omit-unreachable-types": false,
    });
    const documents = records.flatMap((record) =>
      record.versioned ? record.versions : [record],
    );
    const matches = documents.filter(
      (record) => record.document.info.version === "v1",
    );
    if (matches.length !== 1) {
      throw new Error(
        `Expected one v1 Foundry document; found ${matches.length}.`,
      );
    }
    context.program.reportDiagnostics(matches[0].diagnostics);
    if (context.program.hasError()) return;
    await emitFile(context.program, {
      path: path.join(context.emitterOutputDir, "voice-agent-events.json"),
      content: `${JSON.stringify(buildVoiceEventBundle(matches[0].document), null, 2)}\n`,
    });
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
