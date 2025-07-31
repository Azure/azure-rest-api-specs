import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;

@@clientName(Azure.AI.Projects, "AIProjectClient");

// Shorter method names for SDK datasets operations
@@clientName(Azure.AI.Projects.Datasets.listLatest, "list");
@@clientName(Azure.AI.Projects.Datasets.getVersion, "get");
@@clientName(Azure.AI.Projects.Datasets.deleteVersion, "delete");
@@clientName(Azure.AI.Projects.Datasets.createOrUpdateVersion,
  "createOrUpdate"
);
@@clientName(Azure.AI.Projects.Datasets.startPendingUploadVersion,
  "pendingUpload"
);

// Shorter method names for SDK Index operations
@@clientName(Azure.AI.Projects.Indexes.listLatest, "list");
@@clientName(Azure.AI.Projects.Indexes.getVersion, "get");
@@clientName(Azure.AI.Projects.Indexes.deleteVersion, "delete");
@@clientName(Azure.AI.Projects.Indexes.createOrUpdateVersion, "createOrUpdate");

// Less generic names
@@clientName(Azure.AI.Projects.Sku, "ModelDeploymentSku");
@@clientName(Azure.AI.Projects.SasCredential, "BlobReferenceSasCredential"); // Not to be confused with class "SASCredentials"

// More accurate naming
@@clientName(Azure.AI.Projects.AssetCredentialResponse, "DatasetCredential");

// In Python, the emitter changes "keys" to "keys_property", since there is already
// a "keys" method in the generated code due to usage of MutableMapping. Call it credential_keys instead.
@@clientName(Azure.AI.Projects.CustomCredential.keys,
  "credential_keys",
  "python"
);

// Less generic names for C# SDK (avoid one-word class names)
@@clientName(Azure.AI.Projects.Connection, "ConnectionProperties", "csharp");
@@clientName(Azure.AI.Projects.Deployment, "AssetDeployment", "csharp");
@@clientName(Azure.AI.Projects.Index, "SearchIndex", "csharp");

// Do not use terms "request" or "response" in C# class names as these are REST API terms
@@clientName(Azure.AI.Projects.PendingUploadRequest,
  "PendingUploadConfiguration",
  "csharp"
);
@@clientName(Azure.AI.Projects.PendingUploadResponse,
  "PendingUploadResult",
  "csharp"
);

// Need to explicitly make all get and list methods include the object name for C#
@@clientName(Azure.AI.Projects.Connections.get, "getConnection");
@@clientName(Azure.AI.Projects.Connections.getWithCredentials,
  "getConnectionWithCredentials"
);
@@clientName(Azure.AI.Projects.Connections.list, "listConnections");
@@clientName(Azure.AI.Projects.Datasets.getVersion, "getDataset");
@@clientName(Azure.AI.Projects.Datasets.listLatest, "listDatasets");
@@clientName(Azure.AI.Projects.Datasets.listVersions,
  "listDatasetVersions"
);
@@clientName(Azure.AI.Projects.Deployments.get, "getDeployment");
@@clientName(Azure.AI.Projects.Deployments.list, "listDeployments");
@@clientName(Azure.AI.Projects.Indexes.getVersion, "getIndex");
@@clientName(Azure.AI.Projects.Indexes.listLatest, "listIndexes");
@@clientName(Azure.AI.Projects.Indexes.listVersions, "listIndexVersions");

// Make these two internal, since all SDKs hand-write a single public method with boolean "includeCredentials"
// input parameter that calls either on these two.
@@access(Azure.AI.Projects.Connections.get, Access.internal);
@@access(Azure.AI.Projects.Connections.getWithCredentials, Access.internal);
