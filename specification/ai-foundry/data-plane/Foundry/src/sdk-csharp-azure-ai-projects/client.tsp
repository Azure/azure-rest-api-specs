import "../common/service.tsp";
import "../sdk-common/error.default.tsp";
import "../connections/routes.tsp";
import "../datasets/routes.tsp";
import "../indexes/routes.tsp";
import "../models/routes.tsp";
import "../deployments/routes.tsp";
import "../red-teams/routes.tsp";
import "../evaluation-rules/routes.tsp";
import "../evaluation-taxonomies/routes.tsp";
import "../evaluators/routes.tsp";
import "../insights/routes.tsp";
import "../schedules/routes.tsp";
import "../memory-stores/routes.tsp";
import "../routines/routes.tsp";
import "../data_generation_jobs/routes.tsp";
import "../toolboxes/models.tsp";
import "../agents/models.tsp";
import "../skills/models.tsp";

using Azure.ClientGenerator.Core;
namespace Azure.AI.Projects;

// --------------------------------------------------------------------------------
// Fix the xref.
// --------------------------------------------------------------------------------
@@clientNamespace(OpenAI, "Azure.AI.Projects", "csharp");
@@clientNamespace(Azure.Core.Foundations, "Azure.AI.Projects", "csharp");

// --------------------------------------------------------------------------------
// Root client
// --------------------------------------------------------------------------------
@@clientName(Azure.AI.Projects, "AIProjectClient");

@@usage(MemoryStoreUpdateCompletedResult, Usage.output);
@@access(MemoryStoreUpdateCompletedResult, Access.public);
@@clientName(MemoryStoreUpdateCompletedResult, "MemoryUpdateResultDetails");

@@clientName(JobStatus, "ProjectsJobStatus");

@@clientName(MemorySearchOptions, "MemorySearchResultOptions");

// Shorter method names for SDK datasets operations
@@clientName(Datasets.listLatest, "list");
@@clientName(Datasets.getVersion, "get");
@@clientName(Datasets.deleteVersion, "delete");
@@clientName(Datasets.createOrUpdateVersion, "createOrUpdate");
@@clientName(Datasets.startPendingUploadVersion, "pendingUpload");

// Data generation jobs — renamed SDK discoverability
@@clientName(DataGenerationJobs.get, "getGenerationJob", "csharp");
@@clientName(DataGenerationJobs.list, "listGenerationJobs", "csharp");
@@clientName(DataGenerationJobs.create, "createGenerationJob", "csharp");
@@clientName(DataGenerationJobs.cancel, "cancelGenerationJob", "csharp");
@@clientName(DataGenerationJobs.delete, "deleteGenerationJob", "csharp");

// Shorter method names for SDK Index operations
@@clientName(Indexes.listLatest, "list");
@@clientName(Indexes.getVersion, "get");
@@clientName(Indexes.deleteVersion, "delete");
@@clientName(Indexes.createOrUpdateVersion, "createOrUpdate");

// Less generic names
@@clientName(Sku, "ModelDeploymentSku");
@@clientName(SasCredential, "BlobReferenceSasCredential"); // Not to be confused with class "SASCredentials"

// More accurate naming
@@clientName(AssetCredentialResponse, "DatasetCredential");

// Less generic names for C# SDK (avoid one-word class names)
@@clientName(BlobReference, "AIProjectBlobReference", "csharp");
@@clientName(Connection, "AIProjectConnection", "csharp");
@@clientName(Deployment, "AIProjectDeployment", "csharp");
@@clientName(DeploymentType, "AIProjectDeploymentType", "csharp");
@@clientName(FieldMapping, "AIProjectIndexFieldMapping", "csharp");
@@clientName(Index, "AIProjectIndex", "csharp");
@@clientName(CosmosDBIndex, "AIProjectCosmosDBIndex", "csharp");
@@clientName(BaseCredentials, "AIProjectConnectionBaseCredential", "csharp");
@@clientName(
  ApiKeyCredentials,
  "AIProjectConnectionApiKeyCredential",
  "csharp"
);
@@clientName(CustomCredential, "AIProjectConnectionCustomCredential", "csharp");
@@clientName(
  EntraIDCredentials,
  "AIProjectConnectionEntraIdCredential",
  "csharp"
);
@@clientName(SASCredentials, "AIProjectConnectionSasCredential", "csharp");
@@clientName(DatasetVersion, "AIProjectDataset", "csharp");
@@clientName(FileDatasetVersion, "FileDataset", "csharp");
@@clientName(FolderDatasetVersion, "FolderDataset", "csharp");

