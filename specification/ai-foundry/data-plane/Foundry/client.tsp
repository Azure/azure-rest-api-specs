import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

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

// ------------------------------------------------------------------------------------------------
// Operation scope customizations - don't generate Responses. We will use OpenAI client for those
// ------------------------------------------------------------------------------------------------
@@scope(Responses.createResponse, "!(csharp, python, java, javascript)");
@@scope(Responses.createResponseStream, "!(csharp, python, java, javascript)");
@@scope(Responses.getResponseStream, "!(csharp, python, java, javascript)");
@@scope(Responses.getResponse, "!(csharp, python, java, javascript)");
@@scope(Responses.deleteResponse, "!(csharp, python, java, javascript)");
@@scope(Responses.cancelResponse, "!(csharp, python, java, javascript)");
@@scope(Responses.listInputItems, "!(csharp, python, java, javascript)");
@@scope(Responses.listResponses, "!(csharp, python, java, javascript)");

// ---------------------------------------------------------------------------------------------------
// Operation scope customizations - don't generate Conversations. We will use OpenAI client for those
// ---------------------------------------------------------------------------------------------------
@@scope(Conversations.createConversation, "!(python, java, javascript)");
@@scope(Conversations.updateConversation, "!(python, java, javascript)");
@@scope(Conversations.getConversation, "!(python, java, javascript)");
@@scope(Conversations.deleteConversation, "!(python, java, javascript)");
@@scope(Conversations.listConversations, "!(python, java, javascript)");
@@scope(Conversations.createConversationItems, "!(python, java, javascript)");
@@scope(Conversations.getConversationItem, "!(python, java, javascript)");
@@scope(Conversations.deleteConversationItem, "!(python, java, javascript)");
@@scope(Conversations.listConversationItems, "!(python, java, javascript)");

// ---------------------------------------------------------------------------------------------------
// Operation scope customizations - don't generate Evaluations. We will use OpenAI client for those
// ---------------------------------------------------------------------------------------------------
@@scope(OpenAIEvals.listEvals, "!(csharp, python, java, javascript)");
@@scope(OpenAIEvals.createEval, "!(csharp, python, java, javascript)");
@@scope(OpenAIEvals.deleteEval, "!(csharp, python, java, javascript)");
@@scope(OpenAIEvals.getEval, "!(csharp, python, java, javascript)");
@@scope(OpenAIEvals.updateEval, "!(csharp, python, java, javascript)");
@@scope(OpenAIEvals.listRuns, "!(csharp, python, java, javascript)");
@@scope(OpenAIEvals.createEvalRun, "!(csharp, python, java, javascript)");
@@scope(OpenAIEvals.deleteEvalRun, "!(csharp, python, java, javascript)");
@@scope(OpenAIEvals.getEvalRun, "!(csharp, python, java, javascript)");
@@scope(OpenAIEvals.cancelEvalRun, "!(csharp, python, java, javascript)");
@@scope(OpenAIEvals.getEvalRunOutputItems,
  "!(csharp, python, java, javascript)"
);
@@scope(OpenAIEvals.getEvalRunOutputItem,
  "!(csharp, python, java, javascript)"
);

// ---------------------------------------------------------------------------------------------------
// Operation scope customizations - don't generate fine-tuning. We will use OpenAI client for those
// ---------------------------------------------------------------------------------------------------
@@scope(FineTuning.createFineTuningJob, "!(csharp, python, java, javascript)");
@@scope(FineTuning.listPaginatedFineTuningJobs,
  "!(csharp, python, java, javascript)"
);
@@scope(FineTuning.cancelFineTuningJob, "!(csharp, python, java, javascript)");
@@scope(FineTuning.listFineTuningJobCheckpoints,
  "!(csharp, python, java, javascript)"
);
@@scope(FineTuning.retrieveFineTuningJob,
  "!(csharp, python, java, javascript)"
);
@@scope(FineTuning.pauseFineTuningJob, "!(csharp, python, java, javascript)");
@@scope(FineTuning.resumeFineTuningJob, "!(csharp, python, java, javascript)");
@@scope(FineTuning.listFineTuningJobEvents,
  "!(csharp, python, java, javascript)"
);

// ---------------------------------------------------------------------------------------------------
// Operation scope customizations - don't generate container operations *except* for backend C#
// ---------------------------------------------------------------------------------------------------
@@scope(Agents.startAgentContainer, "csharp");
@@scope(Agents.stopAgentContainer, "csharp");
@@scope(Agents.updateAgentContainer, "csharp");
@@scope(Agents.deleteAgentContainer, "csharp");
@@scope(Agents.getAgentContainer, "csharp");
@@scope(Agents.getAgentContainerOperation, "csharp");
@@scope(Agents.listAgentContainerOperations, "csharp");
@@scope(Agents.listAgentVersionContainerOperations, "csharp");
@@scope(Agents.getAgentContainerOperation, "csharp");

