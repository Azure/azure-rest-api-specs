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
@@scope(FoundryOpenAIEvals.listEvals, "!(csharp, python, java, javascript)");
@@scope(FoundryOpenAIEvals.createEval, "!(csharp, python, java, javascript)");
@@scope(FoundryOpenAIEvals.deleteEval, "!(csharp, python, java, javascript)");
@@scope(FoundryOpenAIEvals.getEval, "!(csharp, python, java, javascript)");
@@scope(FoundryOpenAIEvals.updateEval, "!(csharp, python, java, javascript)");
@@scope(FoundryOpenAIEvals.listRuns, "!(csharp, python, java, javascript)");
@@scope(FoundryOpenAIEvals.createEvalRun,
  "!(csharp, python, java, javascript)"
);
@@scope(FoundryOpenAIEvals.deleteEvalRun,
  "!(csharp, python, java, javascript)"
);
@@scope(FoundryOpenAIEvals.getEvalRun, "!(csharp, python, java, javascript)");
@@scope(FoundryOpenAIEvals.cancelEvalRun,
  "!(csharp, python, java, javascript)"
);
@@scope(FoundryOpenAIEvals.getEvalRunOutputItems,
  "!(csharp, python, java, javascript)"
);
@@scope(FoundryOpenAIEvals.getEvalRunOutputItem,
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

// --------------------------------------------------------------------------------
// Agents sub‐client
// --------------------------------------------------------------------------------

// Use short form method names, and use 'retrieve' instead of 'get' to match OpenAI patterns
@@clientName(Agents.getAgent, "retrieve", "python");
@@clientName(Agents.createAgent, "create", "python");
@@clientName(Agents.updateAgent, "update", "python");
@@clientName(Agents.deleteAgent, "delete", "python");
@@clientName(Agents.listAgents, "list", "python");
@@clientName(Agents.createAgentVersion, "create_version", "python");
@@clientName(Agents.getAgentVersion, "retrieve_version", "python");
@@clientName(Agents.deleteAgentVersion, "delete_version", "python");
@@clientName(Agents.listAgentVersions, "list_versions", "python");
@@clientName(Agents.startAgentContainer, "start_container", "python");
@@clientName(Agents.updateAgentContainer, "update_container", "python");
@@clientName(Agents.stopAgentContainer, "stop_container", "python");
@@clientName(Agents.deleteAgentContainer, "delete_container", "python");
@@clientName(Agents.getAgentContainer, "retrieve_container", "python");
@@clientName(Agents.getAgentContainerOperation,
  "retrieve_container_operation",
  "python"
);
@@clientName(Agents.listAgentContainerOperations,
  "list_container_operations",
  "python"
);
@@clientName(Agents.listAgentVersionContainerOperations,
  "list_version_container_operations",
  "python"
);

// --------------------------------------------------------------------------------
// Conversations sub‐client
// --------------------------------------------------------------------------------
@@clientName(OpenAI.ConversationResource, "AgentConversation", "csharp");

// --------------------------------------------------------------------------------
// Responses sub‐client
// --------------------------------------------------------------------------------

// Follow JS naming conventions
@@clientName(OpenAI.CreateResponse, "CreateResponseRequest", "javascript");

// --------------------------------------------------------------------------------
// Tools
// --------------------------------------------------------------------------------

// --------------------------------------------------------------------------------
// Usage / Public accessibility overrides
// --------------------------------------------------------------------------------

@@usage(OpenAI.ItemResource, Usage.json);
@@usage(OpenAI.ResponseStreamEvent, Usage.json);

@@usage(AgentId, Usage.output);
@@access(AgentId, Access.public);

@@usage(AgentReference, Usage.input);
@@access(AgentReference, Access.public);

@@usage(ApiError, Usage.output);
@@access(ApiError, Access.public);

@@usage(ApiErrorResponse, Usage.output);
@@access(ApiErrorResponse, Access.public);

// --------------------------------------------------------------------------------
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
