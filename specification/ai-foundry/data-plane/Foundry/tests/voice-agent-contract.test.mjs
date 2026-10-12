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

test("all managed notifications are typed native-server subclasses with required correlation", () => {
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
      "stream",
      "offset_ms",
    ]) {
      assert.equal(p.get(field).optional, false, `${stage}.${field}`);
    }
    assert.equal(p.has("sub_protocol"), false);
    assert.equal(p.get("backend_store").optional, true);
    assert.equal(p.has("request"), false);
    assert.equal(p.has("failure_context_status"), stage === "failed");
    assert.equal(
      p.has("spoken_text"),
      ["progress", "completed"].includes(stage),
    );
    assert.equal(
      p.has("background_context"),
      ["progress", "completed"].includes(stage),
    );
    assert.equal(p.has("backend_conversation_id"), stage === "completed");
    assert.equal(
      p.has("output_items"),
      ["progress", "completed", "failed", "cancel"].includes(stage),
    );
  }
});

test("output receipts expose typed accepted appends, not raw Responses/tool output", () => {
  const outputItem = type("Azure.AI.Projects.VoiceAgentLiveManagedOutput");
  assert.equal(
    outputItem.properties.get("appends").type.indexer.value,
    type("Azure.AI.Projects.VoiceAgentLiveManagedAppend"),
  );
  const append = type("Azure.AI.Projects.VoiceAgentLiveManagedAppend");
  assert.equal(append.properties.get("status").type.value, "accepted");
  assert.deepEqual(
    [
      ...type(
        "Azure.AI.Projects.VoiceAgentLiveManagedAppendType",
      ).variants.values(),
    ].map((v) => v.type.value),
    ["session.commentary.append", "session.thinking.append"],
  );
  assert.equal(append.properties.get("error").optional, true);
});

