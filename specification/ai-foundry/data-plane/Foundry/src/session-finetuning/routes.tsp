import "../common/service.tsp";
import "../common/custom-types.tsp";
import "./models.tsp";
import "../common/models.tsp";
import "../common/error.range.tsp";
import "../common/servicepatterns.tsp";

using TypeSpec.Http;
using Azure.AI.Projects;

namespace Azure.AI.Projects.SessionFineTuning;

/**
 * A fine-tuning session operation with the required Foundry preview header
 * and API version parameter. Successful responses use HTTP 200. Requests
 * processed asynchronously expose a request identifier for explicit polling.
 */
op FineTuningSessionOperation<
  Params extends Reflection.Model,
  Response
> is FoundryDataPlaneRequiredPreviewOperation<
  FoundryFeaturesOptInKeys.finetuning_sessions_v1_preview,
  Params,
  Response,
  ApiErrorResponse & {
    /** String error code indicating what went wrong. */
    @header("x-ms-error-code") errorCode?: string;
  }
>;

// ─── Fine-tuning sessions ─────────────────────────────────────────────────────

/** Creates and manages fine-tuning sessions in the project. */
@route("/fine_tuning/sessions")
@tag("FineTuningSessions")
interface FineTuningSessions {
  /**
   * Create a new fine-tuning session and allocate it to a GPU engine.
   * The response contains a single session identifier and a request identifier
   * to poll for session initialization.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Session creation preserves POST with HTTP 200 and a request identifier for manual polling, not HTTP 201 resource creation or HTTP 202 Azure LRO."
  @post
  @summary("Create a fine-tuning session")
  create is FineTuningSessionOperation<
    {
      /** Configuration of the fine-tuning session to create. */
      @body session: CreateFineTuningSessionRequest;
    },
    CreateFineTuningSessionResponse
  >;

  /** List fine-tuning sessions in this project using offset-based pagination. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Session listing preserves offset-based pagination and the existing response envelope rather than the standard resource-list contract."
  @get
  @list
  @summary("List fine-tuning sessions")
  list is FineTuningSessionOperation<
    {
      /** Maximum number of sessions to return in this page. If omitted, the service defaults to 20. */
      @query("limit")
      @pageSize
      limit?: int32 = 20;

      /** Number of sessions to skip before returning this page. If omitted, the service defaults to 0. */
      @query("offset")
      @offset
      offset?: int32 = 0;
    },
    FineTuningSessionList
  >;

  /** Get information about a specific fine-tuning session. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Session retrieval preserves the fixed /fine_tuning/sessions/{sessionId} GET route and existing session representation rather than a standard resource template."
  @get
  @route("{sessionId}")
  @summary("Get a fine-tuning session")
  get is FineTuningSessionOperation<
    {
      /** Identifier of the fine-tuning session to retrieve. */
      @path sessionId: string;
    },
    FineTuningSession
  >;

  /**
   * Delete a fine-tuning session and mark its associated resources for cleanup.
   * Repeating deletion for an already-deleted session returns HTTP 200.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Session deletion is idempotent and returns HTTP 200 with a JSON response, including repeated deletion, rather than HTTP 204."
  @delete
  @route("{sessionId}")
  @summary("Delete a fine-tuning session")
  delete is FineTuningSessionOperation<
    {
      /** Identifier of the fine-tuning session to delete. */
      @path sessionId: string;
    },
    FineTuningDeleteSessionResponse
  >;

  /**
   * Unload a session from the GPU engine, freeing memory.
   * Unsaved in-memory LoRA weights are lost; save a checkpoint first.
   * Poll the returned request identifier to track completion.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Session unload preserves POST to the fixed session completion route with HTTP 200 and a request identifier for manual polling, not an Azure LRO."
  @post
  @route("{sessionId}/complete")
  @summary("Unload a fine-tuning session")
  unload is FineTuningSessionOperation<
    {
      /** Identifier of the fine-tuning session to unload. */
      @path sessionId: string;
    },
    FineTuningCompleteResponse
  >;

  /**
   * Refresh an active session to prevent idle expiry.
   * Returns 404 if the session is not found.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Session heartbeat preserves the fixed /fine_tuning/sessions/{sessionId}/heartbeat POST action with an HTTP 200 response."
  @post
  @route("{sessionId}/heartbeat")
  @summary("Session heartbeat")
  heartbeat is FineTuningSessionOperation<
    {
      /** Identifier of the fine-tuning session to keep active. */
      @path sessionId: string;
    },
    FineTuningHeartbeatResponse
  >;
}

// ─── Training ─────────────────────────────────────────────────────────────────

/** Submits training requests for a fine-tuning session. */
@route("/fine_tuning/sessions/{sessionId}")
@tag("Training")
interface Training {
  /**
   * Submit a mini-batch for a combined forward and backward pass.
   * Gradients accumulate until an optimizer step is issued.
   * Poll the returned request identifier for the result.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Forward-backward training preserves POST to the session-scoped forward_backward path with HTTP 200 and a request identifier for manual polling, not an Azure LRO."
  @post
  @route("forward_backward")
  @summary("Forward and backward pass")
  forwardBackward is FineTuningSessionOperation<
    {
      /** Identifier of the fine-tuning session that will process the batch. */
      @path sessionId: string;

