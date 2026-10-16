import "@typespec/openapi";

import "../common/models.tsp";
import "../common/servicepatterns.tsp";
import "../evaluation-suites/models.tsp";

using Azure.Core;
using TypeSpec.OpenAPI;

namespace Azure.AI.Projects;

/** Select an exact named EvalJob version; inline definitions and overrides are P1. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model EvalRunFromJob {
  /** Published job and immutable configuration version to run. */
  evaluation_job: EvalJobReference;
}

/** Provisional execution states, separate from grading outcomes. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
union EvaluationRunStatus {
  /** Accepted and waiting to start. */
  queued: "queued",

  /** Reserved for future observed-evidence upload, not emitted by MVP runs. */
  awaiting_task_runs: "awaiting_task_runs",

  /** Executing contained TaskRuns. */
  running: "running",

  /** Cancellation requested, in-flight work is stopping. */
  cancelling: "cancelling",

  /** Orchestration completed without TaskRun execution errors. */
  @lroSucceeded
  succeeded: "succeeded",

  /** Orchestration completed with at least one TaskRun error. */
  @lroSucceeded
  partially_failed: "partially_failed",

  /** Orchestration could not complete. */
  @lroFailed
  failed: "failed",

  /** Cancelled by the caller. */
  @lroCanceled
  cancelled: "cancelled",
}

/** Execution state of a single Task attempt. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
union EvaluationTaskRunStatus {
  /** Waiting for a concurrency slot. */
  queued: "queued",

  /** Invoking or grading. */
  running: "running",

  /** Attempt completed with an applicable quality outcome. */
  succeeded: "succeeded",

  /** Invocation or grading failed. */
  failed: "failed",

  /** Attempt was cancelled. */
  cancelled: "cancelled",

  /** Every applicable grader returned N/A. */
  skipped: "skipped",
}

/** Mutually exclusive TaskRun outcome counts for a completed run. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model EvalRunCounts {
  /** TaskRuns with a passing quality result. */
  @minValue(0)
  pass: int32;

  /** TaskRuns with a failing quality result but no execution error. */
  @minValue(0)
  fail: int32;

  /** TaskRuns for which every applicable grader returned N/A. */
  @minValue(0)
  skipped: int32;

  /** TaskRuns with an invocation or grading error. */
  @minValue(0)
  error: int32;
}

/** Aggregate results produced by a completed evaluation run. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model EvalRunResult {
  /** Pass, quality fail, all skipped, and invocation or grading error counts. */
  counts: EvalRunCounts;

  /** counts.pass / (counts.pass + counts.fail), or null when neither exists. */
  pass_rate: float32 | null;
}

/** State of a planned or reached lifecycle phase. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
union EvaluationPhaseState {
  pending: "pending",
  in_progress: "in_progress",
  completed: "completed",
  not_reached: "not_reached",
}

/** A planned or reached phase in a run or task-run lifecycle. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model EvaluationPhaseEntry {
  /** Extensible snake_case phase name, such as queued or invoking. */
  phase: string;

  /** Planned, active, finished, or bypassed because the run ended early. */
  state: EvaluationPhaseState;

  /** Start time in Unix milliseconds; set when a phase begins. */
  started_at_ms?: int64;

  /** End time in Unix milliseconds; set only for a completed phase. */
  completed_at_ms?: int64;
}

/** Timing and upcoming work for an EvalRun or TaskRun. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model EvaluationLifecycle {
  /** Creation time in Unix seconds. */
  created_at: FoundryTimestamp;

  /** Execution start time in Unix seconds, after queueing. */
  started_at?: FoundryTimestamp;

  /** Terminal time in Unix seconds. */
  completed_at?: FoundryTimestamp;

  /** Queue duration, present once execution begins. */
  @minValue(0)
  queue_duration_ms?: int64;

  /** Creation-to-terminal duration, including queue time. */
  @minValue(0)
  total_duration_ms?: int64;

  /** Known upcoming phases and timings for phases already reached. */
  @minItems(1)
  phases: EvaluationPhaseEntry[];
}

/** A durable Foundry evaluation run, distinct from the existing OpenAI EvalRun. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model FoundryEvalRun {
  /** Server-assigned run identifier. */
  @visibility(Lifecycle.Read)
  id: string;

  /** Exact published job selected at creation. */
  evaluation_job: EvalJobReference;

  /** Complete job definition captured when this run was admitted. */
  @visibility(Lifecycle.Read)
  job_definition: EvalJobDefinition;

  /** Current orchestration status; quality is reported separately in result. */
  @visibility(Lifecycle.Read)
  @lroStatus
  status: EvaluationRunStatus;

  /** Run and upcoming phase timings. */
  @visibility(Lifecycle.Read)
  lifecycle: EvaluationLifecycle;

  /** Exact target identity resolved when this run was admitted. */
  @visibility(Lifecycle.Read)
  resolved_target: ResolvedEvalInvocationTarget;

  /** Digest of the authorized Task content retained for this run. */
  @visibility(Lifecycle.Read)
  task_content_digest: string;

  /** Quality and coverage counts, set when orchestration succeeds. */
  @visibility(Lifecycle.Read)
  result?: EvalRunResult;

  /** Opaque Foundry portal URL for this run's report. */
  @visibility(Lifecycle.Read)
  report_url?: string;

  /** Terminal orchestration error, set only when the run fails. */
  @visibility(Lifecycle.Read)
  error?: ApiError;
}

