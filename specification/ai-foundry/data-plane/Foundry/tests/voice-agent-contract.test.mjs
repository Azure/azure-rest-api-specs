import assert from "node:assert/strict";
import { mkdtemp, readFile, rm, symlink, writeFile } from "node:fs/promises";
import { tmpdir } from "node:os";
import { dirname, join, resolve } from "node:path";
import { after, before, test } from "node:test";
import { fileURLToPath } from "node:url";
import {
  compile,
  getDiscriminator,
  getMaxItems,
  getMaxLength,
  getMaxValue,
  getMinLength,
  getMinValue,
  getPattern,
  getTypeName,
  NodeHost,
  resolveCompilerOptions,
} from "@typespec/compiler";
import { createSdkContext } from "@azure-tools/typespec-client-generator-core";

const project = resolve(dirname(fileURLToPath(import.meta.url)), "..");
const repo = resolve(project, "../../../..");
let output;
let program;
let native;
let compilerOptions;
const documents = [];
const managedStages = ["started", "progress", "completed", "failed", "cancel"];
const managedModel = (stage) =>
  `Azure.AI.Projects.VoiceAgentLiveManagedDelegation${stage[0].toUpperCase()}${stage.slice(1)}Event`;

function type(name, context = program) {
  const [value, diagnostics] = context.resolveTypeReference(name);
  assert.equal(diagnostics.length, 0, JSON.stringify(diagnostics));
  assert.ok(value, name);
  return value;
}

function fields(model) {
  return new Map([
    ...(model.baseModel ? fields(model.baseModel) : []),
    ...model.properties,
  ]);
}

function checkErrors(diagnostics) {
  assert.deepEqual(
    diagnostics
      .filter((d) => d.severity === "error")
      .map((d) => `${d.code}: ${d.message}`),
    [],
  );
}

function wireShape(model, context) {
  return {
    base: model.baseModel && getTypeName(model.baseModel),
    discriminator: getDiscriminator(context, model),
    children: model.derivedModels.map((child) => getTypeName(child)).sort(),
    properties: [...model.properties].map(([name, p]) => ({
      name,
      optional: p.optional,
      type: getTypeName(p.type),
      default: p.defaultValue?.value?.toString(),
      pattern: getPattern(context, p),
      minLength: getMinLength(context, p),
      maxLength: getMaxLength(context, p),
      min: getMinValue(context, p),
      max: getMaxValue(context, p),
      maxItems: getMaxItems(context, p),
    })),
  };
}

before(async () => {
  output = await mkdtemp(join(tmpdir(), "foundry-voice-contract-"));
  const entrypoint = join(project, "main.tsp");
  const [options, diagnostics] = await resolveCompilerOptions(NodeHost, {
    entrypoint,
    cwd: project,
  });
  checkErrors(diagnostics);
  compilerOptions = options;
  await symlink(
    join(repo, "node_modules"),
    join(output, "node_modules"),
    "dir",
  );
  options.options["@typespec/openapi3"]["emitter-output-dir"] = output;
  program = await compile(NodeHost, entrypoint, options);
  checkErrors(program.diagnostics);
  for (const version of ["v1", "virtual-public-preview"]) {
    documents.push(
      JSON.parse(
        await readFile(
          join(output, "openapi3", version, "microsoft-foundry-openapi3.json"),
          "utf8",
        ),
      ),
    );
  }

  // Compile the published package in isolation as a native wire-contract oracle.
  // Absolute imports allow the temporary probe to resolve the repo's pinned packages.
  const nativeRoot = join(
    repo,
    "node_modules/@azure-tools/openai-typespec/src",
  );
  const nativeEntry = join(output, "native.tsp");
  await writeFile(
    nativeEntry,
    [
      `import ${JSON.stringify(join(nativeRoot, "live/models.tsp"))};`,
      `import ${JSON.stringify(join(nativeRoot, "webhooks/models.tsp"))};`,
      `import ${JSON.stringify(join(repo, "node_modules/@azure-tools/typespec-azure-core/lib/experimental/lib.tsp"))};`,
      // Foundry already maps integer/numeric to int64/float64 for every OpenAI API.
      // Apply that same existing scalar convention on both sides of this comparison.
      `import ${JSON.stringify(join(project, "src/common/custom-types.tsp"))};`,
    ].join("\n"),
  );
  native = await compile(NodeHost, nativeEntry, { noEmit: true });
  checkErrors(native.diagnostics);
});

after(async () => {
  if (output) await rm(output, { recursive: true, force: true });
});

test("voice definitions retain kind -> sub_protocol with separate audio ownership", () => {
  const base = type("Azure.AI.Projects.VoiceAgentDefinition");
  const live = type("Azure.AI.Projects.LiveVoiceAgentDefinition");
  const realtime = type("Azure.AI.Projects.RealtimeVoiceAgentDefinition");
  assert.equal(getDiscriminator(program, base).propertyName, "sub_protocol");
  assert.equal(getDiscriminator(program, base.baseModel).propertyName, "kind");
  assert.equal(live.baseModel, base);
  assert.equal(realtime.baseModel, base);
  assert.equal(base.properties.has("audio"), false);
  assert.equal(live.properties.get("sub_protocol").type.type.value, "live");
  assert.equal(
    realtime.properties.get("sub_protocol").type.type.value,
    "realtime",
  );
  assert.equal(
    realtime.properties.get("audio").type,
    type("Azure.AI.Projects.VoiceAgentAudioConfig"),
  );
  assert.ok(realtime.properties.has("tool_choice"));
  assert.ok(realtime.properties.has("subagent_config"));
});

