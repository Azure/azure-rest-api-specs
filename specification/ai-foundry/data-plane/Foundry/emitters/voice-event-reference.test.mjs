import assert from "node:assert/strict";
import { mkdtemp, readFile, readdir, rm } from "node:fs/promises";
import { tmpdir } from "node:os";
import { join } from "node:path";
import { test } from "node:test";
import { fileURLToPath } from "node:url";
import {
  NodeHost,
  compile,
  formatDiagnostic,
  resolveCompilerOptions,
} from "@typespec/compiler";
import { parse } from "yaml";
import {
  $onEmit,
  buildCombinedReference,
  buildVoiceEventBundle,
  serializeReferenceDocument,
} from "./voice-event-reference.mjs";

function document() {
  return {
    openapi: "3.2.0",
    info: { title: "Microsoft Foundry", version: "v1" },
    components: {
      schemas: {
        Client: {
          "x-foundry-event-direction": "client",
          oneOf: [{ $ref: "#/components/schemas/Append" }],
        },
        Server: {
          "x-foundry-event-direction": "server",
          oneOf: [{ $ref: "#/components/schemas/Delta" }],
        },
        Append: {
          properties: {
            type: { enum: ["input_audio_buffer.append"] },
            audio: { type: "string", contentEncoding: "base64" },
          },
        },
        Delta: {
          properties: {
            type: { enum: ["response.output_audio.delta"] },
            offset_ms: { $ref: "#/components/schemas/Duration" },
          },
        },
        Duration: { type: "integer", format: "int32" },
        Unrelated: { type: "object" },
      },
    },
  };
}

test("exports only the event roots and their transitive dependencies", () => {
  const result = buildVoiceEventBundle(document());
  assert.deepEqual(Object.keys(result.components.schemas), [
    "Append",
    "Client",
    "Delta",
    "Duration",
    "Server",
  ]);
  assert.deepEqual(result.paths, {});
  assert.equal(result.components.schemas.Duration.type, "integer");
  assert.equal(
    result.components.schemas.Append.properties.audio.contentEncoding,
    "base64",
  );
});

test("combines REST metadata and event dependencies without unrelated schemas", () => {
  const events = document();
  const rest = {
    openapi: events.openapi,
    info: events.info,
    paths: {
      "/voice": { get: { responses: { 101: { description: "Upgrade" } } } },
    },
    servers: [{ url: "https://example.com" }],
    tags: [{ name: "Voice" }],
    security: [{ apiKey: [] }],
    components: {
      schemas: {
        Duration: { format: "int32", type: "integer" },
        RestOnly: { type: "string" },
      },
      securitySchemes: {
        apiKey: { type: "apiKey", in: "header", name: "api-key" },
      },
      parameters: {
        Agent: { name: "agent", in: "query", schema: { type: "string" } },
      },
    },
  };
  const original = structuredClone(rest);
  const result = buildCombinedReference(rest, events);
  assert.deepEqual(rest, original);
  assert.equal(
    result.components.schemas.Duration,
    rest.components.schemas.Duration,
  );
  for (const key of ["paths", "servers", "tags", "security"]) {
    assert.deepEqual(result[key], rest[key]);
  }
  assert.deepEqual(
    result.components.securitySchemes,
    rest.components.securitySchemes,
  );
  assert.deepEqual(result.components.parameters, rest.components.parameters);
  assert.deepEqual(Object.keys(result.components.schemas), [
    "Append",
    "Client",
    "Delta",
    "Duration",
    "RestOnly",
    "Server",
  ]);
});

test("serializes matching JSON and YAML using standard OpenAPI ordering", () => {
  const source = {
    ...document(),
    paths: { "/z": {}, "/a": {} },
  };
  source.components.parameters = { Zebra: { name: "z" }, Alpha: { name: "a" } };
  const original = structuredClone(source);
  const json = serializeReferenceDocument(source, "json");
  const yaml = serializeReferenceDocument(source, "yaml");
  assert.deepEqual(parse(yaml), JSON.parse(json));
  assert.deepEqual(Object.keys(JSON.parse(json).paths), ["/a", "/z"]);
  assert.deepEqual(Object.keys(JSON.parse(json).components.parameters), [
    "Alpha",
    "Zebra",
  ]);
  assert.ok(json.endsWith("\n"));
  assert.ok(yaml.endsWith("\n"));
  assert.deepEqual(source, original);
  assert.throws(
    () => serializeReferenceDocument(source, "xml"),
    /Unsupported reference format/,
  );
});

test("rejects conflicting schemas and mismatched API projections", () => {
  const events = document();
  const rest = {
    openapi: events.openapi,
    info: events.info,
    paths: {},
    components: { schemas: { Duration: { type: "string" } } },
  };
  assert.throws(
    () => buildCombinedReference(rest, events),
    /Conflicting REST and event schema: Duration/,
  );
  assert.throws(
    () =>
      buildCombinedReference(
        { ...rest, info: { ...rest.info, version: "other" } },
        events,
      ),
    /same API version/,
  );
});

test("includes discriminator mapping dependencies and handles cycles", () => {
  const source = document();
  source.components.schemas.Duration = {
    discriminator: { mapping: { nested: "#/components/schemas/Nested" } },
  };
  source.components.schemas.Nested = { $ref: "#/components/schemas/Duration" };
  assert.ok(buildVoiceEventBundle(source).components.schemas.Nested);
});

test("does not interpret example payloads as schema references", () => {
  const source = document();
  source.components.schemas.Append.examples = [{ $ref: "application-data" }];
  assert.ok(buildVoiceEventBundle(source).components.schemas.Append);
});

