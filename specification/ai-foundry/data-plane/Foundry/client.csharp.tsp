import "./src/common/service.tsp";
import "./src/connections/routes.tsp";
import "./src/datasets/routes.tsp";
import "./src/indexes/routes.tsp";
import "./src/deployments/routes.tsp";
import "./src/red-teams/routes.tsp";
import "./src/evaluation-rules/routes.tsp";
import "./src/evaluation-taxonomies/routes.tsp";
import "./src/evaluators/routes.tsp";
import "./src/insights/routes.tsp";
import "./src/schedules/routes.tsp";
import "./src/memory-stores/routes.tsp";

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

// Hide classes not currently used
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

@@access(OpenAI.CustomToolParam, Access.internal, "csharp");