// --------------------------------------------------------------------------------
// Agents sub‐client
// --------------------------------------------------------------------------------

// Use short form method names
@@clientName(Agents.getAgent, "get", "python");
@@clientName(Agents.createAgent, "create", "python");
@@clientName(Agents.updateAgent, "update", "python");
@@clientName(Agents.deleteAgent, "delete", "python");
@@clientName(Agents.listAgents, "list", "python");
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

// Rename models ending with 'Object' to end with 'Details' for Python
@@clientName(AgentObject, "AgentDetails", "python");
@@clientName(AgentVersionObject, "AgentVersionDetails", "python");
@@clientName(AgentContainerObject, "AgentContainerDetails", "python");
@@clientName(AgentContainerOperationObject,
  "AgentContainerOperationDetails",
  "python"
);

// --------------------------------------------------------------------------------
// Memories sub‐client
// --------------------------------------------------------------------------------
@@clientName(MemoryStores.createMemoryStore, "create", "python");
@@clientName(MemoryStores.updateMemoryStore, "update", "python");
@@clientName(MemoryStores.getMemoryStore, "get", "python");
@@clientName(MemoryStores.listMemoryStores, "list", "python");
@@clientName(MemoryStores.deleteMemoryStore, "delete", "python");

@@clientName(MemoryStoreSearchResponse, "MemoryStoreSearchResult", "python");
@@clientName(DeleteMemoryStoreResponse, "DeleteMemoryStoreResult", "python");
@@clientName(MemoryStoreUpdateResponse, "MemoryStoreUpdateResult", "python");
@@clientName(MemoryStoreDeleteScopeResponse,
  "MemoryStoreDeleteScopeResult",
  "python"
);

// The SDK will have custom code to handle LRO memory updates.
@@access(MemoryStores.updateMemories, Access.internal, "python");
@@scope(MemoryStores.getUpdateResult, "!(python)");

// Hand written code still needs the below classes. Make sure they are emitted.
@@usage(MemoryStoreUpdateCompletedResult, Usage.output);
@@access(MemoryStoreUpdateCompletedResult, Access.public);
@@usage(MemoryStoreUpdateResponse, Usage.output);
@@access(MemoryStoreUpdateResponse, Access.public);

// Rename models ending with 'Object' to end with 'Details' for Python
@@clientName(MemoryStoreObject, "MemoryStoreDetails", "python");

// --------------------------------------------------------------------------------
// Conversations sub‐client
// --------------------------------------------------------------------------------
@@clientName(OpenAI.ConversationResource, "AgentConversation", "csharp");

// --------------------------------------------------------------------------------
// Responses sub‐client
// --------------------------------------------------------------------------------

// Follow JS naming conventions
@@clientName(OpenAI.CreateResponse, "CreateResponseRequest", "javascript");

// Allow assigning a `dict[str, Any]` object directly to the "schema" property of TextResponseFormatJsonSchema
@@alternateType(OpenAI.ResponseFormatJsonSchemaSchema,
  Record<unknown>,
  "python, javascript"
);

// --------------------------------------------------------------------------------
// Usage / Public accessibility overrides
// --------------------------------------------------------------------------------

@@usage(OpenAI.ItemResource, Usage.json);
@@usage(OpenAI.CreateResponseStreamingResponse, Usage.json);

@@usage(AgentId, Usage.output);
@@access(AgentId, Access.public);

@@usage(AgentReference, Usage.input);
@@access(AgentReference, Access.public);

@@usage(ApiError, Usage.output);
@@access(ApiError, Access.public);

@@usage(ApiErrorResponse, Usage.output);
@@access(ApiErrorResponse, Access.public);

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

// --------------------------------------------------------------------------------
// Indexes sub‐client
// --------------------------------------------------------------------------------

// Shorter method names for SDK Index operations
@@clientName(Indexes.listLatest, "list");
@@clientName(Indexes.getVersion, "get");
@@clientName(Indexes.deleteVersion, "delete");
@@clientName(Indexes.createOrUpdateVersion, "createOrUpdate");

// Less generic names
@@clientName(Sku, "ModelDeploymentSku");
@@clientName(SasCredential, "BlobReferenceSasCredential"); // Not to be confused with class "SASCredentials"

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
