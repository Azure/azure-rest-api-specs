import "@typespec/openapi";

import "../common/models.tsp";
import "../common/servicepatterns.tsp";
import "../evaluation-jobs/models.tsp";

using Azure.Core;
using TypeSpec.OpenAPI;

namespace Azure.AI.Projects;

/** Runs an evaluation definition directly, without a saved Job. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model EvaluationRunFromDefinition {
  /** Optional non-unique display label of 1-64 Unicode scalar values. */
  name?: string | null;

  ...EvaluationDefinition;
}

/** Runs a saved Job version, without inline parameters or overrides. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model EvaluationRunFromJob {
  /** Optional non-unique display label of 1-64 Unicode scalar values. */
  name?: string | null;

  /** The Job to run; an omitted version resolves to the latest at Run creation. */
  evaluation_job: ResourceVersionReference;
}

/** Exactly one of a direct definition or a saved Job reference; mixed forms return `400`. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
union EvaluationRunCreateRequest {
  EvaluationRunFromDefinition,
  EvaluationRunFromJob,
}

/**
 * Execution status of an EvaluationRun: Foundry job statuses plus `cancelling` and
 * `partially_failed`. Clients treat an unknown value as non-terminal. Quality is reported in
 * `run_summary`, not here.
 */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
union EvaluationRunStatus {
  string,

  /** Accepted and waiting to start. */
  queued: "queued",

  /** Executing TaskRuns. */
  in_progress: "in_progress",

  /** Cancellation was requested and in-flight work is stopping. */
  cancelling: "cancelling",

  /** Every TaskRun finished execution; some may still have failed their graders. */
  @lroSucceeded
  succeeded: "succeeded",

  /** The Run finished, but at least one TaskRun's execution failed. */
  @lroSucceeded
  partially_failed: "partially_failed",

  /** The Run could not complete. */
  @lroFailed
  failed: "failed",

  /** The Run was cancelled. */
  @lroCanceled
  cancelled: "cancelled",
}

/** The exact Job version a Run resolved. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model ResolvedEvaluationJobVersion {
  /** The Job name. */
  name: string;

  /** The concrete version. */
  version: string;

  /** Lowercase SHA-256 of the version content. */
  digest: string;
}

/** TaskRun counts by execution status. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model TaskRunStatusCounts {
  /** TaskRuns waiting to start. */
  queued: int64;

  /** TaskRuns executing. */
  in_progress: int64;

  /** TaskRuns whose execution succeeded. */
  succeeded: int64;

  /** TaskRuns whose execution failed. */
  failed: int64;

  /** TaskRuns that were cancelled. */
  cancelled: int64;

  /** TaskRuns that were skipped. */
  skipped: int64;
}

/** How consistent the reported TaskRun progress is. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
union ProgressConsistency {
  string,

  /** Counts are not available yet. */
  unavailable: "unavailable",

  /** Live counts read over an interval; not an atomic snapshot and not monotonic. */
  shard_window: "shard_window",

  /** Final counts of a terminal Run. */
  frozen: "frozen",
}

/** When and how the TaskRun progress was observed. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model ProgressObservation {
  /** The consistency of the counts. */
  consistency: ProgressConsistency;

  /** When the observation started. */
  started_at: FoundryTimestamp | null;

  /** When the observation finished. */
  finished_at: FoundryTimestamp | null;
}

/** Execution progress of a Run's TaskRuns. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model TaskRunProgress {
  /** The number of selected TaskRuns, or null before selection completes. */
  selected_task_run_count: int64 | null;

  /** TaskRun counts by execution status, or null before selection completes. */
  task_run_counts: TaskRunStatusCounts | null;

  /** How the counts were observed. */
  progress_observation: ProgressObservation;
}

/** Terminal TaskRuns or grader results by quality result; `total` is the sum of the other four. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model EvaluationResultCounts {
  /** The sum of `passed`, `failed`, `error` and `skipped`. */
  total: int64;

  /** Results that passed. */
  passed: int64;

  /** Results that failed a quality check. */
  failed: int64;

  /** Results that could not be decided. */
  error: int64;

  /** Results that did not apply. */
  skipped: int64;
}

