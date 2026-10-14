import "@typespec/openapi";

import "../common/models.tsp";
import "../common/servicepatterns.tsp";
import "../evaluation-suites/models.tsp";

using Azure.Core;
using TypeSpec.OpenAPI;

namespace Azure.AI.Projects;

/** Inputs for running the current definition of a named suite. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model EvalRunFromSuite {
  /** The named suite selected for this run. */
  eval_suite: EvalSuiteReference;

  /** Run-only overrides of a named suite's harness and execution settings. */
  config_overrides?: EvalSuiteConfigOverrides;
}

/** Inputs for running a complete one-off definition. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model EvalRunFromDefinition {
  /** The one-off definition, without named-suite overrides. */
  definition: EvalDefinition;
}

/** Exactly one run source: a named suite or a one-off definition. */
@oneOf
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
union EvalRunCreateContent {
  from_suite: EvalRunFromSuite,
  from_definition: EvalRunFromDefinition,
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

  /** Published suite selected at creation, if any. */
  eval_suite?: EvalSuiteReference;

  /** Captured complete definition, including one selected from a named suite. */
  @visibility(Lifecycle.Read)
  definition: EvalDefinition;

  /** Run-only overrides submitted with a named suite. */
  config_overrides?: EvalSuiteConfigOverrides;

  /** Immediate source run for a full rerun. */
  @visibility(Lifecycle.Read)
  rerun_of?: string;

  /** Current orchestration status; quality is reported separately in result. */
  @visibility(Lifecycle.Read)
  @lroStatus
  status: JobStatus;

  /** Run and upcoming phase timings. */
  @visibility(Lifecycle.Read)
  lifecycle: EvaluationLifecycle;

  /** The effective harness and exact agent reference after run overrides. */
  @visibility(Lifecycle.Read)
  resolved_harness_config: ResolvedFoundryAgentHarness;

  /** The effective execution mode and attempt limits after run overrides. */
  @visibility(Lifecycle.Read)
  resolved_execution_config: EvalExecutionConfig;

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

/** The inputs retained in a TaskRun record, including grader-only references. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model EvaluationTaskRunInputs {
  ...PromptTaskInput;

  /** Reference facts for graders, never sent to the agent. */
  expected?: Record<unknown>;

  /** Grader-only Task metadata. */
  metadata?: Record<unknown>;
}

/** The final answer, when the invocation produced usable evidence. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model EvaluationTaskRunOutputs {
  /** Final text-mode answer. */
  text?: string;

  /** Parsed final JSON-schema output, not duplicated in text. */
  data?: Record<unknown>;
}

/** Per-attempt evidence retained before grading. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model EvaluationTaskRunRecord {
  /** Attempted input and grader-only references. */
  inputs: EvaluationTaskRunInputs;

  /** Final answer, absent after an invocation failure. */
  outputs?: EvaluationTaskRunOutputs;

  /** Reference to separately retrieved ATIF evidence. */
  trajectory?: EvaluationTrajectoryReference;

  /** Agent invocation measurements, excluding judge calls. */
  usage?: EvaluationTaskRunUsage;

  /** Metadata for retained evidence, empty when none was captured. */
  artifacts: EvaluationArtifact[];

  /** Retry counts, checkpoints, and retained diagnostic logs. */
  diagnostics?: EvaluationTaskRunDiagnostics;
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
  eval_run_id: string;

  /** The resolved task identity. */
  task: EvaluationTaskSummary;

  /** The one-based repetition number for this task. */
  repetition_number: int32;

  /** The task-run execution status. */
  status: JobStatus;

  /** Inputs and available evidence captured before grading. */
  record: EvaluationTaskRunRecord;

  /** Outcomes from attempted task- and suite-level graders. */
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