test("Live configuration references native model identities, not local copies", () => {
  const live = type("Azure.AI.Projects.LiveVoiceAgentDefinition");
  assert.equal(
    live.properties.get("audio").type,
    type("OpenAI.LiveInitialSessionAudioParam"),
  );
  assert.equal(
    live.properties.get("client").type,
    type("OpenAI.LiveClientConfigParam"),
  );
  assert.equal(
    live.properties.get("input").type.indexer.value,
    type("OpenAI.LiveInitialItem"),
  );
  assert.equal(getMaxItems(program, live.properties.get("input")), 128);
  const delegation = type("Azure.AI.Projects.VoiceAgentLiveDelegation");
  assert.equal(
    delegation.variants.get("client").type,
    type("OpenAI.LiveClientDelegationParam"),
  );
  assert.equal(
    delegation.variants.get("responses").type,
    type("OpenAI.LiveResponsesDelegationParam"),
  );
  assert.deepEqual(
    [...delegation.variants.keys()],
    ["client", "responses", "foundry_managed_agent"],
  );
});

test("managed prompt-agent configuration matches Vienna's canonical contract", () => {
  const config = type("Azure.AI.Projects.VoiceAgentLiveManagedAgentDelegation");
  const p = config.properties;
  assert.deepEqual(
    [...p.keys()],
    ["type", "agent_name", "agent_version", "result_format"],
  );
  assert.equal(p.get("type").type.value, "foundry_managed_agent");
  assert.equal(p.get("agent_name").optional, false);
  assert.equal(p.get("agent_version").optional, true);
  assert.equal(p.get("result_format").type.value, "tagged_text");
  assert.equal(p.get("result_format").defaultValue.value, "tagged_text");
  const name = new RegExp(getPattern(program, p.get("agent_name")));
  const version = new RegExp(getPattern(program, p.get("agent_version")));
  for (const value of ["teacher", "english_teacher-1", "a".repeat(63)])
    assert.ok(name.test(value));
  for (const value of [
    "",
    "_teacher",
    "https://other/agent",
    "../teacher",
    "a".repeat(64),
  ])
    assert.ok(!name.test(value));
  for (const value of ["1", "123", "1".repeat(20)])
    assert.ok(version.test(value));
  for (const value of ["0", "01", "-1", "latest", "1.2", "1".repeat(21)])
    assert.ok(!version.test(value));
});

test("Foundry delegation stays on the definition and inference reuses the native roots", () => {
  const nativeDelegation = type(
    "OpenAI.LiveSessionCreateParams",
  ).properties.get("delegation").type;
  const choices = [...nativeDelegation.variants.values()].map((v) =>
    getTypeName(v.type),
  );
  assert.ok(choices.includes("OpenAI.LiveClientDelegationParam"));
  assert.ok(choices.includes("OpenAI.LiveResponsesDelegationParam"));
  assert.ok(choices.includes("null"));
  assert.equal(
    choices.some((name) => name.includes("Managed")),
    false,
  );
  assert.equal(
    type("Azure.AI.Projects.VoiceAgentLiveClientEvent"),
    type("OpenAI.LiveClientEvent"),
  );
  assert.equal(
    type("Azure.AI.Projects.VoiceAgentLiveServerEvent"),
    type("OpenAI.LiveServerEvent"),
  );
});

test("native Live models change only through the explicitly allowed Foundry extensions", () => {
  const ns = type("OpenAI", native);
  let checked = 0;
  for (const [name, model] of ns.models) {
    if (!name.startsWith("Live")) continue;
    const actual = wireShape(type(`OpenAI.${name}`), program);
    if (name === "LiveServerEvent") {
      const extensions = actual.children.filter((child) =>
        child.startsWith("Azure.AI.Projects."),
      );
      assert.deepEqual(extensions, managedStages.map(managedModel).sort());
      actual.children = actual.children.filter(
        (child) => !extensions.includes(child),
      );
    }
    if (name === "LiveServerEventLiveSessionStarted") {
      const correlation = actual.properties.filter(
        (p) => p.name === "conversation_id",
      );
      assert.equal(correlation.length, 1);
      assert.equal(correlation[0].optional, true);
      assert.equal(correlation[0].type, "string");
      actual.properties = actual.properties.filter(
        (p) => p.name !== "conversation_id",
      );
    }
    assert.deepEqual(actual, wireShape(model, native), name);
    if (
      model.baseModel?.name === "LiveClientEvent" ||
      model.baseModel?.name === "LiveServerEvent"
    ) {
      assert.equal(fields(type(`OpenAI.${name}`)).has("sub_protocol"), false);
    }
    checked++;
  }
  assert.ok(
    checked >= 150,
    `Expected the full native catalog, checked ${checked}`,
  );
});

test("only the native server discriminator gains the five Foundry lifecycle literals", () => {
  const ns = type("OpenAI", native);
  for (const [name, union] of ns.unions) {
    if (!name.startsWith("Live") && name !== "DelegationType") continue;
    const variants = (value) =>
      [...value.variants.values()].map((v) => getTypeName(v.type));
    const expected = variants(union);
    if (name === "LiveServerEventType") {
      expected.push(
        ...managedStages.map((stage) =>
          JSON.stringify(`session.managed_delegation.${stage}`),
        ),
      );
    }
    assert.deepEqual(variants(type(`OpenAI.${name}`)), expected, name);
  }
});

