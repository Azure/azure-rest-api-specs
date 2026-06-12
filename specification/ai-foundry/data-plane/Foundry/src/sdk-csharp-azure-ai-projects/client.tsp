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
@@clientName(ApiKeyCredentials,
  "AIProjectConnectionApiKeyCredential",
  "csharp"
);
@@clientName(CustomCredential, "AIProjectConnectionCustomCredential", "csharp");
@@clientName(EntraIDCredentials,
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
@@clientName(Connections.getWithCredentials,
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
@@clientName(Azure.Core.Foundations.OperationState,
  "operationStatus",
  "csharp"
);
@@clientName(OpenAI.Error, "ApiError");
@@clientName(OpenAI.InputFileContentParam.file_url, "FileUri", "csharp");

@@clientName(AttackStrategy.ROT13, "Rot13", "csharp");

@@alternateType(DayOfWeek,
  {
    identity: "System.DayOfWeek",
  },
  "csharp"
);

@@access(OpenAI.DetailEnum, Access.internal);
@@clientName(OpenAI.DetailEnum, "InternalImageDetailLevel");
@@access(OpenAI.InputImageContentParamAutoParam, Access.internal);
@@clientName(OpenAI.InputImageContentParamAutoParam,
  "InternalInputImageContentParamAutoParam"
);
// --------------------------------------------------------------------------------
// Evaluators sub‐client
// --------------------------------------------------------------------------------
@@access(EvaluatorDefinitionType, Access.public);

// Rename Target from openai-evaluations to EvaluationTarget.
@@clientName(Target, "EvaluationTarget", "csharp");

@@clientName(EvalResult.passed, "IsPassed", "csharp");
@@clientName(EvalRunResultComparison.evaluator, "EvaluatorName", "csharp");
@@clientName(EvalRunResultComparison.metric, "MetricName", "csharp");

@@alternateType(EvaluationScheduleTask.evalRun, unknown, "csharp");

@@clientName(InsightSummary.method, "MethodName", "csharp");

@@clientName(RedTeam.numTurns, "TurnCount", "csharp");
@@clientName(RedTeam.simulationOnly, "IsSimulationOnly", "csharp");

@@clientName(TaxonomySubCategory.enabled, "IsEnabled", "csharp");

@@clientName(DeleteMemoryStoreResponse.deleted, "IsDeleted", "csharp");

@@clientName(MemoryStoreDefaultOptions.chat_summary_enabled,
  "IsChatSummaryEnabled",
  "csharp"
);
@@clientName(MemoryStoreDefaultOptions.user_profile_enabled,
  "IsUserProfileEnabled",
  "csharp"
);

@@clientName(MemoryStoreDeleteScopeResponse.deleted, "IsDeleted", "csharp");
// --------------------------------------------------------------------------------
// Schedules sub‐client
// --------------------------------------------------------------------------------

@@clientName(Azure.Core.Foundations.ResourceBody.resource, "schedule");

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

// --------------------------------------------------------------------------------
// EvaluatorGenerationJobs sub‐client
// --------------------------------------------------------------------------------
// Hide the protocol methods and methods using feature headers
@@access(EvaluatorGenerationJobs.get, Access.internal);
@@access(EvaluatorGenerationJobs.create, Access.internal);
@@access(EvaluatorGenerationJobs.cancel, Access.internal);
@@access(EvaluatorGenerationJobs.delete, Access.internal);

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

// --------------------------------------------------------------------------------
// Routines sub‐client
// --------------------------------------------------------------------------------
@@clientName(Routines, "AIProjectRoutines");
@@clientName(Routine, "ProjectsRoutine");
@@access(Routines.createOrUpdateRoutine, Access.internal);
@@access(Routines.getRoutine, Access.internal);
@@access(Routines.enableRoutine, Access.internal);
@@access(Routines.disableRoutine, Access.internal);
@@access(Routines.deleteRoutine, Access.internal);
@@clientName(Routines.dispatchRoutineAsync, "dispatchAsyncRoutine", "csharp");
@@access(Routines.dispatchRoutineAsync, Access.internal);
