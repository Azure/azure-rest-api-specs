// Python-only preview compatibility projection. The REST specification remains
// session-finetuning/routes.tsp. Never import this file from the REST entrypoint.
import "../session-finetuning/routes.tsp";
import "./loom-models.tsp";

using Azure.ClientGenerator.Core;
using TypeSpec.Http;

@client({ service: Azure.AI.Projects, name: "FineTuningSessionClient" })
@clientNamespace("azure.ai.finetuningsessions", "python")
namespace Azure.AI.FineTuning.Sessions;

@client
@route("/fine_tuning/sessions")
interface Sessions {
  create is Azure.AI.Projects.SessionFineTuning.FineTuningSessions.create;
  list is Azure.AI.Projects.SessionFineTuning.FineTuningSessions.list;
  get is Azure.AI.Projects.SessionFineTuning.FineTuningSessions.get;
  unload is Azure.AI.Projects.SessionFineTuning.FineTuningSessions.unload;
  heartbeat is Azure.AI.Projects.SessionFineTuning.FineTuningSessions.heartbeat;
}

@client
@route("/fine_tuning/sessions/{sessionId}")
interface Training {
  forwardBackward is Azure.AI.Projects.SessionFineTuning.Training.forwardBackward;
  optimizerStep is Azure.AI.Projects.SessionFineTuning.Training.optimizerStep;
}

@client
@route("/fine_tuning/sessions/{sessionId}")
interface Checkpoints {
  save is Azure.AI.Projects.SessionFineTuning.Checkpoints.save;
  saveSamplerWeights is Azure.AI.Projects.SessionFineTuning.Checkpoints.saveSamplerWeights;
  list is Azure.AI.Projects.SessionFineTuning.Checkpoints.list;
  get is Azure.AI.Projects.SessionFineTuning.Checkpoints.get;
}

@client
@route("/fine_tuning/sessions/{sessionId}")
interface Sampling {
  sample is Azure.AI.Projects.SessionFineTuning.Sampling.sample;
}

@client
@route("/fine_tuning/sessions/{sessionId}/request/{requestId}")
interface Operations {
  get is Azure.AI.Projects.SessionFineTuning.Operations.get;
}

@@apiVersion(Azure.Core.Foundations.ApiVersionParameter.apiVersion, false, "python");
@@clientName(Training.optimizerStep, "optimStep", "python");
@@clientNamespace(Azure.AI.Projects, "azure.ai.finetuningsessions", "python");
@@clientNamespace(Azure.AI.Projects.SessionFineTuning, "azure.ai.finetuningsessions", "python");
@@clientNamespace(OpenAI, "azure.ai.finetuningsessions", "python");

