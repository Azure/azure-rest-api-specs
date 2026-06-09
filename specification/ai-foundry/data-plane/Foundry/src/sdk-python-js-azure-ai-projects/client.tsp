//
// This file is used for emitting the Python client (package azure-ai-projects) and
// the JS client (package @azure/ai-projects).
//

// Stable operations (GA routes) with preview features (optional opt-in request headers)
import "../agents/routes.tsp";
import "../evaluation-rules/routes.tsp";

// Stable operation (GA routes) without preview features
import "../connections/routes.tsp";
import "../datasets/routes.tsp";
import "../deployments/routes.tsp";
import "../indexes/routes.tsp";

// Beta operations (preview routes, requiring opt-in request header)
import "../evaluation-taxonomies/routes.tsp";
import "../evaluators/routes.tsp";
import "../insights/routes.tsp";
import "../memory-stores/routes.tsp";
import "../models/routes.tsp";
import "../red-teams/routes.tsp";
import "../routines/routes.tsp";
import "../schedules/routes.tsp";
import "../toolboxes/routes.tsp";
import "../skills/routes.tsp";
import "../agents-session-files/routes.tsp";
import "../data_generation_jobs/routes.tsp";
//import "../evaluation-suites/routes.tsp";
import "../agents-optimization/routes.tsp";

// Create a ".beta" subclient for the above beta operations
import "../sdk-common/beta-ops-relocation-agents.tsp";
import "../sdk-common/beta-ops-relocation-projects.tsp";

using Azure.ClientGenerator.Core;
using Azure.AI.Projects;

// --------------------------------------------------------------------------------
// Root client
// --------------------------------------------------------------------------------
@@clientName(Azure.AI.Projects, "AIProjectClient");

// --------------------------------------------------------------------------------
// Namespace remapping
// --------------------------------------------------------------------------------

// To fix circular dependency in Python, remaining OpenAI types are emitted as Azure.AI.Projects
@@clientNamespace(OpenAI, "azure.ai.projects", "python");

// ********************************************************************************
// ********************************************************************************
// ********************************************************************************
//
//                       PART 1 - RELATED TO GA OPERATIONS
//
// ********************************************************************************
// ********************************************************************************
// ********************************************************************************

// --------------------------------------------------------------------------------
// Agents sub‐client
// --------------------------------------------------------------------------------

// Use short form method names
@@clientName(Agents.getAgent, "get");
@@clientName(Agents.deleteAgent, "delete");
@@clientName(Agents.listAgents, "list");
@@clientName(Agents.createAgentVersion, "createVersion");
@@clientName(Agents.getAgentVersion, "getVersion");
@@clientName(Agents.deleteAgentVersion, "deleteVersion");
@@clientName(Agents.listAgentVersions, "listVersions");
@@clientName(
  Agents.createAgentVersionFromManifest,
  "create_version_from_manifest",
  "python"
);

// Exclude these operations entirely from the Python SDK.
// Note that JavaScript SDK already shipped 2.0.0 with these, so they can't be removed.
@@scope(Agents.createAgent, "!(python)");
@@scope(Agents.updateAgent, "!(python)");
@@scope(Agents.createAgentFromManifest, "!(python)");
@@scope(Agents.updateAgentFromManifest, "!(python)");

// Rename models ending with 'Object' to end with 'Details' for Python
@@clientName(AgentObject, "AgentDetails", "python");
@@clientName(AgentVersionObject, "AgentVersionDetails", "python");
@@clientName(Agents.patchAgentObject, "patchAgentDetails", "python");

@@clientName(AgentObject, "Agent", "javascript");
@@clientName(AgentVersionObject, "AgentVersion", "javascript");

// Python emitter creates enum A2_A_PREVIEW = "a2a_preview". Override it here to "A2A_PREVIEW".
@@clientName(_PreviewAgentToolType.a2a_preview, "A2A_PREVIEW", "python");

