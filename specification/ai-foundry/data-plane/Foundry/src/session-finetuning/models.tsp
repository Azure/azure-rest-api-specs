import "../common/servicepatterns.tsp";

using TypeSpec.Http;
using Azure.AI.Projects;

namespace Azure.AI.FineTuning.Sessions;

// ─── Enums ────────────────────────────────────────────────────────────────────

/**
 * Lifecycle status of a fine-tuning session.
 *
 * Uses the canonical fine-tuning job vocabulary for consistency
 * across all API surfaces.
 */
union FineTuningSessionStatus {
  string,
  /** Session has been created and is waiting for the GPU engine. */
  queued: "queued",
  /** Session is loaded and actively processing requests. */
  running: "running",
  /** Session completed successfully. */
  succeeded: "succeeded",
  /**
   * Session ended in a non-success terminal state (engine death, expiry,
   * or unrecoverable failure). Any in-memory weights are lost.
   */
  failed: "failed",
}

/** Lifecycle status of an async fine-tuning operation — standard Azure LRO values. */
union FineTuningOperationStatus {
  string,
  /** Operation is in progress. */
  running: "running",
  /** Operation completed successfully. */
  succeeded: "succeeded",
  /** Operation failed. */
  failed: "failed",
}

/** Supported loss functions for forward-backward passes. */
union FineTuningLossFn {
  /** Standard language-model cross-entropy loss. */
  cross_entropy: "cross_entropy",
  /** REINFORCE-style importance-sampled policy gradient loss. */
  importance_sampling: "importance_sampling",
  /** PPO (Proximal Policy Optimization) clipped surrogate loss. */
  ppo: "ppo",
  /** Clipped Importance-Sampled Policy Optimization (CISPO) loss. */
  cispo: "cispo",
  /** Soft-Advantage Policy Optimization (SAPO) loss. */
  sapo: "sapo",
}

/** Fine-tuning checkpoint type. */
union FineTuningCheckpointType {
  string,
  /** Full training checkpoint (optimizer state + LoRA weights). */
  training: "training",
  /** Sampler-compatible weights snapshot (no optimizer state). */
  sampler: "sampler",
}

/** Fine-tuning session type. */
union FineTuningSessionType {
  /** A training session for fine-tuning a model. */
  training: "training",
}

/** Discriminator values for async fine-tuning operation results. */
union FineTuningOperationType {
  string,
  /** A forward-backward pass operation. */
  forward_backward: "forward_backward",
  /** An optimizer step operation. */
  optim_step: "optim_step",
  /** A sampling operation. */
  sample: "sample",
  /** A training checkpoint save operation. */
  save_checkpoint: "save_checkpoint",
  /** A sampler-weights save operation. */
  save_sampler_weights: "save_sampler_weights",
}

// ─── Common primitives ────────────────────────────────────────────────────────

/** A 1-D array of floating-point values serialised for the wire. */
model TensorData {
  /** The floating-point values of the tensor. */
  data: float64[];
}

/** A contiguous block of token IDs forming part of a model input. */
model FineTuningModelInputChunk {
  /** Sequence of token IDs in this chunk. */
  tokens: int32[];
}

/** Full model input as one or more token-ID chunks. */
model FineTuningModelInput {
  /** Ordered list of token-ID chunks that together form the complete model input. */
  chunks: FineTuningModelInputChunk[];
}

// ─── LoRA configuration ───────────────────────────────────────────────────────

/**
 * LoRA adapter configuration.
 * `rank` is fixed server-side for v1; omit to use the server default.
 */
model LoRAConfig {
  /** Number of LoRA rank dimensions. */
  rank?: int32;

  /** LoRA scaling factor (effective scale = alpha / rank). Defaults to 32.0 server-side. */
  alpha?: float64;

  /**
   * Seed for LoRA weight initialisation.
   * If omitted, the server picks a random seed and echoes it back.
   */
  seed?: int64;
}

// ─── Adam optimizer parameters ────────────────────────────────────────────────

/** Adam optimizer hyper-parameters. */
model AdamParams {
  @doc("Learning rate.")
  learning_rate: float64 = 1e-4;

  @doc("Adam β₁ coefficient.")
  beta1: float64 = 0.9;

  @doc("Adam β₂ coefficient.")
  beta2: float64 = 0.95;

  @doc("Adam ε (numerical stability floor).")
  eps: float64 = 1e-12;

  @doc("L₂ weight-decay coefficient.")
  weight_decay: float64 = 0.0;
}

