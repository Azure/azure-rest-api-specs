import "../task-sets/models.tsp";

using TypeSpec.OpenAPI;

namespace Azure.AI.Projects;

/** A reference to an exact Foundry agent version. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model FoundryAgentReference {
  /** The agent name. */
  name: string;

  /** The exact agent version. */
  version: string;
}

/** The supported evaluation harness types. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
union EvaluationHarnessType {
  string,

  /** Invoke a versioned Foundry agent. */
  foundry_agent: "foundry_agent",
}

/** The harness used to execute evaluation tasks. */
@discriminator("type")
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model EvaluationHarness {
  /** The harness type. */
  type: EvaluationHarnessType;
}

/** A harness that invokes a versioned Foundry agent. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model FoundryAgentHarness extends EvaluationHarness {
  /** Indicates that this harness invokes a Foundry agent. */
  type: EvaluationHarnessType.foundry_agent;

  /** The exact agent version to invoke. */
  agent: FoundryAgentReference;
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

  /** The maximum total tokens consumed by an attempt. */
  max_tokens?: int64;

  /** The maximum tool calls made by an attempt. */
  max_tool_calls?: int32;

  /** The maximum estimated cost in US dollars for an attempt. */
  max_cost_usd?: decimal128;
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
  concurrency?: int32 = 1;

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
  concurrency?: int32;

  /** Constraint fields to replace; omitted fields inherit the suite value. */
  constraints?: ExecutionConstraints;
}
