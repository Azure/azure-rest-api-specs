import "../common/service.tsp";

import "../connections/routes.tsp";
import "../datasets/routes.tsp";
import "../indexes/routes.tsp";
import "../models/routes.tsp";
import "../deployments/routes.tsp";
import "../red-teams/routes.tsp";
import "../evaluation-rules/routes.tsp";
import "../openai-evaluations/models.tsp";
import "../evaluation-taxonomies/routes.tsp";
import "../evaluators/routes.tsp";
import "../insights/routes.tsp";
import "../schedules/routes.tsp";
import "../routines/routes.tsp";
import "../skills/routes.tsp";
import "../data_generation_jobs/routes.tsp";

import "../sdk-common/beta-ops-relocation-projects.tsp";

using Azure.ClientGenerator.Core;
namespace Azure.AI.Projects;

// --------------------------------------------------------------------------------
// Root client
// --------------------------------------------------------------------------------
@@clientName(Azure.AI.Projects, "AIProjectClient");

// Java promotes the shared Foundry-Features header with @@clientLocation, not @@scope/@@clientInitialization.
// @@scope(..., "!java") removes the header from Java entirely, including REST-interface @HeaderParam wiring.
// @@clientInitialization requires exact singleton opt-in properties (e.g. evaluations_v1_preview) per key.
// Moving the shared aliases keeps generated wire plumbing and automatically covers new operations using this pattern.
@@scope(WithConditionalFoundryPreviewHeader.foundry_features, "!java");
@@scope(WithRequiredFoundryPreviewHeader.foundry_features, "!java");

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
@@clientName(Datasets.listLatest, "listLatestDatasetVersions");
@@clientName(Datasets.deleteVersion, "deleteDatasetVersion");
@@clientName(Datasets.listVersions, "listDatasetVersions");
@@clientName(Datasets.createOrUpdateVersion, "createOrUpdateDatasetVersion");

// Data generation jobs — renamed SDK discoverability
@@clientName(DataGenerationJobs.get, "getGenerationJob", "java");
@@clientName(DataGenerationJobs.list, "listGenerationJobs", "java");
@@clientName(DataGenerationJobs.create, "createGenerationJob", "java");
@@clientName(DataGenerationJobs.cancel, "cancelGenerationJob", "java");
@@clientName(DataGenerationJobs.delete, "deleteGenerationJob", "java");

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
@@clientName(Evaluators.listVersions, "listEvaluatorVersions");
@@clientName(Evaluators.getVersion, "getEvaluatorVersion");
@@clientName(Evaluators.createVersion, "createEvaluatorVersion");
@@clientName(Evaluators.deleteVersion, "deleteEvaluatorVersion");
@@clientName(Evaluators.listLatestVersions, "listLatestEvaluatorVersions");
@@clientName(Evaluators.updateVersion, "updateEvaluatorVersion");

// Indexes
@@clientName(Indexes.createOrUpdateVersion, "createOrUpdateIndexVersion");
@@clientName(Indexes.deleteVersion, "deleteIndexVersion");
@@clientName(Indexes.getVersion, "getIndexVersion");
@@clientName(Indexes.listLatest, "listLatestIndexVersions");
@@clientName(Indexes.listVersions, "listIndexVersions");

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

// Models
@@clientName(Models.getVersion, "getModelVersion");
@@clientName(Models.listVersions, "listModelVersions");
@@clientName(Models.listLatest, "listLatestModelVersions");
@@clientName(Models.deleteVersion, "deleteModelVersion");
@@clientName(Models.createOrUpdateVersion, "updateModelVersion");
@@clientName(Models.createAsync, "createModelVersionAsync");
@@clientName(Models.startPendingUpload, "startModelPendingUpload");
@@clientName(Models.getCredentials, "getModelCredentials");

