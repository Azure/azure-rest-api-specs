import assert from "node:assert/strict";
import { existsSync, readFileSync } from "node:fs";
import { dirname, resolve } from "node:path";
import { fileURLToPath } from "node:url";
import { test } from "node:test";

const project = resolve(dirname(fileURLToPath(import.meta.url)), "..");
const prefix = "#/components/schemas/";
const annotations = new Set([
  "example",
  "examples",
  "default",
  "const",
  "enum",
]);
const schemaMaps = new Set([
  "properties",
  "patternProperties",
  "$defs",
  "definitions",
  "dependentSchemas",
]);

function references(value, result = new Set()) {
  if (!value || typeof value !== "object") return result;
  if (typeof value.$ref === "string") result.add(value.$ref);
  for (const reference of Object.values(value.discriminator?.mapping ?? {}))
    result.add(reference);
  for (const [key, child] of Object.entries(value)) {
    if (schemaMaps.has(key) && child && typeof child === "object") {
      for (const schema of Object.values(child)) references(schema, result);
    } else if (!annotations.has(key) && !key.startsWith("x-")) {
      references(child, result);
    }
  }
  return result;
}

function resolveSchema(schemas, reference) {
  assert(
    reference.startsWith(prefix),
    `External schema reference: ${reference}`,
  );
  const name = reference.slice(prefix.length);
  assert(schemas[name], `Missing schema: ${name}`);
  return schemas[name];
}

test("event reference checks distinguish property schemas from example payloads", () => {
  const expected = `${prefix}Nested`;
  const value = {
    properties: {
      example: { $ref: expected },
      "x-property": { $ref: expected },
    },
    examples: [{ $ref: "application-data" }],
    default: { $ref: "application-data" },
  };
  assert.deepEqual([...references(value)], [expected]);
});

test("voice events use only the native OpenAPI emitter", () => {
  const config = readFileSync(resolve(project, "tspconfig.yaml"), "utf8");
  assert.match(config, /omit-unreachable-types:\s*false/);
  assert.doesNotMatch(config, /voice-event-reference|foundry-voice-events/);
  for (const path of [
    "emitters/voice-event-reference.mjs",
    "event-schemas/voice-agent-events.json",
  ])
    assert.equal(existsSync(resolve(project, path)), false, path);
});

for (const version of ["v1", "virtual-public-preview"]) {
  const document = JSON.parse(
    readFileSync(
      resolve(project, `openapi3/${version}/microsoft-foundry-openapi3.json`),
      "utf8",
    ),
  );
  const schemas = document.components.schemas;

  test(`${version}: native OpenAPI contains nonempty client and server event unions`, () => {
    const roots = Object.entries(schemas).filter(
      ([, schema]) => schema["x-foundry-event-direction"],
    );
    assert.deepEqual(
      roots.map(([name, schema]) => [
        name,
        schema["x-foundry-event-direction"],
      ]),
      [
        ["VoiceAgentClientEvent", "client"],
        ["VoiceAgentServerEvent", "server"],
      ],
    );
    for (const [, root] of roots) {
      assert(root.oneOf.length > 0);
      const variants = root.oneOf.map(({ $ref }) => $ref);
      assert.equal(new Set(variants).size, variants.length);
      for (const reference of variants) {
        const event = resolveSchema(schemas, reference);
        assert(event.required.includes("type"));
        assert.equal(event.properties.type.enum.length, 1);
      }
    }
  });

  test(`${version}: all event dependencies and discriminator targets resolve`, () => {
    const pending = ["VoiceAgentClientEvent", "VoiceAgentServerEvent"];
    const seen = new Set();
    while (pending.length) {
      const name = pending.pop();
      if (seen.has(name)) continue;
      seen.add(name);
      for (const reference of references(schemas[name])) {
        resolveSchema(schemas, reference);
        pending.push(reference.slice(prefix.length));
      }
    }
    assert(seen.has("OpenAI.RealtimeClientEventInputAudioBufferAppend"));
    assert(seen.has("OpenAI.RealtimeServerEventResponseAudioDelta"));
    assert(seen.has("FoundryDurationMilliseconds"));
  });

  test(`${version}: event audio and timing keep their wire encodings`, () => {
    const audio =
      schemas["OpenAI.RealtimeClientEventInputAudioBufferAppend"].properties
        .audio;
    assert.equal(audio.type, "string");
    assert.match(audio.description, /Base64-encoded audio bytes/);
    assert.equal(
      schemas["OpenAI.RealtimeServerEventResponseAudioDelta"].properties.delta
        .contentEncoding,
      "base64",
    );
    assert.equal(schemas.FoundryDurationMilliseconds.type, "integer");
    assert.equal(schemas.FoundryDurationMilliseconds.format, "int32");
    for (const property of ["audio_offset_ms", "audio_duration_ms"]) {
      assert.equal(
        schemas.VoiceAgentServerEventResponseAudioTimestampDelta.properties[
          property
        ].$ref,
        `${prefix}FoundryDurationMilliseconds`,
      );
    }
  });
}