test("session.started exposes optional Foundry correlation without replacing the native session ID", () => {
  const started = type("OpenAI.LiveServerEventLiveSessionStarted");
  assert.equal(started.properties.get("conversation_id").optional, true);
  assert.equal(
    started.properties.get("session").type,
    type("OpenAI.LiveSessionResourceParam"),
  );
  assert.equal(
    type("OpenAI.LiveSessionResourceParam").properties.has("conversation_id"),
    false,
  );
  assert.equal(
    type("OpenAI.LiveSessionStarted").properties.has("conversation_id"),
    false,
  );
  assert.equal(
    type("OpenAI.LiveSidebandServerEventLiveSessionStarted").properties.has(
      "conversation_id",
    ),
    false,
  );
});

test("managed notifications keep correlation and expose flat optional result text", () => {
  assert.ok(
    type(
      "Azure.AI.Projects.VoiceAgentLiveFoundryManagedAgentDelegationMetadata",
    ),
  );
  for (const stage of managedStages) {
    const model = type(managedModel(stage));
    assert.equal(model.baseModel, type("OpenAI.LiveServerEvent"));
    const p = fields(model);
    assert.equal(
      p.get("type").type.value,
      `session.managed_delegation.${stage}`,
    );
    for (const field of [
      "event_id",
      "delegation_id",
      "agent_name",
      "agent_version",
      "result_format",
      "response_id",
      "offset_ms",
    ])
      assert.equal(p.get(field).optional, false, `${stage}.${field}`);
    for (const field of [
      "sub_protocol",
      "request",
      "stream",
      "backend_store",
      "spoken_text",
      "background_context",
      "output_items",
      "appends",
      "has_spoken_text",
      "has_background_context",
      "mcp_call_count",
      "failure_context_status",
    ])
      assert.equal(p.has(field), false, `${stage}.${field}`);
    for (const field of ["error_code", "error_message"]) {
      assert.equal(p.has(field), stage === "failed", `${stage}.${field}`);
      if (stage === "failed") {
        assert.equal(p.get(field).optional, false);
        assert.equal(getTypeName(p.get(field).type), "string");
      }
    }
    assert.equal(p.has("backend_conversation_id"), stage === "completed");
    for (const field of ["commentary", "thinking"]) {
      assert.equal(p.has(field), stage !== "started", `${stage}.${field}`);
      if (stage !== "started") {
        assert.equal(p.get(field).optional, true);
        assert.equal(getTypeName(p.get(field).type), "string");
      }
    }
  }
});

test("delegation results contain only optional commentary and thinking strings", () => {
  const result = type("Azure.AI.Projects.VoiceAgentLiveDelegationResultItem");
  assert.deepEqual([...result.properties.keys()], ["commentary", "thinking"]);
  for (const property of result.properties.values()) {
    assert.equal(property.optional, true);
    assert.equal(getTypeName(property.type), "string");
  }
  const ns = type("Azure.AI.Projects");
  for (const name of [
    "VoiceAgentLiveManagedAppend",
    "VoiceAgentLiveManagedOutput",
    "VoiceAgentLiveManagedGuidance",
    "VoiceAgentLiveManagedOutputs",
    "VoiceAgentLiveManagedDelegationMetadata",
  ])
    assert.ok(!ns.models.has(name), name);
  // Flattening removes the event-type selector too; there is no unused renamed enum.
  for (const name of [
    "VoiceAgentLiveManagedAppendType",
    "VoiceAgentLiveDelegationResultEventType",
    "VoiceAgentLiveFailureContextStatus",
  ])
    assert.ok(!ns.unions.has(name), name);
});

// Target-contract examples. Vienna runtime alignment is a separate follow-up;
// these payloads are not captures from an already-updated service.
const metadata = {
  event_id: "evt_managed_1",
  delegation_id: "del_1",
  agent_name: "english-teacher",
  agent_version: "1",
  result_format: "tagged_text",
  response_id: null,
  offset_ms: 1200,
};
const resultText = { commentary: "Say: Yesterday I went to school." };
const samples = managedStages.map((stage) => {
  const payload = { ...metadata, type: `session.managed_delegation.${stage}` };
  if (["progress", "completed"].includes(stage))
    Object.assign(payload, {
      response_id: "resp_1",
      ...resultText,
    });
  if (stage === "completed") payload.backend_conversation_id = "conv_backend";
  if (stage === "failed")
    Object.assign(payload, {
      error_code: "partial_backend_timeout",
      error_message: "The backend timed out after some guidance was accepted.",
      ...resultText,
    });
  if (stage === "cancel") Object.assign(payload, resultText);
  return { model: managedModel(stage), payload };
});
const sessionStarted = {
  type: "session.started",
  event_id: "evt_started",
  session: {
    id: "live_1",
    model: "gpt-live-1",
    status: "active",
    expires_at: 1800000000,
    store: false,
  },
};
samples.push({
  model: "OpenAI.LiveServerEventLiveSessionStarted",
  payload: sessionStarted,
});

