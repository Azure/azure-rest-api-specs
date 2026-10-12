// Models for custom code in emitted SDKs, not the REST API contract.
// Import this file only from SDK generation entrypoints, never from the REST
// entrypoint. Authoritative wire models are defined in ./models.tsp; matching
// shapes below reference those declarations instead of maintaining another copy.
// The current customizations preserve the existing Python SDK's constructors,
// result classes, and serialization. They do not define server validation or
// service defaults, and no service or operations are declared here.
//
// All current model classes and unions are existing public Python SDK exports.
// Do not mark them internal merely because they support SDK custom code.
// Any future internal-only helper must use @access(Access.internal, "python")
// (or the corresponding language scope) and must not appear in public signatures.
// The existing namespace is retained to preserve generated type identifiers.
// Maintained Python hooks provide additional behavior; the model-by-model
// rationale and generation toolchain are recorded in the SDK generation guide.

import "@azure-tools/typespec-client-generator-core";
import "./models.tsp";

using Azure.ClientGenerator.Core;

@clientNamespace("azure.ai.finetuningsessions", "python")
namespace Azure.AI.FineTuning.Sessions.Loom;

// Aliases reference the same type graph; no fields or enum values are copied.
alias CheckpointType = Azure.AI.Projects.SessionFineTuning.FineTuningCheckpointType;
alias LossFn = Azure.AI.Projects.SessionFineTuning.FineTuningLossFn;
alias SessionType = Azure.AI.Projects.SessionFineTuning.FineTuningSessionType;
alias StopCriteria = Azure.AI.Projects.SessionFineTuning.FineTuningStopCriteria;
alias ModelInputChunk = Azure.AI.Projects.SessionFineTuning.FineTuningInputChunkText;
alias Cursor = Azure.AI.Projects.SessionFineTuning.FineTuningCursor;
alias LossFnConfig = Azure.AI.Projects.SessionFineTuning.LossFnConfig;
alias Datum = Azure.AI.Projects.SessionFineTuning.FineTuningDatum;
alias ForwardBackwardInput = Azure.AI.Projects.SessionFineTuning.ForwardBackwardInput;
alias ForwardBackwardRequest = Azure.AI.Projects.SessionFineTuning.ForwardBackwardRequest;
alias ForwardRequest = Azure.AI.Projects.SessionFineTuning.ForwardRequest;
alias OptimStepRequest = Azure.AI.Projects.SessionFineTuning.OptimStepRequest;
alias Session = Azure.AI.Projects.SessionFineTuning.FineTuningSession;
alias SessionList = Azure.AI.Projects.SessionFineTuning.FineTuningSessionList;
alias CheckpointList = Azure.AI.Projects.SessionFineTuning.FineTuningCheckpointList;
alias SaveCheckpointRequest = Azure.AI.Projects.SessionFineTuning.SaveCheckpointRequest;

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

// Compatibility: existing Python keyword constructors require all Adam fields.
// The REST model instead allows omission and supplies service defaults.
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
  /** Machine-readable error code. */
  code: string;

  /** Human-readable description of the error. */
  message: string;

  /** Request parameter associated with the error. */
  param?: string;

  /** Category of the error. */
  type?: string;

  /** Nested error details associated with this error. */
  details?: ApiError[];

  /** Additional information associated with the error. */
  @encodedName("application/json", "additionalInfo")
  additional_info?: Record<unknown>;

  /** Diagnostic information for troubleshooting the error. */
  @encodedName("application/json", "debugInfo")
  debug_info?: Record<unknown>;
}

/** Error response for API failures. */
@usage(Usage.input | Usage.output, "python")
@clientName("ApiErrorResult", "csharp")
model ApiErrorResponse {
  /** Details of the API failure. */
  error: ApiError;
}

