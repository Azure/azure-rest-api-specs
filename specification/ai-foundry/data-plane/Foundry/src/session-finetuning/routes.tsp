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
 * and API version parameter. Ordinary requests use HTTP 200 and expose a
 * request identifier for explicit polling. Checkpoint preparation separately
 * declares its HTTP 202 Pending and HTTP 200 terminal responses.
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
@route("/fine_tuning_sessions")
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
      @query
      @pageSize
      limit?: int32 = 20;

      /** Number of sessions to skip before returning this page. If omitted, the service defaults to 0. */
      @query
      @offset
      offset?: int32 = 0;
    },
    FineTuningSessionList
  >;

  /** Get information about a specific fine-tuning session. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Session retrieval preserves the canonical session GET route and existing session representation rather than a standard resource template."
  @get
  @route("{sessionId}")
  @summary("Get a fine-tuning session")
  get is FineTuningSessionOperation<
    {
      /** Identifier of the fine-tuning session to retrieve. */
      @minLength(1)
      @path
      sessionId: string;
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
      @minLength(1)
      @path
      sessionId: string;
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
      @minLength(1)
      @path
      sessionId: string;
    },
    FineTuningCompleteResponse
  >;

  /**
   * Refresh an active session to prevent idle expiry.
   * Returns 404 if the session is not found.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Session heartbeat preserves the canonical session heartbeat POST action with an HTTP 200 response."
  @post
  @route("{sessionId}/heartbeat")
  @summary("Session heartbeat")
  heartbeat is FineTuningSessionOperation<
    {
      /** Identifier of the fine-tuning session to keep active. */
      @minLength(1)
      @path
      sessionId: string;
    },
    FineTuningHeartbeatResponse
  >;
}

// ─── Training ─────────────────────────────────────────────────────────────────

/** Submits training requests for a fine-tuning session. */
@route("/fine_tuning_sessions/{sessionId}")
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
      @minLength(1)
      @path
      sessionId: string;

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
      @minLength(1)
      @path
      sessionId: string;

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
      @minLength(1)
      @path
      sessionId: string;

      /** Adam optimizer configuration for applying accumulated gradients. */
      @body request: OptimStepRequest;
    },
    FineTuningActionOperation
  >;
}

// ─── Checkpoints ──────────────────────────────────────────────────────────────

/** Saves and retrieves checkpoints associated with a fine-tuning session. */
@route("/fine_tuning_sessions/{sessionId}")
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
      @minLength(1)
      @path
      sessionId: string;

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
      @minLength(1)
      @path
      sessionId: string;

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
      @minLength(1)
      @path
      sessionId: string;
    },
    FineTuningCheckpointList
  >;

  /** Get metadata for a specific checkpoint. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Checkpoint retrieval preserves the canonical checkpoint GET route and existing checkpoint metadata representation."
  @get
  @route("checkpoints/{checkpointId}")
  @summary("Get checkpoint info")
  get is FineTuningSessionOperation<
    {
      /** Identifier of the fine-tuning session containing the checkpoint. */
      @minLength(1)
      @path
      sessionId: string;

      /** Identifier of the checkpoint to retrieve. */
      @minLength(1)
      @path
      checkpointId: string;
    },
    FineTuningCheckpointInfo
  >;
}

/**
 * Prepares and reads checkpoint exports for explicitly eligible owners and models.
 * These operations do not enable download admission or bypass ownership checks.
 */
@route("/fine_tuning_sessions/{sessionId}/checkpoints/{checkpointId}/download")
@tag("Checkpoints")
interface CheckpointDownloads {
  /**
   * Prepare a checkpoint export without a request body. Repeat this operation
   * while HTTP 202 reports Pending. HTTP 200 reports Succeeded with the file
   * inventory or Failed. This is not the Azure LRO protocol and does not
   * deliver files to the caller's filesystem.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Checkpoint preparation uses repeated bodyless POST with explicit preparation states, not Azure LRO polling."
  @post
  @summary("Prepare a checkpoint download")
  prepare is FineTuningSessionOperation<
    {
      /** Identifier of the session that owns the checkpoint. */
      @minLength(1)
      @path
      sessionId: string;

      /** Identifier of the registered sampler checkpoint to prepare. */
      @minLength(1)
      @path
      checkpointId: string;
    },
    {
      /** HTTP 202 while Pending; HTTP 200 for Succeeded or Failed. */
      #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "These are the two exact HTTP response codes of the existing preparation protocol."
      @statusCode statusCode: 200 | 202;

      /** Preparation state and the complete file inventory on success. */
      @body body: FineTuningCheckpointDownloadResponse;
    }
  >;

  /**
   * Stream one advertised file from a completed, owned checkpoint export.
   * Rechecks download admission and ownership. If-Match must contain the
   * advertised strong ETag; arbitrary storage URLs and unversioned reads are
   * not accepted. This read does not create or renew a checkpoint copy.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Checkpoint file reads use an opaque advertised file identifier and required strong If-Match rather than a standard resource representation."
  @get
  @route("files/{fileId}")
  @summary("Read an authorized checkpoint file")
  getFile is FineTuningSessionOperation<
    {
      /** Identifier of the session that owns the checkpoint. */
      @minLength(1)
      @path
      sessionId: string;

      /** Identifier of the registered sampler checkpoint. */
      @minLength(1)
      @path
      checkpointId: string;

      /** Opaque file identifier from the successful preparation response. */
      @pattern("^[0-9a-f]{64}$")
      @path
      fileId: string;

      /** The advertised strong ETag for the exact file generation to read. */
      @header("If-Match")
      ifMatch: string;
    },
    {
      /** The authorized file is returned as a byte stream. */
      @statusCode statusCode: 200;

      /** Binary file media type. */
      @header("Content-Type") contentType: "application/octet-stream";

      /** Strong ETag of the returned file generation. */
      @header("ETag") etag: string;

      /** Exact number of bytes in the file. */
      @header("Content-Length") contentLength: int64;

      /** Private file bytes must not be cached or transformed. */
      @header("Cache-Control") cacheControl: "no-store, no-transform";

      /** Contents of the authorized, version-pinned checkpoint file. */
      @body body: bytes;
    }
  >;
}

// ─── Sampling ─────────────────────────────────────────────────────────────────

/** Generates completions using sampler checkpoints from a fine-tuning session. */
@route("/fine_tuning_sessions/{sessionId}")
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
      @minLength(1)
      @path
      sessionId: string;

      /** Identifier of the completed sampler checkpoint to use for generation. */
      @minLength(1)
      @query("checkpoint_id")
      checkpointId: string;

      /** Prompt and generation parameters for the requested completions. */
      @body sample: FineTuningSampleRequest;
    },
    FineTuningPendingOperation
  >;
}

// ─── Request-status polling ───────────────────────────────────────────────────

/** Retrieves the raw processing status of a fine-tuning request. */
@route("/fine_tuning_sessions/{sessionId}/request/{requestId}")
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
      @minLength(1)
      @path
      sessionId: string;

      /** Request identifier returned when the work was submitted. */
      @minLength(1)
      @path
      requestId: string;
    },
    FineTuningRequestStatus
  >;
}
