//
// This file is used for emitting the Python client (package azure-ai-projects) and 
// the JS client (package @azure/ai-projects).
//
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
@@scope(Responses.createResponse, "!(python, javascript)");
@@scope(Responses.createResponseStream, "!(python, javascript)");
@@scope(Responses.getResponseStream, "!(python, javascript)");
@@scope(Responses.getResponse, "!(python, javascript)");
@@scope(Responses.deleteResponse, "!(python, javascript)");
@@scope(Responses.cancelResponse, "!(python, javascript)");
@@scope(Responses.listInputItems, "!(python, javascript)");
@@scope(Responses.listResponses, "!(python, javascript)");

// ---------------------------------------------------------------------------------------------------
// Operation scope customizations - don't generate Conversations. We will use OpenAI client for those
// ---------------------------------------------------------------------------------------------------
@@scope(Conversations.createConversation, "!(python, javascript)");
@@scope(Conversations.updateConversation, "!(python, javascript)");
@@scope(Conversations.getConversation, "!(python, javascript)");
@@scope(Conversations.deleteConversation, "!(python, javascript)");
@@scope(Conversations.listConversations, "!(python, javascript)");
@@scope(Conversations.createConversationItems, "!(python, javascript)");
@@scope(Conversations.getConversationItem, "!(python, javascript)");
@@scope(Conversations.deleteConversationItem, "!(python, javascript)");
@@scope(Conversations.listConversationItems, "!(python, javascript)");

// ---------------------------------------------------------------------------------------------------
// Operation scope customizations - don't generate Evaluations. We will use OpenAI client for those
// ---------------------------------------------------------------------------------------------------
@@scope(OpenAIEvals.listEvals, "!(python, javascript)");
@@scope(OpenAIEvals.createEval, "!(python, javascript)");
@@scope(OpenAIEvals.deleteEval, "!(python, javascript)");
@@scope(OpenAIEvals.getEval, "!(python, javascript)");
@@scope(OpenAIEvals.updateEval, "!(python, javascript)");
@@scope(OpenAIEvals.listRuns, "!(python, javascript)");
@@scope(OpenAIEvals.createEvalRun, "!(python, javascript)");
@@scope(OpenAIEvals.deleteEvalRun, "!(python, javascript)");
@@scope(OpenAIEvals.getEvalRun, "!(python, javascript)");
@@scope(OpenAIEvals.cancelEvalRun, "!(python, javascript)");
@@scope(OpenAIEvals.getEvalRunOutputItems, "!(python, javascript)");
@@scope(OpenAIEvals.getEvalRunOutputItem, "!(python, javascript)"
);

// ---------------------------------------------------------------------------------------------------
// Operation scope customizations - don't generate fine-tuning. We will use OpenAI client for those
// ---------------------------------------------------------------------------------------------------
@@scope(FineTuning.createFineTuningJob, "!(python, javascript)");
@@scope(FineTuning.listPaginatedFineTuningJobs, "!(python, javascript)");
@@scope(FineTuning.cancelFineTuningJob, "!(python, javascript)");
@@scope(FineTuning.listFineTuningJobCheckpoints, "!(python, javascript)");
@@scope(FineTuning.retrieveFineTuningJob, "!(python, javascript)");
@@scope(FineTuning.pauseFineTuningJob, "!(python, javascript)");
@@scope(FineTuning.resumeFineTuningJob, "!(python, javascript)");
@@scope(FineTuning.listFineTuningJobEvents, "!(python, javascript)");

// ---------------------------------------------------------------------------------------------------
// Operation scope customizations - don't generate container operations *except* for backend C#
// ---------------------------------------------------------------------------------------------------
@@scope(Agents.startAgentContainer, "!(python, javascript)");
@@scope(Agents.stopAgentContainer, "!(python, javascript)");
@@scope(Agents.updateAgentContainer, "!(python, javascript)");
@@scope(Agents.deleteAgentContainer, "!(python, javascript)");
@@scope(Agents.getAgentContainer, "!(python, javascript)");
@@scope(Agents.getAgentContainerOperation, "!(python, javascript)");
@@scope(Agents.listAgentContainerOperations, "!(python, javascript)");
@@scope(Agents.listAgentVersionContainerOperations, "!(python, javascript)");
@@scope(Agents.getAgentContainerOperation, "!(python, javascript)");

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
// Memories sub-client
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

@@clientName(Azure.Core.Foundations.ResourceBody.resource, "schedule");

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