/** A checkpoint item returned in GET /fine_tuning/sessions/{sessionId}/checkpoints. */
@usage(Usage.input | Usage.output, "python")
model Checkpoint {
  /** Identifier of the saved checkpoint. */
  @visibility(Lifecycle.Read)
  checkpoint_id: string;

  /** Type of checkpoint, such as training state or sampler-compatible weights. */
  @visibility(Lifecycle.Read)
  checkpoint_type: CheckpointType;

  /** Timestamp when the checkpoint was saved. */
  @visibility(Lifecycle.Read)
  time: utcDateTime;
}

/** Detailed metadata for a single checkpoint. */
@usage(Usage.input | Usage.output, "python")
model CheckpointInfo {
  /** Base model used to create the checkpoint. */
  base_model: string;

  /** Whether the checkpoint uses a LoRA adapter. */
  is_lora: boolean;

  /** LoRA adapter rank associated with the checkpoint. */
  lora_rank?: int32;
}

// Compatibility: legacy ejectable field and hook-based checkpoint resume.
// Config and rank are required, matching the authoritative service contract.
/** Request body for POST /fine_tuning/sessions. */
@usage(Usage.input | Usage.output, "python")
@clientName("CreateSessionContent", "csharp")
model CreateSessionRequest {
  /** The session type. */
  type: SessionType;

  /** Base model to use for the fine-tuning session. */
  base_model: string;

  /** Required LoRA adapter configuration, including rank. */
  lora_config: LoRAConfig;

  /** User-provided metadata associated with the session. */
  user_metadata?: Record<unknown>;

  /** Opt the session into idle hibernation. Default False. */
  ejectable?: boolean;

  // Reuse the service property's type, optionality, documentation, and wire name.
  ...PickProperties<
    Azure.AI.Projects.SessionFineTuning.CreateFineTuningSessionRequest,
    "training_type"
  >;
}

/**
 * Legacy Python operation-result base retained for existing raw poller APIs.
 * The service returns request-ID/status envelopes, not this discriminator shape.
 * Maintained convenience hooks implement the service's request-status polling.
 */
@usage(Usage.input | Usage.output, "python")
@discriminator("type")
model OperationResult {
  // The pinned Python generator annotates a base discriminator as str even
  // when its TypeSpec type is an enum-like union. The named variants below
  // retain the target's Literal[OperationType.X] derived discriminators.
  /** Kind of asynchronous operation represented by this result. */
  type: OperationType;

  /** Identifier of the asynchronous operation. */
  @visibility(Lifecycle.Read)
  operation_id: string;

  /** Current lifecycle status of the asynchronous operation. */
  @visibility(Lifecycle.Read)
  status: OperationStatus;
}

/** ForwardBackwardOperationResult. */
@usage(Usage.input | Usage.output, "python")
model ForwardBackwardOperationResult extends OperationResult {
  /** Identifies this result as a forward-backward operation. */
  type: OperationType.forward_backward;

  /** Aggregate training loss, or None when the operation does not report one. */
  total_loss?: float64;

  /** Shape/type identifier for each loss output. */
  loss_fn_output_type?: string;

  /** Per-datum loss outputs, including token logprobs. */
  loss_fn_outputs?: Record<unknown>[];

  /** Token log-probabilities for each training example. */
  per_datum_logprobs?: TensorData[];

  /** Metrics reported by the forward-backward operation. */
  metrics?: Record<unknown>;
}

/**
 * Forward-only payload.
 *
 * Currently identical to ForwardBackwardInput. Exists as a named alias so
 * that the forward endpoint has its own type in the SDK, allowing the
 * contract to diverge later (e.g. making loss_fn optional for forward).
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "This SDK-only mapping preserves the tested Python ForwardInput subclass of ForwardBackwardInput; composition would remove that inheritance. It is not the REST service model."
@usage(Usage.input | Usage.output, "python")
model ForwardInput extends ForwardBackwardInput {}

// Compatibility: the original Python constructor requires session_id; current
// service heartbeat responses may omit it. No new REST requirement is implied.
/** Response from POST /fine_tuning/sessions/{sessionId}/heartbeat. */
@usage(Usage.input | Usage.output, "python")
@clientName("HeartbeatResult", "csharp")
model HeartbeatResponse {
  /** Identifier of the session whose heartbeat was acknowledged. */
  session_id: string;
}