// Do not use terms "request" or "response" in C# class names as these are REST API terms
@@clientName(PendingUploadRequest, "PendingUploadConfiguration", "csharp");
@@clientName(PendingUploadResponse, "PendingUploadResult", "csharp");

// Less generic names for C# subclients
@@clientName(Connections, "AIProjectConnectionsOperations", "csharp");
@@clientName(Datasets, "AIProjectDatasetsOperations", "csharp");
@@clientName(Deployments, "AIProjectDeploymentsOperations", "csharp");
@@clientName(Indexes, "AIProjectIndexesOperations", "csharp");

// Need to explicitly make all get and list methods include the object name for C#
@@clientName(Connections.get, "getConnection", "csharp");
@@clientName(
  Connections.getWithCredentials,
  "getConnectionWithCredentials",
  "csharp"
);
@@clientName(Connections.list, "listConnections", "csharp");
@@clientName(Datasets.getVersion, "getDataset", "csharp");
@@clientName(Datasets.listLatest, "listDatasets", "csharp");
@@clientName(Datasets.listVersions, "listDatasetVersions", "csharp");
@@clientName(Deployments.get, "getDeployment", "csharp");
@@clientName(Deployments.list, "listDeployments", "csharp");
@@clientName(Indexes.getVersion, "getIndex", "csharp");
@@clientName(Indexes.listLatest, "listIndexes", "csharp");
@@clientName(Indexes.listVersions, "listIndexVersions", "csharp");

// Make these two internal, since all SDKs hand-write a single public method with boolean "includeCredentials"
// input parameter that calls either on these two.
@@access(Connections.get, Access.internal);
@@access(Connections.getWithCredentials, Access.internal);

// The fix for ambiguous import of OperationState
@@clientName(
  Azure.Core.Foundations.OperationState,
  "operationStatus",
  "csharp"
);
@@clientName(OpenAI.Error, "ApiError");
@@clientName(OpenAI.InputFileContentParam.file_url, "FileUri", "csharp");

@@clientName(AttackStrategy.ROT13, "Rot13", "csharp");

@@alternateType(
  DayOfWeek,
  {
    identity: "System.DayOfWeek",
  },
  "csharp"
);

@@access(OpenAI.DetailEnum, Access.internal);
@@clientName(OpenAI.DetailEnum, "InternalImageDetailLevel");
@@access(OpenAI.InputImageContentParamAutoParam, Access.internal);
@@clientName(
  OpenAI.InputImageContentParamAutoParam,
  "InternalInputImageContentParamAutoParam"
);
// --------------------------------------------------------------------------------
// Evaluators sub‐client
// --------------------------------------------------------------------------------
@@clientName(Evaluators.getCredentials, "GetCredential");
@@access(Evaluators.getCredentials, Access.internal);
@@access(Evaluators.startPendingUpload, Access.internal);

@@access(EvaluatorDefinitionType, Access.public);

// Rename Target from openai-evaluations to EvaluationTarget.
@@clientName(Target, "EvaluationTarget", "csharp");
@@clientName(EvalResult.passed, "IsPassed", "csharp");
@@clientName(EvalRunResultComparison.evaluator, "EvaluatorName", "csharp");
@@clientName(EvalRunResultComparison.metric, "MetricName", "csharp");
@@clientName(Dimension.always_applicable, "IsAlwaysApplicable");

@@alternateType(EvaluationScheduleTask.evalRun, unknown, "csharp");

@@clientName(RedTeam.numTurns, "TurnCount", "csharp");
@@clientName(RedTeam.simulationOnly, "IsSimulationOnly", "csharp");

@@clientName(TaxonomySubCategory.enabled, "IsEnabled", "csharp");

// --------------------------------------------------------------------------------
// Insights stores sub‐client
// --------------------------------------------------------------------------------
@@clientName(InsightSummary.method, "MethodName", "csharp");
@@clientName(Insight, "ProjectsInsight");

// --------------------------------------------------------------------------------
// Memory stores sub‐client
// --------------------------------------------------------------------------------

@@clientName(DeleteMemoryResponse, "MemoryDeletionResult", "csharp");
@@clientName(DeleteMemoryStoreResponse.deleted, "IsDeleted", "csharp");

