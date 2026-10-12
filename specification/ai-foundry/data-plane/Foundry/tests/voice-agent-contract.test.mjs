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
import {
  createSdkContext,
  isInScope,
} from "@azure-tools/typespec-client-generator-core";

const project = resolve(dirname(fileURLToPath(import.meta.url)), "..");
const repo = resolve(project, "../../../..");
let output;
let program;
let native;
let compilerOptions;
const documents = [];
const managedStages = ["started", "progress", "completed", "failed", "cancel"];
const managedEventKinds = [...managedStages, "output_item"];
const managedModel = (stage) =>
  `Azure.AI.Projects.VoiceAgentLiveManagedDelegation${stage
    .split("_")
    .map((part) => part[0].toUpperCase() + part.slice(1))
    .join("")}Event`;
const managedItemModel =
  "Azure.AI.Projects.VoiceAgentLiveFoundryManagedAgentDelegationItem";

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
  const live = type("Azure.AI.Projects.VoiceAgentLiveDefinition");
  const realtime = type("Azure.AI.Projects.VoiceAgentRealtimeDefinition");
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

test("voice model renames remove legacy names and inline the single result-format value", () => {
  for (const name of [
    "RealtimeVoiceAgentDefinition",
    "LiveVoiceAgentDefinition",
    "VoiceAgentLiveManagedResultFormat",
    "VoiceAgentLiveFoundryManagedAgentDelegationMetadata",
    "VoiceAgentLiveFoundryManagedAgentDelegationConversationItem",
  ]) {
    const [removed] = program.resolveTypeReference(`Azure.AI.Projects.${name}`);
    assert.equal(removed, undefined, name);
  }
  assert.equal(fields(type(managedItemModel)).has("result_format"), false);
  const configuration = type(
    "Azure.AI.Projects.VoiceAgentLiveManagedAgentDelegation",
  ).properties.get("result_format");
  assert.equal(configuration.type.kind, "String");
  assert.equal(configuration.type.value, "tagged_text");
  assert.equal(configuration.optional, true);
  assert.equal(configuration.defaultValue.value, "tagged_text");
});

