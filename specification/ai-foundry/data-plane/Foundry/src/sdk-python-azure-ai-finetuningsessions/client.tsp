// Python-only preview compatibility projection. The REST specification remains
// session-finetuning/routes.tsp. Never import this file from the REST entrypoint.
import "../session-finetuning/routes.tsp";
import "./loom-models.tsp";

using Azure.ClientGenerator.Core;
using TypeSpec.Http;

@client({
  service: Azure.AI.Projects,
  name: "FineTuningSessionClient",
})
@clientNamespace("azure.ai.finetuningsessions", "python")
namespace Azure.AI.FineTuning.Sessions;

@client
@route("/fine_tuning/sessions")
interface Sessions {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Python facade alias preserves the existing fixed-route HTTP 200 session creation and request-ID polling contract."
  create is Azure.AI.Projects.SessionFineTuning.FineTuningSessions.create;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Python facade alias preserves the existing fixed-route HTTP 200 offset-paged session response."
  list is Azure.AI.Projects.SessionFineTuning.FineTuningSessions.list;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Python facade alias preserves the existing fixed-route HTTP 200 session lookup contract."
  get is Azure.AI.Projects.SessionFineTuning.FineTuningSessions.get;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Python facade alias preserves the existing fixed-route HTTP 200 unload response and request-ID polling contract."
  unload is Azure.AI.Projects.SessionFineTuning.FineTuningSessions.unload;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Python facade alias preserves the existing fixed-route HTTP 200 heartbeat contract."
  heartbeat is Azure.AI.Projects.SessionFineTuning.FineTuningSessions.heartbeat;
}

@client
@route("/fine_tuning/sessions/{sessionId}")
interface Training {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Python facade alias preserves the existing fixed-route HTTP 200 forward-backward response and request-ID polling contract."
  forwardBackward is Azure.AI.Projects.SessionFineTuning.Training.forwardBackward;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Python facade alias preserves the existing fixed-route HTTP 200 optimizer-step response and request-ID polling contract."
  optimizerStep is Azure.AI.Projects.SessionFineTuning.Training.optimizerStep;
}

@client
@route("/fine_tuning/sessions/{sessionId}")
interface Checkpoints {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Python facade alias preserves the existing fixed-route HTTP 200 checkpoint-save response and request-ID polling contract."
  save is Azure.AI.Projects.SessionFineTuning.Checkpoints.save;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Python facade alias preserves the existing fixed-route HTTP 200 sampler-weights response and request-ID polling contract."
  saveSamplerWeights is Azure.AI.Projects.SessionFineTuning.Checkpoints.saveSamplerWeights;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Python facade alias preserves the existing fixed-route HTTP 200 single-page checkpoint response."
  list is Azure.AI.Projects.SessionFineTuning.Checkpoints.list;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Python facade alias preserves the existing fixed-route HTTP 200 checkpoint lookup contract."
  get is Azure.AI.Projects.SessionFineTuning.Checkpoints.get;
}

@client
@route("/fine_tuning/sessions/{sessionId}")
interface Sampling {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Python facade alias preserves the existing fixed-route HTTP 200 sampling response and request-ID polling contract."
  sample is Azure.AI.Projects.SessionFineTuning.Sampling.sample;
}

@client
@route("/fine_tuning/sessions/{sessionId}/request/{requestId}")
interface Operations {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Python facade alias preserves the existing fixed-route HTTP 200 request-ID status polling contract."
  get is Azure.AI.Projects.SessionFineTuning.Operations.get;
}

@@apiVersion(
  Azure.Core.Foundations.ApiVersionParameter.apiVersion,
  false,
  "python"
);
@@clientName(Training.optimizerStep, "optimStep", "python");
@@clientNamespace(Azure.AI.Projects, "azure.ai.finetuningsessions", "python");
@@clientNamespace(
  Azure.AI.Projects.SessionFineTuning,
  "azure.ai.finetuningsessions",
  "python"
);
@@clientNamespace(OpenAI, "azure.ai.finetuningsessions", "python");

