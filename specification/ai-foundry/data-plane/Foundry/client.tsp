//
// This file is used for emitting the Python client (package azure-ai-projects) and
// the JS client (package @azure/ai-projects).
//

// Stable operations (GA routes)
import "./src/agents/routes.tsp";
import "./src/common/custom-types.tsp";
import "./src/common/service.tsp";
import "./src/connections/routes.tsp";
import "./src/datasets/routes.tsp";
import "./src/deployments/routes.tsp";
import "./src/indexes/routes.tsp";

// Beta operations (preview routes, requiring opt-in HTTP request header)
import "./src/evaluation-taxonomies/routes.tsp";
import "./src/evaluation-rules/routes.tsp";
import "./src/evaluators/routes.tsp";
import "./src/insights/routes.tsp";
import "./src/memory-stores/routes.tsp";
import "./src/red-teams/routes.tsp";
import "./src/schedules/routes.tsp";
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
@@clientName(Agents.createAgent, "create");
@@clientName(Agents.updateAgent, "update");
@@clientName(Agents.deleteAgent, "delete");
@@clientName(Agents.listAgents, "list");
@@clientName(Agents.createAgentVersion, "create_version", "python");
@@clientName(Agents.getAgentVersion, "get_version", "python");
@@clientName(Agents.deleteAgentVersion, "delete_version", "python");
@@clientName(Agents.listAgentVersions, "list_versions", "python");
@@clientName(Agents.createAgentFromManifest, "create_from_manifest", "python");
@@clientName(Agents.createAgentVersionFromManifest,
  "create_version_from_manifest",
  "python"
);
@@clientName(Agents.updateAgentFromManifest, "update_from_manifest", "python");

@@clientName(Agents.createAgentVersion, "createVersion", "javascript");
@@clientName(Agents.getAgentVersion, "getVersion", "javascript");
@@clientName(Agents.deleteAgentVersion, "deleteVersion", "javascript");
@@clientName(Agents.listAgentVersions, "listVersions", "javascript");

// Rename models ending with 'Object' to end with 'Details' for Python
@@clientName(AgentObject, "AgentDetails", "python");
@@clientName(AgentVersionObject, "AgentVersionDetails", "python");

@@clientName(AgentObject, "Agent", "javascript");
@@clientName(AgentVersionObject, "AgentVersion", "javascript");

// --------------------------------------------------------------------------------
// Memories sub-client
// --------------------------------------------------------------------------------
@@clientName(MemoryStores.createMemoryStore, "create");
@@clientName(MemoryStores.updateMemoryStore, "update");
@@clientName(MemoryStores.getMemoryStore, "get");
@@clientName(MemoryStores.listMemoryStores, "list");
@@clientName(MemoryStores.deleteMemoryStore, "delete");

// The SDK will have custom code to handle LRO memory updates.
@@access(MemoryStores.updateMemories, Access.internal, "python");
@@scope(MemoryStores.getUpdateResult, "!(python)");

@@clientName(MemoryStoreSearchResponse, "MemoryStoreSearchResult", "python");
@@clientName(DeleteMemoryStoreResponse, "DeleteMemoryStoreResult", "python");
@@clientName(MemoryStoreUpdateResponse, "MemoryStoreUpdateResult", "python");
@@clientName(MemoryStoreDeleteScopeResponse,
  "MemoryStoreDeleteScopeResult",
  "python"
);

// Hand written code still needs the below classes. Make sure they are emitted.
@@usage(MemoryStoreUpdateCompletedResult, Usage.output);
@@access(MemoryStoreUpdateCompletedResult, Access.public);
@@usage(MemoryStoreUpdateResponse, Usage.output);
@@access(MemoryStoreUpdateResponse, Access.public);

// Rename models ending with 'Object' to end with 'Details' for Python
@@clientName(MemoryStoreObject, "MemoryStoreDetails", "python");

@@clientName(MemoryStoreObject, "MemoryStore", "javascript");

// --------------------------------------------------------------------------------
// Responses sub‐client
// --------------------------------------------------------------------------------

// Allow assigning a `dict[str, Any]` object directly to the "schema" property of TextResponseFormatJsonSchema
@@alternateType(OpenAI.ResponseFormatJsonSchemaSchema, Record<unknown>);

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