/** Token and cost usage; unknown values are null, never zero. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model EvaluationUsage {
  /** Whether every contributing call reported its usage. */
  known: boolean;

  /** Input tokens, or null when unknown. */
  input_tokens: int64 | null;

  /** Output tokens, or null when unknown. */
  output_tokens: int64 | null;

  /** Cost as a finite invariant decimal string, or null when unknown. */
  cost: string | null;

  /** ISO 4217 currency code of `cost`, or null when unknown. */
  currency: string | null;
}

/** TaskRun latency aggregates. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model EvaluationLatency {
  /** TaskRuns with a measured latency. */
  count: int64;

  /** Sum of measured latencies in milliseconds. */
  total_ms: int64;

  /** Minimum latency in milliseconds, or null when `count` is 0. */
  min_ms: int64 | null;

  /** Maximum latency in milliseconds, or null when `count` is 0. */
  max_ms: int64 | null;
}

/** Results of one Job grader across the Run's TaskRuns. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model GraderSummary {
  /** The Job grader name. */
  name: string;

  /** This grader's results; TaskRuns that failed before grading are left out. */
  result_counts: EvaluationResultCounts;

  /** `passed / (passed + failed)`, or null when nothing was graded. */
  pass_rate: float64 | null;

  /** Mean 0-1 `score` of this grader's results that have one, or null when none do. */
  score: float64 | null;
}

/** Quality results of a Run. Run `status` reports execution only. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model RunSummary {
  /** Terminal TaskRuns by quality result; each repetition counts separately. */
  result_counts: EvaluationResultCounts;

  /** `passed / (passed + failed)`, or null when nothing was graded. Excludes `error` and `skipped`. */
  pass_rate: float64 | null;

  /** One entry per resolved Job grader, in definition order. Task graders have no Run-level summary. */
  grader_summaries: GraderSummary[];

  /** Usage for agent invocations and judge calls. */
  usage: EvaluationUsage;

  /** TaskRun latency aggregates. */
  latency: EvaluationLatency;
}

/**
 * A durable execution of an evaluation definition. `error` is set only when `status` is `failed`
 * or `partially_failed`; its `param` names the related request field when known and never holds a
 * resource ID.
 */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model EvaluationRun is JobLike<never, never, EvaluationRunStatus> {
  /** Optional non-unique display label. */
  name: string | null;

  /** The requested Job reference as written, or null for direct execution. */
  evaluation_job: ResourceVersionReference | null;

  /** The concrete Job version resolved at creation, or null for direct execution. */
  resolved_evaluation_job_version: ResolvedEvaluationJobVersion | null;

  /** Relative API path of this Run's resolved configuration. */
  resolved_run_configuration_ref: string;

  /** Execution progress of the Run's TaskRuns. */
  task_run_progress: TaskRunProgress;

  /** Quality results, or null until aggregates are available. */
  run_summary: RunSummary | null;

  /** The time when the Run was created. */
  created_at: FoundryTimestamp;

  /** The time when the Run was last changed. */
  updated_at: FoundryTimestamp;

  /** The time when execution started, or null before it starts. */
  started_at: FoundryTimestamp | null;

  /** The time when the Run became terminal; null while `status` is not terminal. */
  finished_at: FoundryTimestamp | null;
}

/** A judge deployment and the model it resolved to at Run creation. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model ResolvedJudge {
  /** The requested judge deployment. */
  `model`: string;

  /** The model name behind the deployment. */
  model_name: string;

  /** The model version behind the deployment. */
  model_version: string;
}

/** The kinds of resolved Run dependency. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
union ResolvedDependencyKind {
  string,

  /** The Dataset. */
  dataset: "dataset",

  /** The target agent. */
  agent: "agent",
}

/** A concrete dependency pinned at Run creation. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model ResolvedDependency {
  /** The dependency kind. */
  kind: ResolvedDependencyKind;

  /** The dependency name. */
  name: string;

  /** The concrete version. */
  version: string;

  /** Lowercase SHA-256 of the dependency content. */
  digest: string;

  /** The resolved definition, or null when none is retained. */
  dependency_definition: Record<unknown> | null;
}

