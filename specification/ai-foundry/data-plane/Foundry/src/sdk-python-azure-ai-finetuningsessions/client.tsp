// Python-only preview customization. HTTP routes and service operations are
// defined only in session-finetuning/routes.tsp; do not import this SDK entrypoint
// from the REST entrypoint.
import "../session-finetuning/routes.tsp";
import "../session-finetuning/models-custom-code.tsp";

using Azure.ClientGenerator.Core;
using Azure.AI.Projects.SessionFineTuning;

@clientNamespace("azure.ai.finetuningsessions", "python")
namespace Azure.AI.FineTuning.Sessions;

@@clientName(Azure.AI.Projects, "FineTuningSessionClient", "python");

// Preserve the existing preview operation-group surface. Both capabilities are
// available through maintained Python customization hooks included in SDK
// regeneration, rather than additional raw generated operation-group methods:
// - Sync: FineTuningSession.delete() and FineTuningSession.forward(...).
// - Async: aio.FineTuningSessionClient.delete_session(...), forward(...), and
//   forward_async(...).
// Forward helpers handle chunking and request-ID polling. Delete helpers stop
// the heartbeat, treat HTTP 404 as success, and return None.
// Both REST operations remain defined in session-finetuning/routes.tsp. Adding
// raw operation-group methods would be a separate additive API change.
@@scope(FineTuningSessions.delete, "!python");
@@scope(Training.forward, "!python");
// Maintained download_weights hooks combine preparation and streamed file reads
// with local destination validation; do not add separate raw Python methods.
@@scope(CheckpointDownloads.prepare, "!python");
@@scope(CheckpointDownloads.getFile, "!python");
// Maintained sampling hooks own completion observation and acknowledgement.
@@scope(CompletionFeeds.retrieve, "!python");
// Maintained session creation hooks advertise and inspect these wire headers.
@@scope(FineTuningClientCapabilitiesHeader.clientCapabilities, "!python");
@@scope(FineTuningCompletionFeedHeader.useCompletionFeed, "!python");

// Named SDK locations create the existing flat groups without defining HTTP
// interfaces or copying operations. Routes remain on the service operations.
@@clientLocation(FineTuningSessions.create, "Sessions", "python");
@@clientLocation(FineTuningSessions.list, "Sessions", "python");
@@clientLocation(FineTuningSessions.get, "Sessions", "python");
@@clientLocation(FineTuningSessions.unload, "Sessions", "python");
@@clientLocation(FineTuningSessions.heartbeat, "Sessions", "python");
@@clientLocation(Training.forwardBackward, "Training", "python");
@@clientLocation(Training.optimizerStep, "Training", "python");
@@clientLocation(Checkpoints.save, "Checkpoints", "python");
@@clientLocation(Checkpoints.saveSamplerWeights, "Checkpoints", "python");
@@clientLocation(Checkpoints.list, "Checkpoints", "python");
@@clientLocation(Checkpoints.get, "Checkpoints", "python");
@@clientLocation(Sampling.sample, "Sampling", "python");
@@clientLocation(Operations.get, "Operations", "python");

