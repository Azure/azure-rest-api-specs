import "../common/servicepatterns.tsp";

namespace Azure.AI.Projects;

/** Availability of the job's recorded activity history. */
union AgentOptimizationActivityTrackingStatus {
  string,

  /** A recorded activity journal is available. */
  available: "available",

  /** The supported job has no recorded journal. */
  not_recorded: "not_recorded",

  /** The job's strategy does not record activities. */
  unsupported: "unsupported",

  /** The recording budget was reached; existing history is incomplete even if optimization continues. */
  limit_reached: "limit_reached",
}

/** Lifecycle of an execution activity, independent of the parent job status. */
union AgentOptimizationActivityStatus {
  string,

  /** Execution has not started. */
  not_started: "not_started",

  /** Execution is in progress, including dependency polling. */
  in_progress: "in_progress",

  /** Execution completed successfully. */
  completed: "completed",

  /** Execution failed. */
  failed: "failed",

  /** Execution will not run because a prerequisite could not finish. */
  skipped: "skipped",

  /** Execution was cancelled. */
  cancelled: "cancelled",

  /** A replacement execution began without a recorded completion for this attempt. */
  interrupted: "interrupted",
}

/** Recorded display progress included in optimization job detail GET. It is not a percentage-complete signal or a substitute for the job/candidate outcome. */
model AgentOptimizationActivityProgress {
  /** Whether recorded history is available, missing, unsupported, or limited. */
  tracking_status: AgentOptimizationActivityTrackingStatus;

  /** Recording cutoff in Unix seconds. Omitted while recording continues. */
  recording_stopped_at?: FoundryTimestamp;

  /** Explanation of incomplete history when recording stopped. Omitted when no notice was recorded. */
  notice?: string;

  /** Activity snapshots in presentation order. Empty when no history is available. */
  activities: AgentOptimizationActivity[];

  /** Latest persisted activity update in Unix seconds; null when no activity was recorded. */
  updated_at: FoundryTimestamp | null;

  /** Response observation instant in Unix seconds, used to calculate active durations. */
  observed_at: FoundryTimestamp;
}

/** A recorded execution activity. Retries and replacement executions remain distinct entries; clients must not infer attempt identity from an ID suffix. */
model AgentOptimizationActivity {
  /** Stable execution identity within this job. */
  id: string;

  /** One-based attempt number, at least 1. Omitted when attempt history was not recorded. */
  @minValue(1)
  attempt_number?: int32;

  /** Presentation order, at least 0. */
  @minValue(0)
  order: int32;

  /** Service-authored display title. */
  title: string;

  /** Current recorded state of this execution. */
  status: AgentOptimizationActivityStatus;

  /** Actual execution start in Unix seconds; null before execution starts. */
  started_at: FoundryTimestamp | null;

  /** Recorded completion in Unix seconds; null while active, unstarted, or interrupted. */
  completed_at: FoundryTimestamp | null;

  /** Elapsed execution time in milliseconds; null when the start or interrupted end is unknown. */
  duration_ms: FoundryDurationMilliseconds | null;

  /** Safe display Markdown. Resource links use activity-ref keys resolved against this activity's references, never service-supplied external navigation URLs. */
  detail_markdown: string;

  /** Project-scoped resource identities for this activity's activity-ref links. These identities do not grant access or resolve resources. */
  references: AgentOptimizationActivityReference[];

  /** Recorded activity failure code. Omitted when no code was recorded. */
  error_code?: string;

  /** Safe explanation of failure, skipping, or cancellation. Omitted when unavailable. */
  error_message?: string;
}

/** Resource kinds supported by recorded activity references. */
union AgentOptimizationActivityReferenceType {
  string,

  /** A pinned Foundry agent version. */
  agent: "agent",

  /** A pinned Foundry dataset version. */
  dataset: "dataset",

  /** A pinned Foundry evaluator version. */
  evaluator: "evaluator",

  /** An Insight and its owning monitor. */
  insight: "insight",

  /** A candidate in this optimization job. */
  candidate: "candidate",

  /** A Foundry evaluation and optional run. */
  evaluation: "evaluation",
}

/** Typed identity referenced by an activity-ref link in an activity's Markdown. */
@discriminator("type")
model AgentOptimizationActivityReference {
  /** Resource kind. Unknown kinds must not be interpreted as navigation URLs. */
  type: AgentOptimizationActivityReferenceType;

  /** Key resolved within this activity's references. */
  key: string;
}

/** Pinned agent identity in the current Foundry project. */
model AgentOptimizationActivityAgentReference
  extends AgentOptimizationActivityReference {
  /** Agent reference discriminator. */
  type: AgentOptimizationActivityReferenceType.agent;

  /** Foundry agent name. */
  name: string;

  /** Pinned agent version. */
  version: string;
}

/** Pinned dataset identity in the current Foundry project. */
model AgentOptimizationActivityDatasetReference
  extends AgentOptimizationActivityReference {
  /** Dataset reference discriminator. */
  type: AgentOptimizationActivityReferenceType.dataset;

  /** Foundry dataset name. */
  name: string;

  /** Pinned dataset version. */
  version: string;
}

/** Pinned evaluator identity in the current Foundry project. */
model AgentOptimizationActivityEvaluatorReference
  extends AgentOptimizationActivityReference {
  /** Evaluator reference discriminator. */
  type: AgentOptimizationActivityReferenceType.evaluator;

  /** Foundry evaluator name. */
  name: string;

  /** Pinned evaluator version. */
  version: string;
}

/** Selected Insight and its owning monitor. */
model AgentOptimizationActivityInsightReference
  extends AgentOptimizationActivityReference {
  /** Insight reference discriminator. */
  type: AgentOptimizationActivityReferenceType.insight;

  /** Recorded Insight identity. */
  insight_id: string;

  /** Monitor owning the Insight. */
  monitor_id: string;
}

/** Candidate identity scoped to the current optimization job. */
model AgentOptimizationActivityCandidateReference
  extends AgentOptimizationActivityReference {
  /** Candidate reference discriminator. */
  type: AgentOptimizationActivityReferenceType.candidate;

  /** Recorded candidate identity. */
  candidate_id: string;
}

/** Evaluation identity in the current Foundry project. */
model AgentOptimizationActivityEvaluationReference
  extends AgentOptimizationActivityReference {
  /** Evaluation reference discriminator. */
  type: AgentOptimizationActivityReferenceType.evaluation;

  /** Recorded evaluation identity. */
  evaluation_id: string;

  /** Recorded run identity. Omitted for evaluation-level references. */
  run_id?: string;
}