/**
 * LoRA adapter configuration with an explicit rank, as required by the service.
 * Optional fields remain omitted rather than injecting client-side defaults.
 */
@usage(Usage.input | Usage.output, "python")
model LoRAConfig {
  /** Number of LoRA rank dimensions. */
  rank: int32;

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

// Compatibility: weights is required by the existing Python constructor.
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

/** Reuse the service's discriminated text/image model input directly. */
alias ModelInput = Azure.AI.Projects.SessionFineTuning.FineTuningModelInput;

/** OptimStepOperationResult. */
@usage(Usage.input | Usage.output, "python")
model OptimStepOperationResult extends OperationResult {
  /** Identifies this result as an optimizer-step operation. */
  type: OperationType.optim_step;

  /** Gradient norm reported for the optimizer step. */
  grad_norm: float64;

  /** Number of optimizer steps completed. */
  step_count: int32;

  /** Metrics reported by the optimizer step. */
  metrics?: Record<float64>;
}

/** A single sampled sequence. */
@usage(Usage.input | Usage.output, "python")
model SampledSequence {
  /** Token IDs in the generated sequence. */
  tokens: int32[];

  /** Decoded text of the generated sequence. */
  text?: string;

  /** Log-probability of each generated token. */
  logprobs?: float64[];
}

/** SampleOperationResult. */
@usage(Usage.input | Usage.output, "python")
model SampleOperationResult extends OperationResult {
  /** Identifies this result as a sampling operation. */
  type: OperationType.sample;

  /** Sequences generated by the sampling operation. */
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
@clientName("SampleContent", "csharp")
model SampleRequest {
  /** Number of independent completions to generate. Default 1. */
  num_samples: int32;

  /** Tokenised input prompt. */
  prompt: ModelInput;

  /** Parameters controlling token generation for this request. */
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

  /** Number of top-k log-probabilities per prompt token, from 0 to 20. Zero disables this output. The service defaults to 0 when omitted. */
  // Compatibility: the existing Python keyword constructor requires this field.
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

  // Reuse the service's optional structured-output property and documentation.
  ...PickProperties<
    Azure.AI.Projects.SessionFineTuning.FineTuningSamplingParams,
    "response_format"
  >;
}

/** SaveCheckpointOperationResult. */
@usage(Usage.input | Usage.output, "python")
model SaveCheckpointOperationResult extends OperationResult {
  /** Identifies this result as a training checkpoint save operation. */
  type: OperationType.save_checkpoint;

  /** Identifier of the saved training checkpoint. */
  checkpoint_id: string;

  /** Path associated with the saved training checkpoint. */
  path: string;
}

/** SaveSamplerWeightsOperationResult. */
@usage(Usage.input | Usage.output, "python")
model SaveSamplerWeightsOperationResult extends OperationResult {
  /** Identifies this result as a sampler-weights save operation. */
  type: OperationType.save_sampler_weights;

  /** Identifier of the saved sampler checkpoint. */
  checkpoint_id: string;

  /** Identifier of the sampling session associated with the saved weights. */
  sampling_session_id: string;
}

/** Request body for POST /fine_tuning/sessions/{sessionId}/checkpoint_sample. */
@usage(Usage.input | Usage.output, "python")
@clientName("SaveSamplerWeightsContent", "csharp")
model SaveSamplerWeightsRequest {
  /** Optional explicit identifier for the sampler checkpoint. */
  path?: string;

  /** Ordinal of this sampling session within the training run. */
  sampling_session_seq_id?: int32;

  /** Training step sequence number. */
  seq_id?: int32;
}

/** Nested model sub-object within a session response. */
@usage(Usage.input | Usage.output, "python")
model SessionModelData {
  /** Identifier of the base model used by this session. */
  base_model: string;

  /** LoRA adapter configuration associated with the session. */
  lora_config?: LoRAConfig;

  /** Name of the model associated with this session. */
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

alias TensorData = Azure.AI.Projects.SessionFineTuning.TensorData;