@@apiVersion(
  Azure.AI.Projects.FoundryDataPlaneApiVersionParameter.apiVersion,
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
@@clientNamespace(Azure.AI.ProjectsInternal, "Azure.AI.Projects", "javascript");
@@clientNamespace(Azure.AI.ProjectsInternal, "Azure.AI.Projects", "csharp");
@@clientNamespace(
  Azure.AI.ProjectsInternal.FineTuningSampledSequence,
  "Azure.AI.Projects.SessionFineTuning",
  "javascript"
);
@@clientNamespace(
  Azure.AI.ProjectsInternal.FineTuningSampledSequence,
  "Azure.AI.Projects.SessionFineTuning",
  "csharp"
);

// Document shared types only in this Python entrypoint, without changing the
// shared REST sources or importing this projection into the REST entrypoint.
@@doc(
  Azure.AI.Projects.FoundryDataPlaneOperation,
  "A Foundry operation using the shared API-version parameter and error response contract."
);
@@doc(
  Azure.AI.Projects.FoundryDataPlaneRequiredPreviewOperation,
  "A Foundry operation requiring the feature opt-in header for its preview area."
);
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

// Reuse authoritative REST types whenever their Python shape is compatible.
// Compatibility aliases reference canonical models rather than copying them.
@@clientName(CheckpointType, "CheckpointType", "python");
@@clientName(LossFn, "LossFn", "python");
@@clientName(SessionType, "SessionType", "python");
@@clientName(StopCriteria, "StopCriteria", "python");
@@clientName(ModelInputChunk, "ModelInputChunk", "python");
@@clientName(ModelInput, "ModelInput", "python");
@@clientName(FineTuningInputChunk, "InputChunk", "python");
@@clientName(FineTuningInputChunkType, "InputChunkType", "python");
@@clientName(FineTuningInputChunkImage, "ImageChunk", "python");
// Preserve the existing ImageChunk.format string API and local validation.
@@alternateType(FineTuningImageFormat, string, "python");
@@clientName(Cursor, "Cursor", "python");
@@clientName(Datum, "Datum", "python");
@@clientName(Session, "Session", "python");
@@clientName(SessionList, "SessionList", "python");
@@clientName(CheckpointList, "CheckpointList", "python");
@@usage(CheckpointType, Usage.input | Usage.output, "python");
@@usage(LossFn, Usage.input | Usage.output, "python");
@@usage(SessionType, Usage.input | Usage.output, "python");
@@usage(StopCriteria, Usage.input | Usage.output, "python");
@@usage(TensorData, Usage.input | Usage.output, "python");
@@usage(ModelInputChunk, Usage.input | Usage.output, "python");
@@usage(ModelInput, Usage.input | Usage.output, "python");
@@usage(Cursor, Usage.input | Usage.output, "python");
@@usage(LossFnConfig, Usage.input | Usage.output, "python");
@@usage(Datum, Usage.input | Usage.output, "python");
@@usage(ForwardBackwardInput, Usage.input | Usage.output, "python");
@@usage(ForwardBackwardRequest, Usage.input | Usage.output, "python");
@@usage(ForwardRequest, Usage.input | Usage.output, "python");
@@usage(OptimStepRequest, Usage.input | Usage.output, "python");
@@usage(Session, Usage.input | Usage.output, "python");
@@usage(SessionList, Usage.input | Usage.output, "python");
@@usage(CheckpointList, Usage.input | Usage.output, "python");
@@usage(SaveCheckpointRequest, Usage.input | Usage.output, "python");

// Only genuine compatibility exceptions use alternate types. Optional Python
// constructors and legacy result classes are not alternate server contracts.
@@alternateType(
  Azure.AI.Projects.SessionFineTuning.FineTuningSessionStatus,
  SessionStatus,
  "python"
);
// An extensible string-backed enum adds discoverability without restricting
// existing string inputs or injecting a client-side training-tier default.
@@clientName(
  Azure.AI.Projects.SessionFineTuning.FineTuningTrainingType,
  "TrainingType",
  "python"
);
@@usage(
  Azure.AI.Projects.SessionFineTuning.FineTuningTrainingType,
  Usage.input | Usage.output,
  "python"
);
@@alternateType(
  Azure.AI.Projects.SessionFineTuning.FineTuningSessionSummary,
  SessionSummary,
  "python"
);
@@alternateType(
  Azure.AI.Projects.SessionFineTuning.FineTuningCheckpoint,
  Checkpoint,
  "python"
);
@@clientName(
  Azure.AI.Projects.SessionFineTuning.FineTuningCheckpointPublicationState,
  "CheckpointPublicationState",
  "python"
);
@@alternateType(
  Azure.AI.Projects.SessionFineTuning.FineTuningCheckpointInfo,
  CheckpointInfo,
  "python"
);
@@alternateType(
  Azure.AI.Projects.SessionFineTuning.FineTuningPendingOperation,
  OperationResult,
  "python"
);
@@alternateType(
  Azure.AI.Projects.SessionFineTuning.FineTuningActionOperation,
  OperationResult,
  "python"
);
@@alternateType(
  Azure.AI.Projects.SessionFineTuning.FineTuningRequestStatus,
  OperationResult,
  "python"
);
@@alternateType(
  Azure.AI.Projects.SessionFineTuning.FineTuningSampleRequest,
  SampleRequest,
  "python"
);
@@alternateType(
  Azure.AI.Projects.SessionFineTuning.ForwardBackwardRequest,
  ForwardBackwardRequest,
  "python"
);
@@alternateType(
  Azure.AI.Projects.SessionFineTuning.FineTuningSamplingParams,
  SamplingParams,
  "python"
);
@@alternateType(
  Azure.AI.Projects.SessionFineTuning.FineTuningSampledSequence,
  SampledSequence,
  "python"
);
@@alternateType(
  Azure.AI.Projects.SessionFineTuning.FineTuningCompleteResponse,
  OperationResult,
  "python"
);
@@alternateType(
  Azure.AI.Projects.SessionFineTuning.FineTuningHeartbeatResponse,
  HeartbeatResponse,
  "python"
);
@@alternateType(
  Azure.AI.Projects.SessionFineTuning.FineTuningSessionModelData,
  SessionModelData,
  "python"
);
@@alternateType(
  Azure.AI.Projects.SessionFineTuning.CreateFineTuningSessionRequest,
  CreateSessionRequest,
  "python"
);
@@alternateType(
  Azure.AI.Projects.SessionFineTuning.CreateFineTuningSessionResponse,
  OperationResult,
  "python"
);
@@alternateType(
  Azure.AI.Projects.SessionFineTuning.AdamParams,
  AdamParams,
  "python"
);
@@alternateType(
  Azure.AI.Projects.SessionFineTuning.LoRAConfig,
  LoRAConfig,
  "python"
);
@@alternateType(
  Azure.AI.Projects.SessionFineTuning.LossFnInputs,
  LossFnInputs,
  "python"
);
@@alternateType(
  Azure.AI.Projects.SessionFineTuning.ForwardInput,
  ForwardInput,
  "python"
);
@@alternateType(
  Azure.AI.Projects.SessionFineTuning.SaveSamplerWeightsRequest,
  SaveSamplerWeightsRequest,
  "python"
);
@@alternateType(OpenAI.Error, ApiError, "python");
@@alternateType(Azure.AI.Projects.ApiErrorResponse, ApiErrorResponse, "python");
// Generate the opt-in enum from its sole shared declaration. Existing members
// retain their names/wire values; the remaining shared members are additive.
@@clientName(
  Azure.AI.Projects.FoundryFeaturesOptInKeys,
  "FoundryFeaturesOptInKeys",
  "python"
);
@@usage(
  Azure.AI.Projects.FoundryFeaturesOptInKeys,
  Usage.input | Usage.output,
  "python"
);

// These preserve the older client shape; they do not add HTTP 202 to the API.
// The supported Python operation hooks retain the preview's legacy poller
// semantics. The handwritten training layer implements real request-ID polling.
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preview Python compatibility retains the plain session-list response and cursor instead of an ItemPaged wrapper; no HTTP 202 contract is declared."
@@Azure.ClientGenerator.Core.Legacy.disablePageable(
  FineTuningSessions.list,
  "python"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preview Python compatibility retains the plain checkpoint-list response instead of an ItemPaged wrapper; no HTTP 202 contract is declared."
@@Azure.ClientGenerator.Core.Legacy.disablePageable(Checkpoints.list, "python");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preview Python compatibility retains begin_create and its legacy poller customization; this does not declare an HTTP 202 response."
@@Azure.ClientGenerator.Core.Legacy.markAsLro(
  FineTuningSessions.create,
  "python"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preview Python compatibility retains begin_unload and its legacy poller customization; this does not declare an HTTP 202 response."
@@Azure.ClientGenerator.Core.Legacy.markAsLro(
  FineTuningSessions.unload,
  "python"
);
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
