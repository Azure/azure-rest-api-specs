// SDK-only tested preview model projection; not a REST specification.
// Source inventory: azure/ai/finetuningsessions/models/{_models.py,_enums.py}
// and azure/ai/finetuningsessions/_types.py in the current target SDK.
// 36 models, 116 directly declared properties, 7 extensible enums (26 named
// values), and the StopCriteria union. No handwritten patch-layer types.
// In particular, ModelInput below is the generated token-only base, not its
// multimodal override. No FromCheckpoint, ImageChunk, or extra REST models.
//
// Intended toolchain: Python emitter 0.61.3 / http-client-python 0.28.3 /
// client-generator-core 0.67.3 / TypeSpec compiler 1.11.0.
// This file declares no service or operations; client.tsp maps the REST types
// to these Python-only preview types. The REST service contract is unchanged.
// All declarations have explicit Python input/output usage for retention.
// Read-only properties retain Lifecycle.Read; other properties use the
// default five lifecycle visibilities. Optionality follows annotations and
// keyword constructors, not prose describing server defaults. No defaults,
// ranges, patterns, or additional service constraints are inferred here.
// int32/float64 project Python int/float; exact original widths cannot be
// recovered from Python annotations. Top-level Optional maps to ?, whereas
// explicitly nullable list elements retain | null. Known pinned-emitter
// tuple and nullable-element gaps are implemented in models/_patch.py, with
// exact customer-visible annotations, constructor overloads, and serializers.

import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@clientNamespace("azure.ai.finetuningsessions", "python")
namespace Azure.AI.FineTuning.Sessions.Loom;

/** Fine-tuning checkpoint type. */
@usage(Usage.input | Usage.output, "python")
union CheckpointType {
  /** Full training checkpoint (optimizer state + LoRA weights). */
  training: "training",
  /** Sampler-compatible weights snapshot (no optimizer state). */
  sampler: "sampler",
  string,
}

/** Type of FoundryFeaturesOptInKeys. */
@usage(Usage.input | Usage.output, "python")
union FoundryFeaturesOptInKeys {
  /** EVALUATIONS_V1_PREVIEW. */
  evaluations_v1_preview: "Evaluations=V1Preview",
  /** SCHEDULES_V1_PREVIEW. */
  schedules_v1_preview: "Schedules=V1Preview",
  /** RED_TEAMS_V1_PREVIEW. */
  red_teams_v1_preview: "RedTeams=V1Preview",
  /** INSIGHTS_V1_PREVIEW. */
  insights_v1_preview: "Insights=V1Preview",
  /** MEMORY_STORES_V1_PREVIEW. */
  memory_stores_v1_preview: "MemoryStores=V1Preview",
  /** FINETUNING_SESSIONS_V1_PREVIEW. */
  finetuning_sessions_v1_preview: "FineTuningSessions=V1Preview",
  string,
}

/** Supported loss functions for forward-backward passes. */
@usage(Usage.input | Usage.output, "python")
union LossFn {
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
  string,
}

/** Lifecycle status of an async fine-tuning operation — standard Azure LRO values. */
@usage(Usage.input | Usage.output, "python")
union OperationStatus {
  /** Operation is in progress. */
  running: "running",
  /** Operation completed successfully. */
  succeeded: "succeeded",
  /** Operation failed. */
  failed: "failed",
  string,
}

/** Discriminator values for async fine-tuning operation results. */
@usage(Usage.input | Usage.output, "python")
union OperationType {
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
  string,
}

/**
 * Lifecycle status of a fine-tuning session.
 *
 * Uses the canonical fine-tuning job vocabulary for consistency
 * across all API surfaces.
 */
@usage(Usage.input | Usage.output, "python")
union SessionStatus {
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
  string,
}

/** Fine-tuning session type. */
@usage(Usage.input | Usage.output, "python")
union SessionType {
  /** A training session for fine-tuning a model. */
  training: "training",
  string,
}

/** Stop criteria: either a list of token IDs or a list of stop strings. */
@usage(Usage.input | Usage.output, "python")
union StopCriteria {
  int32[],
  string[],
}

/** Adam optimizer hyper-parameters. */
@usage(Usage.input | Usage.output, "python")
model AdamParams {
  /** Learning rate. */
  learning_rate: float64;
  /** Adam β₁ coefficient. */
  beta1: float64;
  /** Adam β₂ coefficient. */
  beta2: float64;
  /** Adam ε (numerical stability floor). */
  eps: float64;
  /** L₂ weight-decay coefficient. */
  weight_decay: float64;
}

/** ApiError. */
@usage(Usage.input | Usage.output, "python")
model ApiError {
  code: string;
  message: string;
  param?: string;
  type?: string;
  details?: ApiError[];
  @encodedName("application/json", "additionalInfo")
  additional_info?: Record<unknown>;
  @encodedName("application/json", "debugInfo")
  debug_info?: Record<unknown>;
}