test("rejects missing or external dependencies", () => {
  for (const reference of [
    "#/components/schemas/Missing",
    "https://example.com/schema",
  ]) {
    const source = document();
    source.components.schemas.Delta.$ref = reference;
    assert.throws(
      () => buildVoiceEventBundle(source),
      /Missing referenced|self-contained/,
    );
  }
});

test("rejects missing, empty, duplicate, or unknown direction roots", () => {
  const source = document();
  delete source.components.schemas.Server;
  assert.throws(() => buildVoiceEventBundle(source), /server event union/);
  source.components.schemas.Server = {
    "x-foundry-event-direction": "server",
    oneOf: [],
  };
  assert.throws(() => buildVoiceEventBundle(source), /server event union/);
  source.components.schemas.Server.oneOf.push({
    $ref: "#/components/schemas/Delta",
  });
  source.components.schemas.OtherServer = {
    ...source.components.schemas.Server,
  };
  assert.throws(() => buildVoiceEventBundle(source), /server event union/);

  delete source.components.schemas.OtherServer;
  source.components.schemas.Unknown = {
    "x-foundry-event-direction": "unknown",
    oneOf: [{ $ref: "#/components/schemas/Append" }],
  };
  assert.throws(
    () => buildVoiceEventBundle(source),
    /Only client and server event roots/,
  );
});

test("compiles both API projections and formats while preserving standard REST output", async (context) => {
  const outputDir = await mkdtemp(join(tmpdir(), "foundry-reference-"));
  context.after(() => rm(outputDir, { recursive: true, force: true }));
  const projectDir = fileURLToPath(new URL("../", import.meta.url));
  const entrypoint = join(projectDir, "main.tsp");
  const emitterPath = fileURLToPath(
    new URL("./voice-event-reference.mjs", import.meta.url),
  );
  const referenceOptions = {
    "output-file":
      "openapi3/{version}/microsoft-foundry-openapi3.{file-type}",
    "file-type": ["yaml", "json"],
    "omit-unreachable-types": true,
    "openapi-versions": ["3.1.0", "3.2.0"],
  };
  const [options, diagnostics] = await resolveCompilerOptions(NodeHost, {
    entrypoint,
    cwd: projectDir,
    overrides: {
      emit: [emitterPath, "@typespec/openapi3"],
      options: {
        "foundry-voice-events": {
          ...referenceOptions,
          "emitter-output-dir": join(outputDir, "combined"),
        },
        "@typespec/openapi3": {
          ...referenceOptions,
          "emitter-output-dir": join(outputDir, "rest"),
        },
      },
    },
  });
  assert.deepEqual(diagnostics, []);
  const program = await compile(NodeHost, entrypoint, options);
  assert.equal(
    program.hasError(),
    false,
    program.diagnostics.map(formatDiagnostic).join("\n"),
  );

  for (const openapiVersion of referenceOptions["openapi-versions"]) {
    for (const version of ["v1", "virtual-public-preview"]) {
      const relativePath = join(openapiVersion, "openapi3", version);
      const documents = {};
      for (const fileType of referenceOptions["file-type"]) {
        const filename = `microsoft-foundry-openapi3.${fileType}`;
        const combinedText = await readFile(
          join(outputDir, "combined", relativePath, filename),
          "utf8",
        );
        const restText = await readFile(
          join(outputDir, "rest", relativePath, filename),
          "utf8",
        );
        const combined = parse(combinedText);
        const rest = parse(restText);
        assert.equal(combined.openapi, openapiVersion);
        assert.equal(combined.info.version, version);
        documents[fileType] = combined;
        if (version === "virtual-public-preview") {
          assert.equal(combinedText, restText);
        } else {
          const eventSchemas = buildVoiceEventBundle(combined).components.schemas;
          const addedSchemas = Object.keys(combined.components.schemas).filter(
            (name) => !Object.hasOwn(rest.components.schemas, name),
          );
          assert.ok(addedSchemas.length > 0);
          for (const name of addedSchemas) {
            assert.ok(Object.hasOwn(eventSchemas, name), name);
          }
          for (const [name, schema] of Object.entries(rest.components.schemas)) {
            assert.deepEqual(combined.components.schemas[name], schema, name);
          }
          assert.deepEqual(
            {
              ...combined,
              components: {
                ...combined.components,
                schemas: rest.components.schemas,
              },
            },
            rest,
          );
        }
      }
      assert.deepEqual(documents.json, documents.yaml);
    }
  }

  await context.test("dry runs invoke validation without writing files", async () => {
    const dryRunDir = join(outputDir, "dry-run");
    let emitterCalls = 0;
    const host = {
      ...NodeHost,
      async getJsImport(path) {
        const imported = await NodeHost.getJsImport(path);
        if (path !== emitterPath.replaceAll("\\", "/")) return imported;
        return {
          ...imported,
          async $onEmit(context) {
            emitterCalls++;
            await $onEmit(context);
          },
        };
      },
      async writeFile(path) {
        assert.fail(`Dry run attempted to write ${path}`);
      },
    };
    const dryRun = await compile(host, entrypoint, {
      ...options,
      emit: [emitterPath],
      dryRun: true,
      options: {
        "foundry-voice-events": {
          ...referenceOptions,
          "emitter-output-dir": dryRunDir,
        },
      },
    });
    assert.equal(
      dryRun.hasError(),
      false,
      dryRun.diagnostics.map(formatDiagnostic).join("\n"),
    );
    assert.equal(emitterCalls, 1);
    await assert.rejects(readdir(dryRunDir), { code: "ENOENT" });
  });
});