// Document shared types only in this Python entrypoint, without changing the
// shared REST sources or importing this projection into the REST entrypoint.
@@doc(
  Azure.AI.Projects.ApiErrorResponse.error,
  "The service error describing why the API request failed."
);
@@doc(
  Azure.AI.Projects.FoundryFeaturesOptInKeys,
  "Feature opt-in values for the Foundry-Features header used to access preview capabilities."
);
@@doc(
  Azure.AI.Projects.FoundryFeaturesOptInKeys.evaluations_v1_preview,
  "Opts in to the V1 preview of evaluation operations."
);
@@doc(
  Azure.AI.Projects.FoundryFeaturesOptInKeys.schedules_v1_preview,
  "Opts in to the V1 preview of scheduled operations."
);
@@doc(
  Azure.AI.Projects.FoundryFeaturesOptInKeys.red_teams_v1_preview,
  "Opts in to the V1 preview of red-team assessments."
);
@@doc(
  Azure.AI.Projects.FoundryFeaturesOptInKeys.insights_v1_preview,
  "Opts in to the V1 preview of insight generation."
);
@@doc(
  Azure.AI.Projects.FoundryFeaturesOptInKeys.agent_insights_v1_preview,
  "Opts in to the V1 preview of agent insights."
);
@@doc(
  Azure.AI.Projects.FoundryFeaturesOptInKeys.memory_stores_v1_preview,
  "Opts in to the V1 preview of persistent memory stores."
);
@@doc(
  Azure.AI.Projects.FoundryFeaturesOptInKeys.routines_v2_preview,
  "Opts in to the V2 preview of routines."
);
@@doc(
  Azure.AI.Projects.FoundryFeaturesOptInKeys.skills_v1_preview,
  "Opts in to the V1 preview of reusable skills."
);
@@doc(
  Azure.AI.Projects.FoundryFeaturesOptInKeys.data_generation_jobs_v1_preview,
  "Opts in to the V1 preview of data generation jobs."
);
@@doc(
  Azure.AI.Projects.FoundryFeaturesOptInKeys.models_v1_preview,
  "Opts in to the V1 preview of model operations."
);
@@doc(
  Azure.AI.Projects.FoundryFeaturesOptInKeys.agents_optimization_v2_preview,
  "Opts in to the V2 preview of agent optimization."
);
@@doc(
  Azure.AI.Projects.FoundryFeaturesOptInKeys.model_router_controls_v1_preview,
  "Opts in to the V1 preview of model-router configuration controls."
);
@@doc(
  Azure.AI.Projects.FoundryFeaturesOptInKeys.finetuning_sessions_v1_preview,
  "Opts in to the V1 preview of session-based model fine-tuning."
);
@@doc(
  Azure.AI.Projects.AgentDefinitionOptInKeys.workflow_agents_v1_preview,
  "Opts in to V1 preview agent definitions backed by workflows."
);
@@doc(
  Azure.AI.Projects.AgentDefinitionOptInKeys.external_agents_v1_preview,
  "Opts in to V1 preview agent definitions for externally hosted agents."
);
@@doc(
  Azure.AI.Projects.AgentDefinitionOptInKeys.draft_agents_v1_preview,
  "Opts in to the V1 preview of draft agent definitions."
);
@@doc(
  Azure.AI.Projects.AgentDefinitionOptInKeys.voice_agents_v1_preview,
  "Opts in to the V1 preview of voice agent definitions."
);
@@doc(
  Azure.AI.Projects.AgentDefinitionOptInKeys.digital_worker_v1_preview,
  "Opts in to the V1 preview of digital-worker agent definitions."
);
@@doc(
  Azure.AI.Projects.AgentDefinitionOptInKeys.github_copilot_v1_preview,
  "Opts in to the V1 preview of GitHub Copilot agent definitions."
);
@@doc(
  Azure.AI.Projects.AgentDefinitionOptInKeys.skills_v1_preview,
  "Opts in to the V1 preview of skills in agent definitions."
);
@@doc(
  Azure.AI.Projects.AgentDefinitionOptInKeys.hosted_agents_v1_preview,
  "Opts in to the V1 preview of hosted agent definitions."
);
@@doc(
  Azure.AI.Projects.AgentDefinitionOptInKeys.container_agents_v1_preview,
  "Opts in to the V1 preview of container agent definitions."
);
@@doc(
  Azure.AI.Projects.PageOrder,
  "Sort direction by created_at: asc returns oldest objects first; desc returns newest first."
);

