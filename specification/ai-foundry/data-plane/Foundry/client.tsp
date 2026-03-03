//
// This file is used for emitting the Python client (package azure-ai-projects) and
// the JS client (package @azure/ai-projects).
//

// Stable operations (GA routes) with preview features (optional opt-in request headers)
import "./src/agents/routes.tsp";
import "./src/evaluation-rules/routes.tsp";

// Stable operation (GA routes) without preview features
import "./src/connections/routes.tsp";
import "./src/datasets/routes.tsp";
import "./src/deployments/routes.tsp";
import "./src/indexes/routes.tsp";

// Beta operations (preview routes, requiring opt-in request header)
import "./src/evaluation-taxonomies/routes.tsp";
import "./src/evaluators/routes.tsp";
import "./src/insights/routes.tsp";
import "./src/memory-stores/routes.tsp";
import "./src/red-teams/routes.tsp";
import "./src/schedules/routes.tsp";

// Create a ".beta" subclient for the above beta operations
import "./relocate-beta-operations.tsp";

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

// --------------------------------------------------------------------------------
// Agents sub‐client
// --------------------------------------------------------------------------------

// Use short form method names
@@clientName(Agents.getAgent, "get");
@@clientName(Agents.deleteAgent, "delete");
@@clientName(Agents.listAgents, "list");
@@clientName(Agents.createAgentVersion, "create_version", "python");
@@clientName(Agents.getAgentVersion, "get_version", "python");
@@clientName(Agents.deleteAgentVersion, "delete_version", "python");
@@clientName(Agents.listAgentVersions, "list_versions", "python");
@@clientName(Agents.createAgentVersionFromManifest,
  "create_version_from_manifest",
  "python"
);
@@clientName(Agents.createAgentVersion, "createVersion", "javascript");
@@clientName(Agents.getAgentVersion, "getVersion", "javascript");
@@clientName(Agents.deleteAgentVersion, "deleteVersion", "javascript");
@@clientName(Agents.listAgentVersions, "listVersions", "javascript");

// Suppress these operations from Python and JavaScript SDK public surface.
@@access(Agents.createAgent, Access.internal);
@@access(Agents.updateAgent, Access.internal);
@@access(Agents.createAgentFromManifest, Access.internal);
@@access(Agents.updateAgentFromManifest, Access.internal);

// Rename models ending with 'Object' to end with 'Details' for Python
@@clientName(AgentObject, "AgentDetails", "python");
@@clientName(AgentVersionObject, "AgentVersionDetails", "python");

@@clientName(AgentObject, "Agent", "javascript");
@@clientName(AgentVersionObject, "AgentVersion", "javascript");

// Python emitter creates enum A2_A_PREVIEW = "a2a_preview". Override it here to "A2A_PREVIEW".
@@clientName(_PreviewAgentToolType.a2a_preview, "A2A_PREVIEW", "python");

// Python emitter creates enum values ENUM_1_G = "1g", ENUM_4_G = "4g" etc. Override it here as below.
@@clientName(OpenAI.ContainerMemoryLimit.`1g`, "MEMORY_1GB", "python");
@@clientName(OpenAI.ContainerMemoryLimit.`4g`, "MEMORY_4GB", "python");
@@clientName(OpenAI.ContainerMemoryLimit.`16g`, "MEMORY_16GB", "python");
@@clientName(OpenAI.ContainerMemoryLimit.`64g`, "MEMORY_64GB", "python");

// --------------------------------------------------------------------------------
// Memories sub-client
// --------------------------------------------------------------------------------

@@clientName(MemoryStores.createMemoryStore, "create");
@@clientName(MemoryStores.updateMemoryStore, "update");
@@clientName(MemoryStores.getMemoryStore, "get");
@@clientName(MemoryStores.listMemoryStores, "list");
@@clientName(MemoryStores.deleteMemoryStore, "delete");
@@clientName(MemoryStoreSearchResponse, "MemoryStoreSearchResult", "python");
@@clientName(DeleteMemoryStoreResponse, "DeleteMemoryStoreResult", "python");
@@clientName(MemoryStoreUpdateResponse, "MemoryStoreUpdateResult", "python");
@@clientName(MemoryStoreDeleteScopeResponse,
  "MemoryStoreDeleteScopeResult",
  "python"
);