//Evaluator generation jobs
@@clientName(EvaluatorGenerationJobs.create, "createEvaluatorGenerationJob");
@@clientName(EvaluatorGenerationJobs.get, "getEvaluatorGenerationJob");
@@clientName(EvaluatorGenerationJobs.list, "listEvaluatorGenerationJobs");
@@clientName(EvaluatorGenerationJobs.cancel, "cancelEvaluatorGenerationJob");
@@clientName(EvaluatorGenerationJobs.delete, "deleteEvaluatorGenerationJob");

//Routines
@@clientName(Routines.dispatchRoutineAsync, "dispatchRoutine");

// --------------------------------------------------------------------------------
// Renames - models
// --------------------------------------------------------------------------------

// // Less generic names
@@clientName(Sku, "ModelDeploymentSku");
@@clientName(SasCredential, "BlobReferenceSasCredential"); // Not to be confused with class "SASCredentials"

@@clientName(Skill, "SkillDetails");

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

@@clientName(Index, "AIProjectIndex", "java");

@@clientName(Azure.Core.Foundations.ResourceBody.resource, "schedule");

@@clientName(BlobReference.blobUri, "blobUrl");
@@clientName(SasCredential.sasUri, "sasUrl");
@@clientName(DatasetVersion.dataUri, "dataUrl");
@@clientName(FolderDatasetVersion.dataUri, "dataUrl");
@@clientName(CodeBasedEvaluatorDefinition.blob_uri, "blobUrl");
@@clientName(ModelVersion.blobUri, "blobUrl");
@@clientName(ModelCredentialRequest.blobUri, "blobUrl");
@@clientName(EvaluatorCredentialRequest.blob_uri, "blobUrl");

// Rename OpenAI.Error to avoid conflict with Azure.Core.Foundations.Error.
// OpenAI.Error is the object type of the `error` properties in `ApiErrorResponse`
// and `MemoryStoreUpdateResponse`.
@@clientName(OpenAI.Error, "ApiError");

@@clientName(RedTeamTargetConfig, "TargetConfig");

// *Request → *Input renames for public body models
@@clientName(UpdateModelVersionRequest, "UpdateModelVersionInput");
@@clientName(ModelPendingUploadRequest, "ModelPendingUploadInput");
@@clientName(ModelCredentialRequest, "ModelCredentialInput");
@@clientName(EvaluatorCredentialRequest, "EvaluatorCredentialInput");

// *Response → *Result renames for public response models
@@clientName(ModelPendingUploadResponse, "ModelPendingUploadResult");
@@clientName(DispatchRoutineResponse, "DispatchRoutineResult");

// --------------------------------------------------------------------------------
// Usage / Public accessibility overrides
// --------------------------------------------------------------------------------

// Keep preview opt-in enum internal to Java; public builders use allowPreview(boolean).
@@usage(FoundryFeaturesOptInKeys, Usage.input, "java");
@@access(FoundryFeaturesOptInKeys, Access.internal, "java");

// Azure-specific OpenAI eval extensions used with the Stainless OpenAI SDK.
@@usage(
  GraderAzureAIEvaluator,
  Usage.input | Usage.output | Usage.json,
  "java"
);
@@access(GraderAzureAIEvaluator, Access.public, "java");
@@usage(
  TestingCriterionAzureAIEvaluator,
  Usage.input | Usage.output | Usage.json,
  "java"
);
@@access(TestingCriterionAzureAIEvaluator, Access.public, "java");

// Default name produces a style violation
@@clientName(SASCredentials, "SasCredential", "java");
@@clientName(SasCredential, "BlobReferenceSasCredential");

// Singularize "Credentials" -> "Credential" for connection credential models
@@clientName(BaseCredentials, "BaseCredential", "java");
@@clientName(ApiKeyCredentials, "ApiKeyCredential", "java");
@@clientName(EntraIDCredentials, "EntraIdCredential", "java");
@@clientName(NoAuthenticationCredentials, "NoAuthenticationCredential", "java");
@@clientName(
  AgenticIdentityPreviewCredentials,
  "AgenticIdentityPreviewCredential",
  "java"
);

