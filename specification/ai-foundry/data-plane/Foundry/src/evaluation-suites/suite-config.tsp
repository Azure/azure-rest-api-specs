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

/** The supported systems under evaluation. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
union EvalTargetType {
  /** Invoke a Foundry agent. */
  foundry_agent: "foundry_agent",

  /** Invoke an endpoint through a project connection. */
  external_endpoint: "external_endpoint",
}

/** Timeout for a single target invocation, not the entire TaskRun. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model TargetExecution {
  /** Maximum target invocation duration in seconds. */
  @minValue(1)
  timeoutSeconds?: int32;
}

/** The system whose responses are evaluated. */
@discriminator("type")
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model EvalTarget {
  /** The invocation target type. */
  type: EvalTargetType;

  /** Target invocation timeout. */
  execution?: TargetExecution;
}

/** Invoke a Foundry agent; omitted versions resolve when each run starts. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model FoundryAgentTarget extends EvalTarget {
  /** Indicates a Foundry agent. */
  type: EvalTargetType.foundry_agent;

  /** The agent to invoke; an omitted version resolves to the latest version. */
  agent: FoundryAgentReference;
}

/** Invoke a supported external endpoint; registration alone is not invokable. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model ExternalEndpointTarget extends EvalTarget {
  /** Indicates a connected endpoint. */
  type: EvalTargetType.external_endpoint;

  /** Project connection containing the endpoint and delegated authentication. */
  connection_name: string;

  /** Optional registered external-agent identity for provenance. */
  registered_agent?: string;
}

/** A target with a resolved agent version or authorized connection identity. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model ResolvedFoundryAgentTarget {
  /** Indicates a Foundry agent. */
  type: EvalTargetType.foundry_agent;

  /** The exact agent used for this run. */
  agent: ResolvedFoundryAgentReference;

  /** Resolved invocation timeout, when configured. */
  execution?: TargetExecution;
}

/** An invokable Foundry agent or a supported external endpoint. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
union EvalInvocationTarget {
  FoundryAgentTarget,
  ExternalEndpointTarget,
}

/** The exact target identity recorded at run admission. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
union ResolvedEvalInvocationTarget {
  ResolvedFoundryAgentTarget,
  ExternalEndpointTarget,
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