// Python emitter creates enum values ENUM_1_G = "1g", ENUM_4_G = "4g" etc. Override it here as below.
@@clientName(OpenAI.ContainerMemoryLimit.`1g`, "MEMORY_1GB", "python");
@@clientName(OpenAI.ContainerMemoryLimit.`4g`, "MEMORY_4GB", "python");
@@clientName(OpenAI.ContainerMemoryLimit.`16g`, "MEMORY_16GB", "python");
@@clientName(OpenAI.ContainerMemoryLimit.`64g`, "MEMORY_64GB", "python");

@@clientName(OpenAI.ImageGenActionEnum, "ImageGenAction");

// --------------------------------------------------------------------------------
// Datasets sub‐client
// --------------------------------------------------------------------------------

// Shorter method names for SDK datasets operations
@@clientName(Datasets.listLatest, "list");
@@clientName(Datasets.getVersion, "get");
@@clientName(Datasets.deleteVersion, "delete");
@@clientName(Datasets.createOrUpdateVersion, "createOrUpdate");
@@clientName(Datasets.startPendingUploadVersion, "pendingUpload");

// Data generation jobs — renamed for SDK discoverability
@@clientName(DataGenerationJobs.get, "getGenerationJob");
@@clientName(DataGenerationJobs.list, "listGenerationJobs");
@@clientName(DataGenerationJobs.create, "createGenerationJob");
@@clientName(DataGenerationJobs.cancel, "cancelGenerationJob");
@@clientName(DataGenerationJobs.delete, "deleteGenerationJob");

// More accurate naming
@@clientName(AssetCredentialResponse, "DatasetCredential");
@@clientName(SasCredential, "BlobReferenceSasCredential"); // Not to be confused with class "SASCredentials"

// --------------------------------------------------------------------------------
// Indexes sub‐client
// --------------------------------------------------------------------------------

// Shorter method names for SDK Index operations
@@clientName(Indexes.listLatest, "list");
@@clientName(Indexes.getVersion, "get");
@@clientName(Indexes.deleteVersion, "delete");
@@clientName(Indexes.createOrUpdateVersion, "createOrUpdate");

// --------------------------------------------------------------------------------
// Toolboxes sub-client
// --------------------------------------------------------------------------------

@@clientName(Toolboxes.createToolboxVersion, "create_version");
@@clientName(Toolboxes.updateToolbox, "update");
@@clientName(Toolboxes.getToolbox, "get");
@@clientName(Toolboxes.getToolboxVersion, "get_version");
@@clientName(Toolboxes.listToolboxes, "list");
@@clientName(Toolboxes.listToolboxVersions, "list_versions");
@@clientName(Toolboxes.deleteToolbox, "delete");
@@clientName(Toolboxes.deleteToolboxVersion, "delete_version");

// --------------------------------------------------------------------------------
// Connections sub‐client
// --------------------------------------------------------------------------------

// Make these two internal, since all SDKs hand-write a single public method with boolean "includeCredentials"
// input parameter that calls either on these two.
@@access(Connections.get, Access.internal);
@@access(Connections.getWithCredentials, Access.internal);

// --------------------------------------------------------------------------------
// Deployment sub‐client
// --------------------------------------------------------------------------------

// Less generic names
@@clientName(Sku, "ModelDeploymentSku");

// --------------------------------------------------------------------------------
// Other
// --------------------------------------------------------------------------------

// Rename OpenAI.Error to avoid conflict with Azure.Core.Foundations.Error.
// OpenAI.Error is the object type of the `error` properties in `ApiErrorResponse`
// and `MemoryStoreUpdateResponse`.
@@clientName(OpenAI.Error, "ApiError");

// ********************************************************************************
// ********************************************************************************
// ********************************************************************************
//
//                       PART 2 - RELATED TO BETA OPERATIONS
//
// ********************************************************************************
// ********************************************************************************
// ********************************************************************************

// --------------------------------------------------------------------------------
// Beta Agents sub-client
// --------------------------------------------------------------------------------