// ─── Sampling parameters ──────────────────────────────────────────────────────

/**
 * Stop criteria for generation — either a list of token IDs or a list of
 * strings, but never both.
 */
union FineTuningStopCriteria {
  /** Stop when any of these token IDs is produced. */
  stop_token_ids: int32[];

  /** Stop when any of these strings appears in the output. */
  stop_strings: string[];
}

/** Token-generation sampling parameters. */
model FineTuningSamplingParams {
  /** Maximum tokens to generate. */
  max_tokens: int32;

  /** Softmax temperature. Default 1.0. */
  temperature: float64 = 1.0;

  /** Nucleus (top-p) probability mass. Default 1.0. */
  top_p: float64 = 1.0;

  /** Top-k candidates. -1 = disabled. */
  top_k: int32 = -1;

  /** RNG seed for reproducible samples. Server chooses randomly if omitted. */
  seed?: int64;

  /** Stop criteria: either stop_token_ids or stop_strings, not both. */
  stop_criteria?: FineTuningStopCriteria;
}

// ─── Training data ────────────────────────────────────────────────────────────

/** Per-datum loss function inputs used in forward-backward. */
model LossFnInputs {
  /** Target token ids (shifted by 1 relative to model input). */
  target_tokens: TensorData;

  /** Per-token weights (0.0 = masked, 1.0 = counted). */
  weights: TensorData;

  /**
   * Per-token advantage estimates (required for REINFORCE/PPO (Proximal Policy Optimization)/CISPO (Clipped Importance-Sampled Policy Optimization)/SAPO (Soft-Advantage Policy Optimization)).
   * Omit or pass empty array for cross-entropy.
   */
  advantages?: TensorData;

  /**
   * Per-token reference log-probabilities for KL-divergence regularisation.
   * Omit or pass empty array to skip KL.
   */
  logprobs?: TensorData;
}

/** A single training example. */
model FineTuningDatum {
  /** Token-ID input to the model. */
  model_input: FineTuningModelInput;

  /** Loss-function targets, aligned with model_input tokens. */
  loss_fn_inputs: LossFnInputs;
}

/** Optional per-loss-function hyper-parameters. */
model LossFnConfig {
  /** PPO (Proximal Policy Optimization) / CISPO (Clipped Importance-Sampled Policy Optimization): lower clip threshold. */
  clip_low_threshold?: float64;

  /** PPO (Proximal Policy Optimization) / CISPO (Clipped Importance-Sampled Policy Optimization): upper clip threshold. */
  clip_high_threshold?: float64;

  /** SAPO (Soft-Advantage Policy Optimization): positive advantage temperature. */
  tau_pos?: float64;

  /** SAPO (Soft-Advantage Policy Optimization): negative advantage temperature. */
  tau_neg?: float64;
}

// ─── Async operation handle ───────────────────────────────────────────────────

/**
 * Handle for a long-running fine-tuning operation.
 * Check `status` to track progress; the operation is complete when
 * `status` reaches `"succeeded"` or `"failed"`.
 */
model FineTuningPendingOperation {
  /** Unique identifier for this operation. */
  @visibility(Lifecycle.Read)
  operation_id: string;

  /** Current status of the operation. */
  @visibility(Lifecycle.Read)
  status: FineTuningOperationStatus;
}

// ─── Session resource ─────────────────────────────────────────────────────────

/** Nested model sub-object within a session response. */
model FineTuningSessionModelData {
  base_model: string;
  lora_config?: LoRAConfig;
  model_name?: string;
}

/** Response from GET /fine_tuning_sessions/{sessionId}. */
model FineTuningSession {
  /** Unique identifier for this fine-tuning session. */
  @visibility(Lifecycle.Read)
  session_id: string;

  /** The session type. */
  type: FineTuningSessionType;

  /** Current lifecycle status of the session. */
  @visibility(Lifecycle.Read)
  status: FineTuningSessionStatus;

  /** Model and adapter configuration associated with this session. */
  model_data: FineTuningSessionModelData;
}