      /** Training batch and loss configuration for the forward-backward pass. */
      @body request: ForwardBackwardRequest;
    },
    FineTuningActionOperation
  >;

  /**
   * Submit a mini-batch for a forward-only pass without accumulating gradients.
   * Poll the returned request identifier for the result.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Forward-only training preserves POST to the session-scoped forward path with HTTP 200 and a request identifier for manual polling, not an Azure LRO."
  @post
  @route("forward")
  @summary("Forward-only pass")
  forward is FineTuningSessionOperation<
    {
      /** Identifier of the fine-tuning session that will process the batch. */
      @path sessionId: string;

      /** Training batch and loss configuration for the forward-only pass. */
      @body request: ForwardRequest;
    },
    FineTuningActionOperation
  >;

  /**
   * Apply accumulated gradients to the LoRA weights using the Adam optimizer.
   * Poll the returned request identifier for the result.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "The optimizer step preserves POST to the session-scoped optim_step path with HTTP 200 and a request identifier for manual polling, not an Azure LRO."
  @post
  @route("optim_step")
  @summary("Optimizer step")
  optimizerStep is FineTuningSessionOperation<
    {
      /** Identifier of the fine-tuning session whose weights will be updated. */
      @path sessionId: string;

      /** Adam optimizer configuration for applying accumulated gradients. */
      @body request: OptimStepRequest;
    },
    FineTuningActionOperation
  >;
}

// ─── Checkpoints ──────────────────────────────────────────────────────────────

/** Saves and retrieves checkpoints associated with a fine-tuning session. */
@route("/fine_tuning/sessions/{sessionId}")
@tag("Checkpoints")
interface Checkpoints {
  /**
   * Save a training checkpoint containing LoRA weights and optimizer state.
   * Poll the returned request identifier for the result.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Saving a training checkpoint preserves the session-scoped checkpoint POST action with HTTP 200 and a request identifier for manual polling, not an Azure LRO."
  @post
  @route("checkpoint")
  @summary("Save a training checkpoint")
  save is FineTuningSessionOperation<
    {
      /** Identifier of the fine-tuning session to checkpoint. */
      @path sessionId: string;

      /** Identifier and optional training metadata for the checkpoint. */
      @body checkpoint: SaveCheckpointRequest;
    },
    FineTuningPendingOperation
  >;

  /**
   * Save sampler-compatible weights without optimizer state for generation.
   * Poll the returned request identifier before sampling from the checkpoint.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Saving sampler weights preserves the session-scoped checkpoint_sample POST action with HTTP 200 and a request identifier for manual polling, not an Azure LRO."
  @post
  @route("checkpoint_sample")
  @summary("Save sampler weights")
  saveSamplerWeights is FineTuningSessionOperation<
    {
      /** Identifier of the fine-tuning session whose sampler weights will be saved. */
      @path sessionId: string;

      /** Explicit checkpoint identifier or sequence identifiers for the sampler weights. */
      @body checkpoint: SaveSamplerWeightsRequest;
    },
    FineTuningPendingOperation
  >;

  /** List all training and sampler checkpoints for this session in a single page. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Checkpoint listing preserves a flat list in one response without pagination rather than a standard paged resource-list contract."
  @get
  @list
  @route("checkpoints")
  @summary("List checkpoints")
  list is FineTuningSessionOperation<
    {
      /** Identifier of the fine-tuning session whose checkpoints will be listed. */
      @path sessionId: string;
    },
    FineTuningCheckpointList
  >;

  /** Get metadata for a specific checkpoint. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Checkpoint retrieval preserves the fixed /fine_tuning/sessions/{sessionId}/checkpoints/{checkpointId} GET route and existing checkpoint metadata representation."
  @get
  @route("checkpoints/{checkpointId}")
  @summary("Get checkpoint info")
  get is FineTuningSessionOperation<
    {
      /** Identifier of the fine-tuning session containing the checkpoint. */
      @path sessionId: string;

      /** Identifier of the checkpoint to retrieve. */
      @path checkpointId: string;
    },
    FineTuningCheckpointInfo
  >;
}

// ─── Sampling ─────────────────────────────────────────────────────────────────

/** Generates completions using sampler checkpoints from a fine-tuning session. */
@route("/fine_tuning/sessions/{sessionId}")
@tag("Sampling")
interface Sampling {
  /**
   * Generate one or more completions from the specified sampler checkpoint.
   * The sampler-weights save request must have completed before sampling.
   * Poll the returned request identifier for the result.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Sampling preserves the session-scoped sample POST action, required checkpoint_id query, and HTTP 200 request identifier for manual polling, not an Azure LRO."
  @post
  @route("sample")
  @summary("Generate completions")
  sample is FineTuningSessionOperation<
    {
      /** Identifier of the fine-tuning session containing the sampler checkpoint. */
      @path sessionId: string;

      /** Identifier of the completed sampler checkpoint to use for generation. */
      @query("checkpoint_id") checkpointId: string;

      /** Prompt and generation parameters for the requested completions. */
      @body sample: FineTuningSampleRequest;
    },
    FineTuningPendingOperation
  >;
}

// ─── Request-status polling ───────────────────────────────────────────────────

/** Retrieves the raw processing status of a fine-tuning request. */
@route("/fine_tuning/sessions/{sessionId}/request/{requestId}")
@tag("Operations")
interface Operations {
  /**
   * Poll a fine-tuning request using its request identifier.
   * Returns HTTP 200 with status pending while processing, completed with the
   * raw result on success, or failed with error details on failure.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Request polling preserves HTTP 200 with custom pending, completed, or failed payloads at the fixed session request route, not the Azure LRO status protocol."
  @get
  @summary("Poll request status")
  get is FineTuningSessionOperation<
    {
      /** Identifier of the fine-tuning session associated with the request. */
      @path sessionId: string;

      /** Request identifier returned when the work was submitted. */
      @path requestId: string;
    },
    FineTuningRequestStatus
  >;
}