@@clientName(AgentOptimizationJobs.create, "createOptimizationJob");
@@clientName(AgentOptimizationJobs.get, "getOptimizationJob");
@@clientName(AgentOptimizationJobs.list, "listOptimizationJobs");
@@clientName(AgentOptimizationJobs.cancel, "cancelOptimizationJob");
@@clientName(AgentOptimizationJobs.delete, "deleteOptimizationJob");
@@clientName(
  AgentOptimizationJobs.listCandidates,
  "listOptimizationCandidates"
);
@@clientName(AgentOptimizationJobs.getCandidate, "getOptimizationCandidate");
@@clientName(
  AgentOptimizationJobs.getCandidateConfig,
  "getOptimizationCandidateConfig"
);
@@clientName(
  AgentOptimizationJobs.getCandidateResults,
  "getOptimizationCandidateResults"
);

// DatasetItem model has a property `response_items?: OpenAI.OutputItem[]`. It is used
// to define Agent optimization request. If emitted as-is, it pulls in a lot of
// OpenAI responses classes. We want Foundry SDK to be free of those, therefore for the
// time being we define output item as a generic dictionary.
@@alternateType(OpenAI.OutputItem, Record<unknown>);

// Make this method internal, since it's patched with a new one that supports either binary or file-path input
@@access(AgentSessionFiles.uploadSessionFile, Access.internal, "python");
@@usage(SessionFileWriteResponse, Usage.output);
@@access(SessionFileWriteResponse, Access.public);

// Exclude these operations entirely from emitted SDK. These are convenience REST APIs that we don't think bring
// real value on SDK surface. We can do everything using createAgentVersionFromCode.
@@scope(Agents.createAgentFromCode, "!(python, javascript)");
@@scope(Agents.updateAgentFromCode, "!(python, javascript)");

@@clientName(Agents.downloadAgentCode, "download_code", "python");
@@clientName(Agents.createAgentVersionFromCode, "createVersionFromCode");

@@clientName(DownloadAgentCodeResponse, "DownloadAgentCodeResult", "python");
@@clientName(
  SessionDirectoryListResponse,
  "SessionDirectoryListResult",
  "python"
);
@@clientName(SessionFileWriteResponse, "SessionFileWriteResult", "python");

// --------------------------------------------------------------------------------
// Class renames related to Responses
// --------------------------------------------------------------------------------

// Allow assigning a `dict[str, Any]` object directly to the "schema" property of TextResponseFormatJsonSchema
@@alternateType(OpenAI.ResponseFormatJsonSchemaSchema, Record<unknown>);

// Note there is also OpenAI.TextResponseFormatJsonSchema (which extends OpenAI.TextResponseFormatConfiguration). It already has a good name.
@@clientName(OpenAI.TextResponseFormatConfiguration, "TextResponseFormat");
@@clientName(
  OpenAI.TextResponseFormatConfigurationResponseFormatText,
  "TextResponseFormatText"
);
@@clientName(
  OpenAI.TextResponseFormatConfigurationResponseFormatJsonObject,
  "TextResponseFormatJsonObject"
);

// --------------------------------------------------------------------------------
// Beta Memories sub-client
// --------------------------------------------------------------------------------

@@clientName(MemoryStores.createMemoryStore, "create");
@@clientName(MemoryStores.updateMemoryStore, "update");
@@clientName(MemoryStores.getMemoryStore, "get");
@@clientName(MemoryStores.listMemoryStores, "list");
@@clientName(MemoryStores.deleteMemoryStore, "delete");
@@clientName(MemoryStoreSearchResponse, "MemoryStoreSearchResult", "python");
@@clientName(DeleteMemoryStoreResponse, "DeleteMemoryStoreResult", "python");
@@clientName(DeleteMemoryResponse, "DeleteMemoryResult", "python");
@@clientName(MemoryStoreUpdateResponse, "MemoryStoreUpdateResult", "python");
@@clientName(
  MemoryStoreDeleteScopeResponse,
  "MemoryStoreDeleteScopeResult",
  "python"
);