// For Python and JS, Memory Stores update and search operations are the only Foundry operations that
// define OpenAI.InputItem as inputs. This pulls in ~100 OpenAI classes related to input items. We want the
// Foundry SDK to be free of those, therefore for the time being we define input item as a generic dictionary.
@@alternateType(OpenAI.InputItem, Record<unknown>);
@@clientDoc(MemoryStoreUpdateRequest.items,
  "A list of messages to store in memory, each one represented as an object with `role`, `content` and `type` keys. Similar to how OpenAI defines input items in Responses operations. Example of an item: {\"role\": \"user\", \"type\": \"message\", \"content\": \"my user message\"}. Only messages with `type` equals `message` are currently processed. Others are ignored.",
  DocumentationMode.replace,
  "javascript"
);
@@clientDoc(MemoryStoreSearchRequest.items,
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
// Responses sub‐client
// --------------------------------------------------------------------------------

// Allow assigning a `dict[str, Any]` object directly to the "schema" property of TextResponseFormatJsonSchema
@@alternateType(OpenAI.ResponseFormatJsonSchemaSchema, Record<unknown>);

// Note there is also OpenAI.TextResponseFormatJsonSchema (which extends OpenAI.TextResponseFormatConfiguration). It already has a good name.
@@clientName(OpenAI.TextResponseFormatConfiguration, "TextResponseFormat");
@@clientName(OpenAI.TextResponseFormatConfigurationResponseFormatText,
  "TextResponseFormatText"
);
@@clientName(OpenAI.TextResponseFormatConfigurationResponseFormatJsonObject,
  "TextResponseFormatJsonObject"
);

// --------------------------------------------------------------------------------
// Evaluators sub‐client
// --------------------------------------------------------------------------------
@@clientName(Evaluators.listLatestVersions, "list");
@@clientName(Evaluators.startPendingUpload, "pendingUpload");

// --------------------------------------------------------------------------------
// Insights sub‐client
// --------------------------------------------------------------------------------
@@clientName(Azure.AI.Projects.Insight.id, "insight_id");

// --------------------------------------------------------------------------------
// Datasets sub‐client
// --------------------------------------------------------------------------------

// Shorter method names for SDK datasets operations
@@clientName(Datasets.listLatest, "list");
@@clientName(Datasets.getVersion, "get");
@@clientName(Datasets.deleteVersion, "delete");
@@clientName(Datasets.createOrUpdateVersion, "createOrUpdate");
@@clientName(Datasets.startPendingUploadVersion, "pendingUpload");

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
// Schedules sub‐client
// --------------------------------------------------------------------------------

@@clientName(SchedulesCreateOrUpdateParams.resource, "schedule");
@@clientName(Schedule.id, "schedule_id");

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
// To support custom client-side handling of "opt-in" to preview features. 
// --------------------------------------------------------------------------------

// Remove preview opt-in union types from the public PythonSDK surface.
//
// TODO: These do not work. Follow up with the Python emitter team.
// What does work: Adding @scope("!python") to `CreateAgentVersionRequest` above any of the 
// proprties there. But it does not seem to work I add @scope("!python") above `foundry_features`?
// in alias WithConditionalFoundryPreviewHeader.
//
//@@access(AgentDefinitionOptInKeys, Access.internal, "python");
//@@access(FoundryFeaturesOptInKeys, Access.internal, "python");
//@@scope(WithConditionalFoundryPreviewHeader.foundry_features, "!python");
//@@scope(WithRequiredFoundryPreviewHeader.foundry_features, "!python");

// Add optional boolean "allow_preview" client initialization parameter
// See: https://azure.github.io/typespec-azure/docs/howtos/generate-client-libraries/03client/#adding-client-initialization-parameters
model AIProjectClientOptions {
  @doc("Whether to enable preview features. Must be specified and set to True to enable preview features.")
  allow_preview?: boolean;
}

@@clientInitialization(Azure.AI.Projects, {parameters: AIProjectClientOptions}, "python");

// --------------------------------------------------------------------------------
// Other
// --------------------------------------------------------------------------------

// Rename OpenAI.Error to avoid conflict with Azure.Core.Foundations.Error.
// OpenAI.Error is the object type of the `error` properties in `ApiErrorResponse`
// and `MemoryStoreUpdateResponse`.
@@clientName(OpenAI.Error, "ApiError");
