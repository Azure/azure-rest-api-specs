import assert from "node:assert/strict";
import { mkdtemp, readFile, rm, symlink, writeFile } from "node:fs/promises";
import { tmpdir } from "node:os";
import { dirname, join, resolve } from "node:path";
import { after, before, test } from "node:test";
import { fileURLToPath } from "node:url";
import {
  compile,
  getDiscriminator,
  getDoc,
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
const retiredEventKinds = [
  "started",
  "progress",
  "completed",
  "failed",
  "cancel",
  "output_item",
];
const retiredEventModels = ["Managed", "Hosted"].flatMap((kind) =>
  retiredEventKinds.map(
    (stage) =>
      `VoiceAgentLive${kind}Delegation${stage
        .split("_")
        .map((part) => part[0].toUpperCase() + part.slice(1))
        .join("")}Event`,
  ),
);
const managedItemModel =
  "Azure.AI.Projects.VoiceAgentLiveFoundryManagedAgentDelegationItem";
const deferredHostedTypes = [
  "VoiceAgentLiveHostedAgentDelegation",
  "VoiceAgentLiveFoundryHostedAgentDelegationItem",
];
const backendEnvelopeModel = "OpenAI.LiveServerEventLiveResponseEvent";
const nativeEventModels = {
  "session.delegation.created": "OpenAI.LiveServerEventLiveDelegationCreated",
  "response.event": backendEnvelopeModel,
  "session.thinking.appended": "OpenAI.LiveServerEventLiveThinkingAppended",
  "session.commentary.appended": "OpenAI.LiveServerEventLiveCommentaryAppended",
  error: "OpenAI.LiveServerEventLiveErrorEvent",
};
// Test greeting without @example's agent-discriminator conversions.
const liveGreetingProbe = [
  'model LiveGreetingProbe { ...PickProperties<Azure.AI.Projects.VoiceAgentLiveDefinition, "greeting">; }',
];
const liveDelegationProbe = [
  'model LiveDelegationProbe { ...PickProperties<Azure.AI.Projects.VoiceAgentLiveDefinition, "delegation">; }',
];
const originalVoiceDefinitionDoc = [
  "The voice agent definition. Its configuration (model, instructions, audio, tools, and optional avatar) drives a",
  "managed speech-to-speech experience. Establish realtime voice sessions through",
  "`GET /agents/{agent_name}/endpoint/protocols/voice`. Every create or update produces a new immutable version.",
].join("\n");
const realtimeVoiceFields = [
  "sub_protocol",
  "model_type",
  "model",
  "conversation_engine",
  "greeting",
  "audio",
  "output_modalities",
  "max_output_tokens",
  "include",
  "interim_response",
  "avatar",
  "tools",
  "tool_choice",
  "parallel_tool_calls",
  "subagent_config",
];

function type(name, context = program) {
  const [value, diagnostics] = context.resolveTypeReference(name);
  assert.equal(
    diagnostics.length,
    0,
    diagnostics.map((d) => `${d.code}: ${d.message}`).join("\n"),
  );
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

function checkInvalidExample(diagnostics) {
  const errors = diagnostics.filter((d) => d.severity === "error");
  assert.ok(errors.length > 0);
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

function checkNativeSdkEvents(context) {
  const models = context.sdkPackage.models;
  const root = models.find((m) => m.__raw?.name === "LiveServerEvent");
  for (const [eventType, name] of Object.entries(nativeEventModels)) {
    const model = models.find((m) => m.__raw?.name === name.split(".").at(-1));
    assert.ok(model, `Missing native SDK event: ${name}`);
    assert.equal(model.access, "public");
    assert.equal(model.baseModel, root);
    assert.equal(model.discriminatorValue, eventType);
  }
  for (const name of retiredEventModels)
    assert.ok(!models.some((m) => m.__raw?.name === name), name);
  for (const eventType of Object.keys(root.discriminatedSubtypes))
    assert.ok(
      !/^session\.(managed_agent|hosted_agent|managed)_delegation\./.test(
        eventType,
      ),
    );
}

function checkSdkGreetingModels(context) {
  const model = (name) => {
    const value = context.sdkPackage.models.find((m) => m.__raw?.name === name);
    assert.ok(value, `SDK metadata missing ${name}`);
    return value;
  };
  const greeting = model("VoiceAgentLiveDefinition").properties.find(
    (p) => p.serializedName === "greeting",
  );
  assert.equal(greeting.optional, true);
  assert.equal(greeting.type, model("VoiceAgentTemplateGreetingConfig"));
  assert.equal(greeting.type.discriminatorValue, "template");
  assert.equal(
    model("VoiceAgentDefinition").properties.find(
      (p) => p.serializedName === "greeting",
    ).type,
    model("VoiceAgentGreetingConfig"),
  );
  assert.deepEqual(
    Object.keys(model("VoiceAgentGreetingConfig").discriminatedSubtypes).sort(),
    ["llm_generated", "template"],
  );
  assert.ok(
    !model("VoiceAgentBaseDefinition").properties.some(
      (p) => p.serializedName === "greeting",
    ),
  );
}

function checkSdkSessionFields(context) {
  const model = (name) => {
    const value = context.sdkPackage.models.find((m) => m.__raw?.name === name);
    assert.ok(value, `SDK metadata missing ${name}`);
    return value;
  };
  for (const name of [
    "VoiceAgentBaseDefinition",
    "VoiceAgentDefinition",
    "VoiceAgentLiveDefinition",
  ])
    for (const field of ["input", "client"])
      assert.ok(
        !model(name).properties.some((p) => p.serializedName === field),
        `${name}.${field}`,
      );
  for (const name of ["LiveSessionCreateParams", "LiveSessionResourceParam"]) {
    const properties = model(name).properties;
    const input = properties.find((p) => p.serializedName === "input");
    assert.equal(input.optional, true);
    assert.equal(input.type.kind, "array");
    assert.equal(input.type.valueType, model("LiveInitialItem"));
    const client = properties.find((p) => p.serializedName === "client");
    assert.equal(client.optional, true);
    assert.equal(client.type, model("LiveClientConfigParam"));
  }
  assert.equal(
    model("LiveSessionStartEvent").properties.find(
      (p) => p.serializedName === "session",
    ).type,
    model("LiveSessionCreateParams"),
  );
}

function checkSdkVoiceInheritance(context) {
  const model = (name) => {
    const value = context.sdkPackage.models.find((m) => m.__raw?.name === name);
    assert.ok(value, `SDK metadata missing ${name}`);
    return value;
  };
  const voice = model("VoiceAgentBaseDefinition");
  const definition = model("AgentDefinition");
  assert.equal(voice.baseModel, definition);
  assert.equal(definition.discriminatedSubtypes.voice, voice);
  // OpenAPI metadata does not implement SDK subtype dispatch.
  assert.equal(voice.discriminatorProperty, undefined);
  assert.deepEqual(Object.keys(voice.discriminatedSubtypes ?? {}), []);
  for (const [name, optional] of [
    ["VoiceAgentBaseDefinition", true],
    ["VoiceAgentDefinition", true],
    ["VoiceAgentLiveDefinition", false],
  ]) {
    // Public SDK names come from model declarations, not language-specific aliases.
    assert.equal(model(name).name, name);
    assert.equal(model(name).access, "public", name);
    assert.equal(
      model(name).properties.find((p) => p.serializedName === "sub_protocol")
        .optional,
      optional,
      name,
    );
  }
  assert.equal(model("VoiceAgentDefinition").baseModel, voice);
  assert.equal(model("VoiceAgentLiveDefinition").baseModel, voice);
  assert.ok(
    !context.sdkPackage.models.some(
      (m) =>
        m.name === "VoiceAgentRealtimeDefinition" ||
        m.__raw?.name === "VoiceAgentRealtimeDefinition",
    ),
  );
  const realtimeProperties = model("VoiceAgentDefinition").properties;
  assert.deepEqual(
    realtimeProperties.map((p) => p.serializedName),
    realtimeVoiceFields,
  );
  assert.ok(realtimeProperties.every((p) => p.optional));
  for (const name of [
    "VoiceAgentDefinition",
    "VoiceAgentLiveDefinition",
  ])
    assert.equal(
      model(name).doc,
      getDoc(program, type(`Azure.AI.Projects.${name}`)),
    );
  assert.ok(
    !context.sdkPackage.unions.some((u) =>
      [
        "VoiceAgentBaseDefinition",
        "VoiceAgentDefinition",
        "AgentDefinitionUnion",
      ].includes(u.__raw?.name),
    ),
  );
  for (const name of [
    "PromptAgentDefinition",
    "HostedAgentDefinition",
    "WorkflowAgentDefinition",
    "ExternalAgentDefinition",
  ]) {
    assert.equal(model(name).baseModel, definition, name);
  }
  assert.equal(
    model("AgentVersionObject").properties.find(
      (p) => p.serializedName === "definition",
    ).type,
    definition,
  );
  // Python flattens the request model into method parameters.
  const clients = [...context.sdkPackage.clients];
  const methods = [];
  for (let i = 0; i < clients.length; i++) {
    methods.push(...clients[i].methods);
    clients.push(...(clients[i].children ?? []));
  }
  const create = methods.find(
    (m) => m.operation?.__raw.operation.name === "createAgentVersion",
  );
  assert.ok(create, "Missing createAgentVersion SDK method");
  assert.equal(
    create.operation.bodyParam.type.properties.find(
      (p) => p.serializedName === "definition",
    ).type,
    definition,
  );
}

function checkSdkLiveDelegation(context) {
  const model = (name) => {
    const value = context.sdkPackage.models.find((m) => m.__raw?.name === name);
    assert.ok(value, `SDK metadata missing ${name}`);
    return value;
  };
  const delegation = model("VoiceAgentLiveDefinition").properties.find(
    (p) => p.serializedName === "delegation",
  );
  assert.equal(delegation.optional, true);
  assert.equal(delegation.type.kind, "union");
  assert.deepEqual(
    delegation.type.variantTypes.map((v) => v.__raw.name).sort(),
    [
      "LiveClientDelegationParam",
      "LiveResponsesDelegationParam",
      "VoiceAgentLiveManagedAgentDelegation",
    ],
  );
  const version = model("VoiceAgentLiveManagedAgentDelegation").properties.find(
    (p) => p.serializedName === "agent_version",
  );
  assert.equal(version.optional, true);
  assert.equal(version.type.kind, "string");
  for (const name of deferredHostedTypes)
    assert.ok(
      !context.sdkPackage.models.some((m) => m.__raw?.name === name),
      name,
    );
  assert.equal(
    model("VoiceHostedAgentConversationEngine").discriminatorValue,
    "hosted_agent",
  );
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

  // Compare against the pinned OpenAI package without Foundry extensions.
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
      // Match Foundry's scalar mappings in the native baseline.
      `import ${JSON.stringify(join(project, "src/common/custom-types.tsp"))};`,
    ].join("\n"),
  );
  native = await compile(NodeHost, nativeEntry, { noEmit: true });
  checkErrors(native.diagnostics);
});