/** Error response for API failures. */
@usage(Usage.input | Usage.output, "python")
model ApiErrorResponse {
  error: ApiError;
}

/** A checkpoint item returned in GET /fine_tuning/sessions/{sessionId}/checkpoints. */
@usage(Usage.input | Usage.output, "python")
model Checkpoint {
  @visibility(Lifecycle.Read)
  checkpoint_id: string;
  @visibility(Lifecycle.Read)
  checkpoint_type: CheckpointType;
  /** Timestamp when the checkpoint was saved. */
  @visibility(Lifecycle.Read)
  time: utcDateTime;
}

/** Detailed metadata for a single checkpoint. */
@usage(Usage.input | Usage.output, "python")
model CheckpointInfo {
  base_model: string;
  is_lora: boolean;
  lora_rank?: int32;
}

/** List of all checkpoints for a session (no pagination). */
@usage(Usage.input | Usage.output, "python")
model CheckpointList {
  checkpoints: Checkpoint[];
}

/** Request body for POST /fine_tuning/sessions. */
@usage(Usage.input | Usage.output, "python")
model CreateSessionRequest {
  /** The session type. */
  type: SessionType;
  base_model: string;
  /** LoRA adapter config. Rank is fixed server-side for v1; omit to use the server default. */
  lora_config?: LoRAConfig;
  user_metadata?: Record<unknown>;
  /** Opt the session into idle hibernation. Default False. */
  ejectable?: boolean;
  /** Training SKU type: 'GlobalStandard', 'DatazoneStandard', or 'DeveloperTier'. Default 'GlobalStandard'. */
  training_type?: string;
}

/** Pagination cursor returned in list responses. */
@usage(Usage.input | Usage.output, "python")
model Cursor {
  /** Zero-based index of the first item in the current page. */
  offset: int32;
  /** Maximum number of items per page. */
  limit: int32;
  /** Total number of items across all pages. */
  total_count: int32;
}

/** A single training example. */
@usage(Usage.input | Usage.output, "python")
model Datum {
  /** Token-ID input to the model. */
  model_input: ModelInput;
  /** Loss-function targets, aligned with model_input tokens. */
  loss_fn_inputs: LossFnInputs;
}

/** Inner payload for a forward-backward request. */
@usage(Usage.input | Usage.output, "python")
model ForwardBackwardInput {
  data: Datum[];
  loss_fn: LossFn;
  loss_fn_config?: LossFnConfig;
}

/**
 * Discriminated union of all async operation results. Returned by GET
 * /fine_tuning/sessions/{sessionId}/operations/{operationId}.
 */
@usage(Usage.input | Usage.output, "python")
@discriminator("type")
model OperationResult {
  // The pinned Python generator annotates a base discriminator as str even
  // when its TypeSpec type is an enum-like union. The named variants below
  // retain the target's Literal[OperationType.X] derived discriminators.
  type: OperationType;
  @visibility(Lifecycle.Read)
  operation_id: string;
  @visibility(Lifecycle.Read)
  status: OperationStatus;
}

/** ForwardBackwardOperationResult. */
@usage(Usage.input | Usage.output, "python")
model ForwardBackwardOperationResult extends OperationResult {
  type: OperationType.forward_backward;
  /** Aggregate training loss, or None when the operation does not report one. */
  total_loss?: float64;
  /** Shape/type identifier for each loss output. */
  loss_fn_output_type?: string;
  /** Per-datum loss outputs, including token logprobs. */
  loss_fn_outputs?: Record<unknown>[];
  per_datum_logprobs?: TensorData[];
  metrics?: Record<unknown>;
}

/** Request body for POST /fine_tuning/sessions/{sessionId}/forward_backward. */
@usage(Usage.input | Usage.output, "python")
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
@usage(Usage.input | Usage.output, "python")
model ForwardInput extends ForwardBackwardInput {}

/** Request body for POST /fine_tuning/sessions/{sessionId}/forward. */
@usage(Usage.input | Usage.output, "python")
model ForwardRequest {
  forward_input: ForwardInput;
}

/** Response from POST /fine_tuning/sessions/{sessionId}/heartbeat. */
@usage(Usage.input | Usage.output, "python")
model HeartbeatResponse {
  session_id: string;
}

/**
 * LoRA adapter configuration. `rank` is fixed server-side for v1; omit to use the server
 * default.
 */
@usage(Usage.input | Usage.output, "python")
model LoRAConfig {
  /** Number of LoRA rank dimensions. */
  rank?: int32;
  /** LoRA scaling factor (effective scale = alpha / rank). Defaults to 32.0 server-side. */
  alpha?: float64;
  /**
   * Seed for LoRA weight initialisation. If omitted, the server picks a random seed and
   * echoes it back.
   */
  seed?: int32;
  /** Whether to omit LoRA adapters from the vision tower. Defaults to true. */
  freeze_vision_tower?: boolean;
  /**
   * Whether to omit LoRA adapters from the multimodal projector or connector.
   * Defaults to true.
   */
  freeze_multi_modal_projector?: boolean;
}

