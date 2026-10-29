import assert from "node:assert/strict";
import { test } from "node:test";
import { parse } from "yaml";
import {
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