function tspValue(value, stored = false, key = "") {
  // @example takes TypeSpec values, not wire-encoded JSON scalars.
  if (stored && typeof value === "number") {
    if (["created_at", "completed_at"].includes(key))
      return `Azure.AI.Projects.FoundryTimestamp.fromISO(${JSON.stringify(new Date(value * 1000).toISOString())})`;
    if (["start_offset_ms", "duration_ms"].includes(key))
      return `Azure.AI.Projects.FoundryDurationMilliseconds.fromISO("PT${value / 1000}S")`;
  }
  if (Array.isArray(value))
    return `#[${value.map((item) => tspValue(item, stored)).join(",")}]`;
  if (value !== null && typeof value === "object") {
    return `#{${Object.entries(value)
      .map(([key, item]) => {
        assert.match(key, /^[a-zA-Z_][a-zA-Z_0-9]*$/);
        return `\`${key}\`: ${tspValue(item, stored, key)}`;
      })
      .join(",")}}`;
  }
  return JSON.stringify(value);
}

function exampleValue({ model, payload }) {
  return tspValue(
    payload,
    model.startsWith("Azure.AI.Projects.VoiceAgentLive") &&
      model.includes("Conversation"),
  );
}

async function validateExamples(name, examples) {
  const path = join(output, `${name}.tsp`);
  await writeFile(
    path,
    [
      `import ${JSON.stringify(join(project, "main.tsp"))};`,
      ...examples.map(
        (sample) => `@@example(${sample.model}, ${exampleValue(sample)});`,
      ),
    ].join("\n"),
  );
  return compile(NodeHost, path, { ...compilerOptions, noEmit: true });
}

test("lifecycle contract examples including cancel and native startup validate", async () => {
  const result = await validateExamples("valid-events", samples);
  checkErrors(result.diagnostics);
});

test("malformed lifecycle payloads are rejected by the actual TypeSpec models", async () => {
  const missingDelegationId = structuredClone(
    samples.find((s) => s.payload.type.endsWith(".cancel")),
  );
  delete missingDelegationId.payload.delegation_id;
  const invalidOffset = structuredClone(samples[0]);
  invalidOffset.payload.offset_ms = "one";
  const invalidResult = structuredClone(
    samples.find((s) => s.payload.type.endsWith(".progress")),
  );
  invalidResult.payload.commentary = { content: "Not a plain string" };
  const invalidFailure = structuredClone(
    samples.find((s) => s.payload.type.endsWith(".failed")),
  );
  invalidFailure.payload.error_code = 42;
  const result = await validateExamples("invalid-events", [
    missingDelegationId,
    invalidOffset,
    invalidResult,
    invalidFailure,
  ]);
  const errors = result.diagnostics.filter((d) => d.severity === "error");
  assert.ok(
    errors.length >= 4,
    errors.map((d) => `${d.code}: ${d.message}`).join("\n"),
  );
  assert.ok(
    errors.every((d) =>
      ["invalid-argument", "unassignable", "missing-property"].includes(d.code),
    ),
    errors.map((d) => `${d.code}: ${d.message}`).join("\n"),
  );
});

test("failure notifications require string error code and message", async (t) => {
  const failed = samples.find((s) => s.payload.type.endsWith(".failed"));
  const withoutResults = structuredClone(failed);
  delete withoutResults.payload.commentary;
  checkErrors(
    (await validateExamples("failure-without-results", [withoutResults]))
      .diagnostics,
  );

  for (const field of ["error_code", "error_message"]) {
    for (const [name, value] of [
      ["missing", undefined],
      ["null", null],
      ["number", 42],
      ["object", { message: "Not a string" }],
    ]) {
      await t.test(`${field}: ${name}`, async () => {
        const sample = structuredClone(failed);
        if (value === undefined) delete sample.payload[field];
        else sample.payload[field] = value;
        const result = await validateExamples(`failure-${field}-${name}`, [
          sample,
        ]);
        const errors = result.diagnostics.filter((d) => d.severity === "error");
        assert.ok(errors.length > 0);
        assert.ok(
          errors.every((d) =>
            ["invalid-argument", "unassignable", "missing-property"].includes(
              d.code,
            ),
          ),
          errors.map((d) => `${d.code}: ${d.message}`).join("\n"),
        );
      });
    }
  }
});

test("SDK metadata exports native events and separate Live persistence discriminators", async () => {
  const entrypoint = join(
    project,
    "src/sdk-python-js-azure-ai-projects/client.tsp",
  );
  const [options, diagnostics] = await resolveCompilerOptions(NodeHost, {
    entrypoint,
    cwd: project,
  });
  checkErrors(diagnostics);
  const sdkProgram = await compile(NodeHost, entrypoint, {
    ...options,
    noEmit: true,
  });
  checkErrors(sdkProgram.diagnostics);
  const context = await createSdkContext(
    {
      program: sdkProgram,
      options: { "api-version": "v1" },
      emitterOutputDir: output,
    },
    "@azure-tools/typespec-python",
  );
  checkErrors(context.diagnostics);
  const model = (name) => {
    const value = context.sdkPackage.models.find((m) => m.__raw?.name === name);
    assert.ok(value, `SDK metadata missing ${name}`);
    return value;
  };
  for (const stage of managedStages) {
    const value = model(managedModel(stage).split(".").at(-1));
    assert.equal(value.baseModel.__raw.name, "LiveServerEvent");
    assert.ok(
      value.properties.some((p) => p.serializedName === "delegation_id"),
    );
    for (const field of [
      "has_spoken_text",
      "has_background_context",
      "mcp_call_count",
      "failure_context_status",
    ])
      assert.ok(
        !value.properties.some((p) => p.serializedName === field),
        `${stage}.${field}`,
      );
    for (const field of ["error_code", "error_message"]) {
      const property = value.properties.find((p) => p.serializedName === field);
      assert.equal(Boolean(property), stage === "failed", `${stage}.${field}`);
      if (property) {
        assert.equal(property.type.kind, "string");
        assert.equal(property.optional, false);
      }
    }
  }
  assert.ok(
    !context.sdkPackage.models.some(
      (m) => m.__raw?.name === "VoiceAgentLiveManagedDelegationRequestEvent",
    ),
  );
  const item = model("VoiceAgentLiveConversationItem");
  const delegation = model("VoiceAgentLiveDelegationConversationItem");
  assert.equal(item.discriminatorProperty.serializedName, "type");
  assert.deepEqual(Object.keys(item.discriminatedSubtypes).sort(), [
    "delegation",
    "input",
    "output",
  ]);
  assert.equal(delegation.baseModel, item);
  assert.equal(delegation.discriminatorProperty.serializedName, "target");
  assert.deepEqual(Object.keys(delegation.discriminatedSubtypes).sort(), [
    "client",
    "foundry_managed_agent",
    "responses",
  ]);
  assert.equal(
    item.properties.find((p) => p.serializedName === "id").type.kind,
    "string",
  );
  for (const direction of ["Input", "Output"]) {
    const speech = model(`VoiceAgentLive${direction}ConversationItem`);
    assert.equal(speech.baseModel, item);
    assert.equal(
      speech.properties.find((p) => p.serializedName === "audio").type,
      model("VoiceAudioItem"),
    );
    assert.equal(
      speech.properties.find((p) => p.serializedName === "transcription").type
        .kind,
      "string",
    );
  }
  for (const [name, textFields] of [
    ["Client", ["commentary", "thinking"]],
    ["Responses", ["output"]],
    ["FoundryManagedAgent", ["commentary", "thinking", "delegation_context"]],
  ]) {
    const stored = model(`VoiceAgentLive${name}DelegationConversationItem`);
    assert.equal(stored.baseModel, delegation);
    for (const field of textFields)
      assert.equal(
        stored.properties.find((p) => p.serializedName === field).type.kind,
        "string",
      );
  }
  for (const stored of context.sdkPackage.models.filter(
    (m) =>
      m.__raw?.name?.startsWith("VoiceAgentLive") &&
      m.__raw.name.endsWith("ConversationItem"),
  )) {
    assert.ok(
      !stored.properties.some((p) =>
        ["item_id", "delegation_id"].includes(p.serializedName),
      ),
    );
  }
  assert.equal(
    model("VoiceAgentLiveConversation").properties.find(
      (p) => p.serializedName === "usage",
    ).type,
    model("LiveSessionUsage"),
  );
  assert.ok(
    !context.sdkPackage.models.some((m) =>
      m.__raw?.name?.startsWith("VoiceLive"),
    ),
  );
  assert.ok(
    !context.sdkPackage.models.some(
      (m) => m.__raw?.name === "VoiceConversationItem",
    ),
  );
  // @example arguments are checked before copyProperties runs. Verify the final
  // SDK shape for this late augmentation rather than accepting a premature
  // "unexpected-property" diagnostic as evidence about the emitted contract.
  const correlation = model(
    "LiveServerEventLiveSessionStarted",
  ).properties.find((p) => p.serializedName === "conversation_id");
  assert.equal(correlation.optional, true);
  assert.equal(correlation.type.kind, "string");
  assert.equal(
    model("LiveServerEventLiveSessionStarted").properties.find(
      (p) => p.serializedName === "session",
    ).type.__raw.name,
    "LiveSessionResourceParam",
  );
});

test("cancel is server-only and the removed request event has no typed variant", () => {
  const literals = (root) =>
    [...type(root).variants.values()].map((v) => v.type.value);
  assert.ok(
    literals("OpenAI.LiveServerEventType").includes(
      "session.managed_delegation.cancel",
    ),
  );
  assert.ok(
    !literals("OpenAI.LiveServerEventType").includes(
      "session.managed_delegation.request",
    ),
  );
  assert.ok(
    !literals("OpenAI.LiveClientEventType").includes(
      "session.managed_delegation.cancel",
    ),
  );
  assert.ok(
    !fields(type(managedModel("cancel"))).has("failure_context_status"),
  );
});

test("Realtime persistence and inference retain the native Realtime item hierarchy", () => {
  const item = type("Azure.AI.Projects.VoiceAgentLiveConversationItem");
  assert.equal(item.baseModel, undefined);
  const nativeItem = type("OpenAI.RealtimeConversationItem");
  assert.ok(!nativeItem.derivedModels.includes(item));
  const itemTypes = type("OpenAI.RealtimeConversationItemType");
  assert.ok(
    ![...itemTypes.variants.values()].some(
      (v) => v.type.value === "live_delegation",
    ),
  );
  const [removedAlias] = program.resolveTypeReference(
    "Azure.AI.Projects.VoiceConversationItem",
  );
  assert.equal(removedAlias, undefined);
  assert.equal(
    type("Azure.AI.Projects.VoiceResponse").properties.get("output").type
      .indexer.value,
    nativeItem,
  );
  assert.equal(
    type("OpenAI.RealtimeClientEventConversationItemCreate").properties.get(
      "item",
    ).type,
    nativeItem,
  );
});

test("Realtime read routes use native items without a mixed Live union", () => {
  for (const doc of documents) {
    const schemas = doc.components.schemas;
    assert.equal(schemas.VoiceConversationItem, undefined);
    const nativeRef = "#/components/schemas/OpenAI.RealtimeConversationItem";
    assert.equal(schemas.VoiceResponse.properties.output.items.$ref, nativeRef);
    const base =
      "/agents/{agent_name}/endpoint/protocols/voice/conversations/{conversation_id}";
    for (const path of [
      `${base}/items`,
      `${base}/responses/{response_id}/items`,
    ]) {
      const response =
        doc.paths[path].get.responses["200"].content["application/json"].schema;
      assert.equal(response.properties.data.items.$ref, nativeRef);
    }
    assert.equal(
      doc.paths[`${base}/items/{item_id}`].get.responses["200"].content[
        "application/json"
      ].schema.$ref,
      nativeRef,
    );
  }
});

test("Live read and audio routes use a separate namespace with no response resources", () => {
  for (const doc of documents) {
    const base =
      "/agents/{agent_name}/endpoint/protocols/voice/live/conversations";
    const conversation = `${base}/{conversation_id}`;
    const expected = [
      [base, "get", "VoiceAgentLiveConversation", true],
      [conversation, "get", "VoiceAgentLiveConversation"],
      [conversation, "delete"],
      [`${conversation}/items`, "get", "VoiceAgentLiveConversationItem", true],
      [
        `${conversation}/items/{item_id}`,
        "get",
        "VoiceAgentLiveConversationItem",
      ],
      [`${conversation}/items/{item_id}/audio`, "get", "VoiceAudioItem"],
      [`${conversation}/items/{item_id}/audio/content`, "get", "audio/wav"],
      [`${conversation}/audio`, "get", "VoiceRecording"],
      [`${conversation}/audio/content`, "get", "audio/wav"],
    ];
    assert.deepEqual(
      Object.keys(doc.paths)
        .filter((path) => path.startsWith(base))
        .sort(),
      [...new Set(expected.map(([path]) => path))].sort(),
    );
    for (const [path, method, name, paged] of expected) {
      const op = doc.paths[path][method];
      assert.ok(op, `${method} ${path}`);
      assert.deepEqual(op.tags, ["Agent Live Conversations"]);
      assert.ok(op.parameters.some((p) => p.name === "api-version"));
      assert.equal(op.requestBody, undefined);
      if (method === "delete") {
        assert.ok(op.responses["204"]);
      } else if (name === "audio/wav") {
        assert.ok(op.responses["200"].content["audio/wav"]);
      } else {
        const schema = op.responses["200"].content["application/json"].schema;
        const value = paged ? schema.properties.data.items : schema;
        assert.equal(value.$ref, `#/components/schemas/${name}`);
      }
      if (paged) {
        for (const name of ["limit", "after", "before", "order"])
          assert.ok(
            op.parameters.some((p) => p.name === name),
            `${path}: ${name}`,
          );
      }
    }
    const schemas = doc.components.schemas;
    assert.equal(
      schemas.VoiceAgentLiveConversation.properties.usage.$ref,
      "#/components/schemas/OpenAI.LiveSessionUsage",
    );
    assert.equal(
      schemas.VoiceAgentLiveConversation.properties.output,
      undefined,
    );
    assert.equal(
      schemas.VoiceAgentLiveConversation.properties.responses,
      undefined,
    );
    assert.equal(
      schemas.VoiceAgentLiveConversationItem.discriminator.propertyName,
      "type",
    );
    assert.equal(
      schemas.VoiceAgentLiveDelegationConversationItem.discriminator
        .propertyName,
      "target",
    );
    assert.equal(
      schemas.VoiceAgentLiveDelegationConversationItem.properties.type.enum[0],
      "delegation",
    );
  }
});