// A public model's preview optionality is not a change to server validation.
// Keep the tested Python model shape separate from the raw REST model shape.
@@alternateType(Azure.AI.Projects.SessionFineTuning.FineTuningSessionStatus, Loom.SessionStatus, "python");
@@alternateType(Azure.AI.Projects.SessionFineTuning.FineTuningSessionType, Loom.SessionType, "python");
@@alternateType(Azure.AI.Projects.SessionFineTuning.FineTuningTrainingType, string, "python");
@@alternateType(Azure.AI.Projects.SessionFineTuning.FineTuningCheckpointType, Loom.CheckpointType, "python");
@@alternateType(Azure.AI.Projects.SessionFineTuning.FineTuningSession, Loom.Session, "python");
@@alternateType(Azure.AI.Projects.SessionFineTuning.FineTuningSessionSummary, Loom.SessionSummary, "python");
@@alternateType(Azure.AI.Projects.SessionFineTuning.FineTuningCheckpoint, Loom.Checkpoint, "python");
@@alternateType(Azure.AI.Projects.SessionFineTuning.FineTuningCheckpointInfo, Loom.CheckpointInfo, "python");
@@alternateType(Azure.AI.Projects.SessionFineTuning.FineTuningCheckpointList, Loom.CheckpointList, "python");
@@alternateType(Azure.AI.Projects.SessionFineTuning.FineTuningSessionList, Loom.SessionList, "python");
@@alternateType(Azure.AI.Projects.SessionFineTuning.FineTuningPendingOperation, Loom.OperationResult, "python");
@@alternateType(Azure.AI.Projects.SessionFineTuning.FineTuningActionOperation, Loom.OperationResult, "python");
@@alternateType(Azure.AI.Projects.SessionFineTuning.FineTuningRequestStatus, Loom.OperationResult, "python");
@@alternateType(Azure.AI.Projects.SessionFineTuning.FineTuningSampleRequest, Loom.SampleRequest, "python");
@@alternateType(Azure.AI.Projects.SessionFineTuning.FineTuningSamplingParams, Loom.SamplingParams, "python");
@@alternateType(Azure.AI.Projects.SessionFineTuning.FineTuningSampledSequence, Loom.SampledSequence, "python");
@@alternateType(Azure.AI.Projects.SessionFineTuning.FineTuningStopCriteria, Loom.StopCriteria, "python");
@@alternateType(Azure.AI.Projects.SessionFineTuning.FineTuningDatum, Loom.Datum, "python");
@@alternateType(Azure.AI.Projects.SessionFineTuning.FineTuningModelInput, Loom.ModelInput, "python");
@@alternateType(Azure.AI.Projects.SessionFineTuning.FineTuningModelInputChunk, Loom.ModelInputChunk, "python");
@@alternateType(Azure.AI.Projects.SessionFineTuning.FineTuningLossFn, Loom.LossFn, "python");
@@alternateType(Azure.AI.Projects.SessionFineTuning.FineTuningCompleteResponse, Loom.OperationResult, "python");
@@alternateType(Azure.AI.Projects.SessionFineTuning.FineTuningHeartbeatResponse, Loom.HeartbeatResponse, "python");
@@alternateType(Azure.AI.Projects.SessionFineTuning.FineTuningCursor, Loom.Cursor, "python");
@@alternateType(Azure.AI.Projects.SessionFineTuning.FineTuningSessionModelData, Loom.SessionModelData, "python");
@@alternateType(Azure.AI.Projects.SessionFineTuning.CreateFineTuningSessionRequest, Loom.CreateSessionRequest, "python");
@@alternateType(Azure.AI.Projects.SessionFineTuning.CreateFineTuningSessionResponse, Loom.OperationResult, "python");
@@alternateType(Azure.AI.Projects.SessionFineTuning.AdamParams, Loom.AdamParams, "python");
@@alternateType(Azure.AI.Projects.SessionFineTuning.LoRAConfig, Loom.LoRAConfig, "python");
@@alternateType(Azure.AI.Projects.SessionFineTuning.TensorData, Loom.TensorData, "python");
@@alternateType(Azure.AI.Projects.SessionFineTuning.LossFnConfig, Loom.LossFnConfig, "python");
@@alternateType(Azure.AI.Projects.SessionFineTuning.LossFnInputs, Loom.LossFnInputs, "python");
@@alternateType(Azure.AI.Projects.SessionFineTuning.ForwardBackwardInput, Loom.ForwardBackwardInput, "python");
@@alternateType(Azure.AI.Projects.SessionFineTuning.ForwardBackwardRequest, Loom.ForwardBackwardRequest, "python");
@@alternateType(Azure.AI.Projects.SessionFineTuning.ForwardInput, Loom.ForwardInput, "python");
@@alternateType(Azure.AI.Projects.SessionFineTuning.ForwardRequest, Loom.ForwardRequest, "python");
@@alternateType(Azure.AI.Projects.SessionFineTuning.OptimStepRequest, Loom.OptimStepRequest, "python");
@@alternateType(Azure.AI.Projects.SessionFineTuning.SaveCheckpointRequest, Loom.SaveCheckpointRequest, "python");
@@alternateType(Azure.AI.Projects.SessionFineTuning.SaveSamplerWeightsRequest, Loom.SaveSamplerWeightsRequest, "python");
@@alternateType(OpenAI.Error, Loom.ApiError, "python");
@@alternateType(Azure.AI.Projects.ApiErrorResponse, Loom.ApiErrorResponse, "python");
@@alternateType(Azure.AI.Projects.FoundryFeaturesOptInKeys, Loom.FoundryFeaturesOptInKeys, "python");

// These preserve the older client shape; they do not add HTTP 202 to the API.
// The supported Python operation hooks retain the preview's legacy poller
// semantics. The handwritten training layer implements real request-ID polling.
@@Azure.ClientGenerator.Core.Legacy.disablePageable(Sessions.list, "python");
@@Azure.ClientGenerator.Core.Legacy.disablePageable(Checkpoints.list, "python");
@@Azure.ClientGenerator.Core.Legacy.markAsLro(Sessions.create, "python");
@@Azure.ClientGenerator.Core.Legacy.markAsLro(Sessions.unload, "python");
@@Azure.ClientGenerator.Core.Legacy.markAsLro(Training.forwardBackward, "python");
@@Azure.ClientGenerator.Core.Legacy.markAsLro(Training.optimizerStep, "python");
@@Azure.ClientGenerator.Core.Legacy.markAsLro(Checkpoints.save, "python");
@@Azure.ClientGenerator.Core.Legacy.markAsLro(Checkpoints.saveSamplerWeights, "python");
@@Azure.ClientGenerator.Core.Legacy.markAsLro(Sampling.sample, "python");