/** The configuration a Run retained at creation, without credentials or storage locations. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model ResolvedRunConfiguration {
  /** The parent Run ID. */
  evaluation_run_id: string;

  /** The concrete Job version, or null for direct execution. */
  resolved_evaluation_job_version: ResolvedEvaluationJobVersion | null;

  /** Lowercase SHA-256 of the canonical retained configuration. */
  resolved_run_configuration_digest: string;

  /**
   * The effective definition with defaults applied and references resolved. `graders` lists each
   * Job grader as it ran: canonical, with `grader_version` pinned and `pass_threshold` filled in.
   */
  resolved_run_configuration: EvaluationDefinition;

  /** One entry per distinct judge used by Job or Task graders. */
  resolved_judges: ResolvedJudge[];

  /** The Dataset and target pinned for this Run. */
  resolved_dependencies: ResolvedDependency[];
}

/** Execution status of one TaskRun. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
union TaskRunStatus {
  string,

  /** Waiting to start. */
  queued: "queued",

  /** Invoking or grading. */
  in_progress: "in_progress",

  /** Execution completed. */
  succeeded: "succeeded",

  /** Execution failed. */
  failed: "failed",

  /** Execution was cancelled. */
  cancelled: "cancelled",

  /** Execution was skipped. */
  skipped: "skipped",
}

/** Quality result of a TaskRun, decided from its grader results by the scoring rule. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
union TaskRunResult {
  string,

  /** Every applicable grader passed. */
  passed: "passed",

  /** A grader failed. */
  failed: "failed",

  /** Execution failed, an outcome is unknown, or a grader returned `error`. */
  error: "error",

  /** Execution was cancelled or skipped, or every grader returned `skipped`. */
  skipped: "skipped",
}

/** Where a grader was defined. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
union GraderDefinedIn {
  string,

  /** The evaluation definition's graders, including a direct Run's. */
  job: "job",

  /** The Task's own graders. */
  task: "task",
}

/** The outcome of one grader. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
union GraderOutcome {
  string,

  /** The check passed. */
  passed: "passed",

  /** The check failed, including a missing or wrong-type `outputs` value. */
  failed: "failed",

  /** The grader could not decide; never a quality failure. */
  error: "error",

  /** The grader does not apply to this TaskRun. */
  skipped: "skipped",
}

/** One sub-metric of a grader, such as a rubric criterion, on the grader's native scale. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model GraderMetric {
  /** The sub-metric name. */
  name: string;

  /** The sub-metric value, not normalized. */
  value: unknown;

  /** Why this sub-metric got `value`; distinct from the grader-level `explanation`. */
  explanation?: string;
}

/** Why a grader returned `error`. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model GraderError {
  /** A stable code, such as `MissingEvaluationEvidence` or `JudgeUnavailable`. */
  code: string;

  /** The reason the grader could not decide. */
  message: string;
}

/**
 * The result of one grader on a TaskRun. Field presence depends on `result`:
 * - `passed` or `failed`: `score` is always set; `explanation` and `metrics` are optional; `error` is absent.
 * - `error`: `error` is required; `score`, `explanation` and `metrics` are absent.
 * - `skipped`: `explanation` is required; `score`, `metrics`, `error` and `usage` are absent.
 * `usage` is present when a judge was called.
 */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model GraderResult {
  /** The grader name as submitted. */
  name: string;

  /** Where the grader was defined; results are keyed by `defined_in` and `name`. */
  defined_in: GraderDefinedIn;

  /** The grader outcome. */
  result: GraderOutcome;

  /** The primary metric normalized to 0-1, higher is better; boolean graders score 1 or 0. */
  @minValue(0)
  @maxValue(1)
  score?: float64;

  /** Why the grader reached `result`; required for `skipped`. */
  explanation?: string;

  /** Sub-metrics, such as rubric criteria. */
  metrics?: GraderMetric[];

  /** Why the grader could not decide; set only for `error`. */
  error?: GraderError;

  /** This grader's judge calls, including retries; a breakdown of the TaskRun `usage`. */
  usage?: EvaluationUsage;
}

/** The source kind a TaskRun came from. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
union SourceProvenanceType {
  string,

  /** A published Dataset version. */
  dataset: "dataset",

  /** Tasks embedded in the evaluation definition. */
  inline_dataset: "inline_dataset",
}