test("Live speech items use id and share only the existing audio metadata structure", () => {
  const root = type("Azure.AI.Projects.VoiceAgentLiveConversationItem");
  assert.equal(getDiscriminator(program, root).propertyName, "type");
  assert.deepEqual([...root.properties.keys()], ["type", "id"]);
  for (const name of ["Input", "Output"]) {
    const speech = type(
      `Azure.AI.Projects.VoiceAgentLive${name}ConversationItem`,
    );
    assert.equal(speech.baseModel, root);
    const p = fields(speech);
    assert.deepEqual([...p.keys()], ["type", "id", "transcription", "audio"]);
    assert.equal(p.get("id").optional, false);
    assert.equal(getTypeName(p.get("id").type), "string");
    assert.equal(p.get("type").type.value, name.toLowerCase());
    assert.equal(p.get("transcription").optional, true);
    assert.equal(getTypeName(p.get("transcription").type), "string");
    assert.equal(p.get("audio").optional, true);
    assert.equal(p.get("audio").type, type("Azure.AI.Projects.VoiceAudioItem"));
  }
  // The shared audio DTO keeps its existing item_id for Realtime compatibility.
  assert.equal(
    type("Azure.AI.Projects.VoiceAudioItem").properties.get("item_id").optional,
    false,
  );
});

