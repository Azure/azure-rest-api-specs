import assert from "node:assert/strict";
import { readFileSync } from "node:fs";
import { test } from "node:test";

const prefix = "#/components/schemas/";
const toolNames = {
  end_conversation: "VoiceAgentEndConversationSystemTool",
  language_detection: "VoiceAgentLanguageDetectionSystemTool",
  digit_recognition: "VoiceAgentDigitRecognitionSystemTool",
  transfer: "VoiceAgentTransferSystemTool",
  collect_sms: "VoiceAgentCollectSmsSystemTool",
  collect_dtmf: "VoiceAgentCollectDtmfSystemTool",
  send_sms: "VoiceAgentSendSmsSystemTool",
  send_dtmf: "VoiceAgentSendDtmfSystemTool",
};
const outputTypes = [
  "function_call",
  "function_call_output",
  "mcp_approval_request",
  "mcp_approval_response",
  "mcp_call",
  "mcp_list_tools",
  "message",
  "system_tool",
];
const standardItems = {
  VoiceConversationSystemMessageItem:
    "OpenAI.RealtimeConversationItemMessageSystem",
  VoiceConversationUserMessageItem:
    "OpenAI.RealtimeConversationItemMessageUser",
  VoiceConversationAssistantMessageItem:
    "OpenAI.RealtimeConversationItemMessageAssistant",
  VoiceConversationFunctionCallItem:
    "OpenAI.RealtimeConversationItemFunctionCall",
  VoiceConversationFunctionCallOutputItem:
    "OpenAI.RealtimeConversationItemFunctionCallOutput",
  VoiceConversationMcpListToolsItem: "OpenAI.RealtimeMCPListTools",
  VoiceConversationMcpCallItem: "OpenAI.RealtimeMCPToolCall",
  VoiceConversationMcpApprovalRequestItem: "OpenAI.RealtimeMCPApprovalRequest",
  VoiceConversationMcpApprovalResponseItem:
    "OpenAI.RealtimeMCPApprovalResponse",
};

function readDocument(relativePath) {
  return JSON.parse(
    readFileSync(new URL(relativePath, import.meta.url), "utf8"),
  );
}

function resolve(schemas, ref) {
  assert.ok(ref.startsWith(prefix), `Unexpected reference: ${ref}`);
  const schema = schemas[ref.slice(prefix.length)];
  assert.ok(schema, `Missing schema: ${ref}`);
  return schema;
}

function flatten(schemas, schema) {
  const properties = {};
  const required = new Set();
  for (const parent of schema.allOf ?? []) {
    const flat = flatten(schemas, resolve(schemas, parent.$ref));
    Object.assign(properties, flat.properties);
    for (const name of flat.required) required.add(name);
  }
  Object.assign(properties, schema.properties);
  for (const name of schema.required ?? []) required.add(name);
  return { properties, required: [...required].sort() };
}

function references(schemas, name, visited = new Set()) {
  if (visited.has(name)) return visited;
  visited.add(name);
  const schema = schemas[name];
  assert.ok(schema, `Missing schema: ${name}`);
  function walk(value) {
    if (!value || typeof value !== "object") return;
    if (value.$ref?.startsWith(prefix)) {
      references(schemas, value.$ref.slice(prefix.length), visited);
    }
    for (const ref of Object.values(value.discriminator?.mapping ?? {})) {
      references(schemas, ref.slice(prefix.length), visited);
    }
    for (const [key, child] of Object.entries(value)) {
      if (
        !key.startsWith("x-") &&
        !["example", "examples", "default"].includes(key)
      )
        walk(child);
    }
  }
  walk(schema);
  return visited;
}

const events = readDocument("../event-schemas/voice-agent-events.json");
const eventSchemas = events.components.schemas;