// For Python and JS, Memory Stores update and search operations are the only Foundry operations that
// define OpenAI.InputItem as inputs. This pulls in ~100 OpenAI classes related to input items. We want the
// Foundry SDK to be free of those, therefore for the time being we define input item as a generic dictionary.
@@alternateType(OpenAI.InputItem, Record<unknown>);

// Note the doc string replacement below is for JavaScript only, because for Python we hand-write the
// relevant methods with proper doc strings (see `begin_update_memories` and `search_memories` methods)
@@clientDoc(
  MemoryStoreUpdateRequest.items,
  "A list of messages to store in memory, each one represented as an object with `role`, `content` and `type` keys. Similar to how OpenAI defines input items in Responses operations. Example of an item: {\"role\": \"user\", \"type\": \"message\", \"content\": \"my user message\"}. Only messages with `type` equals `message` are currently processed. Others are ignored.",
  DocumentationMode.replace,
  "javascript"
);
@@clientDoc(
  MemoryStoreSearchRequest.items,
  "A list of messages used to extract relevant memories, each one represented as an object with `role`, `content` and `type` keys. Similar to how OpenAI defines input items in Responses operations. Example of an item: {\"role\": \"user\", \"type\": \"message\", \"content\": \"my user message\"}. Only messages with `type` equals `message` are currently processed. Others are ignored.",
  DocumentationMode.replace,
  "javascript"
);

// The Python SDK will have custom code to handle LRO memory updates, and
// new input "items" specified via OpenAI classes.
@@access(MemoryStores.updateMemories, Access.internal, "python");
@@scope(MemoryStores.getUpdateResult, "!(python)");
@@usage(MemoryStoreUpdateCompletedResult, Usage.output);
@@access(MemoryStoreUpdateCompletedResult, Access.public);
@@usage(MemoryStoreUpdateResponse, Usage.output);
@@access(MemoryStoreUpdateResponse, Access.public);

// The Python SDK will have custom code to handle memory search, with
// new input "items" specified via OpenAI classes.
@@access(MemoryStores.searchMemories, Access.internal, "python");
@@access(MemoryStoreSearchResponse, Access.public, "python");

// Rename models ending with 'Object' to end with 'Details' for Python
@@clientName(MemoryStoreObject, "MemoryStoreDetails", "python");

// Remove 'Object' suffix for JS client
@@clientName(MemoryStoreObject, "MemoryStore", "javascript");

// --------------------------------------------------------------------------------
// Beta Routines sub-client
// --------------------------------------------------------------------------------

@@clientName(Routines.createOrUpdateRoutine, "createOrUpdate");
@@clientName(Routines.getRoutine, "get");
@@clientName(Routines.enableRoutine, "enable");
@@clientName(Routines.disableRoutine, "disable");
@@clientName(Routines.listRoutines, "list");
@@clientName(Routines.deleteRoutine, "delete");
@@clientName(Routines.listRoutineRuns, "listRuns");
@@clientName(Routines.dispatchRoutineAsync, "dispatch");
@@clientName(DispatchRoutineResponse, "DispatchRoutineResult", "python");

// --------------------------------------------------------------------------------
// Beta Evaluators sub‐client
// --------------------------------------------------------------------------------

// Need to explicitly mention both languages to avoid compile error
@@clientName(Evaluators.listLatestVersions, "list", "python, javascript");

// Evaluator pending upload
@@clientName(Evaluators.startPendingUpload, "pendingUpload");

// Evaluator generation jobs — renamed for SDK discoverability
@@clientName(EvaluatorGenerationJobs.create, "createGenerationJob");
@@clientName(EvaluatorGenerationJobs.get, "getGenerationJob");
@@clientName(EvaluatorGenerationJobs.list, "listGenerationJobs");
@@clientName(EvaluatorGenerationJobs.cancel, "cancelGenerationJob");
@@clientName(EvaluatorGenerationJobs.delete, "deleteGenerationJob");