test("stored delegation reuses native fields and discriminates target-specific results", () => {
  const root = type("Azure.AI.Projects.VoiceAgentLiveConversationItem");
  const item = type(
    "Azure.AI.Projects.VoiceAgentLiveDelegationConversationItem",
  );
  assert.equal(item.baseModel, root);
  assert.equal(getDiscriminator(program, item).propertyName, "target");
  const p = fields(item);
  assert.deepEqual([...p.keys()].sort(), [
    "created_at",
    "id",
    "response_id",
    "target",
    "type",
  ]);
  for (const name of ["type", "id", "created_at", "target"])
    assert.equal(p.get(name).optional, false, name);
  const nativeItem = type("OpenAI.LiveDelegationItem");
  for (const name of ["id", "type", "response_id"])
    assert.equal(p.get(name).type, nativeItem.properties.get(name).type, name);
  assert.equal(p.get("response_id").optional, true);
  for (const [name, target, ownFields] of [
    ["Client", "client", ["target", "commentary", "thinking"]],
    ["Responses", "responses", ["target", "output"]],
    [
      "FoundryManagedAgent",
      "foundry_managed_agent",
      ["target", "commentary", "thinking", "delegation_context", "status"],
    ],
  ]) {
    const subtype = type(
      `Azure.AI.Projects.VoiceAgentLive${name}DelegationConversationItem`,
    );
    assert.equal(subtype.baseModel, item);
    assert.deepEqual([...subtype.properties.keys()], ownFields);
    assert.equal(subtype.properties.get("target").type.value, target);
    assert.ok(!fields(subtype).has("item_id"));
    assert.ok(!fields(subtype).has("delegation_id"));
  }
  const managed = type(
    "Azure.AI.Projects.VoiceAgentLiveFoundryManagedAgentDelegationConversationItem",
  );
  assert.equal(managed.properties.get("status").optional, false);
  assert.equal(
    managed.properties.get("status").type,
    type("Azure.AI.Projects.VoiceAgentLiveDelegationStatus"),
  );
  const target = type("Azure.AI.Projects.VoiceAgentLiveDelegationTarget");
  assert.deepEqual(
    [...target.variants.values()].map((v) => v.type.value),
    ["responses", "client", "foundry_managed_agent"],
  );
  // Foundry ownership is a persistence extension, not a new native Live target.
  const nativeTarget = nativeItem.properties.get("target").type;
  assert.deepEqual(
    [...nativeTarget.variants.values()].map((v) => v.type.value),
    ["client", "responses"],
  );
  assert.ok(
    ![...type("Azure.AI.Projects").models.keys()].some((name) =>
      name.startsWith("VoiceLive"),
    ),
  );
});

