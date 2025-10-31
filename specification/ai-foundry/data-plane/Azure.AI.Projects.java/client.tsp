import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
namespace Azure.AI.Projects;

// --------------------------------------------------------------------------------
// Root client
// --------------------------------------------------------------------------------
// @@clientName(Azure.AI.Projects, "AIProjectClient");

// --------------------------------------------------------------------------------
// Usage / Public accessibility overrides
// --------------------------------------------------------------------------------

// --------------------------------------------------------------------------------
// Shorter method names for SDK datasets operations
// @@clientName(Datasets.listLatest, "list");
// @@clientName(Datasets.getVersion, "get");
// @@clientName(Datasets.deleteVersion, "delete");
// @@clientName(Datasets.createOrUpdateVersion, "createOrUpdate");
// @@clientName(Datasets.startPendingUploadVersion, "pendingUpload");

// // Shorter method names for SDK Index operations
// @@clientName(Indexes.listLatest, "list");
// @@clientName(Indexes.getVersion, "get");
// @@clientName(Indexes.deleteVersion, "delete");
// @@clientName(Indexes.createOrUpdateVersion, "createOrUpdate");

// // Less generic names
// @@clientName(Sku, "ModelDeploymentSku");
// @@clientName(SasCredential, "BlobReferenceSasCredential"); // Not to be confused with class "SASCredentials"

// // More accurate naming
// @@clientName(AssetCredentialResponse, "DatasetCredential");

// // Less generic names for C# SDK (avoid one-word class names)
// @@clientName(BlobReference, "AIProjectBlobReference", "csharp");
// @@clientName(Connection, "AIProjectConnection", "csharp");
// @@clientName(Deployment, "AIProjectDeployment", "csharp");
// @@clientName(DeploymentType, "AIProjectDeploymentType", "csharp");
// @@clientName(FieldMapping, "AIProjectIndexFieldMapping", "csharp");
// @@clientName(Index, "AIProjectIndex", "csharp");
// @@clientName(CosmosDBIndex, "AIProjectCosmosDBIndex", "csharp");
// @@clientName(BaseCredentials, "AIProjectConnectionBaseCredential", "csharp");
// @@clientName(ApiKeyCredentials,
//   "AIProjectConnectionApiKeyCredential",
//   "csharp"
// );
// @@clientName(CustomCredential, "AIProjectConnectionCustomCredential", "csharp");
// @@clientName(EntraIDCredentials,
//   "AIProjectConnectionEntraIdCredential",
//   "csharp"
// );
// @@clientName(SASCredentials, "AIProjectConnectionSasCredential", "csharp");
// @@clientName(DatasetVersion, "AIProjectDataset", "csharp");
// @@clientName(FileDatasetVersion, "FileDataset", "csharp");
// @@clientName(FolderDatasetVersion, "FolderDataset", "csharp");

// // Do not use terms "request" or "response" in C# class names as these are REST API terms
// @@clientName(PendingUploadRequest, "PendingUploadConfiguration", "csharp");
// @@clientName(PendingUploadResponse, "PendingUploadResult", "csharp");

// // Less generic names for C# subclients
// @@clientName(Connections, "AIProjectConnectionsOperations", "csharp");
// @@clientName(Datasets, "AIProjectDatasetsOperations", "csharp");
// @@clientName(Deployments, "AIProjectDeploymentsOperations", "csharp");
// @@clientName(Indexes, "AIProjectIndexesOperations", "csharp");

// // Need to explicitly make all get and list methods include the object name for C#
// @@clientName(Connections.get, "getConnection", "csharp");
// @@clientName(Connections.getWithCredentials,
//   "getConnectionWithCredentials",
//   "csharp"
// );
// @@clientName(Connections.list, "listConnections", "csharp");
// @@clientName(Datasets.getVersion, "getDataset", "csharp");
// @@clientName(Datasets.listLatest, "listDatasets", "csharp");
// @@clientName(Datasets.listVersions, "listDatasetVersions", "csharp");
// @@clientName(Deployments.get, "getDeployment", "csharp");
// @@clientName(Deployments.list, "listDeployments", "csharp");
// @@clientName(Indexes.getVersion, "getIndex", "csharp");
// @@clientName(Indexes.listLatest, "listIndexes", "csharp");
// @@clientName(Indexes.listVersions, "listIndexVersions", "csharp");

// Make these two internal, since all SDKs hand-write a single public method with boolean "includeCredentials"
// input parameter that calls either on these two.
@@access(Connections.get, Access.internal);
@@access(Connections.getWithCredentials, Access.internal);

// The fix for ambiguous import of OperationState
@@clientName(Azure.Core.Foundations.OperationState,
  "operationStatus",
  "java"
);
