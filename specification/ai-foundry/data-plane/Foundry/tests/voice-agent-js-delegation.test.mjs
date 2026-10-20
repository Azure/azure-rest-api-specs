import assert from "node:assert/strict";
import { resolve } from "node:path";
import { pathToFileURL } from "node:url";
import { test } from "node:test";

// Run against compiled emitter output, not handwritten serializer replacements:
// FOUNDRY_JS_SDK_MODELS=/path/to/dist/models/models.js node --test <this file>
// Set FOUNDRY_JS_PRESERVE_NAMES=1 for the repository's snake_case SDK option.
const generatedModels = process.env.FOUNDRY_JS_SDK_MODELS;
const preserveNames = process.env.FOUNDRY_JS_PRESERVE_NAMES === "1";
const field = (camel, wire) => (preserveNames ? wire : camel);
const json = (value) => JSON.parse(JSON.stringify(value));

test(
  "generated Live delegation serializers preserve the wire contract",
  {
    skip: generatedModels
      ? false
      : "Set FOUNDRY_JS_SDK_MODELS to compiled SDK output.",
  },
  async (t) => {
    const sdk = await import(pathToFileURL(resolve(generatedModels)).href);
    assert.equal(typeof sdk.voiceAgentLiveDefinitionSerializer, "function");
    assert.equal(typeof sdk.voiceAgentLiveDefinitionDeserializer, "function");

    const parameters = {
      type: "object",
      properties: { studentName: { type: "string" } },
      required: ["studentName"],
      additionalProperties: false,
    };
    const tool = {
      type: "function",
      name: "lookup_student",
      parameters,
      strict: true,
    };
    const cases = [
      ["client", { type: "client" }, { type: "client" }],
      [
        "managed with version",
        {
          type: "foundry_managed_agent",
          [field("agentName", "agent_name")]: "english-teacher",
          [field("agentVersion", "agent_version")]: "2",
        },
        {
          type: "foundry_managed_agent",
          agent_name: "english-teacher",
          agent_version: "2",
        },
      ],
      [
        "managed without version",
        {
          type: "foundry_managed_agent",
          [field("agentName", "agent_name")]: "english-teacher",
        },
        { type: "foundry_managed_agent", agent_name: "english-teacher" },
      ],
      [
        "Responses",
        {
          type: "responses",
          responses: {
            model: "gpt-5.6-terra",
            instructions: "Teach English.",
            [field("maxOutputTokens", "max_output_tokens")]: 512,
            [field("serviceTier", "service_tier")]: "auto",
            [field("parallelToolCalls", "parallel_tool_calls")]: false,
            reasoning: { effort: "low" },
            tools: [tool],
            [field("toolChoice", "tool_choice")]: {
              type: "function",
              name: "lookup_student",
            },
          },
        },
        {
          type: "responses",
          responses: {
            model: "gpt-5.6-terra",
            instructions: "Teach English.",
            max_output_tokens: 512,
            service_tier: "auto",
            parallel_tool_calls: false,
            reasoning: { effort: "low" },
            tools: [tool],
            tool_choice: { type: "function", name: "lookup_student" },
          },
        },
      ],
      [
        "Responses nullable settings",
        {
          type: "responses",
          responses: {
            model: "gpt-5.6-terra",
            instructions: null,
            [field("maxOutputTokens", "max_output_tokens")]: null,
            [field("parallelToolCalls", "parallel_tool_calls")]: null,
          },
        },
        {
          type: "responses",
          responses: {
            model: "gpt-5.6-terra",
            instructions: null,
            max_output_tokens: null,
            parallel_tool_calls: null,
          },
        },
      ],
    ];

    const definition = {
      kind: "voice",
      [field("subProtocol", "sub_protocol")]: "live",
      [field("modelType", "model_type")]: "self_deployed",
      model: "gpt-live-1",
    };
    const wireDefinition = {
      kind: "voice",
      sub_protocol: "live",
      model_type: "self_deployed",
      model: "gpt-live-1",
    };
    for (const [name, delegation, wireDelegation] of cases) {
      await t.test(name, () => {
        const input = { ...definition, delegation };
        const original = structuredClone(input);
        const wire = { ...wireDefinition, delegation: wireDelegation };
        assert.deepEqual(
          json(sdk.voiceAgentLiveDefinitionSerializer(input)),
          wire,
        );
        assert.deepEqual(
          json(sdk.voiceAgentLiveDefinitionDeserializer(wire)),
          input,
        );
        assert.deepEqual(
          input,
          original,
          "Serialization must not mutate the caller's object.",
        );
      });
    }

    await t.test("omitted delegation stays omitted", () => {
      assert.deepEqual(
        json(sdk.voiceAgentLiveDefinitionSerializer(definition)),
        wireDefinition,
      );
      assert.deepEqual(
        json(sdk.voiceAgentLiveDefinitionDeserializer(wireDefinition)),
        definition,
      );
    });
  },
);