@@clientName(
  MemoryStoreDefaultOptions.chat_summary_enabled,
  "IsChatSummaryEnabled",
  "csharp"
);
@@clientName(
  MemoryStoreDefaultOptions.user_profile_enabled,
  "IsUserProfileEnabled",
  "csharp"
);
@@clientName(
  MemoryStoreDefaultOptions.procedural_memory_enabled,
  "IsProceduralMemoryEnabled",
  "csharp"
);

@@clientName(MemoryStoreDeleteScopeResponse.deleted, "IsDeleted", "csharp");
// --------------------------------------------------------------------------------
// Schedules sub‐client
// --------------------------------------------------------------------------------

@@clientName(Azure.Core.Foundations.ResourceBody.resource, "schedule");
@@clientName(Schedule, "ProjectsSchedule");

@@alternateType(RecurrenceTrigger.startTime, utcDateTime, "csharp");
@@alternateType(RecurrenceTrigger.endTime, utcDateTime, "csharp");
@@alternateType(OneTimeTrigger.triggerAt, utcDateTime, "csharp");
@@alternateType(CronTrigger.startTime, utcDateTime, "csharp");
@@alternateType(CronTrigger.endTime, utcDateTime, "csharp");
@@alternateType(ScheduleRun.triggerTime, utcDateTime, "csharp");

// --------------------------------------------------------------------------------
// DataGenerationJobs sub‐client
// --------------------------------------------------------------------------------
// Hide the protocol methods and methods using feature headers
@@access(DataGenerationJobs.get, Access.internal);
@@access(DataGenerationJobs.create, Access.internal);
@@access(DataGenerationJobs.cancel, Access.internal);
@@access(DataGenerationJobs.delete, Access.internal);

@@clientName(DataGenerationJobType, "DataGenerationJobKind");
@@clientName(TracesDataGenerationJobSource.end_time, "EndAt");
@@clientName(TracesDataGenerationJobSource.start_time, "StartAt");
@@clientName(TracesEvaluatorGenerationJobSource.end_time, "EndAt");
@@clientName(TracesEvaluatorGenerationJobSource.start_time, "StartAt");

// --------------------------------------------------------------------------------
// EvaluatorGenerationJobs sub‐client
// --------------------------------------------------------------------------------
// Hide the protocol methods and methods using feature headers
@@access(EvaluatorGenerationJobs.get, Access.internal);
@@access(EvaluatorGenerationJobs.create, Access.internal);
@@access(EvaluatorGenerationJobs.cancel, Access.internal);
@@access(EvaluatorGenerationJobs.delete, Access.internal);

@@clientName(EvaluatorGenerationArtifacts.dataset, "Reference");
@@clientName(EvaluatorGenerationArtifacts.kinds, "DatasetRowKinds");
@@clientName(EvaluatorGenerationInputs.evaluator_description, "Description");

// --------------------------------------------------------------------------------
// Models sub‐client
// --------------------------------------------------------------------------------
@@clientName(Models, "AIProjectModels");
// Models
@@clientName(Models.getVersion, "getModelVersion", "csharp");
@@clientName(Models.listVersions, "getModelVersions", "csharp");
@@clientName(Models.listLatest, "getLatestModelVersions", "csharp");
@@clientName(Models.deleteVersion, "deleteModelVersion", "csharp");
@@clientName(Models.createOrUpdateVersion, "updateModelVersion", "csharp");
@@clientName(Models.createAsync, "createModelVersionRequest", "csharp");
@@clientName(Models.startPendingUpload, "startModelPendingUpload", "csharp");
@@clientName(Models.getCredentials, "getModelCredentials", "csharp");

@@usage(UpdateModelVersionRequest, Usage.input | Usage.output);
@@access(UpdateModelVersionRequest, Access.public);
@@clientName(UpdateModelVersionRequest, "UpdateModelVersionOptions");
@@clientName(ModelPendingUploadRequest, "ModelPendingUploadContent");
@@clientName(ModelPendingUploadResponse, "ModelPendingUploadResult");

// --------------------------------------------------------------------------------
// Routines sub‐client
// --------------------------------------------------------------------------------
@@clientName(Routines, "AIProjectRoutines");
@@access(Routines.createOrUpdateRoutine, Access.internal);
@@clientName(Routines.createOrUpdateRoutine, "CreateOrUpdate");
@@access(Routines.getRoutine, Access.internal);
@@clientName(Routines.getRoutine, "Get");
@@access(Routines.enableRoutine, Access.internal);
@@clientName(Routines.enableRoutine, "Enable");
@@access(Routines.disableRoutine, Access.internal);
@@clientName(Routines.disableRoutine, "Disable");
@@access(Routines.deleteRoutine, Access.internal);
@@clientName(Routines.deleteRoutine, "Delete");
@@clientName(Routines.dispatchRoutineAsync, "Dispatch", "csharp");
@@access(Routines.dispatchRoutineAsync, Access.internal);

