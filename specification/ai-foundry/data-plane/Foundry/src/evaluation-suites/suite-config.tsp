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

/** Timeout for a single target invocation, not the entire TaskRun. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model TargetExecution {
  /** Maximum target invocation duration in seconds. */
  @minValue(1)
  timeoutSeconds?: int32;
}

/** Invoke a Foundry agent; omitted versions resolve when each run starts. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model FoundryAgentTarget {
  /** Indicates a Foundry agent. */
  type: "foundry_agent";

  /** The agent to invoke; an omitted version resolves to the latest version. */
  agent: FoundryAgentReference;

  /** Target invocation timeout. */
  execution?: TargetExecution;
}

/** A target with the exact agent version selected for this run. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model ResolvedFoundryAgentTarget {
  /** Indicates a Foundry agent. */
  type: "foundry_agent";

  /** The exact agent used for this run. */
  agent: ResolvedFoundryAgentReference;

  /** Resolved invocation timeout, when configured. */
  execution?: TargetExecution;
}

/** The number of attempts per Task and their aggregation. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model EvaluationRepetitions {
  /** TaskRuns created for every Task. */
  @minValue(1)
  count: int32 = 1;

  /** MVP repetition aggregation. */
  aggregation: "mean" = "mean";
}