const speechExamples = ["input", "output"].flatMap((direction) => {
  const id = `item_${direction}_1`;
  const payload = {
    type: direction,
    id,
    transcription:
      direction === "input"
        ? "Yesterday I goed to school."
        : "Try saying: Yesterday I went to school.",
    audio: {
      conversation_id: "conv_live_1",
      item_id: id,
      role: direction === "input" ? "user" : "agent",
      format: "wav",
      codec: "pcm16",
      sample_rate: 24000,
      channels: 1,
      start_offset_ms: 1200,
      duration_ms: 2450,
      blob_uri: `https://example.blob.core.windows.net/recordings/${id}.wav`,
    },
  };
  const model = `Azure.AI.Projects.VoiceAgentLive${direction === "input" ? "Input" : "Output"}ConversationItem`;
  return [
    { model, payload },
    { model, payload: { type: direction, id } },
    {
      model,
      payload: { type: direction, id, transcription: payload.transcription },
    },
    { model, payload: { type: direction, id, audio: payload.audio } },
  ];
});

const storedDelegation = {
  type: "delegation",
  id: "del_1",
  created_at: 1791763200,
};
const storedExamples = [
  { ...storedDelegation, target: "client", commentary: "Use went, not goed." },
  {
    ...storedDelegation,
    target: "client",
    thinking: "The learner is practicing past tense.",
  },
  {
    ...storedDelegation,
    target: "responses",
    response_id: "resp_1",
    output: "The past tense of go is went.",
  },
  {
    ...storedDelegation,
    target: "foundry_managed_agent",
    status: "completed",
    delegation_context: "The learner asked how to describe yesterday's trip.",
    commentary: "Say: Yesterday I went to school.",
    thinking: "Focus on irregular verbs.",
  },
  {
    ...storedDelegation,
    target: "foundry_managed_agent",
    status: "cancelled",
    delegation_context:
      "The learner changed the question before the backend finished.",
  },
].map((payload) => ({
  model: `Azure.AI.Projects.VoiceAgentLive${
    {
      client: "Client",
      responses: "Responses",
      foundry_managed_agent: "FoundryManagedAgent",
    }[payload.target]
  }DelegationConversationItem`,
  payload,
}));

test("speech, partial capture, and target-specific delegation examples validate", async () => {
  const result = await validateExamples("persisted-live-items", [
    ...speechExamples,
    ...storedExamples,
  ]);
  checkErrors(result.diagnostics);
});

test("Live conversation envelope uses native Live seconds usage, not Realtime token usage", async () => {
  const conversation = type("Azure.AI.Projects.VoiceAgentLiveConversation");
  const original = type("Azure.AI.Projects.VoiceConversation");
  assert.equal(conversation.baseModel, undefined);
  for (const [name, property] of original.properties) {
    if (name === "usage") continue;
    assert.equal(conversation.properties.get(name).type, property.type);
    assert.equal(conversation.properties.get(name).optional, property.optional);
  }
  assert.equal(
    conversation.properties.get("usage").type,
    type("OpenAI.LiveSessionUsage"),
  );
  const result = await validateExamples("live-envelope", [
    {
      model: "Azure.AI.Projects.VoiceAgentLiveConversation",
      payload: {
        id: "conv_live_1",
        object: "voice.conversation",
        status: "completed",
        created_at: 1791763200,
        completed_at: 1791763260,
        metadata: { lesson: "past tense" },
        usage: { seconds: 60 },
      },
    },
  ]);
  checkErrors(result.diagnostics);
});

