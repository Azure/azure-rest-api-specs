import "@typespec/http";

using TypeSpec.Http;

model AgentsPagedResult<T> {
  /** The requested list of items. */
  @pageItems
  data: T[];

  /** The first ID represented in this list. */
  first_id?: string;

  /** The last ID represented in this list. */
  @continuationToken
  last_id?: string;

  /** A value indicating whether there are additional values available not captured in this list. */
  has_more: boolean;
}


// ============================================================================
// GENERIC JOB INFRASTRUCTURE
//
// Minimal changes from the original sample:
//   (+) Added `id`, `error`, `created_at`, `finished_at` to JobLike
//   (~) Changed Operation-Location → Location header (Pattern A)
//   (+) Added cancelJob and deleteJob operation templates
//   (+) Added JobError model with real fields
// ============================================================================

/** Extensible status values shared by Foundry jobs. */
union JobStatus {
  string,

  /** Job is waiting to start. */
  queued: "queued",

  /** Job is actively processing. */
  running: "running",

  /** Job completed successfully. */
  succeeded: "succeeded",

  /** Job failed. */
  failed: "failed",

  /** Job was canceled by the caller. */
  canceled: "canceled",
}

/** Error details attached to a failed job. */
@error
model JobError {
  /** Machine-readable error code. */
  code: string;

  /** Human-readable description. */
  message: string;
}

/**
 * Base shape for every Foundry async job.
 *
 * @template TResult  Data produced on success (use `never` if none).
 * @template TInputs  Caller-supplied configuration (use `never` if none).
 * @template TStatus  Status union (defaults to `JobStatus`).
 */
model JobLike<TResult = never, TInputs = never, TStatus extends string = JobStatus> {
  /** Server-assigned unique identifier. */
  @visibility(Lifecycle.Read)
  id: string;

  /** Caller-supplied inputs — omitted when TInputs is `never`. */
  inputs?: TInputs;

  /** Result produced on success — omitted when TResult is `never`. */
  @visibility(Lifecycle.Read)
  result?: TResult;

  /** Current lifecycle status. */
  @visibility(Lifecycle.Read)
  status: TStatus;

  /** Error details — populated only on failure. */
  @visibility(Lifecycle.Read)
  error?: JobError;
}

// ---- Response envelopes ---------------------------------------------------

alias PostJobResult<TJob extends JobLike<unknown, unknown, string>> = {
  /** Poll this URL to retrieve the latest job status. */
  @header("Location")
  location: string;

  @body job: TJob;
};

// ---- Operation templates --------------------------------------------------

@post op postJob<TJob extends JobLike<unknown, unknown, string>>(
  @body job: TJob,
): CreatedResponse & PostJobResult<TJob> | ConflictResponse & JobError;

@get op queryJobStatus<TJob extends JobLike<unknown, unknown, string>>(
  @path jobId: string,
): OkResponse & {
  @encode(DurationKnownEncoding.seconds, int32)
  @header("Retry-After")
  retryAfter?: duration;

  @body job: TJob;
};

@get op listJobs<TJob extends JobLike<unknown, unknown, string>>() is AgentsPagedR: TJob[];

@post op cancelJob<TJob extends JobLike<unknown, unknown, string>>(
  @path jobId: string,
): TJob;

@delete op deleteJob(
  @path jobId: string,
): NoContentResponse;

// ============================================================================
// DATA GENERATION — Domain Models
// ============================================================================

// ---- Unions / enums -------------------------------------------------------

/** Status values for data generation jobs. */
union DataGenerationJobStatus {
  string,

  /** Job has been queued and is waiting to start. */
  queued: "queued",

  /** Job is currently running. */
  running: "running",

  /** Job completed successfully. */
  succeeded: "succeeded",

  /** Job failed. */
  failed: "failed",

  /** Job was cancelled. */
  cancelled: "cancelled",
}

/** The supported data generation job types. */
union DataGenerationJobType {
  string,

  /** Simple question and answers between user and agent. */
  SimpleQnA: "SimpleQnA",