/** Effective configuration retained at admission, without raw Task content. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model EvalRunResolvedConfiguration {
  /** Exact published job version. */
  evaluation_job: EvalJobReference;

  /** Dataset whose Task content was captured. */
  dataset: EvaluationDatasetVersionReference;

  /** Resolved target identity, never credentials. */
  target: ResolvedEvalInvocationTarget;

  /** Attempts per Task with defaults applied. */
  repetitions: EvaluationRepetitions;

  /** Maximum parallel TaskRuns with the default applied. */
  @minValue(1)
  maxParallelTaskRuns: int32;

  /** Digest of the Task bytes authorized at admission. */
  task_content_digest: string;
}

/** A readable task summary retained with a task run. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model EvaluationTaskSummary {
  /** The task identifier. */
  id: string;

  /** The task description. */
  description?: string;
}

/** The outcome of one rubric criterion. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model EvaluationCriterionResult {
  /** The criterion identifier. */
  id: string;

  /** Whether the criterion passed. */
  passed: boolean;

  /** Optional ordered rating, from one to five. */
  @minValue(1)
  @maxValue(5)
  score?: int32;

  /** An explanation of the criterion outcome. */
  explanation?: string;
}

/** Whether a grader completed, returned N/A, or could not grade. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
union EvaluationGraderStatus {
  completed: "completed",
  skipped: "skipped",
  error: "error",
}

/** The outcome produced by one grader. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model EvaluationGraderResult {
  /** The resolved grader name. */
  grader: string;

  /** Completed grading, genuine N/A, or a grading failure. */
  status: EvaluationGraderStatus;

  /** The quality verdict, present only on a completed grader. */
  passed?: boolean;

  /** An optional diagnostic score between zero and one. */
  @minValue(0)
  @maxValue(1)
  score?: float32;

  /** An explanation of the grader outcome. */
  explanation: string;

  /** Per-criterion outcomes when the grader has multiple criteria. */
  criteria?: EvaluationCriterionResult[];

  /** Failure details for a grader with status error. */
  error?: EvaluationGraderError;

  /** Judge-model usage for this grader, absent for built-in checks. */
  usage?: EvaluationJudgeUsage;

  /** Additional grader diagnostics. */
  diagnostics?: Record<unknown>;
}

/** Details of an attempted grader failure. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model EvaluationGraderError {
  code: string;
  message: string;
}

/** A reference to the normalized trajectory retained for a task run. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model EvaluationTrajectoryReference {
  /** The trajectory format. */
  format: "atif";

  /** The trajectory identifier. */
  trajectory_id: string;

  /** The harness session identifier. */
  session_id: string;

  /** The retained artifact identifier. */
  artifact_id: string;
}

/** Usage fields shared by agent invocation and judge calls. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model EvaluationUsageMetrics {
  /** Active call duration across service retries, excluding queue and retry waits. */
  @minValue(0)
  duration_ms?: int64;

  /** Total input tokens, including cached input tokens. */
  @minValue(0)
  input_tokens?: int64;

  /** The cached subset of input tokens. */
  @minValue(0)
  cached_input_tokens?: int64;

  /** Total output tokens. */
  @minValue(0)
  output_tokens?: int64;

  /** Estimated cost in US dollars for these calls. */
  @minValue(0)
  estimated_cost_usd?: decimal128;
}

/** Agent invocation usage, excluding grading and queueing. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model EvaluationTaskRunUsage {
  ...EvaluationUsageMetrics;

  /** Number of conversation turns. */
  @minValue(0)
  turn_count?: int32;

  /** Number of tool calls. */
  @minValue(0)
  tool_call_count?: int32;
}

/** Judge-model call usage for one grader, including retries. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model EvaluationJudgeUsage {
  ...EvaluationUsageMetrics;
}

/** Metadata for evidence retained with a task run. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model EvaluationArtifact {
  /** The artifact identifier. */
  artifact_id: string;

  /** The artifact type, such as `trajectory` or `harness_log`. */
  type: string;

  /** The artifact media type. */
  media_type: string;

  /** The artifact size in bytes, when known. */
  size_bytes?: int64;
}

/** Retry counts for a task-run phase. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model EvaluationTaskRunAttempts {
  /** The number of harness attempts. */
  harness?: int32;

  /** Grader attempt counts keyed by grader name. */
  graders?: Record<int32>;
}