test("malformed Live speech and delegation items are rejected", async (t) => {
  const cases = [
    [
      "missing speech id",
      speechExamples[0],
      (p) => {
        delete p.id;
      },
    ],
    [
      "item_id instead of id",
      speechExamples[0],
      (p) => {
        p.item_id = p.id;
        delete p.id;
      },
    ],
    [
      "invalid speech type",
      speechExamples[0],
      (p) => {
        p.type = "message";
      },
    ],
    [
      "structured transcription",
      speechExamples[0],
      (p) => {
        p.transcription = { text: "hello" };
      },
    ],
    [
      "missing shared audio item_id",
      speechExamples[0],
      (p) => {
        delete p.audio.item_id;
      },
    ],
    [
      "invalid audio sample rate",
      speechExamples[0],
      (p) => {
        p.audio.sample_rate = "24kHz";
      },
    ],
    [
      "legacy delegation discriminator",
      storedExamples[0],
      (p) => {
        p.type = "live_delegation";
      },
    ],
    [
      "missing native delegation ID",
      storedExamples[0],
      (p) => {
        delete p.id;
      },
    ],
    [
      "unsupported target",
      storedExamples[0],
      (p) => {
        p.target = "unknown_backend";
      },
    ],
    [
      "nested output instead of final text",
      storedExamples[2],
      (p) => {
        p.output = { responses: [] };
      },
    ],
    [
      "receipt instead of commentary text",
      storedExamples[0],
      (p) => {
        p.commentary = { content: "A result" };
      },
    ],
    [
      "array instead of thinking text",
      storedExamples[0],
      (p) => {
        p.thinking = ["A fact"];
      },
    ],
    [
      "backend JSON instead of context text",
      storedExamples[3],
      (p) => {
        p.delegation_context = { input: "A task" };
      },
    ],
    [
      "non-string execution status",
      storedExamples[3],
      (p) => {
        p.status = true;
      },
    ],
    [
      "missing managed execution status",
      storedExamples[3],
      (p) => {
        delete p.status;
      },
    ],
    [
      "Responses fields on client delegation",
      storedExamples[0],
      (p) => {
        p.output = "wrong owner";
      },
    ],
    [
      "managed fields on Responses delegation",
      storedExamples[2],
      (p) => {
        p.delegation_context = "wrong owner";
      },
    ],
  ];
  for (const [index, [name, original, mutate]] of cases.entries()) {
    await t.test(name, async () => {
      const sample = structuredClone(original);
      mutate(sample.payload);
      const result = await validateExamples(`invalid-stored-${index}`, [
        sample,
      ]);
      const errors = result.diagnostics.filter((d) => d.severity === "error");
      assert.ok(errors.length > 0, name);
      assert.ok(
        errors.every((d) =>
          [
            "invalid-argument",
            "unassignable",
            "missing-property",
            "unexpected-property",
          ].includes(d.code),
        ),
        errors.map((d) => `${d.code}: ${d.message}`).join("\n"),
      );
    });
  }
});

test("result strings are optional, not nullable or acknowledgment structures", async () => {
  const model = "Azure.AI.Projects.VoiceAgentLiveDelegationResultItem";
  const result = await validateExamples("optional-result-text", [
    { model, payload: {} },
    { model, payload: { commentary: "Try another sentence." } },
    { model, payload: { thinking: "Wait for the learner's answer." } },
    {
      model,
      payload: {
        commentary: "Correct!",
        thinking: "Increase difficulty next.",
      },
    },
  ]);
  checkErrors(result.diagnostics);
  const nullable = await validateExamples("invalid-null-result-text", [
    { model, payload: { commentary: null } },
    { model, payload: { thinking: null } },
  ]);
  const errors = nullable.diagnostics.filter((d) => d.severity === "error");
  assert.ok(errors.length >= 2);
  assert.ok(
    errors.every((d) => ["invalid-argument", "unassignable"].includes(d.code)),
    errors.map((d) => `${d.code}: ${d.message}`).join("\n"),
  );
  for (const [subtype, names] of [
    ["Responses", ["output"]],
    ["Client", ["commentary", "thinking"]],
    ["FoundryManagedAgent", ["commentary", "thinking", "delegation_context"]],
  ])
    for (const name of names)
      assert.equal(
        type(
          `Azure.AI.Projects.VoiceAgentLive${subtype}DelegationConversationItem`,
        ).properties.get(name).optional,
        true,
        `${subtype}.${name}`,
      );
});

test("OpenAPI exposes the Foundry Live handshake without native REST operations", () => {
  for (const doc of documents) {
    const path = "/agents/{agent_name}/endpoint/protocols/voice/live/sessions";
    const op = doc.paths[path].get;
    assert.ok(op.responses["101"]);
    assert.equal(op.requestBody, undefined);
    assert.equal(
      op.responses["101"].headers?.["Sec-WebSocket-Protocol"],
      undefined,
    );
    const names = op.parameters.map((p) => p.name);
    for (const name of [
      "agent_name",
      "store",
      "structured_input",
      "x-agent-version-override",
    ])
      assert.ok(names.includes(name));
    assert.equal(names.includes("sub_protocol"), false);
    assert.equal(names.includes("model"), false);
    assert.equal(names.includes("Sec-WebSocket-Protocol"), false);
    assert.equal(
      Object.keys(doc.paths).some((p) => p.startsWith("/live/")),
      false,
    );
    assert.ok(doc.paths["/agents/{agent_name}/endpoint/protocols/voice"].get);
  }
});

test("persisted definitions remain flat with Foundry store and native configuration refs", () => {
  for (const doc of documents) {
    const schemas = doc.components.schemas;
    const base = schemas.VoiceAgentDefinition;
    const live = schemas.LiveVoiceAgentDefinition;
    assert.equal(base.discriminator.propertyName, "sub_protocol");
    assert.equal(base.properties.store.default, false);
    assert.equal(base.properties.audio, undefined);
    assert.equal(live.properties.live_config, undefined);
    assert.equal(live.properties.session, undefined);
    assert.equal(
      live.properties.audio.$ref,
      "#/components/schemas/OpenAI.LiveInitialSessionAudioParam",
    );
    const managed = schemas.VoiceAgentLiveManagedAgentDelegation;
    assert.deepEqual(managed.required, ["type", "agent_name"]);
    assert.equal(managed.properties.result_format.default, "tagged_text");
  }
});