// Representative JSON based on Vienna's lifecycle payloads, plus the requested
// cancel notification contract. These are examples, not captured customer events.
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
  stream: true,
  offset_ms: 1200,
};
const acceptedOutput = [
  {
    output_index: 0,
    appends: [
      {
        event_id: "evt_append_1",
        type: "session.commentary.append",
        content: "Say: Yesterday I went to school.",
        status: "accepted",
      },
    ],
  },
];
const samples = managedStages.map((stage) => {
  const payload = { ...metadata, type: `session.managed_delegation.${stage}` };
  if (["progress", "completed"].includes(stage))
    Object.assign(payload, {
      response_id: "resp_1",
      spoken_text: "Say: Yesterday I went to school.",
      background_context: null,
      has_spoken_text: true,
      backend_store: false,
      output_items: acceptedOutput,
    });
  if (stage === "completed") payload.backend_conversation_id = "conv_backend";
  if (stage === "failed")
    Object.assign(payload, {
      error_code: "partial_backend_timeout",
      failure_context_status: "accepted",
      output_items: acceptedOutput,
    });
  if (stage === "cancel")
    Object.assign(payload, {
      error_code: "partial_cancelled_or_superseded",
      output_items: acceptedOutput,
    });
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
  if (model !== "Azure.AI.Projects.VoiceLiveDelegationConversationItem")
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
  const invalidReceipt = structuredClone(
    samples.find((s) => s.payload.type.endsWith(".progress")),
  );
  invalidReceipt.payload.output_items[0].appends[0].status = "unconfirmed";
  const invalidFailure = structuredClone(
    samples.find((s) => s.payload.type.endsWith(".failed")),
  );
  invalidFailure.payload.failure_context_status = 42;
  const result = await validateExamples("invalid-events", [
    missingDelegationId,
    invalidCount,
    invalidReceipt,
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
  for (const name of [
    "VoiceLiveDelegationConversationItem",
    "VoiceLiveDelegationInput",
    "VoiceLiveDelegationOutput",
    "VoiceLiveManagedPromptAgentExecution",
  ])
    model(name);
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

test("delegation persistence does not extend the native realtime inference item hierarchy", () => {
  const item = type("Azure.AI.Projects.VoiceLiveDelegationConversationItem");
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
  // Reuse every known native variant without an open base-type fallback that
  // could swallow malformed live_delegation objects during deserialization.
  const readVariants = [...readItem.variants.values()].map((v) => v.type);
  for (const child of nativeItem.derivedModels)
    assert.ok(readVariants.includes(child), child.name);
  assert.equal(readVariants.length, nativeItem.derivedModels.length + 1);
  assert.ok(!readVariants.includes(nativeItem));
  assert.equal(readItem.variants.get("live_delegation").type, item);
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

test("all shared conversation item read paths expose the typed delegation item", () => {
  for (const doc of documents) {
    const schemas = doc.components.schemas;
    assert.equal(
      schemas.VoiceLiveDelegationConversationItem.properties.type.enum[0],
      "live_delegation",
    );
    assert.equal(
      schemas.VoiceLiveDelegationConversationItem.properties.created_at.$ref,
      "#/components/schemas/FoundryTimestamp",
    );
    assert.equal(schemas.FoundryTimestamp.type, "integer");
    assert.equal(schemas.VoiceConversationItem.oneOf.length, 8);
    assert.ok(
      !schemas.VoiceConversationItem.oneOf.some(
        (v) =>
          v.$ref === "#/components/schemas/OpenAI.RealtimeConversationItem",
      ),
    );
    const hasDelegation = (node, seen = new Set()) => {
      if (Array.isArray(node))
        return node.some((value) => hasDelegation(value, seen));
      if (!node || typeof node !== "object") return false;
      if (node.$ref?.endsWith("/VoiceLiveDelegationConversationItem"))
        return true;
      if (
        node.$ref?.startsWith("#/components/schemas/") &&
        !seen.has(node.$ref)
      ) {
        seen.add(node.$ref);
        if (hasDelegation(schemas[node.$ref.split("/").at(-1)], seen))
          return true;
      }
      return Object.values(node).some((value) => hasDelegation(value, seen));
    };
    const base =
      "/agents/{agent_name}/endpoint/protocols/voice/conversations/{conversation_id}";
    for (const path of [
      `${base}/items`,
      `${base}/items/{item_id}`,
      `${base}/responses/{response_id}/items`,
    ])
      assert.ok(hasDelegation(doc.paths[path].get.responses), path);
    assert.ok(hasDelegation(schemas.VoiceResponse.properties.output));
  }
});

const storedDelegation = {
  type: "live_delegation",
  id: "item_delegation_1",
  response_id: "resp_voice_1",
  created_at: 1791763200,
  delegation_id: "del_1",
  target: "client",
  offset_ms: 1200,
  status: "completed",
  capture_status: "complete",
  input: {
    source: "live_transcript_context",
    exact_backend_request_available: false,
    truncated: false,
    messages: [{ role: "user", text: "Please explain the past tense." }],
  },
  output: { responses: [], client_messages: [] },
};
const storedExamples = [
  {
    ...structuredClone(storedDelegation),
    status: "incomplete",
    output: {
      responses: [],
      client_messages: [
        {
          event_id: "evt_append",
          type: "session.instructions.append",
          content: "Explain went.",
          status: "unconfirmed",
        },
      ],
    },
  },
  {
    ...structuredClone(storedDelegation),
    target: "responses",
    output: {
      client_messages: [],
      responses: [
        {
          id: "resp_backend",
          model: "gpt-5.6-terra",
          status: "completed",
          text: "Use went.",
          output: [
            {
              type: "message",
              id: "msg_1",
              role: "assistant",
              content: [{ type: "output_text", text: "Use went." }],
            },
          ],
        },
      ],
    },
  },
  {
    ...structuredClone(storedDelegation),
    status: "cancelled",
    capture_status: "incomplete",
    capture_reason: "connection_lost",
    input: {
      source: "managed_responses_request",
      exact_backend_request_available: true,
      truncated: false,
      messages: [],
    },
    output: {
      responses: [],
      client_messages: [],
      managed_prompt_agent: {
        agent_name: "english-teacher",
        agent_version: "1",
        result_format: "tagged_text",
        status: "cancelled",
        error_code: "partial_cancelled_or_superseded",
        failure_context_status: "skipped",
        request: {
          input: "Please explain the past tense.",
          conversation: "conv_backend",
          stream: true,
        },
        output_items: acceptedOutput,
      },
    },
  },
].map((payload) => ({
  model: "Azure.AI.Projects.VoiceLiveDelegationConversationItem",
  payload,
}));

test("stored client, Responses, and managed delegation examples validate", async () => {
  const result = await validateExamples(
    "persisted-delegations",
    storedExamples,
  );
  checkErrors(result.diagnostics);
});

test("malformed persisted delegation payloads are rejected", async () => {
  const missingId = structuredClone(storedExamples[0]);
  delete missingId.payload.delegation_id;
  const invalidTarget = structuredClone(storedExamples[0]);
  invalidTarget.payload.target = "foundry_managed_agent";
  const invalidReceipt = structuredClone(storedExamples[0]);
  invalidReceipt.payload.output.client_messages[0].status = "completed";
  const invalidRequestFlag = structuredClone(storedExamples[2]);
  invalidRequestFlag.payload.input.exact_backend_request_available = "true";
  const result = await validateExamples("invalid-persisted-delegations", [
    missingId,
    invalidTarget,
    invalidReceipt,
    invalidRequestFlag,
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

test("stored execution fields distinguish omission from nullable transient events", () => {
  const execution = type(
    "Azure.AI.Projects.VoiceLiveManagedPromptAgentExecution",
  );
  for (const name of [
    "response_id",
    "error_code",
    "spoken_text",
    "background_context",
    "failure_context_status",
    "request",
    "output_items",
  ]) {
    assert.equal(execution.properties.get(name).optional, true, name);
  }
  const message = type("Azure.AI.Projects.VoiceLiveDelegationClientMessage");
  assert.equal(
    message.properties.get("status").type,
    type("Azure.AI.Projects.VoiceLiveDelegationClientMessageStatus"),
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