/** Diagnostics retained for a task run. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model EvaluationTaskRunDiagnostics {
  /** Harness and grader attempt counts. */
  attempts?: EvaluationTaskRunAttempts;

  /** The latest durable phase boundary completed by this task run. */
  last_checkpoint?: string;

  /** Artifact identifiers containing retained diagnostic logs. */
  log_artifacts?: string[];
}

/** Available invocation output and optional reference to retained ATIF. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model EvaluationTaskRunObserved {
  /** Final text-mode answer. */
  text?: string;

  /** Parsed final JSON-schema output, not duplicated in text. */
  data?: Record<unknown>;

  /** Reference to normalized ATIF, fetched through the contained trajectory read. */
  trajectory?: EvaluationTrajectoryReference;
}

/** Where an effective grader was selected. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
union EvaluationGraderSource {
  /** Inherited from the published job. */
  job: "job",

  /** Replaced by this Task's own grader list. */
  task: "task",
}

/** Resolved check selected for a TaskRun before execution starts. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model EvaluationEffectiveGrader {
  /** Grader name within this TaskRun. */
  name: string;

  /** Type of check to apply. */
  type: EvaluationGraderType;

  /** Job default or Task-specific replacement. */
  source: EvaluationGraderSource;

  /** Pinned catalog version when the grader uses a Foundry Evaluator. */
  evaluator?: FoundryEvaluatorReference;
}

/** The component responsible for a task-run error. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
union EvaluationTaskRunErrorSource {
  string,

  /** The harness could not invoke the agent or collect its evidence. */
  harness: "harness",

  /** A grader could not evaluate the captured evidence. */
  grader: "grader",

  /** Orchestration could not complete a task-run phase. */
  orchestration: "orchestration",
}

/** A structured execution or grader failure for one task run. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model EvaluationTaskRunError {
  /** The machine-readable error code. */
  code: string;

  /** The human-readable error description. */
  message: string;

  /** The component where the failure occurred. */
  source: EvaluationTaskRunErrorSource;

  /** The exception type when available. */
  exception_type?: string;

  /** The time when the failure occurred. */
  occurred_at?: FoundryTimestamp;

  /** Whether another attempt might succeed, regardless of remaining service-policy retries. */
  retriable: boolean;

  /** Identifiers of retained artifacts with additional failure evidence. */
  artifact_ids?: string[];
}

/** Quality result of a successfully executed TaskRun. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
union EvaluationTaskOverallResult {
  pass: "pass",
  fail: "fail",
  skipped: "skipped",
}

/** One attempt of one task within an EvalRun. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model EvalTaskRun {
  /** The task-run identifier. */
  id: string;

  /** The parent EvalRun identifier. */
  evaluation_run_id: string;

  /** The resolved task identity. */
  task: EvaluationTaskSummary;

  /** The one-based repetition number for this task. */
  repetition_number: int32;

  /** The task-run execution status. */
  status: EvaluationTaskRunStatus;

  /** Prompt sent to the target, without grader-only reference facts. */
  input: PromptTaskInput;

  /** Reference facts visible only to graders. */
  expected?: Record<unknown>;

  /** Task metadata visible only to graders. */
  metadata?: Record<unknown>;

  /** Final output and trajectory reference, when available. */
  observed?: EvaluationTaskRunObserved;

  /** Available target usage, excluding grader calls. */
  usage?: EvaluationTaskRunUsage;

  /** Metadata for retained evidence, empty when none was captured. */
  artifacts: EvaluationArtifact[];

  /** Retry counts, checkpoints, and retained diagnostic logs. */
  diagnostics?: EvaluationTaskRunDiagnostics;

  /** Selected checks, exposed even before they run or when invocation fails. */
  effective_graders: EvaluationEffectiveGrader[];

  /** Outcomes from attempted effective graders. */
  grader_results: EvaluationGraderResult[];

  /** Pass, quality fail, or all graders N/A; absent on failure and cancellation. */
  overall_result?: EvaluationTaskOverallResult;

  /** Upcoming and reached task-run phases. */
  lifecycle: EvaluationLifecycle;

  /** The terminal task-run error, when execution or grading failed. */
  error?: EvaluationTaskRunError;
}

/** A normalized ATIF trajectory. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model EvaluationTrajectory {
  /** The ATIF schema version. */
  schema_version: string;

  /** The trajectory session identifier. */
  session_id: string;

  /** The trajectory identifier. */
  trajectory_id: string;

  /** The agent identity and model recorded by ATIF. */
  agent: Record<unknown>;

  /** Ordered ATIF messages, tool calls, observations, and final output. */
  steps: Record<unknown>[];

  /** Aggregate metrics recorded by ATIF. */
  final_metrics?: Record<unknown>;
}
