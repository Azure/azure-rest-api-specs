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

  test(`${version}: system tools extend the existing Realtime item hierarchy`, () => {
    const item = schemas["OpenAI.RealtimeConversationItem"];
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
      { $ref: `${prefix}OpenAI.RealtimeConversationItem` },
    ]);
    const message = schemas["OpenAI.RealtimeConversationItemMessage"];
    assert.equal(message.discriminator.propertyName, "role");
    assert.deepEqual(Object.keys(message.discriminator.mapping).sort(), [
      "assistant",
      "system",
      "user",
    ]);
    assert.equal(schemas.VoiceConversationItem, undefined);
    assert.equal(schemas.VoiceConversationItemType, undefined);
    assert.equal(schemas.VoiceAgentResponseOutputItem, undefined);
  });

  test(`${version}: REST and events reuse standard items without duplicate projections`, () => {
    for (const [projectionName, originalName] of Object.entries(
      standardItems,
    )) {
      assert.equal(schemas[projectionName], undefined, projectionName);
      assert.equal(eventSchemas[projectionName], undefined, projectionName);
      assert.deepEqual(
        flatten(schemas, schemas[originalName]),
        flatten(eventSchemas, eventSchemas[originalName]),
        originalName,
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
      `${prefix}OpenAI.RealtimeConversationItem`,
    );
  });

  test(`${version}: system configurations retain typed fields and unchanged duration defaults`, () => {
    for (const [name, schemaName] of Object.entries(toolNames)) {
      const schema = schemas[schemaName];
      assert.equal(schema.unevaluatedProperties, undefined, schemaName);
      assert.equal(schema.additionalProperties, undefined, schemaName);
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
        assert.match(properties.timeout_seconds.description, /from 1 to 300/);
        assert.match(
          properties.timeout_seconds.description,
          /If omitted, the service defaults to 60 seconds\./,
        );
      } else {
        assert.equal(properties.timeout_seconds, undefined);
      }
    }
    for (const [name, defaultSeconds] of Object.entries({
      ring_timeout_seconds: 20,
      total_timeout_seconds: 45,
    })) {
      const property = schemas.VoiceAgentTransferRouting.properties[name];
      assert.equal(property.default, defaultSeconds);
      assert.equal(property.minimum, 1);
      assert.equal(property.maximum, 300);
      assert.match(property.description, /from 1 to 300/);
      assert.ok(
        property.description.includes(
          `If omitted, the service defaults to ${defaultSeconds} seconds.`,
        ),
      );
    }
  });

  test(`${version}: transfer destinations require canonical type without legacy aliases`, () => {
    for (const name of [
      "VoiceAgentTransferRouting",
      "VoiceAgentTransferDestination",
      "VoiceAgentTransferTarget",
    ]) {
      assert.equal(schemas[name].unevaluatedProperties, undefined, name);
      assert.equal(schemas[name].additionalProperties, undefined, name);
    }
    assert.deepEqual(schemas.VoiceAgentTransferDestinationType.enum, [
      "phone_number",
      "teams",
      "sip",
    ]);
    const destination = schemas.VoiceAgentTransferDestination;
    assert.deepEqual([...destination.required].sort(), ["type", "value"]);
    assert.equal(destination.properties.kind, undefined);
    assert.equal(destination.anyOf, undefined);
    assert.equal(
      destination.properties.type.$ref,
      `${prefix}VoiceAgentTransferDestinationType`,
    );
  });

  test(`${version}: Agent configuration does not expose private initialization declarations`, () => {
    const { properties } = flatten(schemas, schemas.VoiceAgentDefinition);
    assert.equal(properties.secrets, undefined);
    assert.equal(schemas.VoiceAgentSessionSecret, undefined);
    assert.ok(!JSON.stringify(document).includes("initial_value_from"));
  });
}

test("client item schema shares the Realtime hierarchy without a separate projection", () => {
  const clientSchemas = references(eventSchemas, "VoiceAgentClientEvent");
  assert.ok(clientSchemas.has("OpenAI.RealtimeConversationItem"));
  assert.ok(clientSchemas.has("VoiceAgentSystemToolItem"));
  assert.ok(!clientSchemas.has("VoiceConversationItem"));
  const clientItem =
    eventSchemas["OpenAI.RealtimeClientEventConversationItemCreate"];
  assert.equal(
    clientItem.properties.item.$ref,
    `${prefix}OpenAI.RealtimeConversationItem`,
  );
  const mapping =
    eventSchemas["OpenAI.RealtimeConversationItem"].discriminator.mapping;
  // As with the existing MCP items, schema membership is not service admission.
  // Runtime rejection of client-authored system_tool items needs its own tests.
  assert.deepEqual(Object.keys(mapping).sort(), outputTypes);
});

test("live response outputs use the original Realtime item hierarchy", () => {
  assert.equal(
    eventSchemas.VoiceAgentRealtimeResponse.properties.output.items.$ref,
    `${prefix}OpenAI.RealtimeConversationItem`,
  );
  for (const eventName of [
    "OpenAI.RealtimeServerEventResponseOutputItemAdded",
    "OpenAI.RealtimeServerEventResponseOutputItemDone",
  ]) {
    assert.equal(
      eventSchemas[eventName].properties.item.$ref,
      `${prefix}OpenAI.RealtimeConversationItem`,
    );
  }
  assert.equal(
    eventSchemas["OpenAI.RealtimeConversationItem"].discriminator.mapping
      .system_tool,
    `${prefix}VoiceAgentSystemToolItem`,
  );
});

test("collection feedback retains private output references without Agent declarations", () => {
  const reference = eventSchemas.VoiceAgentOutputReference;
  assert.equal(reference.type, "string");
  assert.equal(reference.pattern, "^[A-Za-z_][A-Za-z0-9_]*$");
  assert.equal(
    eventSchemas.VoiceAgentServerEventInputCollectionStatus.properties
      .output_ref.$ref,
    `${prefix}VoiceAgentOutputReference`,
  );
  assert.equal(eventSchemas.VoiceAgentSessionSecret, undefined);
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