// EvaluatorVersion datetime fields are typed as string in the spec but carry ISO-8601 timestamps
@@alternateType(EvaluatorVersion.created_at, utcDateTime, "python");
@@alternateType(EvaluatorVersion.modified_at, utcDateTime, "python");

// // EvaluationSuites versioned operations
// @@clientName(EvaluationSuites.listVersions, "list_evaluation_suite_versions");
// @@clientName(EvaluationSuites.listLatest, "list_evaluation_suites");
// @@clientName(EvaluationSuites.getVersion, "get_evaluation_suite");
// @@clientName(EvaluationSuites.deleteVersion, "delete_evaluation_suite");
// @@clientName(EvaluationSuites.createOrUpdateVersion, "create_or_update_evaluation_suite");
// @@clientName(EvaluationSuites.createEvaluationSuiteVersion, "create_evaluation_suite");
// @@clientName(EvaluationSuites.run, "run_evaluation_suite");

// @@clientName(EvaluationSuites.listVersions, "listEvaluationSuiteVersions", "javascript");
// @@clientName(EvaluationSuites.listLatest, "listEvaluationSuites", "javascript");
// @@clientName(EvaluationSuites.getVersion, "getEvaluationSuite", "javascript");
// @@clientName(EvaluationSuites.deleteVersion, "deleteEvaluationSuite", "javascript");
// @@clientName(EvaluationSuites.createOrUpdateVersion, "createOrUpdateEvaluationSuite", "javascript");
// @@clientName(EvaluationSuites.createEvaluationSuiteVersion, "createEvaluationSuite", "javascript");
// @@clientName(EvaluationSuites.run, "runEvaluationSuite", "javascript");

// // Evaluation Suite Generation Jobs — unscoped names (fixes AllScopes conflict)
// @@clientName(EvaluationSuiteGenerationJobs.create, "create_generation_suite_job");
// @@clientName(EvaluationSuiteGenerationJobs.get, "get_generation_suite_job");
// @@clientName(EvaluationSuiteGenerationJobs.list, "list_generation_suite_jobs");
// @@clientName(EvaluationSuiteGenerationJobs.cancel, "cancel_generation_suite_job");
// @@clientName(EvaluationSuiteGenerationJobs.delete, "delete_generation_suite_job");

// // Evaluation Suite Generation Jobs — renamed for JavaScript SDK discoverability
// @@clientName(EvaluationSuiteGenerationJobs.create, "createGenerationSuiteJob", "javascript");
// @@clientName(EvaluationSuiteGenerationJobs.get, "getGenerationSuiteJob", "javascript");
// @@clientName(EvaluationSuiteGenerationJobs.list, "listGenerationSuiteJobs", "javascript");
// @@clientName(EvaluationSuiteGenerationJobs.cancel, "cancelGenerationSuiteJob", "javascript");
// @@clientName(EvaluationSuiteGenerationJobs.delete, "deleteGenerationSuiteJob", "javascript");

// --------------------------------------------------------------------------------
// Beta Insights sub‐client
// --------------------------------------------------------------------------------
@@clientName(Azure.AI.Projects.Insight.id, "insight_id");
@@clientName(InsightsGetParams.id, "insight_id");

// --------------------------------------------------------------------------------
// Beta Models sub‐client
// --------------------------------------------------------------------------------

// Shorter method names for SDK models operations
@@clientName(Models.listLatest, "list");
@@clientName(Models.listVersions, "listVersions");
@@clientName(Models.getVersion, "get");
@@clientName(Models.deleteVersion, "delete");
@@clientName(Models.createOrUpdateVersion, "update");
@@clientName(Models.startPendingUpload, "pendingUpload");
@@clientName(Models.getCredentials, "getCredentials");
@@clientName(Models.createAsync, "pendingCreateVersion");

