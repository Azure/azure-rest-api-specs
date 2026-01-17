import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "./src/common/service.tsp";

import "./src/connections/routes.tsp";
import "./src/datasets/routes.tsp";
import "./src/indexes/routes.tsp";
import "./src/deployments/routes.tsp";
import "./src/red-teams/routes.tsp";
import "./src/evaluationrules/routes.tsp";
import "./src/evaluation_taxonomies/routes.tsp";
import "./src/evaluators/routes.tsp";
import "./src/insights/routes.tsp";
import "./src/schedules/routes.tsp";
import "./src/agents/routes.tsp";
import "./src/memory_stores/routes.tsp";

import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
namespace Azure.AI.Projects;

// --------------------------------------------------------------------------------
// Fix the xref.
// --------------------------------------------------------------------------------
@@clientNamespace(OpenAI, "Azure.AI.Projects", "csharp");

// --------------------------------------------------------------------------------
// Root client
// --------------------------------------------------------------------------------
@@clientName(Azure.AI.Projects, "AIProjectClient");

@@usage(CreateAgentRequest, Usage.input);
@@access(CreateAgentRequest, Access.internal);

@@usage(CreateAgentVersionFromManifestRequest, Usage.input);
@@access(CreateAgentVersionFromManifestRequest, Access.public);

@@usage(UpdateAgentRequest, Usage.input);
@@access(UpdateAgentRequest, Access.internal);

@@usage(CreateAgentVersionRequest, Usage.input);
@@access(CreateAgentVersionRequest, Access.public);
@@clientName(CreateAgentVersionRequest, "AgentVersionCreationOptions");

@@usage(MemoryStoreUpdateCompletedResult, Usage.output);
@@access(MemoryStoreUpdateCompletedResult, Access.public);
@@clientName(MemoryStoreUpdateCompletedResult, "MemoryUpdateResultDetails");

@@clientName(MemorySearchOptions, "MemorySearchResultOptions");

@@scope(Agents.startAgentContainer, "!csharp");
@@scope(Agents.stopAgentContainer, "!csharp");
@@scope(Agents.updateAgentContainer, "!csharp");
@@scope(Agents.deleteAgentContainer, "!csharp");
@@scope(Agents.getAgentContainer, "!csharp");
@@scope(Agents.getAgentContainerOperation, "!csharp");
@@scope(Agents.listAgentContainerOperations, "!csharp");
@@scope(Agents.listAgentVersionContainerOperations, "!csharp");
@@scope(Agents.getAgentContainerOperation, "!csharp");

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
@@clientName(Agents, "AIProjectAgentsOperations", "csharp");

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

// Evaluators
@@access(EvaluatorDefinitionType, Access.public);
