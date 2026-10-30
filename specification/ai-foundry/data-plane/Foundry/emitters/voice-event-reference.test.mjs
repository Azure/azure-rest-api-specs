import assert from "node:assert/strict";
import { test } from "node:test";
import { buildVoiceEventBundle } from "./voice-event-reference.mjs";

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