  /** Tool calling conversation between user and agent. */
  ToolUse: "ToolUse",

  /** Multi turn conversation between user and agent. */
  MultiTurn: "MultiTurn",
}

/** The supported scenarios for a data generation job. */
union DataGenerationJobScenario {
  string,

  /** Supervised Fine-tuning scenario. */
  SupervisedFineTuning: "SupervisedFineTuning",

  /** Reinforcement Fine-tuning scenario. */
  ReinforcementFineTuning: "ReinforcementFineTuning",

  /** Evaluation scenario. */
  Evaluation: "Evaluation",
}

/** The supported source types for a data generation job. */
union DataGenerationJobSourceType {
  string,

  /** Traces source type. */
  Traces: "Traces",

  /** Prompt source type. */
  Prompt: "Prompt",

  /** File source type. */
  File: "File",

  /** Dataset source type. */
  Dataset: "Dataset",
}

/** The supported output types for a data generation job. */
union DataGenerationJobOutputType {
  string,

  /** The generated data is an Azure OpenAI File. */
  File: "File",

  /** The generated data is a Dataset. */
  Dataset: "Dataset",
}

/** The supported question types for SimpleQnA fine-tuning. */
union SimpleQnAFineTuningQuestionType {
  string,

  /** Short answer question type. */
  ShortAnswer: "ShortAnswer",

  /** Long answer question type. */
  LongAnswer: "LongAnswer",
}

// ---- Source models --------------------------------------------------------

/** Base source model for a data generation job. */
@discriminator("type")
model DataGenerationJobSource {
  /** The type of source. */
  type: DataGenerationJobSourceType;
}

/** Traces source — fetches data from Application Insights. */
model TracesDataGenerationJobSource extends DataGenerationJobSource {
  type: DataGenerationJobSourceType.Traces;

  /** The agent name to fetch traces for. */
  agent_name: string;

  /** Optional agent version. */
  agent_version?: string;

  /** Start of the time window (Unix timestamp in seconds). */
  @encode(DateTimeKnownEncoding.unixTimestamp, int32)
  start_time: utcDateTime;

  /** End of the time window (Unix timestamp in seconds). */
  @encode(DateTimeKnownEncoding.unixTimestamp, int32)
  end_time?: utcDateTime;

  /** Sampling limit applied to retrieved traces. */
  max_traces?: int32 = 1000;
}

/** Prompt source — generates data from a prompt or agent instructions. */
model PromptDataGenerationJobSource extends DataGenerationJobSource {
  type: DataGenerationJobSourceType.Prompt;

  /** The prompt used for data generation. */
  prompt?: string;

  /** The agent name to fetch instructions from. */
  agent_name: string;

  /** Optional agent version. */
  agent_version?: string;
}

/** File source — generates data from an Azure OpenAI file. */
model FileDataGenerationJobSource extends DataGenerationJobSource {
  type: DataGenerationJobSourceType.File;

  /** Input Azure OpenAI file id. */
  id: string;
}

/** Dataset source — generates data from a dataset. */
model DatasetDataGenerationJobSource extends DataGenerationJobSource {
  type: DataGenerationJobSourceType.Dataset;

  /** Input dataset name. */
  name: string;

  /** Optional dataset version. */
  version?: string;
}

// ---- Options models -------------------------------------------------------

/** LLM model options for data generation. */
model DataGenerationModelOptions {
  /** Base model name used to generate data. */
  model_name: string;
}

/** Options for managing data generation jobs. */
@discriminator("type")
model DataGenerationJobOptions {
  /** The data generation job type. */
  type: DataGenerationJobType;

  /** Maximum number of samples to generate. */
  max_samples_count: int32;

  /** Model options (required when source type is not Traces). */
  model_options?: DataGenerationModelOptions;
}

/** Options for SimpleQnA job type. */
model SimpleQnADataGenerationJobOptions extends DataGenerationJobOptions {
  type: DataGenerationJobType.SimpleQnA;

  /** Question types to generate (fine-tuning only). */
  question_types?: SimpleQnAFineTuningQuestionType[];
}