@@clientName(
  CreateModelVersionAsyncResponse,
  "ModelPendingCreateVersionResult",
  "python"
);
@@clientName(
  CreateModelVersionAsyncResponse,
  "ModelPendingCreateVersionResponse",
  "javascript"
);

// --------------------------------------------------------------------------------
// Beta Schedules sub‐client
// --------------------------------------------------------------------------------

@@clientName(SchedulesCreateOrUpdateParams.resource, "schedule");
@@clientName(Schedule.id, "schedule_id");

// Schedule trigger datetime fields are typed as string in the spec but carry ISO-8601 timestamps
@@alternateType(RecurrenceTrigger.startTime, utcDateTime, "python");
@@alternateType(RecurrenceTrigger.endTime, utcDateTime, "python");
@@alternateType(OneTimeTrigger.triggerAt, utcDateTime, "python");
@@alternateType(CronTrigger.startTime, utcDateTime, "python");
@@alternateType(CronTrigger.endTime, utcDateTime, "python");
@@alternateType(ScheduleRun.triggerTime, utcDateTime, "python");

// --------------------------------------------------------------------------------
// Beta Skills sub-client
// --------------------------------------------------------------------------------

@@clientName(Skills.createSkillVersion, "create");
@@clientName(Skills.createSkillVersionFromFiles, "create_from_files");
@@clientName(Skills.deleteSkill, "delete");
@@clientName(Skills.deleteSkillVersion, "delete_version");
@@clientName(Skills.getSkill, "get");
@@clientName(Skills.getSkillContent, "download");
@@clientName(Skills.getSkillVersion, "get_version");
@@clientName(Skills.getSkillVersionContent, "download_version");
@@clientName(Skills.listSkills, "list");
@@clientName(Skills.listSkillVersions, "list_versions");
@@clientName(Skills.updateSkill, "update");

@@clientName(Skill, "SkillDetails", "python");
@@clientName(DeleteSkillResponse, "DeleteSkillResult", "python");
@@clientName(DeleteSkillVersionResponse, "DeleteSkillVersionResult", "python");
@@clientName(DownloadSkillResponse, "DownloadSkillResult", "python");

// --------------------------------------------------------------------------------
// Beta Evaluation Taxonomies sub-client
// --------------------------------------------------------------------------------

// Note that we can't rename it in src\openai-evaluations\models.tsp, since in
// src\evaluations\models.tsp we already define EvaluationTarget (not for v1).
// If/when src\evaluations will be removed, consider doing the rename in
// src\openai-evaluations\models.tsp instead.
@@clientName(Target, "EvaluationTarget");

// --------------------------------------------------------------------------------
// To support custom client-side handling of "opt-in" to preview features.
// --------------------------------------------------------------------------------

// Remove foundry_features input arguments from public methods, as they are set internally.
@@scope(WithConditionalFoundryPreviewHeader.foundry_features, "!python");
@@scope(WithRequiredFoundryPreviewHeader.foundry_features, "!python");

// Force emitting these two, as patched code uses values from these enums to internally set Foundry-Features header.
@@usage(AgentDefinitionOptInKeys, Usage.input, "python");
@@access(AgentDefinitionOptInKeys, Access.internal, "python");
@@clientName(AgentDefinitionOptInKeys, "_AgentDefinitionOptInKeys", "python");
@@usage(FoundryFeaturesOptInKeys, Usage.input, "python");
@@access(FoundryFeaturesOptInKeys, Access.internal, "python");
@@clientName(FoundryFeaturesOptInKeys, "_FoundryFeaturesOptInKeys", "python");

// Add optional boolean "allow_preview" client initialization parameter
// See: https://azure.github.io/typespec-azure/docs/howtos/generate-client-libraries/03client/#adding-client-initialization-parameters
model AIProjectClientOptions {
  @doc("Whether to enable preview features. Must be specified and set to True to enable preview features.")
  allow_preview?: boolean;
}

@@clientInitialization(
  Azure.AI.Projects,
  {
    parameters: AIProjectClientOptions,
  },
  "python"
);