test("Live configuration references native model identities, not local copies", () => {
  const live = type("Azure.AI.Projects.VoiceAgentLiveDefinition");
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
      assert.deepEqual(extensions, managedEventKinds.map(managedModel).sort());
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

test("only the native server discriminator gains the six Foundry managed-delegation literals", () => {
  const ns = type("OpenAI", native);
  for (const [name, union] of ns.unions) {
    if (!name.startsWith("Live") && name !== "DelegationType") continue;
    const variants = (value) =>
      [...value.variants.values()].map((v) => getTypeName(v.type));
    const expected = variants(union);
    if (name === "LiveServerEventType") {
      expected.push(
        ...managedEventKinds.map((stage) =>
          JSON.stringify(`session.managed_agent_delegation.${stage}`),
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

test("managed lifecycle notifications contain only correlation and failure details", () => {
  for (const stage of managedStages) {
    const model = type(managedModel(stage));
    assert.equal(model.baseModel, type("OpenAI.LiveServerEvent"));
    const p = fields(model);
    assert.equal(
      p.get("type").type.value,
      `session.managed_agent_delegation.${stage}`,
    );
    assert.deepEqual(
      [...p.keys()].sort(),
      [
        "type",
        "event_id",
        "delegation_id",
        ...(stage === "failed" ? ["error_code", "error_message"] : []),
      ].sort(),
    );
    for (const field of ["event_id", "delegation_id"]) {
      assert.equal(p.get(field).optional, false, `${stage}.${field}`);
      assert.equal(getTypeName(p.get(field).type), "string");
    }
    for (const field of ["error_code", "error_message"]) {
      assert.equal(p.has(field), stage === "failed", `${stage}.${field}`);
      if (stage === "failed") {
        assert.equal(p.get(field).optional, false);
        assert.equal(getTypeName(p.get(field).type), "string");
      }
    }
  }
});

test("managed output_item streams an indexed result, not a delegation snapshot", () => {
  const model = type(managedModel("output_item"));
  assert.equal(model.baseModel, type("OpenAI.LiveServerEvent"));
  const p = fields(model);
  assert.deepEqual([...p.keys()].sort(), [
    "delegation_id",
    "event_id",
    "item",
    "output_index",
    "type",
  ]);
  for (const field of p.values()) assert.equal(field.optional, false);
  assert.equal(
    p.get("type").type.value,
    "session.managed_agent_delegation.output_item",
  );
  assert.equal(getTypeName(p.get("output_index").type), "int32");
  assert.equal(getMinValue(program, p.get("output_index")), 0);
  assert.equal(
    p.get("item").type,
    type("Azure.AI.Projects.VoiceAgentLiveDelegationResultItem"),
  );
  assert.ok(
    ![...type("OpenAI.LiveClientEventType").variants.values()].some(
      (v) => v.type.value === "session.managed_agent_delegation.output_item",
    ),
  );
});

test("managed delegation aggregate retains an ordered result list without event metadata", () => {
  const item = type(managedItemModel);
  assert.equal(
    item.baseModel,
    type("Azure.AI.Projects.VoiceAgentLiveDelegationConversationItem"),
  );
  const p = fields(item);
  for (const field of [
    "event_id",
    "delegation_id",
    "result_format",
    "commentary",
    "thinking",
  ])
    assert.equal(p.has(field), false, field);
  assert.equal(p.get("id").optional, false);
  assert.equal(p.get("output").optional, false);
  assert.equal(
    p.get("output").type.indexer.value,
    type("Azure.AI.Projects.VoiceAgentLiveDelegationResultItem"),
  );
  assert.equal(p.get("status").optional, false);
  assert.equal(p.get("backend_conversation_id").optional, true);
  for (const doc of documents) {
    const schema =
      doc.components.schemas.VoiceAgentLiveFoundryManagedAgentDelegationItem;
    assert.equal(schema.properties.output.type, "array");
    assert.equal(
      schema.properties.output.items.$ref,
      "#/components/schemas/VoiceAgentLiveDelegationResultItem",
    );
    assert.ok(schema.required.includes("output"));
    assert.equal(schema.properties.result_format, undefined);
    assert.equal(
      doc.components.schemas.VoiceAgentLiveDelegationConversationItem
        .discriminator.mapping.foundry_managed_agent,
      "#/components/schemas/VoiceAgentLiveFoundryManagedAgentDelegationItem",
    );
    assert.equal(
      doc.components.schemas
        .VoiceAgentLiveFoundryManagedAgentDelegationConversationItem,
      undefined,
    );
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
const resultText = { commentary: "Say: Yesterday I went to school." };
const samples = managedStages.map((stage) => {
  const payload = {
    type: `session.managed_agent_delegation.${stage}`,
    event_id: `evt_managed_${stage}`,
    delegation_id: "del_1",
  };
  if (stage === "failed")
    Object.assign(payload, {
      error_code: "partial_backend_timeout",
      error_message: "The backend timed out after some guidance was accepted.",
    });
  return { model: managedModel(stage), payload };
});
const outputSamples = [
  {
    delegation_id: "del_1",
    output_index: 0,
    item: { thinking: "Focus on irregular past-tense verbs." },
  },
  {
    delegation_id: "del_2",
    output_index: 0,
    item: { commentary: "Try a greeting." },
  },
  { delegation_id: "del_1", output_index: 1, item: resultText },
  {
    delegation_id: "del_1",
    output_index: 2,
    item: {
      commentary: "Now tell me what you ate yesterday.",
      thinking: "Move on to another irregular verb.",
    },
  },
].map((payload, index) => ({
  model: managedModel("output_item"),
  payload: {
    type: "session.managed_agent_delegation.output_item",
    event_id: `evt_output_${index}`,
    ...payload,
  },
}));
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
      (model.includes("Conversation") || model === managedItemModel),
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

test("lifecycle, streamed output, and native startup examples validate", async () => {
  const result = await validateExamples("valid-events", [
    ...samples,
    ...outputSamples,
  ]);
  checkErrors(result.diagnostics);
});

test("managed-agent events do not retain the old event-name prefix", async () => {
  const serverTypes = [...type("OpenAI.LiveServerEventType").variants.values()]
    .map((variant) => variant.type.value)
    .filter((value) => typeof value === "string");
  assert.ok(
    !serverTypes.some((value) =>
      value.startsWith("session.managed_delegation."),
    ),
  );
  for (const kind of managedEventKinds)
    assert.ok(serverTypes.includes(`session.managed_agent_delegation.${kind}`));

  const oldExamples = managedEventKinds.map((kind) => {
    const sample = structuredClone(
      kind === "output_item"
        ? outputSamples[0]
        : samples.find((sample) => sample.model === managedModel(kind)),
    );
    sample.payload.type = `session.managed_delegation.${kind}`;
    return sample;
  });
  const result = await validateExamples(
    "removed-managed-event-prefix",
    oldExamples,
  );
  const errors = result.diagnostics.filter((d) => d.severity === "error");
  assert.equal(errors.length, oldExamples.length);
  assert.ok(
    errors.every((d) => ["invalid-argument", "unassignable"].includes(d.code)),
  );
  for (const sample of oldExamples)
    assert.ok(
      errors.some((d) => d.message.includes(sample.payload.type)),
      sample.payload.type,
    );
});

test("malformed lifecycle payloads are rejected by the actual TypeSpec models", async () => {
  const missingDelegationId = structuredClone(
    samples.find((s) => s.payload.type.endsWith(".cancel")),
  );
  delete missingDelegationId.payload.delegation_id;
  const invalidIndex = structuredClone(outputSamples[0]);
  invalidIndex.payload.output_index = "one";
  const invalidResult = structuredClone(outputSamples[0]);
  invalidResult.payload.item.commentary = { content: "Not a plain string" };
  const invalidFailure = structuredClone(
    samples.find((s) => s.payload.type.endsWith(".failed")),
  );
  invalidFailure.payload.error_code = 42;
  const result = await validateExamples("invalid-events", [
    missingDelegationId,
    invalidIndex,
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

test("streamed output requires correlation, an integer index, and one typed item", async (t) => {
  const cases = [
    [
      "missing delegation ID",
      (p) => {
        delete p.delegation_id;
      },
    ],
    [
      "missing output index",
      (p) => {
        delete p.output_index;
      },
    ],
    [
      "fractional output index",
      (p) => {
        p.output_index = 0.5;
      },
    ],
    [
      "missing result item",
      (p) => {
        delete p.item;
      },
    ],
    [
      "list instead of one result",
      (p) => {
        p.item = [p.item];
      },
    ],
    [
      "nullable result text",
      (p) => {
        p.item.thinking = null;
      },
    ],
    [
      "legacy result format",
      (p) => {
        p.result_format = "tagged_text";
      },
    ],
  ];
  for (const [index, [name, mutate]] of cases.entries()) {
    await t.test(name, async () => {
      const sample = structuredClone(outputSamples[0]);
      mutate(sample.payload);
      const result = await validateExamples(`invalid-stream-output-${index}`, [
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

test("lifecycle notifications reject copied delegation metadata and result text", async (t) => {
  for (const stage of [
    "started",
    "progress",
    "completed",
    "failed",
    "cancel",
  ]) {
    await t.test(stage, async () => {
      const sample = structuredClone(
        samples.find((s) => s.payload.type.endsWith(`.${stage}`)),
      );
      Object.assign(sample.payload, {
        agent_name: "english-teacher",
        result_format: "tagged_text",
        commentary: "Must be sent as an output_item, not in a lifecycle event.",
      });
      const result = await validateExamples(
        `invalid-lifecycle-snapshot-${stage}`,
        [sample],
      );
      const errors = result.diagnostics.filter((d) => d.severity === "error");
      assert.ok(errors.length > 0, stage);
      assert.ok(
        errors.every((d) =>
          ["invalid-argument", "unexpected-property"].includes(d.code),
        ),
        errors.map((d) => `${d.code}: ${d.message}`).join("\n"),
      );
    });
  }
});

test("failure notifications require string error code and message", async (t) => {
  const failed = samples.find((s) => s.payload.type.endsWith(".failed"));
  checkErrors(
    (await validateExamples("failure-without-results", [failed])).diagnostics,
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
  const voice = model("VoiceAgentDefinition");
  assert.equal(model("VoiceAgentRealtimeDefinition").baseModel, voice);
  assert.equal(model("VoiceAgentLiveDefinition").baseModel, voice);
  assert.deepEqual(Object.keys(voice.discriminatedSubtypes).sort(), [
    "live",
    "realtime",
  ]);
  for (const name of [
    "RealtimeVoiceAgentDefinition",
    "LiveVoiceAgentDefinition",
  ])
    assert.ok(
      !context.sdkPackage.models.some((m) => m.__raw?.name === name),
      name,
    );
  for (const stage of managedEventKinds) {
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
      "result_format",
      "agent_name",
      "agent_version",
      "response_id",
      "backend_conversation_id",
      "offset_ms",
      "output",
      "commentary",
      "thinking",
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
  ]) {
    const stored = model(`VoiceAgentLive${name}DelegationConversationItem`);
    assert.equal(stored.baseModel, delegation);
    for (const field of textFields)
      assert.equal(
        stored.properties.find((p) => p.serializedName === field).type.kind,
        "string",
      );
  }
  const managed = model("VoiceAgentLiveFoundryManagedAgentDelegationItem");
  assert.equal(managed.baseModel, delegation);
  assert.equal(delegation.discriminatedSubtypes.foundry_managed_agent, managed);
  const outputArray = managed.properties.find(
    (p) => p.serializedName === "output",
  );
  assert.equal(outputArray.optional, false);
  assert.equal(outputArray.type.kind, "array");
  const resultItem = model("VoiceAgentLiveDelegationResultItem");
  assert.equal(outputArray.type.valueType, resultItem);
  const outputEvent = model("VoiceAgentLiveManagedDelegationOutputItemEvent");
  assert.equal(
    outputEvent.properties.find((p) => p.serializedName === "item").type,
    resultItem,
  );
  assert.equal(
    outputEvent.properties.find((p) => p.serializedName === "output_index").type
      .kind,
    "int32",
  );
  assert.ok(
    !context.sdkPackage.models.some(
      (m) =>
        m.__raw?.name ===
        "VoiceAgentLiveFoundryManagedAgentDelegationConversationItem",
    ),
  );
  for (const name of [
    "event_id",
    "delegation_id",
    "result_format",
    "commentary",
    "thinking",
  ])
    assert.ok(!managed.properties.some((p) => p.serializedName === name), name);
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

test("Java SDK customization targets Realtime fields and keeps Live events without HTTP upgrade methods", async () => {
  const entrypoint = join(project, "src/sdk-java-azure-ai-agents/client.tsp");
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
    "@azure-tools/typespec-java",
  );
  checkErrors(context.diagnostics);
  const model = (name) => {
    const value = context.sdkPackage.models.find((m) => m.__raw?.name === name);
    assert.ok(value, `Java SDK metadata missing ${name}`);
    return value;
  };

  const realtime = type(
    "Azure.AI.Projects.VoiceAgentRealtimeDefinition",
    sdkProgram,
  );
  assert.equal(
    realtime.properties.get("tool_choice").type.name,
    "ToolChoiceValue",
  );
  assert.equal(
    model("VoiceAgentRealtimeDefinition").properties.find(
      (p) => p.serializedName === "subagent_config",
    ).name,
    "subagentConfiguration",
  );
  assert.equal(
    fields(type("Azure.AI.Projects.VoiceAgentDefinition", sdkProgram)).has(
      "tool_choice",
    ),
    false,
  );
  assert.equal(
    fields(type("Azure.AI.Projects.VoiceAgentLiveDefinition", sdkProgram)).has(
      "tool_choice",
    ),
    false,
  );

  for (const name of [
    "Azure.AI.Projects.VoiceAgentWebSocket.connectVoiceAgent",
    "Azure.AI.Projects.VoiceAgentLiveWebSocket.connectLiveVoiceAgent",
  ])
    assert.equal(isInScope(context, type(name, sdkProgram)), false, name);
  for (const name of ["LiveClientEvent", "LiveServerEvent"]) {
    assert.equal(model(name).access, "public");
  }
  for (const kind of managedEventKinds) {
    const event = model(managedModel(kind).split(".").at(-1));
    assert.equal(event.baseModel, model("LiveServerEvent"));
    assert.equal(
      event.discriminatorValue,
      `session.managed_agent_delegation.${kind}`,
    );
  }
});

test("cancel is server-only and the removed request event has no typed variant", () => {
  const literals = (root) =>
    [...type(root).variants.values()].map((v) => v.type.value);
  assert.ok(
    literals("OpenAI.LiveServerEventType").includes(
      "session.managed_agent_delegation.cancel",
    ),
  );
  assert.ok(
    !literals("OpenAI.LiveServerEventType").includes(
      "session.managed_agent_delegation.request",
    ),
  );
  assert.ok(
    !literals("OpenAI.LiveClientEventType").includes(
      "session.managed_agent_delegation.cancel",
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
  const managed = type(managedItemModel);
  assert.equal(managed.baseModel, item);
  assert.equal(
    managed.properties.get("target").type.value,
    "foundry_managed_agent",
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
const managedIdentity = {
  agent_name: "english-teacher",
  agent_version: "1",
  offset_ms: 1200,
};
const managedOutput = outputSamples
  .filter((sample) => sample.payload.delegation_id === storedDelegation.id)
  .map((sample) => sample.payload.item);
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
    ...managedIdentity,
    target: "foundry_managed_agent",
    status: "completed",
    response_id: "resp_managed_1",
    backend_conversation_id: "conv_backend",
    delegation_context: "The learner asked how to describe yesterday's trip.",
    output: managedOutput,
  },
  {
    ...storedDelegation,
    ...managedIdentity,
    target: "foundry_managed_agent",
    status: "cancelled",
    output: managedOutput.slice(0, 1),
    delegation_context:
      "The learner changed the question before the backend finished.",
  },
  {
    ...storedDelegation,
    ...managedIdentity,
    target: "foundry_managed_agent",
    status: "in_progress",
    output: [],
  },
  {
    ...storedDelegation,
    ...managedIdentity,
    target: "foundry_managed_agent",
    status: "failed",
    output: managedOutput.slice(0, 2),
  },
].map((payload) => ({
  model:
    payload.target === "foundry_managed_agent"
      ? managedItemModel
      : `Azure.AI.Projects.VoiceAgentLive${payload.target === "client" ? "Client" : "Responses"}DelegationConversationItem`,
  payload,
}));

test("speech, partial capture, and target-specific delegation examples validate", async () => {
  const result = await validateExamples("persisted-live-items", [
    ...speechExamples,
    ...storedExamples,
  ]);
  checkErrors(result.diagnostics);
});

test("streamed result indices map to the managed aggregate independently per delegation", async () => {
  const collected = new Map();
  for (const { payload } of outputSamples) {
    const output = collected.get(payload.delegation_id) ?? [];
    assert.equal(payload.output_index, output.length);
    output.push(payload.item);
    collected.set(payload.delegation_id, output);
  }
  assert.deepEqual(collected.get("del_1"), storedExamples[3].payload.output);
  assert.equal(collected.get("del_2").length, 1);
  // Validate the second independent aggregate too, including the shared result identity.
  const second = structuredClone(storedExamples[3]);
  second.payload.id = "del_2";
  second.payload.output = collected.get("del_2");
  checkErrors(
    (await validateExamples("interleaved-delegation-output", [second]))
      .diagnostics,
  );
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
      "missing managed result list",
      storedExamples[3],
      (p) => {
        delete p.output;
      },
    ],
    [
      "object instead of a managed result list",
      storedExamples[3],
      (p) => {
        p.output = resultText;
      },
    ],
    [
      "null managed result entry",
      storedExamples[3],
      (p) => {
        p.output = [null];
      },
    ],
    [
      "invalid managed result entry",
      storedExamples[3],
      (p) => {
        p.output[0].thinking = ["Not a string"];
      },
    ],
    [
      "flattened managed result text",
      storedExamples[3],
      (p) => {
        p.commentary = "Use an output item.";
      },
    ],
    [
      "removed result format on managed item",
      storedExamples[3],
      (p) => {
        p.result_format = "tagged_text";
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
  ])
    for (const name of names)
      assert.equal(
        type(
          `Azure.AI.Projects.VoiceAgentLive${subtype}DelegationConversationItem`,
        ).properties.get(name).optional,
        true,
        `${subtype}.${name}`,
      );
  assert.equal(
    type(managedItemModel).properties.get("delegation_context").optional,
    true,
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
    const live = schemas.VoiceAgentLiveDefinition;
    assert.equal(base.discriminator.propertyName, "sub_protocol");
    assert.deepEqual(base.discriminator.mapping, {
      realtime: "#/components/schemas/VoiceAgentRealtimeDefinition",
      live: "#/components/schemas/VoiceAgentLiveDefinition",
    });
    assert.equal(schemas.RealtimeVoiceAgentDefinition, undefined);
    assert.equal(schemas.LiveVoiceAgentDefinition, undefined);
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