/** Summary item returned in the paginated GET /fine_tuning_sessions list. */
model FineTuningSessionSummary {
  /** Unique identifier for this fine-tuning session. */
  @visibility(Lifecycle.Read)
  session_id: string;

  /** Base model used for this fine-tuning session. */
  base_model: string;

  /** Current lifecycle status of the session. */
  @visibility(Lifecycle.Read)
  status: FineTuningSessionStatus;

  /** Whether the session uses a LoRA adapter. */
  is_lora: boolean;
  /** LoRA rank, if applicable. */
  lora_rank?: int32;
  /** Indicates whether the session state is corrupted and cannot be resumed. */
  corrupted: boolean;

  /** Timestamp of the most recent request made against this session. */
  @visibility(Lifecycle.Read)
  last_request_time: utcDateTime;
}

/** Pagination cursor returned in list responses. */
model FineTuningCursor {
  /** Zero-based index of the first item in the current page. */
  offset: int32;
  /** Maximum number of items per page. */
  limit: int32;
  /** Total number of items across all pages. */
  total_count: int32;
}

// ─── Checkpoint resource ──────────────────────────────────────────────────────

/** A checkpoint item returned in GET /fine_tuning_sessions/{sessionId}/checkpoints. */
model FineTuningCheckpoint {
  @visibility(Lifecycle.Read)
  checkpoint_id: string;

  @visibility(Lifecycle.Read)
  checkpoint_type: FineTuningCheckpointType;

  /** Timestamp when the checkpoint was saved. */
  @visibility(Lifecycle.Read)
  time: utcDateTime;
}

/** Detailed metadata for a single checkpoint. */
model FineTuningCheckpointInfo {
  base_model: string;
  is_lora: boolean;
  lora_rank?: int32;
}

// ─── Request bodies ───────────────────────────────────────────────────────────

/** Request body for POST /fine_tuning_sessions. */
model CreateFineTuningSessionRequest {
  /** The session type. */
  type: FineTuningSessionType;

  base_model: string;

  /** LoRA adapter config. Rank is fixed server-side for v1; omit to use the server default. */
  lora_config?: LoRAConfig;

  user_metadata?: Record<string>;

  /** Opt the session into idle hibernation. Default False. */
  ejectable?: boolean;
}

/**
 * Response from POST /fine_tuning_sessions.
 *
 * `session_id` is an array of two identifiers:
 *
 * - `session_xxx` — use as `{sessionId}` for training operations
 * - `sampling_xxx` — use as `{samplingId}` for sampling operations
 */
model CreateFineTuningSessionResponse {
  session_id: string[];
  type: FineTuningSessionType;
  base_model: string;
  lora_config?: LoRAConfig;
  status: FineTuningSessionStatus;
  operation_id: string;
  info_message?: string;
  warning_message?: string;
  user_metadata?: Record<string>;
}

/** Inner payload for a forward-backward request. */
model ForwardBackwardInput {
  data: FineTuningDatum[];
  loss_fn: FineTuningLossFn;
  loss_fn_config?: LossFnConfig;
}

/** Request body for POST /fine_tuning_sessions/{sessionId}/forward_backward. */
model ForwardBackwardRequest {
  forward_backward_input: ForwardBackwardInput;
}

/**
 * Forward-only payload.
 *
 * Currently identical to ForwardBackwardInput. Exists as a named alias so
 * that the forward endpoint has its own type in the SDK, allowing the
 * contract to diverge later (e.g. making loss_fn optional for forward).
 */
model ForwardInput extends ForwardBackwardInput {}

/** Request body for POST /fine_tuning/sessions/{sessionId}/forward. */
model ForwardRequest {
  forward_input: ForwardInput;
}

/** Request body for POST /fine_tuning_sessions/{sessionId}/optim_step. */
model OptimStepRequest {
  adam_params: AdamParams;
}

/** Request body for POST /fine_tuning_sessions/{sessionId}/checkpoint. */
model SaveCheckpointRequest {
  /**
   * User-supplied checkpoint identifier.
   * Alphanumeric plus underscores and hyphens; max 255 characters.
   */
  @pattern("^[a-zA-Z0-9_-]+$")
  @maxLength(255)
  path: string;

  /** Training iteration this checkpoint corresponds to. Optional. */
  step_number?: int32;

  /** Per-step evaluation metrics at checkpoint time. Optional. */
  metrics?: Record<unknown>;
}

