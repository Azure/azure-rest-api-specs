import "./src/common/service.tsp";

import "./src/connections/routes.tsp";
import "./src/datasets/routes.tsp";
import "./src/indexes/routes.tsp";
import "./src/deployments/routes.tsp";
import "./src/red-teams/routes.tsp";
import "./src/evaluation-rules/routes.tsp";
// Don't import openai-evaluations, we'll use Stainless SDK like in AgentsV2
// import "./openai-evaluations/routes.tsp";
import "./src/evaluation-taxonomies/routes.tsp";
import "./src/evaluators/routes.tsp";
import "./src/insights/routes.tsp";
import "./src/schedules/routes.tsp";

using Azure.ClientGenerator.Core;
namespace Azure.AI.Projects;

// --------------------------------------------------------------------------------
// Root client
// --------------------------------------------------------------------------------
@@clientName(Azure.AI.Projects, "AIProjectClient");

// --------------------------------------------------------------------------------
// Renames - operations
// --------------------------------------------------------------------------------

// Connections
@@clientName(Connections.list, "listConnections");
@@clientName(Connections.get, "getConnection");
@@clientName(Connections.getWithCredentials, "getConnectionWithCredentials");

// Datasets
@@clientName(Datasets.getVersion, "getDatasetVersion");
@@clientName(Datasets.startPendingUploadVersion, "pendingUpload");
@@clientName(Datasets.listLatest, "listLatestVersion");

// Deployments
@@clientName(Deployments.list, "listDeployments");
@@clientName(Deployments.get, "getDeployment");

// Evaluation rules
@@clientName(EvaluationRules.list, "listEvaluationRules");
@@clientName(EvaluationRules.get, "getEvaluationRule");
@@clientName(EvaluationRules.createOrUpdate, "createOrUpdateEvaluationRule");
@@clientName(EvaluationRules.delete, "deleteEvaluationRule");

// Evaluation taxonomies
@@clientName(EvaluationTaxonomies.list, "listEvaluationTaxonomies");
@@clientName(EvaluationTaxonomies.get, "getEvaluationTaxonomy");
@@clientName(EvaluationTaxonomies.create, "createEvaluationTaxonomy");
@@clientName(EvaluationTaxonomies.delete, "deleteEvaluationTaxonomy");
@@clientName(EvaluationTaxonomies.update, "updateEvaluationTaxonomy");

// Evaluators
// no renames

// Indexes 
// removed because convention dictates names need to be `verbNoun`
// @@clientName(Indexes.createOrUpdateVersion, "createOrUpdate");

// Insights
@@clientName(Insights.list, "listInsights");
@@clientName(Insights.get, "getInsight");
@@clientName(Insights.generate, "generateInsight");

// Red Teams
@@clientName(RedTeams.list, "listRedTeams");
@@clientName(RedTeams.get, "getRedTeam");
@@clientName(RedTeams.create, "createRedTeamRun");

// Schedules
@@clientName(Schedules.list, "listSchedules");
@@clientName(Schedules.get, "getSchedule");
@@clientName(Schedules.createOrUpdate, "createOrUpdateSchedule");
@@clientName(Schedules.delete, "deleteSchedule");
@@clientName(Schedules.getRun, "getScheduleRun");
@@clientName(Schedules.listRuns, "listScheduleRuns");

// --------------------------------------------------------------------------------
// Renames - models
// --------------------------------------------------------------------------------


// // Less generic names
@@clientName(Sku, "ModelDeploymentSku");
@@clientName(SasCredential, "BlobReferenceSasCredential"); // Not to be confused with class "SASCredentials"

// // More accurate naming
@@clientName(AssetCredentialResponse, "DatasetCredential");

@@clientName(EntraIDCredentials, "EntraIdCredentials");

@@clientName(EvalResult, "EvaluationResult");
@@clientName(EvalRun, "EvaluationRun");
@@clientName(EvalRunDataSource, "EvaluationRunDataSource");
@@clientName(EvalRunOutputItem, "EvaluationRunOutputItem");
@@clientName(EvalRunOutputItemResult, "EvaluationRunOutputItemResult");
@@clientName(EvalRunResultCompareItem, "EvaluationRunResultCompareItem");
@@clientName(EvalRunResultComparison, "EvaluationRunResultComparison");
@@clientName(EvalRunResultSummary, "EvaluationRunResultSummary");

@@clientName(Azure.Core.Foundations.ResourceBody.resource, "schedule");

@@clientName(BlobReference.blobUri, "blobUrl");
@@clientName(SasCredential.sasUri, "sasUrl");

@@clientName(OpenAI.Error, "OpenAIError"); // prevents codegen conflict
// --------------------------------------------------------------------------------
// Usage / Public accessibility overrides
// --------------------------------------------------------------------------------

// Needs forceful exposition
@@access(FoundryFeaturesOptInKeys, Access.public);

// Default name produces a style violation
@@clientName(SASCredentials, "SasCredential", "java");
@@clientName(SasCredential, "BlobReferenceSasCredential");

// Singularize "Credentials" -> "Credential" for connection credential models
@@clientName(BaseCredentials, "BaseCredential", "java");
@@clientName(ApiKeyCredentials, "ApiKeyCredential", "java");
@@clientName(EntraIDCredentials, "EntraIdCredential", "java");
@@clientName(NoAuthenticationCredentials, "NoAuthenticationCredential", "java");
@@clientName(AgenticIdentityPreviewCredentials, "AgenticIdentityPreviewCredential", "java");

// Enums variants
@@clientName(ConnectionType.APIKey, "API_KEY", "java");

// Make these two internal, since all SDKs hand-write a single public method with boolean "includeCredentials"
// input parameter that calls either on these two.
@@access(Connections.get, Access.internal);
@@access(Connections.getWithCredentials, Access.internal);

// The fix for ambiguous import of OperationState
@@clientName(Azure.Core.Foundations.OperationState, "operationStatus", "java");

// --------------------------------------------------------------------------------
// Type replacements / encodings
// --------------------------------------------------------------------------------

// @@alternateType(DayOfWeek, { identity: "java.time.DayOfWeek" }, "java")

// @@access(DayOfWeek, Access.internal);
// @@usage(DayOfWeek, Usage.input);

// EvaluatorVersion datetime fields are typed as string in the spec but carry ISO-8601 timestamps
@@alternateType(EvaluatorVersion.created_at, utcDateTime, "java");
@@alternateType(EvaluatorVersion.modified_at, utcDateTime, "java");

// Schedule trigger datetime fields are typed as string in the spec but carry ISO-8601 timestamps
@@alternateType(RecurrenceTrigger.startTime, utcDateTime, "java");
@@alternateType(RecurrenceTrigger.endTime, utcDateTime, "java");
@@alternateType(OneTimeTrigger.triggerAt, utcDateTime, "java");
@@alternateType(CronTrigger.startTime, utcDateTime, "java");
@@alternateType(CronTrigger.endTime, utcDateTime, "java");
@@alternateType(ScheduleRun.triggerTime, utcDateTime, "java");
