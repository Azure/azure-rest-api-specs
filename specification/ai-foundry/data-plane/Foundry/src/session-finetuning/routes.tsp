import "./models.tsp";
import "../common/servicepatterns.tsp";

using TypeSpec.Http;
using Azure.Core;
using Azure.AI.Projects;

namespace Azure.AI.FineTuning.Sessions;

// ─── Preview header ───────────────────────────────────────────────────────────

/** Required Foundry-Features header for all fine-tuning session operations (preview). */
alias FineTuningSessionPreviewHeader = WithRequiredFoundryPreviewHeader<FoundryFeaturesOptInKeys.finetuning_sessions_v1_preview>;

// ─── LRO response alias ───────────────────────────────────────────────────────

/**
 * 200 OK response for all async fine-tuning operations.
 * Loom returns 200 (not 202) with the pending operation body.
 * The client then calls GET .../request/{requestId} to long-poll for the result.
 */
alias SessionActionResponse = OkResponse & FineTuningPendingOperation;

// ─── LRO operation template ───────────────────────────────────────────────────
//
// Foundry's shared FoundryDataPlaneOperation<> returns synchronous responses.
// Fine-tuning session operations are inherently async (202 + Operation-Location header).
// This template covers all mutating fine-tuning operations.
//
// Poll: GET /fine_tuning_sessions/{sessionId}/operations/{operationId}
// until status is "succeeded" or "failed".

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Fine-tuning sessions use a custom per-session LRO polling endpoint"
#suppress "@azure-tools/typespec-azure-core/long-running-polling-operation-required" "Polling endpoint is GET .../operations/{operationId}"
op SessionLROOperation<
  TParams extends Reflection.Model
>(
  ...TParams,
  ...FineTuningSessionPreviewHeader,
  ...FoundryDataPlaneApiVersionParameter,
): SessionActionResponse | ApiErrorResponse;

// ─── Fine-Tuning Sessions ─────────────────────────────────────────────────────
//
// Base URL (from @server in common/service.tsp):
//   https://{resource}.services.ai.azure.com/api/projects/{project}
//
// All routes below are relative to that base.

@route("fine_tuning/sessions")
@tag("FineTuningSessions")
interface FineTuningSessions {

  /**
   * Create a new fine-tuning session and allocate it to a GPU engine.
   *
   * Returns `session_id` array `["session_xxx", "sampling_xxx"]`.
   * Use `session_xxx` as `{sessionId}` for training ops and
   * `sampling_xxx` as `{samplingId}` for sampling ops.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Fine-tuning session uses custom per-session LRO"
  #suppress "@azure-tools/typespec-azure-core/long-running-polling-operation-required" "Polling via GET .../operations/{operationId}"
  @post
  @summary("Create a fine-tuning session")
  create(
    @body body: CreateFineTuningSessionRequest,
    ...FineTuningSessionPreviewHeader,
    ...FoundryDataPlaneApiVersionParameter,
  ): OkResponse & CreateFineTuningSessionResponse | ApiErrorResponse;

  /** List all fine-tuning sessions for this project. */
  @get
  @summary("List fine-tuning sessions")
  list(
    ...FineTuningSessionPreviewHeader,
    ...FoundryDataPlaneApiVersionParameter,
    @query limit?: int32 = 20,
    @query offset?: int32 = 0,
  ): FineTuningSessionList | ApiErrorResponse;

