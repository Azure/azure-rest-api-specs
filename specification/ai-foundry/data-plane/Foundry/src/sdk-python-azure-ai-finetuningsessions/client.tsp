// Python SDK customization only. The REST contract is in session-finetuning.
import "../session-finetuning/routes.tsp";

using Azure.ClientGenerator.Core;
using Azure.AI.Projects.SessionFineTuning;
using TypeSpec.Http;

// Select the session operations from the shared Foundry service, without
// generating a second Projects client or importing unrelated Foundry routes.
@client({ service: Azure.AI.Projects, name: "FineTuningSessionClient" })
@clientNamespace("azure.ai.finetuning_sessions", "python")
namespace Azure.AI.FineTuning.Sessions;

@client
@route("/fine_tuning_sessions")
interface Sessions {
	create is Azure.AI.Projects.SessionFineTuning.FineTuningSessions.create;
	list is Azure.AI.Projects.SessionFineTuning.FineTuningSessions.list;
	get is Azure.AI.Projects.SessionFineTuning.FineTuningSessions.get;
	delete is Azure.AI.Projects.SessionFineTuning.FineTuningSessions.delete;
	unload is Azure.AI.Projects.SessionFineTuning.FineTuningSessions.unload;
	heartbeat is Azure.AI.Projects.SessionFineTuning.FineTuningSessions.heartbeat;
}

@client
@route("/fine_tuning_sessions/{sessionId}")
interface Training {
	forwardBackward is Azure.AI.Projects.SessionFineTuning.Training.forwardBackward;
	forward is Azure.AI.Projects.SessionFineTuning.Training.forward;
	optimizerStep is Azure.AI.Projects.SessionFineTuning.Training.optimizerStep;
}

@client
@route("/fine_tuning_sessions/{sessionId}")
interface Checkpoints {
	save is Azure.AI.Projects.SessionFineTuning.Checkpoints.save;
	saveSamplerWeights is Azure.AI.Projects.SessionFineTuning.Checkpoints.saveSamplerWeights;
	list is Azure.AI.Projects.SessionFineTuning.Checkpoints.list;
	get is Azure.AI.Projects.SessionFineTuning.Checkpoints.get;
}

@client
@route("/fine_tuning_sessions/{sessionId}")
interface Sampling {
	sample is Azure.AI.Projects.SessionFineTuning.Sampling.sample;
}

@client
@route("/fine_tuning_sessions/{sessionId}/request/{requestId}")
interface Operations {
	get is Azure.AI.Projects.SessionFineTuning.Operations.get;
}

@@clientNamespace(Azure.AI.Projects, "azure.ai.finetuning_sessions", "python");
@@clientNamespace(Azure.AI.Projects.SessionFineTuning, "azure.ai.finetuning_sessions", "python");
@@clientNamespace(OpenAI, "azure.ai.finetuning_sessions", "python");
@@clientName(OpenAI.Error, "ApiError", "python");

@@clientName(FineTuningSessionStatus, "SessionStatus", "python");
@@clientName(FineTuningSessionType, "SessionType", "python");
@@clientName(FineTuningTrainingType, "TrainingType", "python");
@@clientName(FineTuningCheckpointType, "CheckpointType", "python");
@@clientName(FineTuningSession, "Session", "python");
@@clientName(FineTuningSessionSummary, "SessionSummary", "python");
@@clientName(FineTuningCheckpoint, "Checkpoint", "python");
@@clientName(FineTuningCheckpointInfo, "CheckpointInfo", "python");
@@clientName(FineTuningCheckpointList, "CheckpointList", "python");
@@clientName(FineTuningSessionList, "SessionList", "python");
@@clientName(FineTuningPendingOperation, "PendingOperation", "python");
@@clientName(FineTuningActionOperation, "ActionOperation", "python");
@@clientName(FineTuningRequestStatus, "RequestStatus", "python");
@@clientName(PendingFineTuningRequest, "PendingRequest", "python");
@@clientName(CompletedFineTuningRequest, "CompletedRequest", "python");
@@clientName(FailedFineTuningRequest, "FailedRequest", "python");
@@clientName(FineTuningDeleteSessionResponse, "DeleteSessionResponse", "python");
@@clientName(FineTuningSampleRequest, "SampleRequest", "python");
@@clientName(FineTuningSamplingParams, "SamplingParams", "python");
@@clientName(FineTuningSampledSequence, "SampledSequence", "python");
@@clientName(FineTuningStopCriteria, "StopCriteria", "python");
@@clientName(FineTuningDatum, "Datum", "python");
@@clientName(FineTuningModelInput, "ModelInput", "python");
@@clientName(FineTuningModelInputChunk, "ModelInputChunk", "python");
@@clientName(FineTuningImageChunk, "ImageChunk", "python");
@@clientName(FineTuningImageFormat, "ImageFormat", "python");
@@clientName(FineTuningFromCheckpoint, "FromCheckpoint", "python");
@@clientName(FineTuningLossFn, "LossFn", "python");
@@clientName(FineTuningCompleteResponse, "CompleteResponse", "python");
@@clientName(FineTuningHeartbeatResponse, "HeartbeatResponse", "python");
@@clientName(FineTuningCursor, "Cursor", "python");
@@clientName(FineTuningSessionModelData, "SessionModelData", "python");
@@clientName(CreateFineTuningSessionRequest, "CreateSessionRequest", "python");
@@clientName(CreateFineTuningSessionResponse, "CreateSessionResponse", "python");