@@clientName(Routine, "ProjectsRoutine");
@@clientName(Routine.enabled, "IsEnabled");
@@clientName(DispatchRoutineResponse, "DispatchRoutineResult");
@@usage(DispatchRoutineResponse, Usage.input | Usage.output);
@@clientName(
  InvokeAgentInvocationsApiDispatchPayload,
  "AgentInvocationsApiDispatchPayload"
);
@@clientName(
  InvokeAgentInvocationsApiRoutineAction,
  "AgentInvocationsApiRoutineAction"
);
@@clientName(
  InvokeAgentResponsesApiDispatchPayload,
  "AgentResponsesApiDispatchPayload"
);
@@clientName(
  InvokeAgentResponsesApiRoutineAction,
  "AgentResponsesApiRoutineAction"
);
@@clientName(RoutineActionType, "RoutineActionKind");
@@clientName(RoutineTriggerType, "RoutineTriggerKind");

// --------------------------------------------------------------------------------
// Export Azure Tool types from the OpenAI package instead of re-emitting them.
// Each target verified public in OpenAI 3.0.0-alpha.20260805.1.
// --------------------------------------------------------------------------------
@@alternateType(
  Azure.AI.Projects.A2APreviewTool,
  {
    identity: "Azure.AI.Extensions.OpenAI.A2APreviewTool",
    package: "Azure.AI.Extensions.OpenAI",
    minVersion: "3.0.0-alpha.20260805.1",
  },
  "csharp"
);
@@alternateType(
  Azure.AI.Projects.AzureAISearchTool,
  {
    identity: "Azure.AI.Extensions.OpenAI.AzureAISearchTool",
    package: "Azure.AI.Extensions.OpenAI",
    minVersion: "3.0.0-alpha.20260805.1",
  },
  "csharp"
);
@@alternateType(
  Azure.AI.Projects.AISearchIndexResource,
  {
    identity: "Azure.AI.Extensions.OpenAI.AzureAISearchToolIndex",
    package: "Azure.AI.Extensions.OpenAI",
    minVersion: "3.0.0-alpha.20260805.1",
  },
  "csharp"
);
@@alternateType(
  Azure.AI.Projects.AzureAISearchToolResource,
  {
    identity: "Azure.AI.Extensions.OpenAI.AzureAISearchToolOptions",
    package: "Azure.AI.Extensions.OpenAI",
    minVersion: "3.0.0-alpha.20260805.1",
  },
  "csharp"
);
@@alternateType(
  Azure.AI.Projects.AzureFunctionBinding,
  {
    identity: "Azure.AI.Extensions.OpenAI.AzureFunctionBinding",
    package: "Azure.AI.Extensions.OpenAI",
    minVersion: "3.0.0-alpha.20260805.1",
  },
  "csharp"
);
@@alternateType(
  Azure.AI.Projects.AzureFunctionDefinition,
  {
    identity: "Azure.AI.Extensions.OpenAI.AzureFunctionDefinition",
    package: "Azure.AI.Extensions.OpenAI",
    minVersion: "3.0.0-alpha.20260805.1",
  },
  "csharp"
);
@@alternateType(
  Azure.AI.Projects.AzureFunctionStorageQueue,
  {
    identity: "Azure.AI.Extensions.OpenAI.AzureFunctionStorageQueue",
    package: "Azure.AI.Extensions.OpenAI",
    minVersion: "3.0.0-alpha.20260805.1",
  },
  "csharp"
);
@@alternateType(
  Azure.AI.Projects.AzureFunctionTool,
  {
    identity: "Azure.AI.Extensions.OpenAI.AzureFunctionTool",
    package: "Azure.AI.Extensions.OpenAI",
    minVersion: "3.0.0-alpha.20260805.1",
  },
  "csharp"
);
@@alternateType(
  Azure.AI.Projects.BingCustomSearchPreviewTool,
  {
    identity: "Azure.AI.Extensions.OpenAI.BingCustomSearchPreviewTool",
    package: "Azure.AI.Extensions.OpenAI",
    minVersion: "3.0.0-alpha.20260805.1",
  },
  "csharp"
);
@@alternateType(
  Azure.AI.Projects.BingGroundingTool,
  {
    identity: "Azure.AI.Extensions.OpenAI.BingGroundingTool",
    package: "Azure.AI.Extensions.OpenAI",
    minVersion: "3.0.0-alpha.20260805.1",
  },
  "csharp"
);
@@alternateType(
  Azure.AI.Projects.BingCustomSearchConfiguration,
  {
    identity: "Azure.AI.Extensions.OpenAI.BingCustomSearchConfiguration",
    package: "Azure.AI.Extensions.OpenAI",
    minVersion: "3.0.0-alpha.20260805.1",
  },
  "csharp"
);
@@alternateType(
  Azure.AI.Projects.BingCustomSearchToolParameters,
  {
    identity: "Azure.AI.Extensions.OpenAI.BingCustomSearchToolOptions",
    package: "Azure.AI.Extensions.OpenAI",
    minVersion: "3.0.0-alpha.20260805.1",
  },
  "csharp"
);
@@alternateType(
  Azure.AI.Projects.BingGroundingSearchConfiguration,
  {
    identity: "Azure.AI.Extensions.OpenAI.BingGroundingSearchConfiguration",
    package: "Azure.AI.Extensions.OpenAI",
    minVersion: "3.0.0-alpha.20260805.1",
  },
  "csharp"
);
@@alternateType(
  Azure.AI.Projects.BingGroundingSearchToolParameters,
  {
    identity: "Azure.AI.Extensions.OpenAI.BingGroundingSearchToolOptions",
    package: "Azure.AI.Extensions.OpenAI",
    minVersion: "3.0.0-alpha.20260805.1",
  },
  "csharp"
);
@@alternateType(
  Azure.AI.Projects.BrowserAutomationPreviewTool,
  {
    identity: "Azure.AI.Extensions.OpenAI.BrowserAutomationPreviewTool",
    package: "Azure.AI.Extensions.OpenAI",
    minVersion: "3.0.0-alpha.20260805.1",
  },
  "csharp"
);
@@alternateType(
  Azure.AI.Projects.BrowserAutomationToolConnectionParameters,
  {
    identity: "Azure.AI.Extensions.OpenAI.BrowserAutomationToolConnectionParameters",
    package: "Azure.AI.Extensions.OpenAI",
    minVersion: "3.0.0-alpha.20260805.1",
  },
  "csharp"
);
@@alternateType(
  Azure.AI.Projects.BrowserAutomationToolParameters,
  {
    identity: "Azure.AI.Extensions.OpenAI.BrowserAutomationToolOptions",
    package: "Azure.AI.Extensions.OpenAI",
    minVersion: "3.0.0-alpha.20260805.1",
  },
  "csharp"
);
@@alternateType(
  Azure.AI.Projects.CaptureStructuredOutputsTool,
  {
    identity: "Azure.AI.Extensions.OpenAI.CaptureStructuredOutputsTool",
    package: "Azure.AI.Extensions.OpenAI",
    minVersion: "3.0.0-alpha.20260805.1",
  },
  "csharp"
);
@@alternateType(
  Azure.AI.Projects.FabricIQPreviewTool,
  {
    identity: "Azure.AI.Extensions.OpenAI.FabricIQPreviewTool",
    package: "Azure.AI.Extensions.OpenAI",
    minVersion: "3.0.0-alpha.20260805.1",
  },
  "csharp"
);
@@alternateType(
  Azure.AI.Projects.FabricDataAgentToolParameters,
  {
    identity: "Azure.AI.Extensions.OpenAI.FabricDataAgentToolOptions",
    package: "Azure.AI.Extensions.OpenAI",
    minVersion: "3.0.0-alpha.20260805.1",
  },
  "csharp"
);
@@alternateType(
  Azure.AI.Projects.MemorySearchPreviewTool,
  {
    identity: "Azure.AI.Extensions.OpenAI.MemorySearchPreviewTool",
    package: "Azure.AI.Extensions.OpenAI",
    minVersion: "3.0.0-alpha.20260805.1",
  },
  "csharp"
);
@@alternateType(
  Azure.AI.Projects.MemorySearchOptions,
  {
    identity: "Azure.AI.Extensions.OpenAI.MemorySearchOptions",
    package: "Azure.AI.Extensions.OpenAI",
    minVersion: "3.0.0-alpha.20260805.1",
  },
  "csharp"
);
@@alternateType(
  Azure.AI.Projects.MicrosoftFabricPreviewTool,
  {
    identity: "Azure.AI.Extensions.OpenAI.MicrosoftFabricPreviewTool",
    package: "Azure.AI.Extensions.OpenAI",
    minVersion: "3.0.0-alpha.20260805.1",
  },
  "csharp"
);
@@alternateType(
  Azure.AI.Projects.OpenApiAnonymousAuthDetails,
  {
    identity: "Azure.AI.Extensions.OpenAI.OpenAPIAnonymousAuthenticationDetails",
    package: "Azure.AI.Extensions.OpenAI",
    minVersion: "3.0.0-alpha.20260805.1",
  },
  "csharp"
);
@@alternateType(
  Azure.AI.Projects.OpenApiAuthDetails,
  {
    identity: "Azure.AI.Extensions.OpenAI.OpenApiAuthenticationDetails",
    package: "Azure.AI.Extensions.OpenAI",
    minVersion: "3.0.0-alpha.20260805.1",
  },
  "csharp"
);
@@alternateType(
  Azure.AI.Projects.OpenApiTool,
  {
    identity: "Azure.AI.Extensions.OpenAI.OpenAPITool",
    package: "Azure.AI.Extensions.OpenAI",
    minVersion: "3.0.0-alpha.20260805.1",
  },
  "csharp"
);
@@alternateType(
  Azure.AI.Projects.SharepointPreviewTool,
  {
    identity: "Azure.AI.Extensions.OpenAI.SharepointPreviewTool",
    package: "Azure.AI.Extensions.OpenAI",
    minVersion: "3.0.0-alpha.20260805.1",
  },
  "csharp"
);