// Singularize "credentials" -> "credential" for Connection property accessor
@@clientName(Connection.credentials, "credential", "java");

// Enums variants
@@clientName(ConnectionType.APIKey, "API_KEY", "java");
@@clientName(ConnectionType.RemoteTool, "REMOTE_TOOL_PREVIEW", "java");

// Make these two internal, since all SDKs hand-write a single public method with boolean "includeCredentials"
// input parameter that calls either on these two.
@@access(Connections.get, Access.internal);
@@access(Connections.getWithCredentials, Access.internal);

// The fix for ambiguous import of OperationState
@@clientName(Azure.Core.Foundations.OperationState, "operationStatus", "java");

// is_primary -> primary so accessors become isPrimary()/setPrimary()
@@clientName(EvaluatorMetric.is_primary, "primary", "java");

// Disabled convenient API generation and make private to provide a custom shim returning `void` in the client
@@convenientAPI(Skills.deleteSkill, false, "java");
@@convenientAPI(Skills.deleteSkillVersion, false, "java");

//making delete methods internal to add public shims that return void
@@access(Skills.deleteSkill, Access.internal);
@@clientName(Skills.deleteSkill, "internalDeleteSkill");
@@access(Skills.deleteSkillVersion, Access.internal);
@@clientName(Skills.deleteSkillVersion, "internalDeleteSkillVersion");

// --------------------------------------------------------------------------------
// Type replacements / encodings
// --------------------------------------------------------------------------------

// OpenAI de-dup: suppress ComparisonFilter & CompoundFilter (and their anonymous
// enum types FileSearchToolFiltersType / FileSearchToolFiltersType1) in favour of
// the equivalent openai-java models.
@@alternateType(
  OpenAI.ComparisonFilter,
  {
    identity: "com.openai.models.ComparisonFilter",
  },
  "java"
);
@@alternateType(
  OpenAI.CompoundFilter,
  {
    identity: "com.openai.models.CompoundFilter",
  },
  "java"
);

// GrammarSyntax1 → expandable GrammarSyntax enum
// The OpenAI TypeSpec names this enum "GrammarSyntax1"; replace with an open union
// so it generates as the extensible "GrammarSyntax" string enum in Java.
union GrammarSyntaxExpandable {
  string,
  lark: "lark",
  regex: "regex",
}

@@clientName(GrammarSyntaxExpandable, "GrammarSyntax", "java");
@@alternateType(OpenAI.GrammarSyntax1, GrammarSyntaxExpandable, "java");

@@alternateType(
  DayOfWeek,
  {
    identity: "java.time.DayOfWeek",
  },
  "java"
);

@@alternateType(
  PageOrder,
  {
    identity: "com.azure.ai.agents.models.PageOrder",
  },
  "java"
);

//Suppress the OpenAI.Tool type to prevent from emitting entire tool model tree
@@alternateType(OpenAI.Tool, unknown, "java");

// SasCredential (BlobReferenceSasCredential) type field should use the shared CredentialType enum
@@alternateType(SasCredential.type, CredentialType, "java");

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

// TimeZone property override via model indirection
@alternateType(
  {
    identity: "java.util.TimeZone",
  },
  "java"
)
model TimeZoneType {}

@@alternateType(RecurrenceTrigger.timeZone, TimeZoneType, "java");

// --------------------------------------------------------------------------------
// Relocate EvaluatorGenerationJobs, EvaluationSuites, and
// EvaluationSuiteGenerationJobs onto the Evaluators sub-client
// --------------------------------------------------------------------------------

@@clientLocation(EvaluatorGenerationJobs.create, Evaluators);
@@clientLocation(EvaluatorGenerationJobs.get, Evaluators);
@@clientLocation(EvaluatorGenerationJobs.list, Evaluators);
@@clientLocation(EvaluatorGenerationJobs.cancel, Evaluators);
@@clientLocation(EvaluatorGenerationJobs.delete, Evaluators);
