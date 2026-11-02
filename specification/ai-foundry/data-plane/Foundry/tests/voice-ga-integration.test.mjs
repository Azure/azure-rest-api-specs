import assert from "node:assert/strict";
import { readFileSync } from "node:fs";
import { test } from "node:test";

const prefix = "#/components/schemas/";
const preview = "VoiceAgents=V1Preview";
const read = (path) =>
  JSON.parse(readFileSync(new URL(path, import.meta.url), "utf8"));

function properties(schemas, name) {
  const schema = schemas[name];
  assert.ok(schema, name);
  return Object.assign(
    {},
    ...(schema.allOf ?? []).map((parent) =>
      properties(schemas, parent.$ref.slice(prefix.length)),
    ),
    schema.properties,
  );
}

for (const version of ["v1", "virtual-public-preview"]) {
  const document = read(
    `../openapi3/${version}/microsoft-foundry-openapi3.json`,
  );
  const schemas = document.components.schemas;

  test(`${version}: core voice surfaces are GA while Live, inline handoff and SIP stay behind the voice preview`, () => {
    const meta = (name) => schemas[name]?.["x-ms-foundry-meta"] ?? {};
    for (const name of [
      "VoiceAgentLiveDefinition",
      "VoiceAgentInlineSubagentConfig",
      "InlineVoiceSubagent",
      "VoiceAgentHandoffPolicy",
      "VoiceAgentHandoffId",
      "VoiceAgentHandoffNodeReference",
      "VoiceAgentHandoffMaxOutputTokenCount",
      "SipTelephonyBinding",
      "SipTelephonyBindingListItem",
      "SipAddress",
    ]) {
      assert.ok(meta(name).required_previews?.includes(preview), name);
    }
    for (const name of [
      "VoiceAgentSubProtocol",
      "VoiceAgentSubagentType",
      "VoiceAgentSubagentConfig",
      "VoiceAgentTransferDestinationType",
      "TelephonyProvider",
      "TelephonyAddressType",
      "VoiceAgentServerEventTypeExtensions",
    ]) {
      assert.ok(meta(name).conditional_previews?.includes(preview), name);
      assert.equal(meta(name).required_previews, undefined, name);
    }
    for (const name of [
      "VoiceAgentBaseDefinition",
      "VoiceAgentDefinition",
      "VoiceAgentVoiceSelectionConfig",
      "VoiceAgentVoiceSynthesisConfig",
      "VoiceAgentDelegateSubagentConfig",
      "VoiceAgentPostCallConfig",
      "TelephonyBinding",
      "TwilioTelephonyBinding",
      "TeamsPhoneExtensibilityTelephonyBinding",
      "TelephonyCallJob",
      "TelephonyCampaign",
      "TelephonyCampaignOperation",
      "VoiceAgentTransferSystemTool",
      "VoiceAgentCollectSmsSystemTool",
      "VoiceAgentCollectDtmfSystemTool",
      "VoiceConversation",
      "GenerateVoiceAgentRequest",
    ]) {
      assert.equal(meta(name).required_previews, undefined, `${name} is GA`);
    }

    const realtime = properties(schemas, "VoiceAgentDefinition");
    const live = properties(schemas, "VoiceAgentLiveDefinition");
    assert.ok(realtime.subagent_config);
    assert.ok(realtime.soundscape, "Retain the release baseline soundscape");
    assert.ok(realtime.post_call, "Retain release baseline post-call delivery");
    assert.ok(live.delegation);
    assert.equal(live.subagent_config, undefined);
    assert.equal(live.soundscape, undefined);
    assert.ok(properties(schemas, "InlineVoiceSubagent").handoff_conditions);
    assert.equal(
      schemas.VoiceAgentBaseDefinition.discriminator.defaultMapping,
      `${prefix}VoiceAgentDefinition`,
    );
    assert.equal(
      schemas.VoiceAgentDefinition.properties.structured_inputs,
      undefined,
      "Shared settings belong on the voice base, not duplicated on Realtime",
    );
  });

  test(`${version}: inline handoff preserves optional delegate selection and bounded overrides`, () => {
    const delegate = schemas.VoiceAgentDelegateSubagentConfig;
    assert.ok(!delegate.required?.includes("subagent_type"));
    const inline = schemas.VoiceAgentInlineSubagentConfig;
    assert.ok(inline.required.includes("subagent_type"));
    assert.equal(inline.properties.subagents.minItems, 2);
    assert.equal(inline.properties.subagents.maxItems, 32);
    const node = properties(schemas, "InlineVoiceSubagent");
    assert.equal(node.handoff_conditions.maxItems, 128);
    assert.equal(node.parallel_tool_calls.default, false);
    assert.equal(node.inherit_base_instructions.default, true);
    const condition = properties(schemas, "VoiceAgentHandoffCondition");
    assert.equal(condition.condition.maxLength, 500);
    assert.equal(condition.delay_ms.minimum, 0);
    assert.equal(condition.delay_ms.maximum, 10000);
    const policy = properties(schemas, "VoiceAgentHandoffPolicy");
    assert.equal(policy.max_transfers.default, 16);
    assert.equal(policy.max_transfers.maximum, 100);
    assert.equal(
      properties(schemas, "VoiceAgentVoiceConfig").speed.default,
      undefined,
      "Omitted inline speed must inherit rather than reset session speed",
    );
    assert.equal(
      properties(schemas, "VoiceAgentAudioOutputConfig").speed.default,
      1,
    );
  });

  test(`${version}: campaign request visibility and SIP examples use the reconciled binding contract`, () => {
    const sip = properties(schemas, "SipTelephonyBinding");
    assert.ok(sip.allowed_calling_numbers);
    assert.equal(sip.status, undefined);
    assert.equal(schemas.CreateSipTelephonyBindingRequest, undefined);
    assert.equal(schemas.CreateTelephonyBindingRequest, undefined);

    for (const name of [
      "CreateSipBinding",
      "GetSipBinding",
      "ListSipBindings",
      "UpdateSipBinding",
      "ClearSipBindingAllowedCallers",
    ]) {
      const example = read(`../examples/v1/AgentTelephony_${name}.json`);
      assert.equal(example.parameters.status, undefined);
      if (name === "CreateSipBinding") {
        assert.equal(example.parameters.binding.provider, "sip");
        assert.equal(example.parameters.body, undefined);
      }
      for (const response of Object.values(example.responses)) {
        for (const binding of response.body.data ?? [response.body]) {
          for (const key of Object.keys(binding)) {
            assert.ok(
              key in sip || key === "etag",
              `${name}: obsolete or unknown binding property ${key}`,
            );
          }
        }
      }
    }
    const operations = Object.entries(document.paths).flatMap(([path, item]) =>
      Object.entries(item)
        .filter(([verb]) => ["get", "post", "put", "delete"].includes(verb))
        .map(([verb, operation]) => ({ path, verb, operation })),
    );
    const live = operations.filter(({ path }) =>
      path.includes("/voice/live/conversations"),
    );
    const campaigns = operations.filter(({ path }) =>
      path.includes("/telephony/campaigns"),
    );
    assert.equal(live.length, 9);
    assert.equal(campaigns.length, 7);
    const header = (operation) =>
      operation.parameters?.find(
        (parameter) => parameter.name === "Foundry-Features",
      );
    for (const { path, verb, operation } of live) {
      assert.ok(
        operation["x-ms-foundry-meta"]?.required_previews?.includes(preview),
        `${verb} ${path}`,
      );
      assert.equal(
        header(operation)?.required,
        true,
        `${verb} ${path}: required opt-in`,
      );
    }
    for (const { path, verb, operation } of campaigns) {
      // Campaigns are GA; only SipOutbound campaign writes need the opt-in, so it is never required.
      assert.equal(
        operation["x-ms-foundry-meta"]?.required_previews,
        undefined,
        `${verb} ${path}`,
      );
      assert.notEqual(
        header(operation)?.required,
        true,
        `${verb} ${path}: optional opt-in`,
      );
      if (verb !== "get") {
        assert.ok(
          operation["x-ms-foundry-meta"]?.conditional_previews?.includes(
            preview,
          ),
          `${verb} ${path}: SIP writes are conditional`,
        );
      }
    }
    const connect =
      document.paths["/agents/{agent_name}/endpoint/protocols/voice"].get;
    assert.equal(
      header(connect),
      undefined,
      "GA voice WebSocket has no opt-in header",
    );
    assert.ok(
      !connect.parameters.some(
        (parameter) => parameter.name === "foundry_features",
      ),
      "GA voice WebSocket drops the foundry_features query alias",
    );
    for (const [path, item] of Object.entries(document.paths)) {
      if (!path.includes("/endpoint/protocols/voice/conversations")) continue;
      for (const [verb, operation] of Object.entries(item)) {
        if (!operation?.responses) continue;
        assert.equal(
          header(operation),
          undefined,
          `${verb} ${path}: GA conversation reads`,
        );
        assert.equal(
          operation["x-ms-foundry-meta"],
          undefined,
          `${verb} ${path}`,
        );
      }
    }
  });
}

test("native Realtime event bundle retains both handoff and private system-tool events", () => {
  const schemas = read("../event-schemas/voice-agent-events.json").components
    .schemas;
  const events = new Set(
    schemas.VoiceAgentServerEvent.oneOf.map(({ $ref }) =>
      $ref.slice(prefix.length),
    ),
  );
  for (const name of [
    "VoiceAgentServerEventSessionHandoffStarted",
    "VoiceAgentServerEventSessionHandoffCompleted",
    "VoiceAgentServerEventSessionHandoffAborted",
    "VoiceAgentServerEventSystemToolArgumentsDelta",
    "VoiceAgentServerEventSystemToolArgumentsDone",
    "VoiceAgentServerEventInputCollectionStatus",
  ]) {
    assert.ok(events.has(name), name);
    assert.ok(schemas[name], name);
  }
  const status = properties(
    schemas,
    "VoiceAgentServerEventInputCollectionStatus",
  );
  assert.ok(status.output_ref);
  assert.equal(status.resolved_arguments, undefined);
  assert.equal(status.secret_value, undefined);
});