/** A concrete source version and its digest. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model ResolvedSourceVersion {
  /** The source name. */
  name: string;

  /** The concrete version. */
  version: string;

  /** Lowercase SHA-256 of the source content. */
  digest: string;
}

/** The selected source record of a TaskRun. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model SourceProvenance {
  /** The source kind. */
  type: SourceProvenanceType;

  /** The source record ID. */
  source_record_id: string;

  /** Zero-based ordinal of the record in the source. */
  record_ordinal: int64;

  /** Lowercase SHA-256 of the record content. */
  content_digest: string;

  /** The Dataset version, for Dataset sources. */
  dataset?: ResolvedSourceVersion;

  /** The Job version, when execution selected a saved Job. */
  evaluation_job_version?: ResolvedSourceVersion;
}

/** What the agent returned, as graders read it through `{{outputs.*}}`. Trajectory and artifacts are Later. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model TaskRunOutputs {
  /** The agent's final answer. */
  text?: string;

  /** The parsed result when the agent declares a JSON response schema. */
  data?: unknown;
}

/** TaskRun execution phases. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
union TaskRunPhase {
  string,
  acquire: "acquire",
  invoke: "invoke",
  collect: "collect",
  grade: "grade",
  publish: "publish",
  complete: "complete",
}

/** Status of one TaskRun phase. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
union TaskRunPhaseStatus {
  string,
  succeeded: "succeeded",
  failed: "failed",
  cancelled: "cancelled",
  skipped: "skipped",

  /** The phase may or may not have taken effect. */
  outcome_unknown: "outcome_unknown",
}

/** A phase failure. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model ExecutionFailure {
  /** The failure code. */
  code: string;

  /** The failure description. */
  message: string;

  /** Whether the phase may be retried. */
  retryable: boolean;
}

/** The outcome of one TaskRun phase. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model PhaseResult {
  /** The phase. */
  phase: TaskRunPhase;

  /** The phase status. */
  status: TaskRunPhaseStatus;

  /** When the phase started. */
  started_at: FoundryTimestamp | null;

  /** When the phase finished. */
  finished_at: FoundryTimestamp | null;

  /** The phase failure, or null. */
  failure: ExecutionFailure | null;
}

/**
 * One attempt of one Task within an EvaluationRun. `error` is set only when `status` is
 * `failed`: the last failed or unknown phase, with `param` naming that phase (never a resource ID); other execution
 * failures follow in `details`, at most 10. Grader errors stay in `grader_results[].error`.
 */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model TaskRun {
  /** The TaskRun ID, scoped to its parent Run. */
  id: string;

  /** The execution status. */
  status: TaskRunStatus;

  /** The execution failure, set only when `status` is `failed`. */
  error?: ApiError;

  /** The parent Run ID. */
  evaluation_run_id: string;

  /** The Task ID. */
  task_id: string;

  /** The one-based repetition number of this Task. */
  @minValue(1)
  repetition: int32;

  /** The quality result, set exactly when `status` is terminal; otherwise null. */
  result: TaskRunResult | null;

  /** The selected source record. */
  provenance: SourceProvenance;

  /** The resolved target invoked by this TaskRun. */
  target: EvaluationTargetDefinition;

  /** The Task's inputs as sent to the agent; graders read them through `{{inputs.*}}`. */
  inputs: PromptTaskInput;

  /** The Task's reference values; graders read them through `{{expected.*}}`. */
  expected?: Record<unknown>;

  /** The Task's context; graders read it through `{{metadata.*}}`. */
  metadata?: Record<unknown>;

  /** What the agent returned, present once the agent answered; graders read it through `{{outputs.*}}`. */
  outputs?: TaskRunOutputs;

  /** One result per grader with a retained terminal result, Job graders first, each in definition order. */
  grader_results: GraderResult[];

  /** Execution phase outcomes. */
  phase_results: PhaseResult[];

  /** Usage for the agent invocation and every judge call. */
  usage: EvaluationUsage;

  /** TaskRun latency in milliseconds, or null. */
  latency_ms: int64 | null;

  /** The time when execution started, or null before it starts. */
  started_at: FoundryTimestamp | null;

  /** The time when the TaskRun became terminal; null while `status` is not terminal. */
  finished_at: FoundryTimestamp | null;
}