// A public model's preview optionality is not a change to server validation.
// Keep the tested Python model shape separate from the raw REST model shape.
@@alternateType(
  Azure.AI.Projects.SessionFineTuning.FineTuningSessionStatus,
  Loom.SessionStatus,
  "python"
);
@@alternateType(
  Azure.AI.Projects.SessionFineTuning.FineTuningSessionType,
  Loom.SessionType,
  "python"
);
@@alternateType(
  Azure.AI.Projects.SessionFineTuning.FineTuningTrainingType,
  string,
  "python"
);
@@alternateType(
  Azure.AI.Projects.SessionFineTuning.FineTuningCheckpointType,
  Loom.CheckpointType,
  "python"
);
@@alternateType(
  Azure.AI.Projects.SessionFineTuning.FineTuningSession,
  Loom.Session,
  "python"
);
@@alternateType(
  Azure.AI.Projects.SessionFineTuning.FineTuningSessionSummary,
  Loom.SessionSummary,
  "python"
);
@@alternateType(
  Azure.AI.Projects.SessionFineTuning.FineTuningCheckpoint,
  Loom.Checkpoint,
  "python"
);
@@alternateType(
  Azure.AI.Projects.SessionFineTuning.FineTuningCheckpointInfo,
  Loom.CheckpointInfo,
  "python"
);
@@alternateType(
  Azure.AI.Projects.SessionFineTuning.FineTuningCheckpointList,
  Loom.CheckpointList,
  "python"
);
@@alternateType(
  Azure.AI.Projects.SessionFineTuning.FineTuningSessionList,
  Loom.SessionList,
  "python"
);
@@alternateType(
  Azure.AI.Projects.SessionFineTuning.FineTuningPendingOperation,
  Loom.OperationResult,
  "python"
);
@@alternateType(
  Azure.AI.Projects.SessionFineTuning.FineTuningActionOperation,
  Loom.OperationResult,
  "python"
);
@@alternateType(
  Azure.AI.Projects.SessionFineTuning.FineTuningRequestStatus,
  Loom.OperationResult,
  "python"
);
@@alternateType(
  Azure.AI.Projects.SessionFineTuning.FineTuningSampleRequest,
  Loom.SampleRequest,
  "python"
);
@@alternateType(
  Azure.AI.Projects.SessionFineTuning.FineTuningSamplingParams,
  Loom.SamplingParams,
  "python"
);
@@alternateType(
  Azure.AI.Projects.SessionFineTuning.FineTuningSampledSequence,
  Loom.SampledSequence,
  "python"
);
@@alternateType(
  Azure.AI.Projects.SessionFineTuning.FineTuningStopCriteria,
  Loom.StopCriteria,
  "python"
);
@@alternateType(
  Azure.AI.Projects.SessionFineTuning.FineTuningDatum,
  Loom.Datum,
  "python"
);
@@alternateType(
  Azure.AI.Projects.SessionFineTuning.FineTuningModelInput,
  Loom.ModelInput,
  "python"
);
@@alternateType(
  Azure.AI.Projects.SessionFineTuning.FineTuningModelInputChunk,
  Loom.ModelInputChunk,
  "python"
);
@@alternateType(
  Azure.AI.Projects.SessionFineTuning.FineTuningLossFn,
  Loom.LossFn,
  "python"
);
@@alternateType(
  Azure.AI.Projects.SessionFineTuning.FineTuningCompleteResponse,
  Loom.OperationResult,
  "python"
);
@@alternateType(
  Azure.AI.Projects.SessionFineTuning.FineTuningHeartbeatResponse,
  Loom.HeartbeatResponse,
  "python"
);
@@alternateType(
  Azure.AI.Projects.SessionFineTuning.FineTuningCursor,
  Loom.Cursor,
  "python"
);
@@alternateType(
  Azure.AI.Projects.SessionFineTuning.FineTuningSessionModelData,
  Loom.SessionModelData,
  "python"
);
@@alternateType(
  Azure.AI.Projects.SessionFineTuning.CreateFineTuningSessionRequest,
  Loom.CreateSessionRequest,
  "python"
);
@@alternateType(
  Azure.AI.Projects.SessionFineTuning.CreateFineTuningSessionResponse,
  Loom.OperationResult,
  "python"
);
@@alternateType(
  Azure.AI.Projects.SessionFineTuning.AdamParams,
  Loom.AdamParams,
  "python"
);
@@alternateType(
  Azure.AI.Projects.SessionFineTuning.LoRAConfig,
  Loom.LoRAConfig,
  "python"
);
@@alternateType(
  Azure.AI.Projects.SessionFineTuning.TensorData,
  Loom.TensorData,
  "python"
);
@@alternateType(
  Azure.AI.Projects.SessionFineTuning.LossFnConfig,
  Loom.LossFnConfig,
  "python"
);
@@alternateType(
  Azure.AI.Projects.SessionFineTuning.LossFnInputs,
  Loom.LossFnInputs,
  "python"
);
@@alternateType(
  Azure.AI.Projects.SessionFineTuning.ForwardBackwardInput,
  Loom.ForwardBackwardInput,
  "python"
);
@@alternateType(
  Azure.AI.Projects.SessionFineTuning.ForwardBackwardRequest,
  Loom.ForwardBackwardRequest,
  "python"
);
@@alternateType(
  Azure.AI.Projects.SessionFineTuning.ForwardInput,
  Loom.ForwardInput,
  "python"
);
@@alternateType(
  Azure.AI.Projects.SessionFineTuning.ForwardRequest,
  Loom.ForwardRequest,
  "python"
);
@@alternateType(
  Azure.AI.Projects.SessionFineTuning.OptimStepRequest,
  Loom.OptimStepRequest,
  "python"
);
@@alternateType(
  Azure.AI.Projects.SessionFineTuning.SaveCheckpointRequest,
  Loom.SaveCheckpointRequest,
  "python"
);
@@alternateType(
  Azure.AI.Projects.SessionFineTuning.SaveSamplerWeightsRequest,
  Loom.SaveSamplerWeightsRequest,
  "python"
);
@@alternateType(OpenAI.Error, Loom.ApiError, "python");
@@alternateType(
  Azure.AI.Projects.ApiErrorResponse,
  Loom.ApiErrorResponse,
  "python"
);
@@alternateType(
  Azure.AI.Projects.FoundryFeaturesOptInKeys,
  Loom.FoundryFeaturesOptInKeys,
  "python"
);

