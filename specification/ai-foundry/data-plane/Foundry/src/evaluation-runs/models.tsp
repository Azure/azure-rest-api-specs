import "@typespec/openapi";

import "../common/models.tsp";
import "../common/servicepatterns.tsp";
import "../evaluation-suites/models.tsp";

using TypeSpec.OpenAPI;

namespace Azure.AI.Projects;

/** Caller-supplied immutable inputs for an evaluation run. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model EvalRunInputs {
  /** The exact suite version to execute; exclusive with inline_suite. */
  suite?: EvalSuiteReference;

  /** A complete one-off suite definition; exclusive with suite and run_config_overrides. */
  inline_suite?: InlineEvalSuite;

  /** Execution settings replacing a referenced suite's defaults for this run. */
  run_config_overrides?: EvalRunConfigOverrides;
}

/** Request to create an evaluation run with immutable caller-supplied inputs. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model EvalRunCreateContent {
  /** The immutable inputs used throughout the run. */
  inputs: EvalRunInputs;
}

/** Aggregate results produced by a completed evaluation run. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model EvalRunResult {
  /** The total number of task runs. */
  task_run_count: int32;

  /** The number of task runs that passed all applicable graders. */
  passed_count: int32;

  /** The number of gradable task runs that did not pass. */
  not_passed_count: int32;

  /** Task runs without a quality verdict because harness invocation or grading failed. */
  error_count: int32;

  /** Passed task runs divided by gradable task runs, or null when none were gradable. */
  pass_rate: float32 | null;
}

/** A durable Foundry evaluation run, distinct from the existing OpenAI EvalRun. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model FoundryEvalRun is JobLike<EvalRunResult, EvalRunInputs> {
  /** The effective suite execution configuration after run overrides. */
  @visibility(Lifecycle.Read)
  resolved_run_config: EvalRunConfig;

  /** The time when the run was accepted. */
  @visibility(Lifecycle.Read)
  created_at: utcDateTime;

  /** The time when execution started. */
  @visibility(Lifecycle.Read)
  started_at?: utcDateTime;

  /** The time when the run reached a terminal state. */
  @visibility(Lifecycle.Read)
  completed_at?: utcDateTime;
}

/** A readable task summary retained with a task run. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model EvaluationTaskSummary {
  /** The task identifier. */
  id: string;

  /** The task name. */
  name: string;

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

  /** An explanation of the criterion outcome. */
  explanation?: string;
}

/** The outcome produced by one grader. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model EvaluationGraderResult {
  /** The resolved grader name. */
  grader: string;

  /** Whether the grader passed. */
  passed: boolean;

  /** An optional diagnostic score between zero and one. */
  @minValue(0)
  @maxValue(1)
  score?: float32;

  /** An explanation of the grader outcome. */
  explanation: string;

  /** Per-criterion outcomes when the grader has multiple criteria. */
  criteria?: EvaluationCriterionResult[];

  /** Additional grader diagnostics. */
  diagnostics?: Record<unknown>;
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

  /** The associated observability trace identifier, when available. */
  trace_id?: string;
}

/** Usage measurements for one task run. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model EvaluationTaskRunUsage {
  /** Total duration in milliseconds. */
  duration_ms?: int64;

  /** Total input tokens, including cached input tokens. */
  input_tokens?: int64;

  /** The cached subset of input tokens. */
  cached_input_tokens?: int64;

  /** Total output tokens. */
  output_tokens?: int64;

  /** Number of conversation turns. */
  turn_count?: int32;

  /** Number of tool calls. */
  tool_call_count?: int32;

  /** Estimated cost in US dollars. */
  estimated_cost_usd?: decimal128;
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
  /** Phase durations in milliseconds, keyed by phase name. */
  phase_timings?: Record<int64>;

  /** Harness and grader attempt counts. */
  attempts?: EvaluationTaskRunAttempts;

  /** The latest durable phase boundary completed by this task run. */
  last_checkpoint?: string;

  /** Artifact identifiers containing retained diagnostic logs. */
  log_artifacts?: string[];
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
  occurred_at?: utcDateTime;

  /** Whether another attempt might succeed, regardless of remaining service-policy retries. */
  retriable: boolean;

  /** Identifiers of retained artifacts with additional failure evidence. */
  artifact_ids?: string[];
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

  /** The one-based attempt number for this task. */
  repetition: int32;

  /** The task-run execution status. */
  status: JobStatus;

  /** A reference to normalized ATIF evidence. */
  trajectory?: EvaluationTrajectoryReference;

  /** Outcomes from every applicable task- and suite-level grader. */
  grader_results: EvaluationGraderResult[];

  /** Whether all applicable graders passed. Unset when execution or grading failed. */
  passed?: boolean;

  /** Usage measurements for the task run. */
  usage?: EvaluationTaskRunUsage;

  /** Metadata for retained evidence. */
  artifacts: EvaluationArtifact[];

  /** Retry, phase, and recovery diagnostics. */
  diagnostics?: EvaluationTaskRunDiagnostics;

  /** The terminal task-run error, when execution or grading failed. */
  error?: EvaluationTaskRunError;

  /** The time when execution started. */
  started_at?: utcDateTime;

  /** The time when the task run reached a terminal state. */
  completed_at?: utcDateTime;
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