for (const version of ["v1", "virtual-public-preview"]) {
  const document = readDocument(
    `../openapi3/${version}/microsoft-foundry-openapi3.json`,
  );
  const schemas = document.components.schemas;

  test(`${version}: output items use a discriminator hierarchy, not a wrapper union`, () => {
    const item = schemas.VoiceConversationItem;
    assert.equal(item.type, "object");
    assert.equal(item.anyOf, undefined);
    assert.equal(item.oneOf, undefined);
    assert.equal(item.discriminator.propertyName, "type");
    assert.deepEqual(
      Object.keys(item.discriminator.mapping).sort(),
      outputTypes,
    );
    assert.equal(
      item.discriminator.mapping.system_tool,
      `${prefix}VoiceAgentSystemToolItem`,
    );
    assert.deepEqual(schemas.VoiceAgentSystemToolItem.allOf, [
      { $ref: `${prefix}VoiceConversationItem` },
    ]);
    const message = schemas.VoiceConversationMessageItem;
    assert.equal(message.discriminator.propertyName, "role");
    assert.deepEqual(Object.keys(message.discriminator.mapping).sort(), [
      "assistant",
      "system",
      "user",
    ]);
    assert.equal(schemas.VoiceAgentResponseOutputItem, undefined);
  });

  test(`${version}: output projections preserve every standard item field and requirement`, () => {
    for (const [outputName, originalName] of Object.entries(standardItems)) {
      // The REST emitter omits upstream item types no longer reachable from a
      // route; the event bundle still contains them for client-created items.
      assert.deepEqual(
        flatten(schemas, schemas[outputName]),
        flatten(eventSchemas, eventSchemas[originalName]),
        outputName,
      );
    }
  });

  test(`${version}: system intent retains optional read-only persistence metadata`, () => {
    const { properties, required } = flatten(
      schemas,
      schemas.VoiceAgentSystemToolItem,
    );
    assert.deepEqual(required, [
      "arguments",
      "call_id",
      "name",
      "status",
      "type",
    ]);
    assert.equal(properties.arguments.type, "string");
    assert.deepEqual(properties.type.enum, ["system_tool"]);
    for (const name of ["created_at", "response_id"]) {
      assert.equal(properties[name].readOnly, true);
      assert.ok(!required.includes(name));
    }
    for (const name of [
      "value",
      "resolved_arguments",
      "output",
      "parameter_bindings",
    ]) {
      assert.equal(properties[name], undefined);
    }
    assert.equal(
      schemas.VoiceResponse.properties.output.items.$ref,
      `${prefix}VoiceConversationItem`,
    );
  });

  test(`${version}: system configurations remain closed with unchanged duration defaults`, () => {
    for (const [name, schemaName] of Object.entries(toolNames)) {
      const schema = schemas[schemaName];
      assert.deepEqual(schema.unevaluatedProperties, { not: {} }, schemaName);
      const { properties } = flatten(schemas, schema);
      assert.deepEqual(properties.name.enum, [name]);
      assert.equal(properties.description.type, "string");
      assert.equal(properties.response_scheduling, undefined);
      for (const invocationOnly of [
        "secret",
        "output_variable_name",
        "digits",
        "message",
        "completion_mode",
      ]) {
        assert.equal(
          properties[invocationOnly],
          undefined,
          `${schemaName}.${invocationOnly}`,
        );
      }
      if (name.startsWith("collect_") || name.startsWith("send_")) {
        assert.equal(properties.timeout_seconds.default, 60);
        assert.equal(properties.timeout_seconds.minimum, 1);
        assert.equal(properties.timeout_seconds.maximum, 300);
      } else {
        assert.equal(properties.timeout_seconds, undefined);
      }
    }
  });

  test(`${version}: private initialization accepts only the documented top-level reference grammar`, () => {
    const property =
      schemas.VoiceAgentSessionSecret.properties.initial_value_from;
    const pattern = new RegExp(property.pattern);
    for (const value of ["structured_inputs.code", "structured_inputs._code2"])
      assert.ok(pattern.test(value));
    for (const value of [
      "$.structured_inputs.code",
      "/structured_inputs/code",
      "structured_inputs.a.b",
      "structured_inputs[0]",
      "structured_inputs.*",
      "structured_inputs.0",
      "code",
    ]) {
      assert.ok(!pattern.test(value), value);
    }
    assert.match(property.description, /not JSONPath/);
    assert.match(property.description, /JSON Pointer/);
    assert.match(property.description, /rejected with 400/);
  });
}

test("client-created items do not acquire the service-owned output hierarchy", () => {
  const clientSchemas = references(eventSchemas, "VoiceAgentClientEvent");
  assert.ok(clientSchemas.has("OpenAI.RealtimeConversationItem"));
  for (const name of ["VoiceConversationItem", "VoiceAgentSystemToolItem"])
    assert.ok(!clientSchemas.has(name), name);
  const clientItem =
    eventSchemas["OpenAI.RealtimeClientEventConversationItemCreate"];
  assert.equal(
    clientItem.properties.item.$ref,
    `${prefix}OpenAI.RealtimeConversationItem`,
  );
  const mapping =
    eventSchemas["OpenAI.RealtimeConversationItem"].discriminator.mapping;
  assert.deepEqual(
    Object.keys(mapping).sort(),
    outputTypes.filter((name) => name !== "system_tool"),
  );
});

test("live response outputs share the typed output hierarchy", () => {
  assert.equal(
    eventSchemas.VoiceAgentRealtimeResponse.properties.output.items.$ref,
    `${prefix}VoiceConversationItem`,
  );
  for (const eventName of [
    "OpenAI.RealtimeServerEventResponseOutputItemAdded",
    "OpenAI.RealtimeServerEventResponseOutputItemDone",
  ]) {
    assert.equal(
      eventSchemas[eventName].properties.item.$ref,
      `${prefix}VoiceConversationItem`,
    );
  }
  assert.equal(
    eventSchemas.VoiceConversationItem.discriminator.mapping.system_tool,
    `${prefix}VoiceAgentSystemToolItem`,
  );
});

test("new server events retain their exact wire discriminators", () => {
  for (const [schemaName, type] of Object.entries({
    VoiceAgentServerEventSystemToolArgumentsDelta:
      "response.system_tool_arguments.delta",
    VoiceAgentServerEventSystemToolArgumentsDone:
      "response.system_tool_arguments.done",
    VoiceAgentServerEventInputCollectionStatus: "input_collection.status",
  })) {
    assert.deepEqual(eventSchemas[schemaName].properties.type.enum, [type]);
  }
});
