import "../task-sets/models.tsp";

using TypeSpec.OpenAPI;

namespace Azure.AI.Projects;

/** A Foundry agent; an omitted version resolves when a run is created. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model FoundryAgentReference {
  /** The agent name. */
  name: string;

  /** The exact agent version, when pinned by the caller. */
  version?: string;
}

/** The resolved agent version used by a run. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model ResolvedFoundryAgentReference {
  name: string;
  version: string;
}

/** The supported evaluation harness types. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
union EvaluationHarnessType {
  string,

  /** Invoke a versioned Foundry agent with an inline harness definition. */
  inline_foundry_agent_harness: "inline_foundry_agent_harness",
}

/** The harness used to execute evaluation tasks. */
@discriminator("type")
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model EvaluationHarness {
  /** The harness type. */
  type: EvaluationHarnessType;
}

/** An inline harness that invokes a versioned Foundry agent. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model InlineFoundryAgentHarness extends EvaluationHarness {
  /** Indicates an inline Foundry-agent harness. */
  type: EvaluationHarnessType.inline_foundry_agent_harness;

  /** The agent to invoke; an omitted version resolves to the latest version. */
  agent: FoundryAgentReference;
}

/** The exact agent and harness used by a run. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model ResolvedFoundryAgentHarness {
  type: EvaluationHarnessType.inline_foundry_agent_harness;
  agent: ResolvedFoundryAgentReference;
}

/** The supported execution modes. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
union EvalExecutionConfigType {
  string,

  /** Invoke the configured harness for each task attempt. */
  harness_invocation: "harness_invocation",
}

/** Per-attempt execution constraints. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model ExecutionConstraints {
  /** The maximum attempt duration in seconds. */
  max_duration_seconds?: int32;
}

/** Suite-owned execution defaults, independent of the harness configuration. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model EvalExecutionConfig {
  /** The execution mode. */
  type: EvalExecutionConfigType.harness_invocation;

  /** The number of attempts created for each task. */
  @minValue(1)
  repetitions?: int32 = 1;

  /** The maximum number of task attempts executed concurrently. */
  @minValue(1)
  task_concurrency?: int32 = 1;

  /** Per-attempt execution constraints. */
  constraints?: ExecutionConstraints;
}

/** Execution settings that replace a published suite's defaults for one run. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model EvalExecutionConfigOverrides {
  /** The number of attempts created for each task. */
  @minValue(1)
  repetitions?: int32;

  /** The maximum number of task attempts executed concurrently. */
  @minValue(1)
  task_concurrency?: int32;

  /** Constraint fields to replace; omitted fields inherit the suite value. */
  constraints?: ExecutionConstraints;
}