// Preserve the explicit page+cursor API. The service uses client-driven offsets,
// not nextLink/continuation tokens; an emitted single-page iterator would silently
// truncate results. REST still carries @list/@pageItems/@offset/@pageSize.
@@Azure.ClientGenerator.Core.Legacy.disablePageable(Sessions.list, "python");
@@Azure.ClientGenerator.Core.Legacy.disablePageable(Checkpoints.list, "python");
@@usage(FineTuningSessionList, Usage.output, "python");
@@usage(FineTuningCheckpointList, Usage.output, "python");
@@usage(Azure.AI.Projects.FoundryFeaturesOptInKeys, Usage.input, "python");
@@access(Azure.AI.Projects.FoundryFeaturesOptInKeys, Access.public, "python");

// These are Python convenience result shapes, NOT REST polling responses.
// They are populated by the handwritten normalization layer. Keeping their
// definitions here makes them reproducible without polluting the REST schema.
/** Normalized state of an SDK convenience operation. */
union OperationStatus {
	string,
	/** Work is in progress. */
	running: "running",
	/** Work completed successfully. */
	succeeded: "succeeded",
	/** Work failed. */
	failed: "failed",
}

/** Discriminator for normalized SDK convenience results. */
union OperationType {
	string,
	/** A forward or forward-backward result. */
	forward_backward: "forward_backward",
	/** An optimizer-step result. */
	optim_step: "optim_step",
	/** A sampling result. */
	sample: "sample",
	/** A saved training checkpoint. */
	save_checkpoint: "save_checkpoint",
	/** Saved sampler weights. */
	save_sampler_weights: "save_sampler_weights",
}

/** Normalized result returned by SDK convenience methods, not the REST poll envelope. */
@usage(Usage.input | Usage.output | Usage.json, "python")
@access(Access.public, "python")
@discriminator("type")
model OperationResult {
	/** Kind of operation whose result was normalized. */
	type: OperationType;
	/** Request identifier associated with this convenience result. */
	@visibility(Lifecycle.Read)
	operation_id: string;
	/** Normalized operation state. */
	@visibility(Lifecycle.Read)
	status: OperationStatus;
}

/** Normalized forward or forward-backward result. */
model ForwardBackwardOperationResult extends OperationResult {
	/** Identifies the forward-result shape. */
	type: OperationType.forward_backward;
	/** Aggregate loss, absent for forward-only results that do not report it. */
	total_loss?: float64;
	/** Shape identifier of each loss output. */
	loss_fn_output_type?: string;
	/** Per-datum outputs, including token log-probabilities. */
	loss_fn_outputs?: Record<unknown>[];
	/** Legacy per-datum log-probability tensors, when reported. */
	per_datum_logprobs?: TensorData[];
	/** Metrics reported by the service, retaining arbitrary JSON values. */
	metrics?: Record<unknown>;
}

/** Normalized optimizer-step result. */
model OptimStepOperationResult extends OperationResult {
	/** Identifies an optimizer-step result. */
	type: OperationType.optim_step;
	/** Gradient norm, when reported. */
	grad_norm?: float64;
	/** Optimizer step count, when reported. */
	step_count?: int32;
	/** Metrics reported by the service. */
	metrics?: Record<unknown>;
}

/** Normalized sampling result. */
model SampleOperationResult extends OperationResult {
	/** Identifies a sampling result. */
	type: OperationType.sample;
	/** Generated sequences. */
	sequences: FineTuningSampledSequence[];
	/** Prompt-token log-probabilities; null marks a token without a computed value. */
	prompt_logprobs?: (float64 | null)[];
	/** Per-prompt-token lists of [token_id, logprob] pairs; null marks an unavailable position. */
	topk_prompt_logprobs?: (unknown[][] | null)[];
	/** Sampling and prefill metrics, when available. */
	metrics?: Record<unknown>;
}

/** Normalized result of saving a training checkpoint. */
model SaveCheckpointOperationResult extends OperationResult {
	/** Identifies a training checkpoint result. */
	type: OperationType.save_checkpoint;
	/** Checkpoint identifier within its source session. */
	checkpoint_id: string;
	/** Portable path identifying the checkpoint. */
	path: string;
}

/** Normalized result of saving sampler weights. */
model SaveSamplerWeightsOperationResult extends OperationResult {
	/** Identifies a sampler-checkpoint result. */
	type: OperationType.save_sampler_weights;
	/** Checkpoint identifier within its source session. */
	checkpoint_id: string;
	/** Sampling-session identifier, when reported. */
	sampling_session_id?: string;
}