  /** Get information about a specific fine-tuning session. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Direct GET returning session model"
  @get
  @route("{sessionId}")
  @summary("Get a fine-tuning session")
  get(
    @path sessionId: string,
    ...FineTuningSessionPreviewHeader,
    ...FoundryDataPlaneApiVersionParameter,
  ): FineTuningSession | ApiErrorResponse;

  /**
   * Unload a session from the GPU engine, freeing memory.
   * LoRA weights are lost; save a checkpoint before calling this.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Fine-tuning session uses custom per-session LRO"
  #suppress "@azure-tools/typespec-azure-core/long-running-polling-operation-required" "Polling via GET .../operations/{operationId}"
  @post
  @route("{sessionId}/complete")
  @summary("Unload a fine-tuning session")
  unload(
    @path sessionId: string,
    ...FineTuningSessionPreviewHeader,
    ...FoundryDataPlaneApiVersionParameter,
  ): SessionActionResponse | ApiErrorResponse;

  /**
   * Heartbeat — refresh an active session to prevent idle expiry.
   * The SDK sends this automatically every 30 seconds.
   * Returns 404 if the session has already expired.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Simple POST action"
  @post
  @route("{sessionId}/heartbeat")
  @summary("Session heartbeat")
  heartbeat(
    @path sessionId: string,
    ...FineTuningSessionPreviewHeader,
    ...FoundryDataPlaneApiVersionParameter,
  ): FineTuningHeartbeatResponse | ApiErrorResponse;
}

// ─── Training ─────────────────────────────────────────────────────────────────

@route("fine_tuning/sessions/{sessionId}")
@tag("Training")
interface Training {

  /**
   * Submit a mini-batch for a combined forward + backward pass.
   *
   * Gradients accumulate until an optimizer step is issued.
   * Poll the returned operation URL for `ForwardBackwardResult`.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Fine-tuning session uses custom per-session LRO"
  #suppress "@azure-tools/typespec-azure-core/long-running-polling-operation-required" "Polling via GET .../operations/{operationId}"
  @post
  @route("forward_backward")
  @summary("Forward and backward pass")
  forwardBackward(
    @path sessionId: string,
    @body body: ForwardBackwardRequest,
    ...FineTuningSessionPreviewHeader,
    ...FoundryDataPlaneApiVersionParameter,
  ): SessionActionResponse | ApiErrorResponse;

  /**
   * Apply accumulated gradients to the LoRA weights using the Adam optimizer.
   *
   * Poll the returned operation URL for `OptimStepResult`.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Fine-tuning session uses custom per-session LRO"
  #suppress "@azure-tools/typespec-azure-core/long-running-polling-operation-required" "Polling via GET .../operations/{operationId}"
  @post
  @route("optim_step")
  @summary("Optimizer step")
  optimStep(
    @path sessionId: string,
    @body body: OptimStepRequest,
    ...FineTuningSessionPreviewHeader,
    ...FoundryDataPlaneApiVersionParameter,
  ): SessionActionResponse | ApiErrorResponse;
}

// ─── Checkpoints ──────────────────────────────────────────────────────────────

@route("fine_tuning/sessions/{sessionId}")
@tag("Checkpoints")
interface Checkpoints {

  /**
   * Save a training checkpoint (LoRA weights + optimizer state) to blob storage.
   *
   * Poll the returned operation URL for `SaveCheckpointResult`.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Fine-tuning session uses custom per-session LRO"
  #suppress "@azure-tools/typespec-azure-core/long-running-polling-operation-required" "Polling via GET .../operations/{operationId}"
  @post
  @route("checkpoint")
  @summary("Save a training checkpoint")
  save(
    @path sessionId: string,
    @body body: SaveCheckpointRequest,
    ...FineTuningSessionPreviewHeader,
    ...FoundryDataPlaneApiVersionParameter,
  ): SessionActionResponse | ApiErrorResponse;

  /**
   * Save sampler-compatible weights (no optimizer state) for generation.
   *
   * Poll the returned operation URL for `SaveSamplerWeightsResult`.
   * The result contains `sampling_session_id` — pass this to subsequent sample calls.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Fine-tuning session uses custom per-session LRO"
  #suppress "@azure-tools/typespec-azure-core/long-running-polling-operation-required" "Polling via GET .../operations/{operationId}"
  @post
  @route("checkpoint_sample")
  @summary("Save sampler weights")
  saveSamplerWeights(
    @path sessionId: string,
    @body body: SaveSamplerWeightsRequest,
    ...FineTuningSessionPreviewHeader,
    ...FoundryDataPlaneApiVersionParameter,
  ): SessionActionResponse | ApiErrorResponse;

  /** List all checkpoints (training and sampler) for this session. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Direct GET returning checkpoint list"
  @get
  @route("checkpoints")
  @summary("List checkpoints")
  list(
    @path sessionId: string,
    ...FineTuningSessionPreviewHeader,
    ...FoundryDataPlaneApiVersionParameter,
  ): FineTuningCheckpointList | ApiErrorResponse;

  /** Get metadata for a specific checkpoint. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Direct GET returning checkpoint info"
  @get
  @route("checkpoints/{checkpointId}")
  @summary("Get checkpoint info")
  get(
    @path sessionId: string,
    @path checkpointId: string,
    ...FineTuningSessionPreviewHeader,
    ...FoundryDataPlaneApiVersionParameter,
  ): FineTuningCheckpointInfo | ApiErrorResponse;
}

// ─── Sampling ─────────────────────────────────────────────────────────────────

@route("fine_tuning/sessions/{sessionId}")
@tag("Sampling")
interface Sampling {

  /**
   * Generate one or more completions using the session's current LoRA weights.
   *
   * Requires a prior `checkpoint_sample` call to push weights to the sampler.
   * Pass `sampling_session_id` and `seq_id` from that call in the request body.
   *
   * Poll the returned operation URL for `FineTuningSampleResult`.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Fine-tuning session uses custom per-session LRO"
  #suppress "@azure-tools/typespec-azure-core/long-running-polling-operation-required" "Polling via GET .../operations/{operationId}"
  @post
  @route("sample")
  @summary("Generate completions")
  sample(
    @path sessionId: string,
    @body body: FineTuningSampleRequest,
    ...FineTuningSessionPreviewHeader,
    ...FoundryDataPlaneApiVersionParameter,
  ): SessionActionResponse | ApiErrorResponse;
}

// ─── Async operation poll ─────────────────────────────────────────────────────

@route("fine_tuning/sessions/{sessionId}/request/{requestId}")
@tag("Operations")
interface Operations {

  /**
   * Poll for the result of an async fine-tuning operation (Azure LRO).
   *
   * Returns `status: "running"` while in progress, `"succeeded"` on completion,
   * or `"failed"` on error. When succeeded, the body contains the typed result
   * (`ForwardBackwardOperationResult`, `OptimStepOperationResult`, etc.)
   * discriminated by `type`.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Fine-tuning session uses custom per-session LRO polling endpoint"
  @get
  @summary("Poll operation status")
  get(
    @path sessionId: string,
    @path requestId: string,
    ...FineTuningSessionPreviewHeader,
    ...FoundryDataPlaneApiVersionParameter,
  ): FineTuningOperationResult | ApiErrorResponse;
}