// These preserve the older client shape; they do not add HTTP 202 to the API.
// The supported Python operation hooks retain the preview's legacy poller
// semantics. The handwritten training layer implements real request-ID polling.
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preview Python compatibility retains the plain session-list response and cursor instead of an ItemPaged wrapper; no HTTP 202 contract is declared."
@@Azure.ClientGenerator.Core.Legacy.disablePageable(Sessions.list, "python");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preview Python compatibility retains the plain checkpoint-list response instead of an ItemPaged wrapper; no HTTP 202 contract is declared."
@@Azure.ClientGenerator.Core.Legacy.disablePageable(Checkpoints.list, "python");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preview Python compatibility retains begin_create and its legacy poller customization; this does not declare an HTTP 202 response."
@@Azure.ClientGenerator.Core.Legacy.markAsLro(Sessions.create, "python");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preview Python compatibility retains begin_unload and its legacy poller customization; this does not declare an HTTP 202 response."
@@Azure.ClientGenerator.Core.Legacy.markAsLro(Sessions.unload, "python");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preview Python compatibility retains begin_forward_backward and its legacy poller customization; this does not declare an HTTP 202 response."
@@Azure.ClientGenerator.Core.Legacy.markAsLro(
  Training.forwardBackward,
  "python"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preview Python compatibility retains begin_optim_step and its legacy poller customization; this does not declare an HTTP 202 response."
@@Azure.ClientGenerator.Core.Legacy.markAsLro(Training.optimizerStep, "python");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preview Python compatibility retains begin_save and its legacy poller customization; this does not declare an HTTP 202 response."
@@Azure.ClientGenerator.Core.Legacy.markAsLro(Checkpoints.save, "python");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preview Python compatibility retains begin_save_sampler_weights and its legacy poller customization; this does not declare an HTTP 202 response."
@@Azure.ClientGenerator.Core.Legacy.markAsLro(
  Checkpoints.saveSamplerWeights,
  "python"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preview Python compatibility retains begin_sample and its legacy poller customization; this does not declare an HTTP 202 response."
@@Azure.ClientGenerator.Core.Legacy.markAsLro(Sampling.sample, "python");