after(async () => {
  if (output) await rm(output, { recursive: true, force: true });
});

test("voice subtype docs preserve the original Realtime description and parallel Live guidance", () => {
  const realtime = type("Azure.AI.Projects.VoiceAgentDefinition");
  const live = type("Azure.AI.Projects.VoiceAgentLiveDefinition");
  assert.equal(getDoc(program, realtime), originalVoiceDefinitionDoc);
  const liveDoc = getDoc(program, live);
  assert.ok(liveDoc.startsWith("The Live voice agent definition."));
  for (const text of [
    "model, instructions, audio, and delegation",
    "Foundry GPT Live deployment",
    "`GET /agents/{agent_name}/endpoint/protocols/voice/live/sessions`",
    "Every create or update produces a new immutable version.",
  ])
    assert.ok(liveDoc.includes(text), text);
  assert.doesNotMatch(liveDoc, /\bnative\b/i);
  assert.equal(
    getDoc(program, live.properties.get("sub_protocol")),
    "Selects the Live protocol.",
  );
  for (const doc of documents)
    for (const model of [realtime, live])
      assert.equal(
        doc.components.schemas[model.name].description,
        getDoc(program, model),
      );
});

test("voice models retain inheritance and optional protocol fields with separate audio ownership", () => {
  const base = type("Azure.AI.Projects.VoiceAgentBaseDefinition");
  const live = type("Azure.AI.Projects.VoiceAgentLiveDefinition");
  const realtime = type("Azure.AI.Projects.VoiceAgentDefinition");
  assert.equal(base.kind, "Model");
  assert.equal(getDiscriminator(program, base), undefined);
  assert.equal(getDiscriminator(program, base.baseModel).propertyName, "kind");
  assert.equal(live.baseModel, base);
  assert.equal(realtime.baseModel, base);
  assert.equal(base.properties.has("audio"), false);
  assert.equal(live.properties.get("sub_protocol").type.value, "live");
  assert.equal(live.properties.get("sub_protocol").optional, false);
  assert.equal(realtime.properties.get("sub_protocol").type.value, "realtime");
  for (const model of [base, realtime]) {
    assert.equal(model.properties.get("sub_protocol").optional, true);
    assert.equal(model.properties.get("sub_protocol").defaultValue, undefined);
  }
  assert.equal(
    realtime.properties.get("audio").type,
    type("Azure.AI.Projects.VoiceAgentAudioConfig"),
  );
  assert.ok(realtime.properties.has("tool_choice"));
  assert.ok(realtime.properties.has("subagent_config"));
});

test("VoiceAgentDefinition retains the original Realtime fields without SDK name aliases", () => {
  const base = type("Azure.AI.Projects.VoiceAgentBaseDefinition");
  const realtime = type("Azure.AI.Projects.VoiceAgentDefinition");
  const live = type("Azure.AI.Projects.VoiceAgentLiveDefinition");
  assert.deepEqual([...base.properties.keys()], [
    "kind",
    "sub_protocol",
    "instructions",
    "structured_inputs",
    "store",
  ]);
  assert.deepEqual([...realtime.properties.keys()], realtimeVoiceFields);
  assert.ok([...realtime.properties.values()].every((p) => p.optional));
  for (const model of [base, realtime, live]) {
    assert.equal(model.kind, "Model");
    assert.equal(model.node.id.sv, model.name);
    assert.ok(
      !model.decorators.some((d) => d.definition?.name === "@clientName"),
      model.name,
    );
  }
});

test("shared request and response definitions retain the original AgentDefinition model", () => {
  const definition = type("Azure.AI.Projects.AgentDefinition");
  const voice = type("Azure.AI.Projects.VoiceAgentBaseDefinition");
  assert.equal(definition.kind, "Model");
  assert.equal(getDiscriminator(program, definition).propertyName, "kind");
  assert.equal(voice.baseModel, definition);
  for (const name of [
    "CreateAgentVersionRequest",
    "CreateAgentRequest",
    "UpdateAgentRequest",
    "AgentVersionObject",
  ])
    assert.equal(
      fields(type(`Azure.AI.Projects.${name}`)).get("definition").type,
      definition,
      name,
    );
  for (const name of ["AgentDefinitionUnion", "VoiceAgentDefinitionBase"])
    assert.equal(
      program.resolveTypeReference(`Azure.AI.Projects.${name}`)[0],
      undefined,
      name,
    );
});

