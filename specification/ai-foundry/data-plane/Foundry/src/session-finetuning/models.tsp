import "./service.tsp";

namespace Azure.AI.Projects.SessionFineTuning;

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

/** Supported loss functions for forward-backward passes. */
union FineTuningLossFn {
  string,
  /** Standard language-model cross-entropy loss. */
  cross_entropy: "cross_entropy",
  /** REINFORCE-style importance-sampled policy gradient loss. */
  importance_sampling: "importance_sampling",
  /** PPO (Proximal Policy Optimization) clipped surrogate loss. */
  ppo: "ppo",
  /** Clipped Importance-Sampled Policy Optimization (CISPO) loss. */
  cispo: "cispo",
  /** Soft Adaptive Policy Optimization (SAPO) loss. */
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
  string,
  /** A training session for fine-tuning a model. */
  training: "training",
}

/** Training tiers available for fine-tuning sessions. */
union FineTuningTrainingType {
  string,
  /** Standard training using globally available capacity. */
  GlobalStandard: "GlobalStandard",
  /** Standard training constrained to the applicable data zone. */
  DatazoneStandard: "DatazoneStandard",
  /** Developer-tier training, subject to service eligibility. */
  DeveloperTier: "DeveloperTier",
}

/** Supported encodings for an image supplied as model input. */
union FineTuningImageFormat {
  string,
  /** JPEG image encoding. */
  jpeg: "jpeg",
  /** PNG image encoding. */
  png: "png",
  /** WebP image encoding. */
  webp: "webp",
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

/**
 * An image supplied as part of a multimodal input.
 * Each decoded image must not exceed 10 MB. The service validates the image
 * content and token count at runtime.
 */
model FineTuningImageChunk {
  /** Identifies this chunk as an image. */
  type: "image" = "image";

  /** Image bytes, serialized as a base64-encoded string. */
  @encode("base64")
  data: bytes;

  /** Encoding of the supplied image bytes. */
  format: FineTuningImageFormat;

  /** Number of model tokens expected to represent this image. */
  @minValue(1)
  expected_tokens: int32;
}

/** A text-token or image chunk within a model input. */
union FineTuningInputChunk {
  /** A contiguous sequence of text tokens. */
  text: FineTuningModelInputChunk,
  /** An encoded image. */
  image: FineTuningImageChunk,
}

/** Full model input as an ordered sequence of token-ID and image chunks. */
model FineTuningModelInput {
  /**
   * Chunks forming the complete model input. At most 64 image chunks are
   * allowed per example; the service enforces this limit at runtime.
   */
  chunks: FineTuningInputChunk[];
}

// ─── LoRA configuration ───────────────────────────────────────────────────────

/**
 * LoRA adapter configuration.
 * Omit optional settings to use the server defaults.
 */
model LoRAConfig {
  /** Number of LoRA rank dimensions required by the service. */
  rank: int32;

  /** LoRA scaling factor (effective scale = alpha / rank). Defaults to 32.0 server-side. */
  alpha?: float64;

  /**
   * Seed for LoRA weight initialisation.
   * If omitted, the server picks a random seed and echoes it back.
   */
  seed?: int64;

  /** Whether to freeze the vision tower during training. Defaults to true server-side. */
  freeze_vision_tower?: boolean;

  /** Whether to freeze the multimodal projector during training. Defaults to true server-side. */
  freeze_multi_modal_projector?: boolean;
}

// ─── Adam optimizer parameters ────────────────────────────────────────────────

/** Adam optimizer hyper-parameters. */
model AdamParams {
  /** Nonnegative learning rate. Defaults to 0.0001. */
  @minValue(0)
  learning_rate?: float64 = 1e-4;

  /** Adam first-moment coefficient, from zero inclusive to one exclusive. Defaults to 0.9. */
  @minValue(0)
  @maxValueExclusive(1)
  beta1?: float64 = 0.9;

  /** Adam second-moment coefficient, from zero inclusive to one exclusive. Defaults to 0.95. */
  @minValue(0)
  @maxValueExclusive(1)
  beta2?: float64 = 0.95;

  /** Positive numerical stability floor. Defaults to 0.000000000001. */
  @minValueExclusive(0)
  eps?: float64 = 1e-12;

  /** Nonnegative L2 weight-decay coefficient. Defaults to zero. */
  @minValue(0)
  weight_decay?: float64 = 0.0;
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
  /** Maximum number of tokens to generate. Must be positive. */
  @minValue(1)
  max_tokens: int32;

  /** Softmax temperature. Default 1.0. */
  temperature?: float64 = 1.0;

  /** Nucleus (top-p) probability mass. Default 1.0. */
  top_p?: float64 = 1.0;

  /** Top-k candidates. -1 = disabled. */
  top_k?: int32 = -1;

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

  /** Per-token weights (0.0 = masked, 1.0 = counted). Omission uses a weight of one for each target. */
  weights?: TensorData;

  /**
   * Per-token advantage estimates (required for REINFORCE/PPO (Proximal Policy Optimization)/CISPO (Clipped Importance-Sampled Policy Optimization)/SAPO (Soft Adaptive Policy Optimization)).
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
  /** Token-ID and optional image input to the model. */
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

  /** SAPO (Soft Adaptive Policy Optimization): positive advantage temperature. */
  tau_pos?: float64;

  /** SAPO (Soft Adaptive Policy Optimization): negative advantage temperature. */
  tau_neg?: float64;
}

// ─── Pending request handles ──────────────────────────────────────────────────

/** Identifies an accepted request whose result can be retrieved by polling. */
model FineTuningPendingOperation {
  /** Request identifier to pass to the session's request-status endpoint. */
  @visibility(Lifecycle.Read)
  request_id: string;

  /** Indicates that the request has not yet completed. */
  @visibility(Lifecycle.Read)
  status: "pending";
}

/** Identifies an accepted training request and its fine-tuning session. */
model FineTuningActionOperation {
  ...FineTuningPendingOperation;
  /** Identifier of the session processing this request. */
  @visibility(Lifecycle.Read)
  session_id: string;
}

// ─── Request-status responses ─────────────────────────────────────────────────

/** Status envelope returned when polling a fine-tuning request. */
@discriminator("status")
model FineTuningRequestStatus {
  /** Request state, which determines the shape of the status response. */
  status: string;
}

/** A request that is still being processed. */
model PendingFineTuningRequest extends FineTuningRequestStatus {
  /** Indicates that the request has not yet completed. */
  status: "pending";

  /** Current processing phase, when reported by the service. */
  phase?: string | null;
}

/** A request that completed successfully. */
model CompletedFineTuningRequest extends FineTuningRequestStatus {
  /** Indicates that the request completed successfully. */
  status: "completed";

  /** Raw result payload, whose properties depend on the submitted request. */
  result: Record<unknown>;
}

/** A request that failed during processing. */
model FailedFineTuningRequest extends FineTuningRequestStatus {
  /** Indicates that the request failed. */
  status: "failed";

  /** Description of the failure. */
  error: string;

  /** Machine-readable error code, when available. */
  error_code?: string | null;

  /** Diagnostic reference that can be provided when requesting support. */
  debug_ref?: string | null;

  /** Whether the service recommends retrying the failed request. */
  should_retry?: boolean | null;

  /** Recommended delay in seconds before retrying the failed request. */
  retry_after_sec?: float64 | null;
}

// ─── Session resource ─────────────────────────────────────────────────────────

/** Nested model sub-object within a session response. */
model FineTuningSessionModelData {
  /** Base model used by the session. */
  base_model: string;

  /** LoRA adapter configuration, when the model uses an adapter. */
  lora_config?: LoRAConfig | null;

  /** Name of the model associated with the session, when available. */
  model_name?: string | null;
}

/** Response from GET /fine_tuning/sessions/{sessionId}. */
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

/** Summary item returned in the paginated GET /fine_tuning/sessions list. */
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
  lora_rank?: int32 | null;
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

/** A checkpoint item returned in GET /fine_tuning/sessions/{sessionId}/checkpoints. */
model FineTuningCheckpoint {
  /** Identifier of the saved checkpoint within the session. */
  @visibility(Lifecycle.Read)
  checkpoint_id: string;

  /** Whether the checkpoint contains training state or sampler weights. */
  @visibility(Lifecycle.Read)
  checkpoint_type: FineTuningCheckpointType;

  /** Timestamp when the checkpoint was saved. */
  @visibility(Lifecycle.Read)
  time: utcDateTime;

  /** Training step associated with the checkpoint, when recorded. */
  @visibility(Lifecycle.Read)
  @minValue(0)
  step_number?: int32 | null;

  /** Metrics stored with the checkpoint, retaining their JSON value types. */
  @visibility(Lifecycle.Read)
  metrics?: Record<unknown> | null;
}

/** Detailed metadata for a single checkpoint. */
model FineTuningCheckpointInfo {
  /** Base model from which the checkpoint was created. */
  base_model: string;

  /** Whether the checkpoint contains a LoRA adapter. */
  is_lora: boolean;

  /** LoRA rank of the checkpoint, if applicable. */
  lora_rank?: int32 | null;
}

// ─── Request bodies ───────────────────────────────────────────────────────────

/** A training checkpoint used to initialize a new fine-tuning session. */
model FineTuningFromCheckpoint {
  /** Identifier of the session containing the source training checkpoint. */
  @pattern("^[a-zA-Z0-9_-]+$")
  @maxLength(255)
  source_session_id: string;

  /** Identifier of the training checkpoint within the source session. */
  @pattern("^[a-zA-Z0-9_-]+$")
  @maxLength(255)
  checkpoint_id: string;
}

/** Request body for POST /fine_tuning/sessions. */
model CreateFineTuningSessionRequest {
  /** The session type. */
  type: FineTuningSessionType;

  /** Base model to use for the new training session. */
  base_model: string;

  /** Required LoRA adapter configuration, including the adapter rank. */
  lora_config: LoRAConfig;

  /** Caller-provided metadata whose values can be any JSON value. */
  user_metadata?: Record<unknown> | null;

  /** Training checkpoint to load while initializing the session, when provided. */
  from_checkpoint?: FineTuningFromCheckpoint | null;

  /**
   * Training tier. When omitted, the service defaults to GlobalStandard unless
   * the legacy user_metadata.DeveloperTier setting selects DeveloperTier.
   */
  training_type?: FineTuningTrainingType;
}

/**
 * Response from POST /fine_tuning/sessions.
 * Poll the returned request identifier to track session initialization.
 */
model CreateFineTuningSessionResponse {
  /** Identifier of the newly created fine-tuning session. */
  session_id: string;

  /** Type of session created by the service. */
  type: string;

  /** Base model used by the session. */
  base_model: string;

  /** LoRA adapter configuration selected for the session. */
  lora_config: LoRAConfig;

  /** Current lifecycle status, which can initially be created or queued. */
  status: FineTuningSessionStatus;

  /** Request identifier used to poll for session initialization. */
  request_id: string;

  /** Informational message associated with session creation, when available. */
  info_message?: string | null;

  /** Warning associated with session creation, when available. */
  warning_message?: string | null;

  /** Caller-provided metadata associated with the session. */
  user_metadata?: Record<unknown> | null;
}

/** Inner payload for a forward-backward request. */
model ForwardBackwardInput {
  /** Training examples to process in this batch. */
  data: FineTuningDatum[];

  /** Loss function to evaluate for the batch. */
  loss_fn: FineTuningLossFn;

  /** Optional hyper-parameters for the selected loss function. */
  loss_fn_config?: LossFnConfig;
}

/** Request body for POST /fine_tuning/sessions/{sessionId}/forward_backward. */
model ForwardBackwardRequest {
  /** Batch inputs for the combined forward and backward pass. */
  forward_backward_input: ForwardBackwardInput;
}

/**
 * Inputs for a forward-only pass without gradient accumulation.
 * Uses the same batch and loss configuration as a forward-backward pass.
 */
model ForwardInput {
  ...ForwardBackwardInput;
}

/** Request body for POST /fine_tuning/sessions/{sessionId}/forward. */
model ForwardRequest {
  /** Batch inputs for the forward-only pass. */
  forward_input: ForwardInput;
}

/** Request body for POST /fine_tuning/sessions/{sessionId}/optim_step. */
model OptimStepRequest {
  /** Adam optimizer parameters used to apply accumulated gradients. */
  adam_params: AdamParams;
}

/** Request body for POST /fine_tuning/sessions/{sessionId}/checkpoint. */
model SaveCheckpointRequest {
  /**
   * User-supplied checkpoint identifier.
   * Alphanumeric plus underscores and hyphens; max 255 characters.
   */
  @pattern("^[a-zA-Z0-9_-]+$")
  @maxLength(255)
  path: string;

  /** Training iteration this checkpoint corresponds to. Optional. */
  @minValue(0)
  step_number?: int32;

  /** Per-step evaluation metrics at checkpoint time. Optional. */
  metrics?: Record<unknown>;
}

/**
 * Request body for POST /fine_tuning/sessions/{sessionId}/checkpoint_sample.
 * Supply either path or both sampling_session_seq_id and seq_id. The service
 * validates this requirement at runtime.
 */
model SaveSamplerWeightsRequest {
  /** Explicit sampler checkpoint identifier. Required unless both sequence identifiers are supplied. */
  @pattern("^[a-zA-Z0-9_-]+$")
  @maxLength(255)
  path?: string;

  /** Ordinal of this sampling session within the training run. Required with seq_id when path is omitted. */
  sampling_session_seq_id?: int32;

  /** Training step sequence number. Required with sampling_session_seq_id when path is omitted. */
  seq_id?: int32;

  /** Identifies the request as saving sampler-compatible weights. */
  type?: "save_weights_for_sampler" = "save_weights_for_sampler";
}

/** Request body for POST /fine_tuning/sessions/{sessionId}/sample. */
model FineTuningSampleRequest {
  /** Number of independent completions to generate. Default 1. */
  num_samples?: int32 = 1;

  /** Tokenised input prompt. */
  prompt: FineTuningModelInput;

  /** Parameters controlling token generation. */
  sampling_params: FineTuningSamplingParams;

  /** Sampling session identifier from a prior sampler-weights save request. */
  sampling_session_id?: string;

  /** Training step index; must match the seq_id used when saving sampler weights. */
  seq_id?: int32;

  /** Whether to return prompt-token log-probabilities in the overall sample result. Defaults to false server-side. */
  prompt_logprobs?: boolean;

  /** Number of top-k log-probabilities per prompt token. Defaults to zero (disabled); maximum 20. */
  @minValue(0)
  @maxValue(20)
  topk_prompt_logprobs?: int32 = 0;
}

// ─── Response bodies ──────────────────────────────────────────────────────────

/** Paginated list of fine-tuning sessions. */
model FineTuningSessionList {
  /** Sessions returned in the current page. */
  @pageItems
  data: FineTuningSessionSummary[];

  /** Offset, limit, and total count for the requested page. */
  cursor: FineTuningCursor;
}

/** List of all checkpoints for a session (no pagination). */
model FineTuningCheckpointList {
  /** All training and sampler checkpoints for the session, returned in one page. */
  @pageItems
  checkpoints: FineTuningCheckpoint[];
}

/** Response from POST /fine_tuning/sessions/{sessionId}/complete. */
model FineTuningCompleteResponse {
  /** Identifier of the session being unloaded. */
  session_id: string;

  /** Request identifier used to poll for completion of the unload request. */
  request_id: string;
}

/** Response from DELETE /fine_tuning/sessions/{sessionId}. */
model FineTuningDeleteSessionResponse {
  /** Identifier of the session targeted for deletion. */
  session_id: string;

  /** Whether the session is marked as deleted. */
  deleted: boolean;

  /** Identifies the response as a session deletion result. */
  type: "delete_session";
}

/** Response from POST /fine_tuning/sessions/{sessionId}/heartbeat. */
model FineTuningHeartbeatResponse {
  /** Identifier of the session whose heartbeat was refreshed. */
  session_id: string;

  /** Identifies the response as a session heartbeat acknowledgement, when included. */
  type?: "session_heartbeat";
}

// ─── Sampling output primitives ───────────────────────────────────────────────

/** A single sampled sequence within a sampling result payload. */
model FineTuningSampledSequence {
  /** Generated token identifiers, in sequence order. */
  tokens: int32[];

  /** Decoded text of the generated sequence, when available. */
  text?: string | null;

  /** Log-probabilities of the generated tokens, when available. */
  logprobs?: float64[] | null;
}