@@usage(OpenAI.OutputItemType, Usage.output | Usage.json | Usage.input);
@@alternateType(
  OpenAI.OutputItemType,
  {
    identity: "OpenAI.Responses.ResponseItemKind",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);

// --------------------------------------------------------------------------------
// Export OpenAI types from the OpenAI package instead of re-emitting them.
// Each target verified public in OpenAI 2.11.0. Input/output TypeSpec twins
// (the "...Param" variants) are mapped onto the single OpenAI package type.
// --------------------------------------------------------------------------------
//@@usage(OpenAI.ToolType, Usage.output | Usage.json | Usage.input);
@@alternateType(
  OpenAI.RankingOptions,
  {
    identity: "OpenAI.Responses.FileSearchToolRankingOptions",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
@@alternateType(
  OpenAI.ToolType,
  {
    identity: "OpenAI.Responses.ResponseToolKind",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
@@alternateType(
  OpenAI.Tool,
  {
    identity: "OpenAI.Responses.ResponseTool",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
@@alternateType(
  OpenAI.ComputerTool,
  {
    identity: "OpenAI.Responses.ComputerTool",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);

@@alternateType(
  OpenAI.WebSearchTool,
  {
    identity: "OpenAI.Responses.WebSearchTool",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
@@alternateType(
  OpenAI.FunctionTool,
  {
    identity: "OpenAI.Responses.FunctionTool",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
@@alternateType(
  OpenAI.AnnotationType,
  {
    identity: "OpenAI.Responses.ResponseMessageAnnotationKind",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
@@alternateType(
  OpenAI.ApplyPatchCallOutputStatus,
  {
    identity: "OpenAI.Responses.ApplyPatchCallOutputStatus",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
@@alternateType(
  OpenAI.ImageGenTool,
  {
    identity: "OpenAI.Responses.ImageGenerationTool",
  },
  "csharp"
);
@@alternateType(
  OpenAI.ImageGenTool,
  {
    identity: "OpenAI.Responses.ImageGenerationTool",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);

@@alternateType(
  OpenAI.CodeInterpreterOutputImage,
  {
    identity: "OpenAI.Responses.CodeInterpreterCallImageOutput",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
@@alternateType(
  OpenAI.CodeInterpreterOutputLogs,
  {
    identity: "OpenAI.Responses.CodeInterpreterCallLogsOutput",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
// ApplyPatch tool: status enums (closed enum -> extensible struct in package)
@@alternateType(
  OpenAI.ApplyPatchCallOutputStatusParam,
  {
    identity: "OpenAI.Responses.ApplyPatchCallOutputStatus",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
@@alternateType(
  OpenAI.ApplyPatchCallStatus,
  {
    identity: "OpenAI.Responses.ApplyPatchCallStatus",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
@@alternateType(
  OpenAI.ApplyPatchCallStatusParam,
  {
    identity: "OpenAI.Responses.ApplyPatchCallStatus",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);

// ApplyPatch tool: file operations
@@alternateType(
  OpenAI.ApplyPatchOperationParam,
  {
    identity: "OpenAI.Responses.ApplyPatchOperation",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
@@alternateType(
  OpenAI.ApplyPatchCreateFileOperation,
  {
    identity: "OpenAI.Responses.ApplyPatchCreateFileOperation",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
@@alternateType(
  OpenAI.ApplyPatchDeleteFileOperation,
  {
    identity: "OpenAI.Responses.ApplyPatchDeleteFileOperation",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
@@alternateType(
  OpenAI.ApplyPatchDeleteFileOperationParam,
  {
    identity: "OpenAI.Responses.ApplyPatchDeleteFileOperation",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
@@alternateType(
  OpenAI.ApplyPatchUpdateFileOperation,
  {
    identity: "OpenAI.Responses.ApplyPatchUpdateFileOperation",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
@@alternateType(
  OpenAI.ApplyPatchUpdateFileOperationParam,
  {
    identity: "OpenAI.Responses.ApplyPatchUpdateFileOperation",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);

// Computer tool
// @@alternateType(OpenAI.ComputerActionType, {  identity: "OpenAI.Responses.ComputerCallActionKind",  package: "OpenAI",  minVersion: "2.12.0"}, "csharp");
@@alternateType(
  OpenAI.ComputerCallSafetyCheckParam,
  {
    identity: "OpenAI.Responses.ComputerCallSafetyCheck",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);

// Message item
//@@alternateType(OpenAI.MessageRole, {  identity: "OpenAI.Responses.MessageRole",  package: "OpenAI",  minVersion: "2.12.0"}, "csharp");
//@@alternateType(OpenAI.MessageStatus, {  identity: "OpenAI.Responses.MessageStatus",  package: "OpenAI",  minVersion: "2.12.0"}, "csharp");

// Annotations
@@alternateType(
  OpenAI.ContainerFileCitationBody,
  {
    identity: "OpenAI.Responses.ContainerFileCitationMessageAnnotation",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);

// Response-level enums / details
@@alternateType(
  OpenAI.ResponseErrorCode,
  {
    identity: "OpenAI.Responses.ResponseErrorCode",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
// NOTE: the TypeSpec model is `union ServiceTier`; the emitter prefixes it to
// ResponseServiceTier, so the alternateType source must be OpenAI.ServiceTier.
@@alternateType(
  OpenAI.ServiceTier,
  {
    identity: "OpenAI.Responses.ResponseServiceTier",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);

// Token usage
@@alternateType(
  OpenAI.ResponseUsage,
  {
    identity: "OpenAI.Responses.ResponseTokenUsage",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
@@alternateType(
  OpenAI.ResponseUsageInputTokensDetails,
  {
    identity: "OpenAI.Responses.ResponseInputTokenUsageDetails",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
@@alternateType(
  OpenAI.ResponseUsageOutputTokensDetails,
  {
    identity: "OpenAI.Responses.ResponseOutputTokenUsageDetails",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);

@@alternateType(
  OpenAI.Annotation,
  {
    identity: "OpenAI.Responses.ResponseMessageAnnotation",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);

@@alternateType(
  OpenAI.Response,
  {
    identity: "OpenAI.Responses.ResponseResult",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);

@@alternateType(
  OpenAI.DetailEnum,
  {
    identity: "OpenAI.Responses.ResponseImageDetailLevel",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
@@alternateType(
  OpenAI.ImageGenActionEnum,
  {
    identity: "OpenAI.Responses.ImageGenerationToolAction",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
@@alternateType(
  OpenAI.InputFidelity,
  {
    identity: "OpenAI.Responses.ImageGenerationToolInputFidelity",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
@@alternateType(
  OpenAI.TopLogProb,
  {
    identity: "OpenAI.Responses.ResponseTokenTopLogProbabilityDetails",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
@@alternateType(
  OpenAI.LogProb,
  {
    identity: "OpenAI.Responses.ResponseTokenLogProbabilityDetails",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);

@@alternateType(
  OpenAI.Reasoning,
  {
    identity: "OpenAI.Responses.ResponseReasoningOptions",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
@@alternateType(
  OpenAI.ResponseError,
  {
    identity: "OpenAI.Responses.ResponseError",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
@@alternateType(
  OpenAI.ApproximateLocation,
  {
    identity: "OpenAI.Responses.WebSearchToolApproximateLocation",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);

@@alternateType(
  OpenAI.MCPTool,
  {
    identity: "OpenAI.Responses.McpTool",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
@@alternateType(
  OpenAI.WebSearchPreviewTool,
  {
    identity: "OpenAI.Responses.WebSearchPreviewTool",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
@@alternateType(
  OpenAI.CodeInterpreterTool,
  {
    identity: "OpenAI.Responses.CodeInterpreterToolContainer",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
@@alternateType(
  OpenAI.MCPListToolsTool,
  {
    identity: "OpenAI.Responses.McpToolDefinition",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
@@alternateType(
  OpenAI.WebSearchActionSearch,
  {
    identity: "OpenAI.Responses.WebSearchSearchAction",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
@@alternateType(
  OpenAI.WebSearchActionOpenPage,
  {
    identity: "OpenAI.Responses.WebSearchOpenPageAction",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
@@alternateType(
  OpenAI.WebSearchActionFind,
  {
    identity: "OpenAI.Responses.WebSearchFindInPageAction",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
@@alternateType(
  OpenAI.MCPToolRequireApproval,
  {
    identity: "OpenAI.Responses.McpToolCallApprovalPolicy",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
@@alternateType(
  OpenAI.MCPToolFilter,
  {
    identity: "OpenAI.Responses.McpToolFilter",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);

// And now drop classes that aren't referenced, and aren't pruned.
@@alternateType(
  OpenAI.InputTextContent,
  {
    identity: "System.Object",
  },
  "csharp"
);
@@alternateType(
  OpenAI.InputTextContentParam,
  {
    identity: "System.Object",
  },
  "csharp"
);
@@alternateType(
  OpenAI.InputImageContent,
  {
    identity: "System.Object",
  },
  "csharp"
);
@@alternateType(
  OpenAI.ComparisonFilter,
  {
    identity: "System.Object",
  },
  "csharp"
);
@@alternateType(
  OpenAI.CompoundFilter,
  {
    identity: "System.Object",
  },
  "csharp"
);
@@alternateType(
  OpenAI.RankingOptions,
  {
    identity: "System.Object",
  },
  "csharp"
);
@@alternateType(
  OpenAI.InputImageContentParamAutoParam,
  {
    identity: "System.Object",
  },
  "csharp"
);
@@alternateType(
  OpenAI.InputFileContent,
  {
    identity: "System.Object",
  },
  "csharp"
);
// GAP (FD-2): The Foundry service accepts `memory_limit` and `network_policy` on the code-interpreter
// "auto" container config (see AutoCodeInterpreterToolParam in the compiled openapi3), but OpenAI's
// .NET type `OpenAI.Responses.AutomaticCodeInterpreterToolContainerConfiguration` (2.12.0) models only
// `file_ids`. This is an upstream source-of-truth lag: openai-dotnet/specification's CodeInterpreterToolAuto
// omits these fields while openai-openapi-pr defines them, so no richer OpenAI type exists to map to.
// Dropping to System.Object intentionally leaves the gap unfilled (file_ids and container-id selection are
// unaffected). Revisit once the OpenAI .NET SDK models memory_limit/network_policy. See CHANGELOG 3.0.0-beta.1.
@@alternateType(
  OpenAI.AutoCodeInterpreterToolParam,
  {
    identity: "System.Object",
  },
  "csharp"
);
@@alternateType(
  OpenAI.ToolChoiceOptions,
  {
    identity: "System.Object",
  },
  "csharp"
);
@@alternateType(
  OpenAI.VectorStoreFileAttributes,
  {
    identity: "System.Object",
  },
  "csharp"
);

@@alternateType(
  OpenAI.ResponseFormatJsonSchemaSchema,
  {
    identity: "System.Object",
  },
  "csharp"
);
// OpenAI SDK: internal partial class InternalItemContentInputFile
@@alternateType(
  OpenAI.InputFileContentParam,
  {
    identity: "System.Object",
  },
  "csharp"
);
// ToolType = "local_shell"
@@alternateType(
  OpenAI.LocalShellToolParam,
  {
    identity: "System.Object",
  },
  "csharp"
);
// ToolType = "shell"
@@alternateType(
  OpenAI.FunctionShellToolParam,
  {
    identity: "System.Object",
  },
  "csharp"
);
// ToolType = "custom"
@@alternateType(
  OpenAI.CustomToolParam,
  {
    identity: "System.Object",
  },
  "csharp"
);
// ToolType = "namespace"
@@alternateType(
  OpenAI.NamespaceToolParam,
  {
    identity: "System.Object",
  },
  "csharp"
);

// ToolType = "tool_search"
@@alternateType(
  OpenAI.ToolSearchToolParam,
  {
    identity: "System.Object",
  },
  "csharp"
);