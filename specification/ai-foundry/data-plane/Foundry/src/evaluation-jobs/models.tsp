import "@typespec/openapi";

import "../common/models.tsp";
import "../common/servicepatterns.tsp";
import "../task-sets/models.tsp";
import "./graders.tsp";

using TypeSpec.OpenAPI;
using TypeSpec.Rest;

namespace Azure.AI.Projects;

/** A named resource and an optional version; an omitted version resolves to the latest at Run creation. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model ResourceVersionReference {
  /** The resource name. */
  name: string;

  /** The exact version; when omitted, each Run resolves and pins the latest version. */
  version?: string;
}

/** The kinds of system under test. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
union EvaluationTargetDefinitionType {
  string,

  /** An existing Foundry agent. */
  foundry_agent: "foundry_agent",
}

/** The system under test invoked by each TaskRun. */
@discriminator("type")
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model EvaluationTargetDefinition {
  /** The target type. */
  type: EvaluationTargetDefinitionType;
}

/** An existing Foundry agent, matching Foundry's agent reference. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model FoundryAgentEvaluationTarget extends EvaluationTargetDefinition {
  /** Indicates a Foundry agent. */
  type: EvaluationTargetDefinitionType.foundry_agent;

  /** The agent name. */
  @maxLength(256)
  name: string;

  /** The agent version; when omitted, each Run resolves and pins the latest version. */
  version?: string;
}

/** Agent-invocation Tasks embedded in the definition instead of a published Dataset. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model InlineDataset {
  /** The Tasks to run; IDs are unique within the list. */
  tasks: Task[];
}

/** The number of TaskRuns created for every Task. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model EvaluationRepetitions {
  /** TaskRuns created for every Task. */
  @minValue(1)
  count: int32 = 1;
}

/**
 * What an evaluation runs. It is the Job-version create body and is flattened into the direct
 * Run-create body. Exactly one of `dataset` or `inline_dataset` is required. A field the schema does
 * not define returns `400 invalid_request`; a recognized value that is not yet supported, such as a
 * Later grader feature, returns `400 unsupported_feature`.
 */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model EvaluationDefinition {
  /** An Eval-owned `agent_invocation` Dataset. */
  dataset?: ResourceVersionReference;

  /** Tasks embedded in this definition. */
  inline_dataset?: InlineDataset;

  /** The system invoked for each Task. */
  target: EvaluationTargetDefinition;

  /** The default judge for graders that need one. */
  judge?: Judge;

  /** Graders run for every Task, before the Task's own graders. */
  @maxItems(32)
  graders?: JobGrader[];

  /** How grader results combine into each TaskRun result. */
  scoring?: EvaluationScoring;

  /** The number of TaskRuns created for every Task. */
  repetitions?: EvaluationRepetitions;

  /** The maximum number of concurrently admitted TaskRuns, including invocation and grading. */
  @minValue(1)
  max_parallel_task_runs?: int32 = 1;
}

/** Request body that publishes an EvaluationJob version. */
alias CreateEvaluationJobVersionRequest = {
  ...EvaluationDefinition;

  /** A human-readable description of this version. */
  description?: string;

  /** User-defined string labels for this version. */
  metadata?: Record<string>;
};

/** An immutable published version of an EvaluationJob. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model EvaluationJobVersion {
  /** The Job name. */
  name: string;

  /** The service-assigned decimal version, such as `"1"`. */
  version: string;

  /** A human-readable description of this version. */
  description?: string;

  /** User-defined string labels for this version. */
  metadata?: Record<string>;

  /** The time when this version was published. */
  created_at: FoundryTimestamp;

  ...EvaluationDefinition;
}

/** The versions embedded in an EvaluationJob. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model EvaluationJobVersions {
  /** The newest remaining version. */
  latest: EvaluationJobVersion;
}

/** Lifecycle state of an EvaluationJob. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
union EvaluationJobState {
  string,

  /** Asynchronous deletion is in progress; publication returns `409`. */
  deleting: "deleting",
}

/** A saved, versioned evaluation configuration identified by its name. */
@resource("evaluation_jobs")
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model EvaluationJob {
  /** The Job name: 1-64 ASCII letters, digits or hyphens with alphanumeric ends, canonicalized to lowercase. */
  @key
  @visibility(Lifecycle.Read)
  name: string;

  /** The Job's latest version. */
  versions: EvaluationJobVersions;

  /** Set to `deleting` while asynchronous deletion is in progress; omitted while the Job is active. */
  @visibility(Lifecycle.Read)
  state?: EvaluationJobState;
}