test("voice model renames remove legacy names and the result-format alias", () => {
  for (const name of [
    "VoiceAgentRealtimeDefinition",
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
  for (const [name, model] of type("Azure.AI.Projects").models) {
    if (name.startsWith("VoiceAgentLive"))
      assert.equal(fields(model).has("result_format"), false, name);
  }
});

test("Live configuration references native model identities, not local copies", () => {
  const live = type("Azure.AI.Projects.VoiceAgentLiveDefinition");
  assert.equal(
    live.properties.get("audio").type,
    type("OpenAI.LiveInitialSessionAudioParam"),
  );
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

test("Live delegation and managed version are optional but non-nullable", () => {
  const delegation = type(
    "Azure.AI.Projects.VoiceAgentLiveDefinition",
  ).properties.get("delegation");
  assert.equal(delegation.optional, true);
  assert.equal(delegation.defaultValue, undefined);
  assert.equal(
    delegation.type,
    type("Azure.AI.Projects.VoiceAgentLiveDelegation"),
  );
  const version = type(
    "Azure.AI.Projects.VoiceAgentLiveManagedAgentDelegation",
  ).properties.get("agent_version");
  assert.equal(version.optional, true);
  assert.equal(version.defaultValue, undefined);
  assert.equal(getTypeName(version.type), "string");
  for (const doc of documents) {
    const schemas = doc.components.schemas;
    const live = schemas.VoiceAgentLiveDefinition;
    assert.ok(!live.required.includes("delegation"));
    assert.equal(
      live.properties.delegation.$ref,
      "#/components/schemas/VoiceAgentLiveDelegation",
    );
    assert.equal(live.properties.delegation.anyOf, undefined);
    assert.equal(live.properties.delegation.nullable, undefined);
    assert.deepEqual(
      schemas.VoiceAgentLiveDelegation.oneOf.map((v) => v.$ref),
      [
        "#/components/schemas/OpenAI.LiveClientDelegationParam",
        "#/components/schemas/OpenAI.LiveResponsesDelegationParam",
        "#/components/schemas/VoiceAgentLiveManagedAgentDelegation",
      ],
    );
    const managed = schemas.VoiceAgentLiveManagedAgentDelegation;
    assert.ok(!managed.required.includes("agent_version"));
    assert.equal(managed.properties.agent_version.type, "string");
    assert.equal(managed.properties.agent_version.nullable, undefined);
    assert.equal(
      managed.properties.agent_version.pattern,
      getPattern(program, version),
    );
  }
});

test("Live hosted delegation is absent while the Realtime hosted engine remains", () => {
  for (const name of [
    ...deferredHostedTypes,
    "VoiceAgentLiveFoundryAgentDelegationFields",
  ]) {
    const [removed] = program.resolveTypeReference(`Azure.AI.Projects.${name}`);
    assert.equal(removed, undefined, name);
    for (const doc of documents)
      assert.equal(doc.components.schemas[name], undefined, name);
  }
  const engine = type("Azure.AI.Projects.VoiceHostedAgentConversationEngine");
  assert.equal(
    type("Azure.AI.Projects.VoiceAgentDefinition").properties.get(
      "conversation_engine",
    ).type,
    engine.baseModel,
  );
  assert.equal(engine.properties.get("type").type.value, "hosted_agent");
  for (const doc of documents) {
    assert.ok(!JSON.stringify(doc).includes("foundry_hosted_agent"));
    assert.equal(
      doc.components.schemas.VoiceHostedAgentConversationEngine.properties.type
        .enum[0],
      "hosted_agent",
    );
  }
});

test("input and client permissions belong to native sessions, not persisted voice definitions", () => {
  for (const name of [
    "VoiceAgentBaseDefinition",
    "VoiceAgentDefinition",
    "VoiceAgentLiveDefinition",
  ])
    for (const field of ["input", "client"])
      assert.equal(
        fields(type(`Azure.AI.Projects.${name}`)).has(field),
        false,
        `${name}.${field}`,
      );
  for (const name of ["LiveSessionCreateParams", "LiveSessionResourceParam"]) {
    const p = fields(type(`OpenAI.${name}`));
    assert.equal(p.get("input").optional, true);
    assert.equal(
      p.get("input").type.indexer.value,
      type("OpenAI.LiveInitialItem"),
    );
    assert.equal(getMaxItems(program, p.get("input")), 128);
    assert.equal(p.get("client").optional, true);
    assert.equal(p.get("client").type, type("OpenAI.LiveClientConfigParam"));
  }
  assert.equal(
    fields(type("OpenAI.LiveSessionStartEvent")).get("session").type,
    type("OpenAI.LiveSessionCreateParams"),
  );
});

test("Live greeting reuses only the existing template subtype while Realtime retains both modes", () => {
  const live = type("Azure.AI.Projects.VoiceAgentLiveDefinition");
  const template = type("Azure.AI.Projects.VoiceAgentTemplateGreetingConfig");
  const greeting = live.properties.get("greeting");
  assert.equal(greeting.optional, true);
  assert.equal(greeting.defaultValue, undefined);
  assert.equal(greeting.type, template);
  assert.equal(fields(template).get("type").type.value, "template");
  assert.equal(fields(template).get("text").optional, false);
  assert.equal(getMinLength(program, fields(template).get("text")), 1);
  assert.deepEqual([...fields(template).keys()].sort(), ["text", "type"]);
  const root = type("Azure.AI.Projects.VoiceAgentGreetingConfig");
  assert.equal(
    type("Azure.AI.Projects.VoiceAgentDefinition").properties.get(
      "greeting",
    ).type,
    root,
  );
  assert.deepEqual(
    root.derivedModels.map((m) => m.properties.get("type").type.value).sort(),
    ["llm_generated", "template"],
  );
  assert.ok(
    !fields(type("Azure.AI.Projects.VoiceAgentBaseDefinition")).has("greeting"),
  );
  for (const name of ["LiveSessionCreateParams", "LiveSessionUpdateParams"])
    assert.ok(!fields(type(`OpenAI.${name}`)).has("greeting"), name);
  for (const doc of documents) {
    const schemas = doc.components.schemas;
    assert.equal(
      schemas.VoiceAgentLiveDefinition.properties.greeting.$ref,
      "#/components/schemas/VoiceAgentTemplateGreetingConfig",
    );
    assert.ok(!schemas.VoiceAgentLiveDefinition.required.includes("greeting"));
    assert.equal(
      schemas.VoiceAgentTemplateGreetingConfig.properties.text.minLength,
      1,
    );
    assert.equal(
      schemas.VoiceAgentDefinition.properties.greeting.$ref,
      "#/components/schemas/VoiceAgentGreetingConfig",
    );
  }
});

test("Responses model remains a native string while Foundry documents deployment-name semantics", () => {
  const live = type("Azure.AI.Projects.VoiceAgentLiveDefinition");
  assert.match(
    getDoc(program, live.properties.get("delegation")),
    /responses\.model.*deployment name/,
  );
  assert.match(
    getDoc(program, live.properties.get("model")),
    /deployment name/,
  );
  for (const name of [
    "LiveResponsesDelegationSettingsInputParam",
    "LiveResponsesDelegationSettingsUpdateInputParam",
  ]) {
    const settings = type(`OpenAI.${name}`);
    assert.equal(getTypeName(settings.properties.get("model").type), "string");
    assert.deepEqual(
      wireShape(settings, program),
      wireShape(type(`OpenAI.${name}`, native), native),
    );
  }
  for (const doc of documents)
    assert.match(
      doc.components.schemas.VoiceAgentLiveDefinition.properties.delegation
        .description,
      /deployment name.*not a model catalog ID/,
    );
});

test("managed prompt-agent configuration contains only target identity", () => {
  const config = type("Azure.AI.Projects.VoiceAgentLiveManagedAgentDelegation");
  const p = config.properties;
  assert.deepEqual([...p.keys()], ["type", "agent_name", "agent_version"]);
  assert.equal(p.get("type").type.value, "foundry_managed_agent");
  assert.equal(p.get("agent_name").optional, false);
  assert.equal(p.get("agent_version").optional, true);
  assert.equal(p.has("result_format"), false);
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
    choices.some((name) => /Managed|Hosted/.test(name)),
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

test("native Live models change only through optional Foundry session correlation", () => {
  const ns = type("OpenAI", native);
  let checked = 0;
  for (const [name, model] of ns.models) {
    if (!name.startsWith("Live")) continue;
    const actual = wireShape(type(`OpenAI.${name}`), program);
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

test("all native Live event discriminators remain identical to the published package", () => {
  const ns = type("OpenAI", native);
  for (const [name, union] of ns.unions) {
    if (!name.startsWith("Live") && name !== "DelegationType") continue;
    const variants = (value) =>
      [...value.variants.values()].map((v) => getTypeName(v.type));
    const expected = variants(union);
    assert.deepEqual(variants(type(`OpenAI.${name}`)), expected, name);
  }
});

test("custom delegation lifecycle and output-item types are absent from the contract", () => {
  for (const name of [
    ...retiredEventModels,
    "VoiceAgentLiveServerEventTypeExtension",
    "VoiceAgentLiveManagedDelegationEventCorrelation",
  ]) {
    const [removed] = program.resolveTypeReference(`Azure.AI.Projects.${name}`);
    assert.equal(removed, undefined, name);
    for (const document of documents)
      assert.equal(document.components.schemas[name], undefined, name);
  }
  const serverTypes = [
    ...type("OpenAI.LiveServerEventType").variants.values(),
  ].map((v) => v.type.value);
  for (const kind of ["managed_agent", "hosted_agent", "managed"])
    for (const stage of [...retiredEventKinds, "request"])
      assert.ok(!serverTypes.includes(`session.${kind}_delegation.${stage}`));
  // Do not replace the removed extensions with invented native lifecycle events.
  for (const stage of [
    "started",
    "progress",
    "completed",
    "failed",
    "cancel",
    "output_item",
  ])
    assert.ok(!serverTypes.includes(`session.delegation.${stage}`));
});

test("native delegation, append acknowledgment and error fields are not widened", () => {
  for (const [eventType, name] of Object.entries(nativeEventModels)) {
    const model = type(name);
    assert.equal(model.baseModel, type("OpenAI.LiveServerEvent"));
    assert.equal(fields(model).get("type").type.value, eventType);
    assert.deepEqual(
      wireShape(model, program),
      wireShape(type(name, native), native),
    );
  }
  for (const channel of ["thinking", "commentary"]) {
    const p = fields(type(nativeEventModels[`session.${channel}.appended`]));
    assert.deepEqual([...p.keys()].sort(), [
      "client_event_id",
      "end_ms",
      "event_id",
      "start_ms",
      "type",
    ]);
    assert.equal(p.get("client_event_id").optional, true);
  }
  const error = fields(type(nativeEventModels.error));
  assert.equal(error.get("error").type, type("OpenAI.LiveLiveError"));
  for (const field of ["type", "code", "message"])
    assert.equal(
      type("OpenAI.LiveLiveError").properties.get(field).optional,
      false,
    );
  assert.ok(!error.has("delegation_id"));
  assert.ok(!error.has("error_code"));
  assert.ok(!error.has("error_message"));
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

test("managed delegation retains tagged output without a format selector", () => {
  const config = type("Azure.AI.Projects.VoiceAgentLiveManagedAgentDelegation");
  const doc = getDoc(program, config);
  for (const text of ["[thinking]", "[commentary]"])
    assert.ok(doc.includes(text), text);
  assert.equal(config.properties.has("result_format"), false);
  const route = getDoc(
    program,
    type("Azure.AI.Projects.VoiceAgentLiveWebSocket.connectLiveVoiceAgent"),
  );
  assert.ok(route.includes("private reasoning are not forwarded"));
  assert.ok(route.includes("Responses-delegation-only"));
  for (const text of [
    "session.thinking.append",
    "session.commentary.append",
    "response.event",
  ])
    assert.ok(route.includes(text), text);
  for (const doc of documents) {
    const description =
      doc.paths["/agents/{agent_name}/endpoint/protocols/voice/live/sessions"]
        .get.description;
    for (const text of ["[thinking]", "[commentary]", "response.event"])
      assert.ok(description.includes(text), text);
  }
});

test("backend observation reuses the native response.event without a new wrapper or discriminator", () => {
  const envelope = type(backendEnvelopeModel);
  assert.equal(envelope.baseModel, type("OpenAI.LiveServerEvent"));
  assert.deepEqual(
    wireShape(envelope, program),
    wireShape(type(backendEnvelopeModel, native), native),
  );
  assert.equal(envelope.properties.get("event").optional, false);
  assert.equal(
    envelope.properties.get("event").type.indexer.value.name,
    "unknown",
  );
  // Foundry supplies correlation without narrowing the native optional field.
  assert.equal(envelope.properties.get("delegation_id").optional, true);
  const wrappers = type("OpenAI.LiveServerEvent").derivedModels.filter(
    (model) => fields(model).get("type").type.value === "response.event",
  );
  assert.deepEqual(wrappers, [envelope]);
  for (const model of type("Azure.AI.Projects").models.values())
    assert.notEqual(fields(model).get("type")?.type.value, "response.event");
  for (const command of [
    "LiveResponseItemCreateParam",
    "LiveResponseCreateParam",
  ])
    assert.deepEqual(
      wireShape(type(`OpenAI.${command}`), program),
      wireShape(type(`OpenAI.${command}`, native), native),
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
  // Retired format and event types stay absent.
  for (const name of [
    "VoiceAgentLiveManagedAppendType",
    "VoiceAgentLiveDelegationResultEventType",
    "VoiceAgentLiveFailureContextStatus",
  ])
    assert.ok(!ns.unions.has(name), name);
});

// Contract fixtures, not service captures; runtime filtering is not tested.
const resultText = { commentary: "Say: Yesterday I went to school." };
const taggedThinking = "Focus on irregular past-tense verbs.";
const taggedCommentary = "Say: Yesterday I went to school.";
const taggedBackendText = `[thinking]\n${taggedThinking}\n[commentary]\n${taggedCommentary}`;

// Native nested events are Record<unknown>; only the envelope is type-checked.
const backendSamples = ["managed_1", "managed_2"].flatMap((id) => {
  const response = {
    id: `resp_${id}`,
    instructions: null,
    tools: [],
    output: [],
  };
  return [
    {
      type: "response.created",
      response: { ...response, status: "in_progress" },
    },
    {
      type: "response.output_item.done",
      output_index: 0,
      item: {
        type: "web_search_call",
        id: `ws_${id}`,
        status: "completed",
        action: {
          type: "search",
          queries: ["beginner irregular past tense lesson"],
        },
      },
    },
    {
      type: "response.output_text.delta",
      item_id: `msg_${id}`,
      output_index: 1,
      content_index: 0,
      delta: taggedBackendText,
      logprobs: [],
    },
    {
      type: "response.output_item.done",
      output_index: 1,
      item: {
        type: "message",
        id: `msg_${id}`,
        role: "assistant",
        status: "completed",
        content: [
          { type: "output_text", text: taggedBackendText, annotations: [] },
        ],
      },
    },
    {
      type: "response.completed",
      response: { ...response, status: "completed" },
    },
  ].map((event, index) => ({
    model: backendEnvelopeModel,
    payload: {
      type: "response.event",
      event_id: `evt_backend_${id}_${index}`,
      delegation_id: `del_${id}`,
      event: { ...event, sequence_number: index },
    },
  }));
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
const nativeFailure = {
  model: nativeEventModels.error,
  payload: {
    type: "error",
    event_id: "evt_append_error_1",
    error: {
      type: "invalid_request_error",
      code: "invalid_delegation_result",
      message:
        "The delegated result could not be injected into the Live session.",
      client_event_id: "evt_append_managed_thinking",
    },
  },
};

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

async function validateExamples(name, examples, declarations = []) {
  const path = join(output, `${name}.tsp`);
  await writeFile(
    path,
    [
      `import ${JSON.stringify(join(project, "main.tsp"))};`,
      ...declarations,
      ...examples.map(
        (sample) => `@@example(${sample.model}, ${exampleValue(sample)});`,
      ),
    ].join("\n"),
  );
  return compile(NodeHost, path, { ...compilerOptions, noEmit: true });
}

test("typed voice definitions remain assignable to unchanged create, update, and read contracts", async () => {
  const definitions = [
    { kind: "voice", model_type: "managed", model: "gpt-realtime" },
    { kind: "voice", model_type: "managed", model: "gpt-4o" },
    { kind: "voice", model_type: "self_deployed", model: "gpt-live-1" },
    {
      kind: "voice",
      sub_protocol: "realtime",
      model_type: "managed",
      model: "gpt-realtime",
    },
    {
      kind: "voice",
      sub_protocol: "live",
      model_type: "self_deployed",
      model: "gpt-live-1",
    },
  ];
  const examplesFor = (name) => [
    `@@example(Azure.AI.Projects.CreateAgentRequest, #{name: "teacher", definition: ${name}});`,
    `@@example(Azure.AI.Projects.CreateAgentVersionRequest, #{definition: ${name}});`,
    `@@example(Azure.AI.Projects.UpdateAgentRequest, #{definition: ${name}});`,
    `@@example(ReadDefinitionProbe, #{definition: ${name}});`,
  ];
  const declarations = definitions.flatMap((definition, index) => {
    const model =
      definition.sub_protocol === "live"
        ? "VoiceAgentLiveDefinition"
        : "VoiceAgentDefinition";
    const name = `voice${index}`;
    return [
      `const ${name}: Azure.AI.Projects.${model} = ${tspValue(definition)};`,
      ...examplesFor(name),
    ];
  });
  checkErrors(
    (
      await validateExamples(
        "optional-voice-protocol",
        [],
        [
          'model ReadDefinitionProbe { ...PickProperties<Azure.AI.Projects.AgentVersionObject, "definition">; }',
          ...declarations,
          // Preserve the sealed engine subtype when checking inherited properties.
          'const engine: Azure.AI.Projects.VoiceHostedAgentConversationEngine = #{type: "hosted_agent", name: "english-teacher"};',
          'const hostedVoice: Azure.AI.Projects.VoiceAgentDefinition = #{kind: "voice", conversation_engine: engine};',
          ...examplesFor("hostedVoice"),
        ],
      )
    ).diagnostics,
  );
});

test("concrete voice definitions reject invalid protocols and incomplete Live definitions", async (t) => {
  const live = {
    kind: "voice",
    sub_protocol: "live",
    model_type: "self_deployed",
    model: "gpt-live-1",
  };
  const missing = (field) =>
    Object.fromEntries(Object.entries(live).filter(([key]) => key !== field));
  for (const [name, definition] of [
    ["null", { ...live, sub_protocol: null }],
    ["unknown", { ...live, sub_protocol: "other" }],
    ["empty", { ...live, sub_protocol: "" }],
    ["number", { ...live, sub_protocol: 1 }],
    ["missing kind", missing("kind")],
    ["missing Live model", missing("model")],
    ["missing Live model type", missing("model_type")],
  ])
    await t.test(name, async () => {
      const result = await validateExamples(`invalid-voice-protocol-${name}`, [
        {
          model: "Azure.AI.Projects.VoiceAgentLiveDefinition",
          payload: definition,
        },
      ]);
      checkInvalidExample(result.diagnostics);
    });
});

test("VoiceAgentDefinition rejects the Live protocol under the legacy Realtime name", async () => {
  const result = await validateExamples("realtime-definition-rejects-live", [], [
    `const voice: Azure.AI.Projects.VoiceAgentDefinition = ${tspValue({
      kind: "voice",
      sub_protocol: "live",
      model_type: "self_deployed",
      model: "gpt-live-1",
    })};`,
  ]);
  checkInvalidExample(result.diagnostics);
});

test("non-Voice definitions retain their original base and kind union members", () => {
  const ns = type("Azure.AI.Projects");
  for (const [name, kind] of [
    ["Prompt", "prompt"],
    ["Hosted", "hosted"],
    ["External", "external"],
    ["Workflow", "workflow"],
    ["ContainerApp", "container_app"],
  ]) {
    const model = ns.models.get(`${name}AgentDefinition`);
    assert.ok(model, name);
    assert.equal(model.baseModel, ns.models.get("AgentDefinition"));
    assert.equal(
      model.properties.get("kind").type,
      ns.unions.get("AgentKind").variants.get(kind),
    );
  }
});

test("Live delegation accepts omission and managed target versions", async () => {
  // Native union-member discriminators need schema/SDK checks; @example rejects them.
  const payloads = [
    {},
    {
      delegation: {
        type: "foundry_managed_agent",
        agent_name: "english-teacher",
      },
    },
    {
      delegation: {
        type: "foundry_managed_agent",
        agent_name: "english-teacher",
        agent_version: "1",
      },
    },
  ];
  checkErrors(
    (
      await validateExamples(
        "live-delegation-targets",
        payloads.map((payload) => ({ model: "LiveDelegationProbe", payload })),
        liveDelegationProbe,
      )
    ).diagnostics,
  );
});

test("Live definition rejects null delegation and deferred hosted targets", async (t) => {
  for (const [name, delegation] of [
    ["null", null],
    ["hosted", { type: "foundry_hosted_agent", agent_name: "english-teacher" }],
  ])
    await t.test(name, async () => {
      checkInvalidExample(
        (
          await validateExamples(
            `unsupported-live-delegation-${name}`,
            [{ model: "LiveDelegationProbe", payload: { delegation } }],
            liveDelegationProbe,
          )
        ).diagnostics,
      );
    });
});

test("native Live session delegation retains its nullable contract", async () => {
  checkErrors(
    (
      await validateExamples("native-null-delegation", [
        {
          model: "OpenAI.LiveSessionCreateParams",
          payload: { model: "gpt-live-1", delegation: null },
        },
      ])
    ).diagnostics,
  );
});

test("Live definition examples reject session-only input and client fields", async (t) => {
  // Exclude discriminator conversions so failures identify the removed fields.
  const declarations = [
    'model LiveDefinitionProbe { ...OmitProperties<Azure.AI.Projects.VoiceAgentLiveDefinition, "kind" | "sub_protocol">; }',
  ];
  const model = "LiveDefinitionProbe";
  const payload = { model_type: "self_deployed", model: "gpt-live-1" };
  checkErrors(
    (
      await validateExamples(
        "live-definition",
        [{ model, payload }],
        declarations,
      )
    ).diagnostics,
  );
  for (const [field, value] of [
    ["input", []],
    ["client", { data_channel: { allowed_client_events: "all" } }],
  ])
    await t.test(field, async () => {
      const result = await validateExamples(
        `live-definition-rejects-${field}`,
        [{ model, payload: { ...payload, [field]: value } }],
        declarations,
      );
      checkInvalidExample(result.diagnostics);
      assert.ok(
        result.diagnostics.some(
          (d) => d.severity === "error" && d.message.includes(field),
        ),
      );
    });
});

test("native session examples still accept input and client permissions", async () => {
  checkErrors(
    (
      await validateExamples("native-session-fields", [
        {
          model: "OpenAI.LiveSessionCreateParams",
          payload: {
            model: "gpt-live-1",
            input: [],
            client: {
              data_channel: {
                allowed_client_events: "all",
                allowed_server_events: [
                  { type: "session.output_transcript.delta" },
                ],
              },
            },
          },
        },
      ])
    ).diagnostics,
  );
});

test("optional Live template greetings and existing Realtime greeting examples validate", async () => {
  const examples = [
    { model: "LiveGreetingProbe", payload: {} },
    ...[
      "Hello! I am your English teacher.",
      "Hello {{student_name}}! What would you like to practice?",
      "你好 {{student_name}}，我们开始今天的练习吧。",
    ].map((text) => ({
      model: "LiveGreetingProbe",
      payload: { greeting: { type: "template", text } },
    })),
    {
      model: "Azure.AI.Projects.VoiceAgentLlmGeneratedGreetingConfig",
      payload: {
        type: "llm_generated",
        prompt: "Introduce yourself as an English teacher.",
      },
    },
  ];
  checkErrors(
    (
      await validateExamples(
        "live-template-greeting",
        examples,
        liveGreetingProbe,
      )
    ).diagnostics,
  );
});

test("Live greeting rejects generated mode and unsupported greeting fields", async (t) => {
  for (const [name, greeting] of [
    ["null", null],
    [
      "generated mode",
      { type: "llm_generated", prompt: "Introduce yourself." },
    ],
    ["missing mode", { text: "Hello!" }],
    ["missing text", { type: "template" }],
    ["non-string text", { type: "template", text: 42 }],
    ["prompt", { type: "template", text: "Hello!", prompt: "Rewrite it." }],
    ["tool choice", { type: "template", text: "Hello!", tool_choice: "none" }],
  ]) {
    await t.test(name, async () => {
      checkInvalidExample(
        (
          await validateExamples(
            `invalid-live-greeting-${name}`,
            [{ model: "LiveGreetingProbe", payload: { greeting } }],
            liveGreetingProbe,
          )
        ).diagnostics,
      );
    });
  }
});

test("Responses configuration accepts deployment aliases without requiring catalog-name equality", async () => {
  const examples = [
    "LiveResponsesDelegationSettingsInputParam",
    "LiveResponsesDelegationSettingsUpdateInputParam",
  ].flatMap((name) =>
    ["teacher-backend", "gpt-5.6-terra"].map((deployment) => ({
      model: `OpenAI.${name}`,
      payload: { model: deployment },
    })),
  );
  checkErrors(
    (await validateExamples("responses-deployment-name", examples)).diagnostics,
  );
});

test("native startup, delegation creation and errors validate for Foundry-owned work", async () => {
  const examples = [
    {
      model: "OpenAI.LiveServerEventLiveSessionStarted",
      payload: sessionStarted,
    },
    nativeFailure,
    {
      model: nativeEventModels.error,
      payload: {
        type: "error",
        event_id: "evt_target_error",
        error: {
          type: "server_error",
          code: "delegation_target_unavailable",
          message: "The delegated agent could not be reached.",
        },
      },
    },
    ...["managed_1", "managed_2"].map((id) => ({
      model: nativeEventModels["session.delegation.created"],
      payload: {
        type: "session.delegation.created",
        event_id: `evt_delegation_${id}`,
        offset_ms: 1200,
        delegation: {
          id: `del_${id}`,
          type: "delegation",
          target: "client",
        },
      },
    })),
  ];
  checkErrors(
    (await validateExamples("native-foundry-notifications", examples))
      .diagnostics,
  );
});

test("native backend status remains nested and correlated across concurrent delegations", async () => {
  const examples = ["managed_1", "managed_2"].flatMap((id) =>
    ["in_progress", "completed", "failed", "incomplete"].map(
      (status, index) => ({
        model: backendEnvelopeModel,
        payload: {
          type: "response.event",
          event_id: `evt_backend_${id}_${status}`,
          delegation_id: `del_${id}`,
          event: {
            type: `response.${status}`,
            sequence_number: index,
            response: {
              id: `resp_${id}_${status}`,
              status,
              instructions: null,
              tools: [],
              output: [],
            },
          },
        },
      }),
    ),
  );
  for (const sample of examples) {
    assert.equal(sample.payload.type, "response.event");
    assert.ok(sample.payload.delegation_id);
    assert.equal("status" in sample.payload, false);
  }
  checkErrors(
    (await validateExamples("native-backend-status", examples)).diagnostics,
  );
});

test("native errors reject retired flattened failure fields and missing required details", async (t) => {
  for (const [name, mutate] of [
    [
      "missing error",
      (p) => {
        delete p.error;
      },
    ],
    [
      "missing code",
      (p) => {
        delete p.error.code;
      },
    ],
    [
      "missing message",
      (p) => {
        delete p.error.message;
      },
    ],
    [
      "non-string message",
      (p) => {
        p.error.message = 42;
      },
    ],
    [
      "flattened error",
      (p) => {
        p.error_code = p.error.code;
        p.error_message = p.error.message;
        delete p.error;
      },
    ],
    [
      "delegation field",
      (p) => {
        p.delegation_id = "del_managed_1";
      },
    ],
  ]) {
    await t.test(name, async () => {
      const sample = structuredClone(nativeFailure);
      mutate(sample.payload);
      checkInvalidExample(
        (await validateExamples(`invalid-native-error-${name}`, [sample]))
          .diagnostics,
      );
    });
  }
});

test("managed backend text, tool and lifecycle samples use the native envelope", async () => {
  checkErrors(
    (await validateExamples("foundry-backend-events", backendSamples))
      .diagnostics,
  );
  assert.equal(
    new Set(backendSamples.map((s) => s.payload.event_id)).size,
    backendSamples.length,
  );
  for (const { payload } of backendSamples) {
    assert.ok(payload.delegation_id);
    assert.equal(payload.type, "response.event");
    assert.equal("output_index" in payload, false);
    const event = payload.event;
    if (event.type === "response.output_text.delta")
      assert.equal(event.delta, taggedBackendText);
    if (event.response) {
      assert.equal("input" in event.response, false);
      assert.equal(event.response.instructions, null);
      assert.deepEqual(event.response.tools, []);
      assert.deepEqual(event.response.output, []);
    }
  }
});

test("tagged backend output becomes native appends and a separate persisted result", async () => {
  const examples = [];
  for (const id of ["managed_1", "managed_2"]) {
    const source = backendSamples.find(
      (s) =>
        s.payload.delegation_id === `del_${id}` &&
        s.payload.event.type === "response.output_item.done" &&
        s.payload.event.item.type === "message",
    );
    assert.equal(source.payload.event.output_index, 1);
    assert.equal(source.payload.event.item.content[0].text, taggedBackendText);
    const projected = {
      model: managedItemModel,
      payload: {
        type: "delegation",
        target: "foundry_managed_agent",
        id: source.payload.delegation_id,
        created_at: 1791763200,
        agent_name: "english-teacher",
        agent_version: "1",
        offset_ms: 1200,
        status: "in_progress",
        output: [{ thinking: taggedThinking, commentary: taggedCommentary }],
      },
    };
    examples.push(projected);
    for (const [channel, content] of Object.entries(
      projected.payload.output[0],
    )) {
      assert.ok(!content.includes(`[${channel}]`));
      const eventId = `evt_append_${id}_${channel}`;
      examples.push({
        model: `OpenAI.LiveClientEventLive${channel === "thinking" ? "Thinking" : "Commentary"}AppendParam`,
        payload: {
          type: `session.${channel}.append`,
          event_id: eventId,
          delegation_id: source.payload.delegation_id,
          content,
        },
      });
      examples.push({
        model: nativeEventModels[`session.${channel}.appended`],
        payload: {
          type: `session.${channel}.appended`,
          event_id: `evt_ack_${id}_${channel}`,
          client_event_id: eventId,
          start_ms: 1400,
          end_ms: 1420,
        },
      });
    }
  }
  checkErrors(
    (await validateExamples("tagged-output-and-live-injection", examples))
      .diagnostics,
  );
});

test("native append acknowledgments reject custom output-item payloads", async (t) => {
  for (const channel of ["thinking", "commentary"]) {
    for (const [field, value] of [
      ["content", "Use the text from the outgoing append command."],
      ["delegation_id", "del_managed_1"],
      ["output_index", 0],
      ["item", { commentary: taggedCommentary }],
    ]) {
      await t.test(`${channel}: ${field}`, async () => {
        const sample = {
          model: nativeEventModels[`session.${channel}.appended`],
          payload: {
            type: `session.${channel}.appended`,
            event_id: `evt_ack_${channel}`,
            client_event_id: `evt_append_${channel}`,
            start_ms: 1400,
            end_ms: 1420,
            [field]: value,
          },
        };
        checkInvalidExample(
          (
            await validateExamples(`invalid-native-ack-${channel}-${field}`, [
              sample,
            ])
          ).diagnostics,
        );
      });
    }
  }
});

test("backend observation envelopes reject malformed outer fields", async (t) => {
  for (const [name, mutate] of [
    [
      "missing event",
      (p) => {
        delete p.event;
      },
    ],
    [
      "missing event ID",
      (p) => {
        delete p.event_id;
      },
    ],
    [
      "non-object event",
      (p) => {
        p.event = "backend text";
      },
    ],
    [
      "invalid correlation",
      (p) => {
        p.delegation_id = 42;
      },
    ],
    [
      "invented wrapper",
      (p) => {
        p.type = "session.managed_agent_delegation.event";
      },
    ],
  ]) {
    await t.test(name, async () => {
      const sample = structuredClone(backendSamples[0]);
      mutate(sample.payload);
      checkInvalidExample(
        (await validateExamples(`invalid-backend-envelope-${name}`, [sample]))
          .diagnostics,
      );
    });
  }
});

test("managed configuration needs no format selector and rejects the removed field", async () => {
  const model = "Azure.AI.Projects.VoiceAgentLiveManagedAgentDelegation";
  const payload = {
    type: "foundry_managed_agent",
    agent_name: "english-teacher",
  };
  const valid = await validateExamples("managed-config-no-format", [
    { model, payload },
    { model, payload: { ...payload, agent_version: "1" } },
  ]);
  checkErrors(valid.diagnostics);

  // Rejected legacy field.
  const invalid = await validateExamples("removed-config-result-format", [
    { model, payload: { ...payload, result_format: "tagged_text" } },
  ]);
  const errors = invalid.diagnostics.filter((d) => d.severity === "error");
  assert.ok(errors.length > 0);
  assert.ok(
    errors.every((d) =>
      ["invalid-argument", "unexpected-property"].includes(d.code),
    ),
    errors.map((d) => `${d.code}: ${d.message}`).join("\n"),
  );
  assert.ok(errors.some((d) => d.message.includes("result_format")));
});

test("managed configuration rejects invalid identity, wrong type, and removed format", async (t) => {
  const model = "Azure.AI.Projects.VoiceAgentLiveManagedAgentDelegation";
  for (const [name, fields] of [
    ["missing name", {}],
    ["invalid name type", { agent_name: ["teacher"] }],
    ["invalid version type", { agent_name: "teacher", agent_version: 1 }],
    ["null version", { agent_name: "teacher", agent_version: null }],
    ["wrong kind", { agent_name: "teacher", type: "foundry_hosted_agent" }],
    ["removed format", { agent_name: "teacher", result_format: "tagged_text" }],
  ]) {
    await t.test(name, async () => {
      const result = await validateExamples(`invalid-managed-config-${name}`, [
        { model, payload: { type: "foundry_managed_agent", ...fields } },
      ]);
      checkInvalidExample(result.diagnostics);
    });
  }
});

const liveConversationSdkNames = [
  ["listLiveAgentConversations", "list", "listAgentConversations"],
  ["getLiveAgentConversation", "get", "getAgentConversation"],
  ["deleteLiveAgentConversation", "delete", "deleteAgentConversation"],
  ["listLiveAgentConversationItems", "listItems", "listAgentConversationItems"],
  ["getLiveAgentConversationItem", "getItem", "getAgentConversationItem"],
  [
    "getLiveAgentConversationAudioItem",
    "getAudioItem",
    "getAgentConversationAudioItem",
  ],
  [
    "getLiveAgentConversationAudioItemContent",
    "downloadAudioItem",
    "downloadAgentConversationAudioItem",
  ],
  ["getLiveAgentConversationAudio", "getAudio", "getAgentConversationAudio"],
  [
    "getLiveAgentConversationAudioContent",
    "downloadAudio",
    "downloadAgentConversationAudio",
  ],
];

const realtimeConversationSdkNames = [
  ["listAgentConversations", "list"],
  ["getAgentConversation", "get"],
  ["deleteAgentConversation", "delete"],
  ["listAgentConversationResponses", "listResponses"],
  ["getAgentConversationResponse", "getResponse"],
  ["listAgentConversationResponseItems", "listResponseItems"],
  ["listAgentConversationItems", "listItems"],
  ["getAgentConversationItem", "getItem"],
  ["getAgentConversationAudioItem", "getAudioItem"],
  [
    "getAgentConversationAudioItemContent",
    "downloadAudioItem",
    "downloadAgentConversationAudioItem",
  ],
  ["getAgentConversationGeneratedAudioItem", "getGeneratedAudioItem"],
  [
    "getAgentConversationGeneratedAudioItemContent",
    "downloadGeneratedAudioItem",
    "downloadAgentConversationGeneratedAudioItem",
  ],
  ["getAgentConversationAudio", "getAudio"],
  [
    "getAgentConversationAudioContent",
    "downloadAudio",
    "downloadAgentConversationAudio",
  ],
];

for (const [language, directory, emitter, rootClient] of [
  [
    "python",
    "sdk-python-js-azure-ai-projects",
    "@azure-tools/typespec-python",
    "AIProjectClient",
  ],
  [
    "javascript",
    "sdk-python-js-azure-ai-projects",
    "@azure-tools/typespec-ts",
    "AIProjectClient",
  ],
  [
    "java",
    "sdk-java-azure-ai-agents",
    "@azure-tools/typespec-java",
    "AgentsClient",
  ],
  [
    "csharp",
    "sdk-csharp-azure-ai-projects-agents",
    "@typespec/http-client-csharp",
    "ProjectsClient",
  ],
]) {
  for (const version of ["v1", "virtual-public-preview"]) {
    test(`${language}/${version} SDK places Live conversations and excludes WebSocket upgrades`, async () => {
      const entrypoint = join(project, "src", directory, "client.tsp");
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
          options: { "api-version": version },
          emitterOutputDir: output,
        },
        emitter,
      );
      checkErrors(context.diagnostics);
      checkSdkVoiceInheritance(context);

      const clients = [];
      const methods = [];
      function visit(client, parent = "") {
        const location = parent ? `${parent}.${client.name}` : client.name;
        clients.push(client);
        methods.push(...client.methods.map((method) => ({ method, location })));
        for (const child of client.children ?? []) visit(child, location);
      }
      for (const client of context.sdkPackage.clients) visit(client);

      for (const name of [
        "Azure.AI.Projects.VoiceAgentWebSocket.connectVoiceAgent",
        "Azure.AI.Projects.VoiceAgentLiveWebSocket.connectLiveVoiceAgent",
      ]) {
        const operation = type(name, sdkProgram);
        assert.equal(isInScope(context, operation), false, name);
        assert.ok(
          !methods.some(
            ({ method }) => method.operation?.__raw.operation === operation,
          ),
          name,
        );
      }

      const live = methods.filter(
        ({ method }) =>
          method.operation?.__raw.operation.interface?.name ===
          "AgentEndpointLiveConversations",
      );
      assert.equal(live.length, 9);
      const liveLocation =
        language === "csharp"
          ? `${rootClient}.AgentEndpointLiveConversations`
          : `${rootClient}.Beta.VoiceAgents.LiveConversations`;
      for (const [operation, shortName, javaName] of liveConversationSdkNames) {
        const matches = live.filter(
          ({ method }) => method.operation.__raw.operation.name === operation,
        );
        assert.equal(matches.length, 1, operation);
        const [{ method, location }] = matches;
        assert.equal(location, liveLocation, operation);
        assert.equal(
          method.name,
          language === "csharp"
            ? operation
            : language === "java"
              ? javaName
              : shortName,
        );
        assert.ok(
          method.operation.path.startsWith(
            "/agents/{agent_name}/endpoint/protocols/voice/live/conversations",
          ),
        );
        if (operation.startsWith("list")) assert.equal(method.kind, "paging");
      }
      if (language !== "csharp") {
        assert.ok(
          !clients.some(
            (client) => client.name === "AgentEndpointLiveConversations",
          ),
        );
      }

      const realtime = methods.filter(
        ({ method }) =>
          method.operation?.__raw.operation.interface?.name ===
          "AgentEndpointConversations",
      );
      assert.equal(realtime.length, realtimeConversationSdkNames.length);
      const realtimeLocation =
        language === "csharp"
          ? `${rootClient}.AgentEndpointConversations`
          : `${rootClient}.Beta.VoiceAgents.Conversations`;
      for (const [
        operation,
        shortName,
        javaName = operation,
      ] of realtimeConversationSdkNames) {
        const matches = realtime.filter(
          ({ method }) => method.operation.__raw.operation.name === operation,
        );
        assert.equal(matches.length, 1, operation);
        const [{ method, location }] = matches;
        assert.equal(location, realtimeLocation, operation);
        assert.equal(
          method.name,
          language === "csharp"
            ? operation
            : language === "java"
              ? javaName
              : shortName,
        );
      }

      // Excluding HTTP upgrade methods must not remove the public WebSocket event types.
      for (const name of ["LiveClientEvent", "LiveServerEvent"]) {
        const model = context.sdkPackage.models.find(
          (value) => value.__raw?.name === name,
        );
        assert.ok(model, name);
        assert.equal(model.access, "public");
        assert.equal(model.discriminatorProperty.serializedName, "type");
      }
      checkNativeSdkEvents(context);
    });
  }
}

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
  const backend = model("LiveServerEventLiveResponseEvent");
  checkSdkGreetingModels(context);
  checkSdkSessionFields(context);
  checkSdkLiveDelegation(context);
  checkNativeSdkEvents(context);
  assert.equal(backend.baseModel, model("LiveServerEvent"));
  assert.equal(backend.discriminatorValue, "response.event");
  assert.equal(
    backend.properties.find((p) => p.serializedName === "event").type.kind,
    "dict",
  );
  for (const value of context.sdkPackage.models) {
    if (value.__raw?.name?.startsWith("VoiceAgentLive"))
      assert.ok(
        !value.properties.some((p) => p.serializedName === "result_format"),
        value.__raw.name,
      );
  }
  const voice = model("VoiceAgentBaseDefinition");
  assert.equal(model("VoiceAgentDefinition").baseModel, voice);
  assert.equal(model("VoiceAgentLiveDefinition").baseModel, voice);
  checkSdkVoiceInheritance(context);
  for (const name of [
    "RealtimeVoiceAgentDefinition",
    "LiveVoiceAgentDefinition",
  ])
    assert.ok(
      !context.sdkPackage.models.some((m) => m.__raw?.name === name),
      name,
    );
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
  // copyProperties runs after @example validation; inspect the final SDK shape.
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
  for (const value of context.sdkPackage.models) {
    if (value.__raw?.name?.startsWith("VoiceAgentLive"))
      assert.ok(
        !value.properties.some((p) => p.serializedName === "result_format"),
        value.__raw.name,
      );
  }

  const realtime = type(
    "Azure.AI.Projects.VoiceAgentDefinition",
    sdkProgram,
  );
  checkSdkGreetingModels(context);
  checkSdkSessionFields(context);
  checkSdkLiveDelegation(context);
  checkSdkVoiceInheritance(context);
  assert.equal(
    realtime.properties.get("tool_choice").type.name,
    "ToolChoiceValue",
  );
  assert.equal(
    model("VoiceAgentDefinition").properties.find(
      (p) => p.serializedName === "subagent_config",
    ).name,
    "subagentConfiguration",
  );
  assert.equal(
    fields(type("Azure.AI.Projects.VoiceAgentBaseDefinition", sdkProgram)).has(
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
  assert.equal(model("LiveServerEventLiveResponseEvent").access, "public");
  assert.equal(
    model("LiveServerEventLiveResponseEvent").discriminatorValue,
    "response.event",
  );
  checkNativeSdkEvents(context);
  for (const name of [
    "VoiceAgentLiveManagedAgentDelegation",
    "VoiceAgentLiveFoundryManagedAgentDelegationItem",
  ])
    assert.equal(model(name).access, "public");
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
  // Preserve Realtime's audio.item_id.
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
  // Foundry targets extend persistence only.
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
const managedOutput = [
  { thinking: "Focus on irregular past-tense verbs." },
  resultText,
  {
    commentary: "Now tell me what you ate yesterday.",
    thinking: "Move on to another irregular verb.",
  },
];
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
      "missing managed version",
      storedExamples[3],
      (p) => {
        delete p.agent_version;
      },
    ],
    [
      "missing managed name",
      storedExamples[3],
      (p) => {
        delete p.agent_name;
      },
    ],
    [
      "hosted delegation is deferred",
      storedExamples[3],
      (p) => {
        p.target = "foundry_hosted_agent";
      },
    ],
    [
      "event metadata on managed item",
      storedExamples[3],
      (p) => {
        p.delegation_id = p.id;
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
      "structured_inputs",
      "x-agent-version-override",
    ])
      assert.ok(names.includes(name));
    assert.equal(names.includes("structured_input"), false);
    const structuredInputs = op.parameters.find(
      (p) => p.name === "structured_inputs",
    );
    assert.equal(structuredInputs.in, "query");
    assert.equal(structuredInputs.required, false);
    assert.equal(structuredInputs.schema.type, "string");
    const realtime =
      doc.paths["/agents/{agent_name}/endpoint/protocols/voice"].get;
    assert.ok(realtime.parameters.some((p) => p.name === "structured_inputs"));
    assert.ok(!realtime.parameters.some((p) => p.name === "structured_input"));
    const realtimeInputs = realtime.parameters.find(
      (p) => p.name === "structured_inputs",
    );
    assert.equal(realtimeInputs.in, "query");
    assert.equal(realtimeInputs.required, false);
    assert.equal(realtimeInputs.schema.type, "string");
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
    const base = schemas.VoiceAgentBaseDefinition;
    const realtime = schemas.VoiceAgentDefinition;
    const live = schemas.VoiceAgentLiveDefinition;
    assert.equal(base.discriminator.propertyName, "sub_protocol");
    assert.deepEqual(base.discriminator.mapping, {
      realtime: "#/components/schemas/VoiceAgentDefinition",
      live: "#/components/schemas/VoiceAgentLiveDefinition",
    });
    assert.equal(
      base.discriminator.defaultMapping,
      "#/components/schemas/VoiceAgentDefinition",
    );
    assert.equal(base.oneOf, undefined);
    for (const ref of [
      ...Object.values(base.discriminator.mapping),
      base.discriminator.defaultMapping,
    ])
      assert.ok(schemas[ref.split("/").at(-1)], ref);
    assert.deepEqual(Object.keys(realtime.properties), realtimeVoiceFields);
    for (const schema of [realtime, live])
      assert.deepEqual(schema.allOf, [
        { $ref: "#/components/schemas/VoiceAgentBaseDefinition" },
      ]);
    assert.deepEqual(schemas.VoiceAgentSubProtocol.enum, ["realtime", "live"]);
    assert.equal(schemas.VoiceAgentSubProtocol.type, "string");
    assert.ok(!base.required?.includes("sub_protocol"));
    assert.ok(!realtime.required?.includes("sub_protocol"));
    assert.ok(live.required.includes("sub_protocol"));
    for (const schema of [base, realtime])
      assert.equal(schema.properties.sub_protocol.default, undefined);
    assert.equal(
      schemas.AgentDefinition.discriminator.mapping.voice,
      "#/components/schemas/VoiceAgentBaseDefinition",
    );
    for (const name of [
      "CreateAgentVersionRequest",
      "CreateAgentRequest",
      "UpdateAgentRequest",
      "AgentVersionObject",
    ])
      assert.equal(
        schemas[name].properties.definition.$ref,
        "#/components/schemas/AgentDefinition",
        name,
      );
    assert.equal(
      Object.hasOwn(
        schemas.AgentDefinition.discriminator.mapping,
        "container_app",
      ),
      doc.info.version === "virtual-public-preview",
    );
    assert.equal(schemas.AgentDefinitionUnion, undefined);
    assert.equal(schemas.VoiceAgentDefinitionBase, undefined);
    assert.equal(schemas.VoiceAgentRealtimeDefinition, undefined);
    assert.equal(schemas.RealtimeVoiceAgentDefinition, undefined);
    assert.equal(schemas.LiveVoiceAgentDefinition, undefined);
    assert.equal(base.properties.store.default, false);
    assert.equal(base.properties.audio, undefined);
    assert.equal(live.properties.live_config, undefined);
    assert.equal(live.properties.session, undefined);
    for (const schema of [base, live, realtime])
      for (const field of ["input", "client"])
        assert.equal(schema.properties[field], undefined, field);
    assert.equal(
      live.properties.audio.$ref,
      "#/components/schemas/OpenAI.LiveInitialSessionAudioParam",
    );
    const managed = schemas.VoiceAgentLiveManagedAgentDelegation;
    assert.deepEqual(managed.required, ["type", "agent_name"]);
    assert.equal(managed.properties.result_format, undefined);
    assert.deepEqual(Object.keys(managed.properties), [
      "type",
      "agent_name",
      "agent_version",
    ]);
    for (const [name, schema] of Object.entries(schemas)) {
      if (name.startsWith("VoiceAgentLive"))
        assert.equal(schema.properties?.result_format, undefined, name);
    }
  }
});