/** Optional per-loss-function hyper-parameters. */
@usage(Usage.input | Usage.output, "python")
model LossFnConfig {
  /**
   * PPO (Proximal Policy Optimization) / CISPO (Clipped Importance-Sampled Policy Optimization):
   * lower clip threshold.
   */
  clip_low_threshold?: float64;
  /**
   * PPO (Proximal Policy Optimization) / CISPO (Clipped Importance-Sampled Policy Optimization):
   * upper clip threshold.
   */
  clip_high_threshold?: float64;
  /** SAPO (Soft Adaptive Policy Optimization): positive advantage temperature. */
  tau_pos?: float64;
  /** SAPO (Soft Adaptive Policy Optimization): negative advantage temperature. */
  tau_neg?: float64;
}

/** Per-datum loss function inputs used in forward-backward. */
@usage(Usage.input | Usage.output, "python")
model LossFnInputs {
  /** Target token ids (shifted by 1 relative to model input). */
  target_tokens: TensorData;
  /** Per-token weights (0.0 = masked, 1.0 = counted). */
  weights: TensorData;
  /**
   * Per-token advantage estimates (required for REINFORCE/PPO (Proximal Policy Optimization)/CISPO
   * (Clipped Importance-Sampled Policy Optimization)/SAPO (Soft Adaptive Policy Optimization)).
   * Omit or pass empty array for cross-entropy.
   */
  advantages?: TensorData;
  /**
   * Per-token reference log-probabilities for KL-divergence regularisation.
   * Omit or pass empty array to skip KL.
   */
  logprobs?: TensorData;
}

/** Full model input as one or more token-ID chunks. */
@usage(Usage.input | Usage.output, "python")
model ModelInput {
  /** Ordered list of token-ID chunks that together form the complete model input. */
  chunks: ModelInputChunk[];
}

/** A contiguous block of token IDs forming part of a model input. */
@usage(Usage.input | Usage.output, "python")
model ModelInputChunk {
  /** Sequence of token IDs in this chunk. */
  tokens: int32[];
}

/** OptimStepOperationResult. */
@usage(Usage.input | Usage.output, "python")
model OptimStepOperationResult extends OperationResult {
  type: OperationType.optim_step;
  grad_norm: float64;
  step_count: int32;
  metrics?: Record<float64>;
}

/** Request body for POST /fine_tuning/sessions/{sessionId}/optim_step. */
@usage(Usage.input | Usage.output, "python")
model OptimStepRequest {
  adam_params: AdamParams;
}

/** A single sampled sequence. */
@usage(Usage.input | Usage.output, "python")
model SampledSequence {
  tokens: int32[];
  /** Decoded text of the generated sequence. */
  text?: string;
  logprobs?: float64[];
}

/** SampleOperationResult. */
@usage(Usage.input | Usage.output, "python")
model SampleOperationResult extends OperationResult {
  type: OperationType.sample;
  sequences: SampledSequence[];
  /**
   * Per-token log-probabilities for the prompt, if requested.
   * None at positions where logprobs were not computed (e.g. the first prompt token).
   */
  // Target: Optional[list[Optional[float]]]. This TypeSpec shape preserves
  // nullable elements, but http-client-python 0.28.3 getType("nullable")
  // unwraps the inner type. models/_patch.py restores the exact nested Optional.
  prompt_logprobs?: (float64 | null)[];
  /**
   * Top-k log-probabilities per prompt token, if requested.
   * Each entry is a list of (token_id, logprob) pairs sorted by logprob descending,
   * or None for positions where logprobs were not computed (e.g. the first prompt token).
   * Note: over the wire each pair is a JSON array, so at runtime pairs are lists, not tuples.
   */
  // Target: Optional[list[Optional[list[tuple[int, float]]]]].
  // Exact TypeSpec: topk_prompt_logprobs?: ([int32, float64][] | null)[];
  // PINNED-EMITTER GAP: TCGC supports tuples, but http-client-python 0.28.3
  // getType has no "tuple" case and throws "Not supported tuple". Use an
  // unknown[] for each pair in the generated base. models/_patch.py overrides
  // this property with the exact nullable tuple-array annotation and matching
  // constructor overload. The public patched model, not this lossy generated
  // base alone, is verified against the immutable preview SDK.
  topk_prompt_logprobs?: (unknown[][] | null)[];
  /**
   * Per-call prefill and sample token COGS, including counts,
   * duration, throughput, and prefill cache-hit tokens when supported.
   */
  metrics?: Record<unknown>;
}

