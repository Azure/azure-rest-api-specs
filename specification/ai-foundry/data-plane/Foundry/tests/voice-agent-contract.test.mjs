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
      "error_code",
      "has_spoken_text",
      "has_background_context",
      "mcp_call_count",
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
    ])
      assert.equal(p.has(field), false, `${stage}.${field}`);
    assert.equal(p.has("failure_context_status"), stage === "failed");
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
  error_code: null,
  has_spoken_text: false,
  has_background_context: false,
  mcp_call_count: 0,
  offset_ms: 1200,
};
const resultText = { commentary: "Say: Yesterday I went to school." };
const samples = managedStages.map((stage) => {
  const payload = { ...metadata, type: `session.managed_delegation.${stage}` };
  if (["progress", "completed"].includes(stage))
    Object.assign(payload, {
      response_id: "resp_1",
      has_spoken_text: true,
      ...resultText,
    });
  if (stage === "completed") payload.backend_conversation_id = "conv_backend";
  if (stage === "failed")
    Object.assign(payload, {
      error_code: "partial_backend_timeout",
      failure_context_status: "accepted",
      ...resultText,
    });
  if (stage === "cancel")
    Object.assign(payload, {
      error_code: "partial_cancelled_or_superseded",
      ...resultText,
    });
  payload.has_spoken_text = Boolean(payload.commentary);
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

function tspValue(value) {
  if (Array.isArray(value)) return `#[${value.map(tspValue).join(",")}]`;
  if (value !== null && typeof value === "object") {
    return `#{${Object.entries(value)
      .map(([key, item]) => {
        assert.match(key, /^[a-zA-Z_][a-zA-Z_0-9]*$/);
        return `\`${key}\`: ${tspValue(item)}`;
      })
      .join(",")}}`;
  }
  return JSON.stringify(value);
}

function exampleValue({ model, payload }) {
  const text = tspValue(payload);
  if (model !== "Azure.AI.Projects.VoiceAgentLiveDelegationConversationItem")
    return text;
  // FoundryTimestamp is a utcDateTime encoded as Unix seconds on the wire.
  return text.replace(
    `\`created_at\`: ${payload.created_at}`,
    `\`created_at\`: Azure.AI.Projects.FoundryTimestamp.fromISO(${JSON.stringify(new Date(payload.created_at * 1000).toISOString())})`,
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
  const invalidCount = structuredClone(samples[0]);
  invalidCount.payload.mcp_call_count = "one";
  const invalidResult = structuredClone(
    samples.find((s) => s.payload.type.endsWith(".progress")),
  );
  invalidResult.payload.commentary = { content: "Not a plain string" };
  const invalidFailure = structuredClone(
    samples.find((s) => s.payload.type.endsWith(".failed")),
  );
  invalidFailure.payload.failure_context_status = 42;
  const result = await validateExamples("invalid-events", [
    missingDelegationId,
    invalidCount,
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

test("SDK metadata exports all managed event types and the optional stored-conversation field", async () => {
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
  }
  assert.ok(
    !context.sdkPackage.models.some(
      (m) => m.__raw?.name === "VoiceAgentLiveManagedDelegationRequestEvent",
    ),
  );
  const stored = model("VoiceAgentLiveDelegationConversationItem");
  for (const field of [
    "output",
    "commentary",
    "thinking",
    "delegation_context",
  ])
    assert.equal(
      stored.properties.find((p) => p.serializedName === field).type.kind,
      "string",
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

test("conversation read alias reuses native Realtime without extending inference", () => {
  const item = type(
    "Azure.AI.Projects.VoiceAgentLiveDelegationConversationItem",
  );
  assert.equal(item.baseModel, undefined);
  const nativeItem = type("OpenAI.RealtimeConversationItem");
  assert.ok(!nativeItem.derivedModels.includes(item));
  const itemTypes = type("OpenAI.RealtimeConversationItemType");
  assert.ok(
    ![...itemTypes.variants.values()].some(
      (v) => v.type.value === "live_delegation",
    ),
  );
  const readItem = type("Azure.AI.Projects.VoiceConversationItem");
  assert.ok(!readItem.name, "The read alias must not introduce a named union");
  assert.deepEqual(
    [...readItem.variants.values()].map((v) => v.type),
    [nativeItem, item],
  );
  assert.equal(
    type("Azure.AI.Projects.VoiceResponse").properties.get("output").type
      .indexer.value,
    readItem,
  );
  assert.equal(
    type("OpenAI.RealtimeClientEventConversationItemCreate").properties.get(
      "item",
    ).type,
    nativeItem,
  );
});

test("all shared item read paths expose the two reused shapes without a wrapper schema", () => {
  for (const doc of documents) {
    const schemas = doc.components.schemas;
    const item = schemas.VoiceAgentLiveDelegationConversationItem;
    assert.equal(item.properties.type.enum[0], "live_delegation");
    assert.equal(
      item.properties.created_at.$ref,
      "#/components/schemas/FoundryTimestamp",
    );
    assert.equal(schemas.FoundryTimestamp.type, "integer");
    assert.equal(schemas.VoiceConversationItem, undefined);
    const nativeRef = "#/components/schemas/OpenAI.RealtimeConversationItem";
    const liveRef =
      "#/components/schemas/VoiceAgentLiveDelegationConversationItem";
    const checkReadItem = (value) => {
      assert.deepEqual(
        value.anyOf.map((v) => v.$ref),
        [nativeRef, liveRef],
      );
      assert.equal(
        value.oneOf,
        undefined,
        "The extensible native base requires anyOf, not overlapping oneOf branches",
      );
    };
    checkReadItem(schemas.VoiceResponse.properties.output.items);
    const base =
      "/agents/{agent_name}/endpoint/protocols/voice/conversations/{conversation_id}";
    for (const path of [
      `${base}/items`,
      `${base}/responses/{response_id}/items`,
    ]) {
      const response =
        doc.paths[path].get.responses["200"].content["application/json"].schema;
      checkReadItem(response.properties.data.items);
    }
    checkReadItem(
      doc.paths[`${base}/items/{item_id}`].get.responses["200"].content[
        "application/json"
      ].schema,
    );
  }
});

test("stored delegation is a minimal flat item with a distinct managed target", () => {
  const item = type(
    "Azure.AI.Projects.VoiceAgentLiveDelegationConversationItem",
  );
  const p = item.properties;
  assert.deepEqual(
    [...p.keys()],
    [
      "type",
      "id",
      "delegation_id",
      "created_at",
      "target",
      "output",
      "commentary",
      "thinking",
      "delegation_context",
      "status",
    ],
  );
  for (const name of ["type", "id", "delegation_id", "created_at", "target"])
    assert.equal(p.get(name).optional, false, name);
  for (const name of ["output", "commentary", "thinking", "delegation_context"])
    assert.equal(getTypeName(p.get(name).type), "string", name);
  assert.equal(
    p.get("status").type,
    type("Azure.AI.Projects.VoiceAgentLiveDelegationStatus"),
  );
  const target = type("Azure.AI.Projects.VoiceAgentLiveDelegationTarget");
  assert.deepEqual(
    [...target.variants.values()].map((v) => v.type.value),
    ["responses", "client", "foundry_managed_agent"],
  );
  // Foundry ownership is a persistence extension, not a new native Live target.
  const nativeTarget = type("OpenAI.LiveDelegationItem").properties.get(
    "target",
  ).type;
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

const storedDelegation = {
  type: "live_delegation",
  id: "item_delegation_1",
  delegation_id: "del_1",
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
  model: "Azure.AI.Projects.VoiceAgentLiveDelegationConversationItem",
  payload,
}));

test("simple client, Responses, and managed delegation examples validate", async () => {
  const result = await validateExamples(
    "persisted-delegations",
    storedExamples,
  );
  checkErrors(result.diagnostics);
});

test("malformed persisted delegation fields are rejected", async (t) => {
  const cases = [
    [
      "missing native delegation ID",
      (p) => {
        delete p.delegation_id;
      },
    ],
    [
      "unsupported target",
      (p) => {
        p.target = "unknown_backend";
      },
    ],
    [
      "nested output instead of final text",
      (p) => {
        p.output = { responses: [] };
      },
    ],
    [
      "receipt instead of commentary text",
      (p) => {
        p.commentary = { content: "A result" };
      },
    ],
    [
      "array instead of thinking text",
      (p) => {
        p.thinking = ["A fact"];
      },
    ],
    [
      "backend JSON instead of context text",
      (p) => {
        p.delegation_context = { input: "A task" };
      },
    ],
    [
      "non-string execution status",
      (p) => {
        p.status = true;
      },
    ],
  ];
  for (const [index, [name, mutate]] of cases.entries()) {
    await t.test(name, async () => {
      const sample = structuredClone(storedExamples[3]);
      mutate(sample.payload);
      const result = await validateExamples(`invalid-stored-${index}`, [
        sample,
      ]);
      const errors = result.diagnostics.filter((d) => d.severity === "error");
      assert.ok(errors.length > 0, name);
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
  for (const name of [
    "output",
    "commentary",
    "thinking",
    "delegation_context",
    "status",
  ])
    assert.equal(
      type(
        "Azure.AI.Projects.VoiceAgentLiveDelegationConversationItem",
      ).properties.get(name).optional,
      true,
      name,
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