/** Options for ToolUse job type (fine-tuning only). */
model ToolUseFineTuningDataGenerationJobOptions extends DataGenerationJobOptions {
  type: DataGenerationJobType.ToolUse;
}

/** Options for MultiTurn job type. */
model MultiTurnDataGenerationJobOptions extends DataGenerationJobOptions {
  type: DataGenerationJobType.MultiTurn;
}

// ---- Output models --------------------------------------------------------

/** Output information for a data generation job. */
@discriminator("type")
model DataGenerationJobOutput {
  /** The type of the output. */
  type: DataGenerationJobOutputType;
}

/** Azure OpenAI file output. */
model FileDataGenerationJobOutput extends DataGenerationJobOutput {
  type: DataGenerationJobOutputType.File;

  /** The id of the output file. */
  @visibility(Lifecycle.Read)
  id: string;

  /** The filename of the output file. */
  @visibility(Lifecycle.Read)
  filename: string;
}

/** Dataset output. */
model DatasetDataGenerationJobOutput extends DataGenerationJobOutput {
  type: DataGenerationJobOutputType.Dataset;

  /** The id of the output dataset. */
  @visibility(Lifecycle.Read)
  id?: string;

  /** The name of the output dataset. */
  name?: string;

  /** The version of the output dataset. */
  @visibility(Lifecycle.Read)
  version?: string;

  /** Description of the output dataset. */
  description?: string;

  /** Tag dictionary for the output dataset. */
  tags?: Record<string>;
}

// ---- Supporting models ----------------------------------------------------

/** Token usage information for a data generation job. */
model TokenUsage {
  /** The number of prompt tokens used. */
  prompt_tokens?: int32;

  /** The number of completion tokens generated. */
  completion_tokens?: int32;

  /** Total number of tokens used. */
  total_tokens?: int32;
}

// ============================================================================
// DATA GENERATION — Job Model (composed from generics)
// ============================================================================

/** Result produced by a successful data generation job. */
model DataGenerationResult {
  /** The final job outputs. */
  outputs?: DataGenerationJobOutput[];

  /** Number of samples actually generated. */
  generated_samples?: int32;

  /** Token usage information. */
  token_usage?: TokenUsage;
}

/** Caller-supplied inputs for a data generation job. */
model DataGenerationInputs {
  /** Display name of the job. */
  name: string;

  /** Sources used for data generation. */
  sources: DataGenerationJobSource[];

  /** Generation options (discriminated by type). */
  options: DataGenerationJobOptions;

  /** The scenario — fine-tuning or evaluation. */
  scenario: DataGenerationJobScenario;
}

/**
 * A data generation job composed from the generic JobLike template.
 *
 * Wire shape:
 * ```json
 * {
 *   "id": "...",
 *   "status": "running",
 *   "inputs": { "name": "...", "sources": [...], "options": {...}, "scenario": "..." },
 *   "result": { "outputs": [...], "generated_samples": 100, "token_usage": {...} },
 *   "error": null,
 *   "created_at": 1712345678,
 *   "finished_at": null
 * }
 * ```
 */
model DataGenerationJob
  is JobLike<DataGenerationResult, DataGenerationInputs, DataGenerationJobStatus> {
  /** Unix timestamp (seconds) when the job was created. */
  @visibility(Lifecycle.Read)
  created_at: int64;

  /** Unix timestamp (seconds) when the job finished. */
  @visibility(Lifecycle.Read)
  finished_at?: int64;
}

// ============================================================================
// DATA GENERATION — Concrete Operations
// ============================================================================

@route("data_generation/jobs")
op createDataGenerationJob is postJob<DataGenerationJob>;

@route("data_generation/jobs/{jobId}")
op getDataGenerationJob is queryJobStatus<DataGenerationJob>;

@route("data_generation/jobs")
op listDataGenerationJobs is listJobs<DataGenerationJob>;

@route("data_generation/jobs/{jobId}/cancel")
op cancelDataGenerationJob is cancelJob<DataGenerationJob>;

@route("data_generation/jobs/{jobId}")
op deleteDataGenerationJob is deleteJob;