/** Request body for POST /fine_tuning/sessions/{sessionId}/sample. */
@usage(Usage.input | Usage.output, "python")
model SampleRequest {
  /** Number of independent completions to generate. Default 1. */
  num_samples: int32;
  /** Tokenised input prompt. */
  prompt: ModelInput;
  sampling_params: SamplingParams;
  /** Sampling session ID from a prior save_sampler_weights call. */
  sampling_session_id?: string;
  /** Training step index; must match the seq_id used in save_sampler_weights. */
  seq_id?: int32;
  /**
   * If true, return per-token log-probabilities for the prompt tokens as a 1-D float32 numpy array,
   * shape `(prompt_length,)`. `NaN` at positions where logprobs were not computed
   * (e.g. the first prompt token).
   */
  prompt_logprobs?: boolean;
  /** Number of top-k log-probabilities to return per prompt token. 0 = none. Must be between 0 and 20 (default 20). */
  // The target annotation and keyword constructor require this field;
  // preserve that shape despite the target docstring describing a default.
  // These defaults are copied SDK prose, not a newly asserted REST contract.
  topk_prompt_logprobs: int32;
}

/** Token-generation sampling parameters. */
@usage(Usage.input | Usage.output, "python")
model SamplingParams {
  /** Maximum tokens to generate. */
  max_tokens: int32;
  /** Softmax temperature. Default 1.0. */
  temperature: float64;
  /** Nucleus (top-p) probability mass. Default 1.0. */
  top_p: float64;
  /** Top-k candidates. -1 = disabled. */
  top_k: int32;
  /** RNG seed for reproducible samples. Server chooses randomly if omitted. */
  seed?: int32;
  /** Stop criteria: either stop_token_ids or stop_strings, not both. */
  stop_criteria?: StopCriteria;
}

/** SaveCheckpointOperationResult. */
@usage(Usage.input | Usage.output, "python")
model SaveCheckpointOperationResult extends OperationResult {
  type: OperationType.save_checkpoint;
  checkpoint_id: string;
  path: string;
}

/** Request body for POST /fine_tuning/sessions/{sessionId}/checkpoint. */
@usage(Usage.input | Usage.output, "python")
model SaveCheckpointRequest {
  /** User-supplied checkpoint identifier. Alphanumeric plus underscores and hyphens; max 255 characters. */
  path: string;
  /** Training iteration this checkpoint corresponds to. Optional. */
  step_number?: int32;
  /** Per-step evaluation metrics at checkpoint time. Optional. */
  metrics?: Record<unknown>;
}

/** SaveSamplerWeightsOperationResult. */
@usage(Usage.input | Usage.output, "python")
model SaveSamplerWeightsOperationResult extends OperationResult {
  type: OperationType.save_sampler_weights;
  checkpoint_id: string;
  sampling_session_id: string;
}

/** Request body for POST /fine_tuning/sessions/{sessionId}/checkpoint_sample. */
@usage(Usage.input | Usage.output, "python")
model SaveSamplerWeightsRequest {
  /** Optional explicit identifier for the sampler checkpoint. */
  path?: string;
  /** Ordinal of this sampling session within the training run. */
  sampling_session_seq_id?: int32;
  /** Training step sequence number. */
  seq_id?: int32;
}

/** Response from GET /fine_tuning/sessions/{sessionId}. */
@usage(Usage.input | Usage.output, "python")
model Session {
  /** Unique identifier for this fine-tuning session. */
  @visibility(Lifecycle.Read)
  session_id: string;
  /** The session type. */
  type: SessionType;
  /** Current lifecycle status of the session. */
  @visibility(Lifecycle.Read)
  status: SessionStatus;
  /** Model and adapter configuration associated with this session. */
  model_data: SessionModelData;
}

/** Paginated list of fine-tuning sessions. */
@usage(Usage.input | Usage.output, "python")
model SessionList {
  data: SessionSummary[];
  cursor: Cursor;
}

/** Nested model sub-object within a session response. */
@usage(Usage.input | Usage.output, "python")
model SessionModelData {
  base_model: string;
  lora_config?: LoRAConfig;
  model_name?: string;
}

/** Summary item returned in the paginated GET /fine_tuning/sessions list. */
@usage(Usage.input | Usage.output, "python")
model SessionSummary {
  /** Unique identifier for this fine-tuning session. */
  @visibility(Lifecycle.Read)
  session_id: string;
  /** Base model used for this fine-tuning session. */
  base_model: string;
  /** Current lifecycle status of the session. */
  @visibility(Lifecycle.Read)
  status: SessionStatus;
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

/** A 1-D array of floating-point values serialised for the wire. */
@usage(Usage.input | Usage.output, "python")
model TensorData {
  /** The floating-point values of the tensor. */
  data: float64[];
}