/** Request body for POST /fine_tuning_sessions/{sessionId}/checkpoint_sample. */
model SaveSamplerWeightsRequest {
  /** Optional explicit identifier for the sampler checkpoint. */
  @pattern("^[a-zA-Z0-9_-]+$")
  @maxLength(255)
  path?: string;

  /** Ordinal of this sampling session within the training run. */
  sampling_session_seq_id?: int32;

  /** Training step sequence number. */
  seq_id?: int32;
}

/** Request body for POST /fine_tuning_sessions/{sessionId}/sample. */
model FineTuningSampleRequest {
  /** Number of independent completions to generate. Default 1. */
  num_samples: int32 = 1;

  /** Tokenised input prompt. */
  prompt: FineTuningModelInput;

  sampling_params: FineTuningSamplingParams;

  /** Sampling session ID from a prior save_sampler_weights call. */
  sampling_session_id?: string;

  /** Training step index; must match the seq_id used in save_sampler_weights. */
  seq_id?: int32;

  /** If true, return per-token log-probabilities for the prompt tokens. */
  prompt_logprobs?: boolean;

  /** Number of top-k log-probabilities to return per prompt token. 0 = none. */
  topk_prompt_logprobs: int32 = 0;
}

// ─── Response bodies ──────────────────────────────────────────────────────────

/** Paginated list of fine-tuning sessions. */
model FineTuningSessionList {
  data: FineTuningSessionSummary[];
  cursor: FineTuningCursor;
}

/** List of all checkpoints for a session (no pagination). */
model FineTuningCheckpointList {
  checkpoints: FineTuningCheckpoint[];
}

/** Response from POST /fine_tuning_sessions/{sessionId}/complete. */
model FineTuningCompleteResponse {
  session_id: string;
  operation_id: string;
}

/** Response from POST /fine_tuning_sessions/{sessionId}/session_heartbeat. */
model FineTuningHeartbeatResponse {
  session_id: string;
}

// ─── Operation result payloads ────────────────────────────────────────────────

/** A single sampled sequence. */
model FineTuningSampledSequence {
  tokens: int32[];

  /** Decoded text of the generated sequence. */
  text?: string;

  logprobs?: float64[];
  prompt_logprobs?: float64[];
}

/** Result of a completed sample operation. */
model FineTuningSampleResult {
  sequences: FineTuningSampledSequence[];
}

/** Result of a completed forward-backward pass. */
model ForwardBackwardResult {
  total_loss: float64;
  per_datum_logprobs?: TensorData[];
  metrics?: Record<float64>;
}

/** Result of a completed optimizer step. */
model OptimStepResult {
  grad_norm: float64;
  step_count: int32;
  metrics?: Record<float64>;
}

/** Result of a completed training checkpoint save. */
model SaveCheckpointResult {
  checkpoint_id: string;
  path: string;
}

/** Result of a completed sampler-weights save. */
model SaveSamplerWeightsResult {
  checkpoint_id: string;
  sampling_session_id: string;
}

/**
 * Discriminated union of all async operation results.
 * Returned by GET /fine_tuning_sessions/{sessionId}/operations/{operationId}.
 */
@discriminator("type")
model FineTuningOperationResult {
  type: FineTuningOperationType;

  @visibility(Lifecycle.Read)
  operation_id: string;

  @visibility(Lifecycle.Read)
  status: FineTuningOperationStatus;
}

model ForwardBackwardOperationResult extends FineTuningOperationResult {
  type: FineTuningOperationType.forward_backward;
  ...ForwardBackwardResult;
}

model OptimStepOperationResult extends FineTuningOperationResult {
  type: FineTuningOperationType.optim_step;
  ...OptimStepResult;
}

model FineTuningSampleOperationResult extends FineTuningOperationResult {
  type: FineTuningOperationType.sample;
  ...FineTuningSampleResult;
}

model SaveCheckpointOperationResult extends FineTuningOperationResult {
  type: FineTuningOperationType.save_checkpoint;
  ...SaveCheckpointResult;
}

model SaveSamplerWeightsOperationResult extends FineTuningOperationResult {
  type: FineTuningOperationType.save_sampler_weights;
  ...SaveSamplerWeightsResult;
}
