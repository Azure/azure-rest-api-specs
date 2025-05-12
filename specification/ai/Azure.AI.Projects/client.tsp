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

// In Python, the emitter changes "keys" to "keys_property", since there is already
// a "keys" method in the generated code due to usage of MutableMapping. Call it credential_keys instead.
@@clientName(Azure.AI.Projects.CustomCredential.keys,
  "credential_keys",
  "python"
);

// Make these two internal, since all SDKs hand-write a single public method with boolean "includeCredentials"
// input parameter that calls either on these two.
@@access(Azure.AI.Projects.Connections.get, Access.internal);
@@access(Azure.AI.Projects.Connections.getWithCredentials, Access.internal);

// For some reason for Python the emitter creates an empty ServicePatternsOperations operation
// class. Mark it as internal here. Apply to all languages just in case.
//@@access(Azure.AI.Projects.ServicePatterns, Access.internal);  <== this did not work. It makes all methods internal.

@@clientName(Azure.AI.Projects.SASCredentials, "SasCredentials", "java");
@@clientName(Azure.AI.Projects.ConnectionType.AzureAISearch, "AZURE_AI_SEARCH", "java");
@@clientName(Azure.AI.Projects.AssetCredentialResponse, "AssetCredentialResult", "java");

@@clientName(Azure.AI.Projects.Connections.list, "listConnections", "java");
@@clientName(Azure.AI.Projects.Connections.get, "getConnection", "java");
@@clientName(Azure.AI.Projects.Connections.getWithCredentials, "getConnectionWithCredentials", "java");

@@clientName(Azure.AI.Projects.Datasets.listLatest, "listLatestDatasetVersions", "java");
@@clientName(Azure.AI.Projects.Datasets.getVersion, "getDatasetVersion", "java");
@@clientName(Azure.AI.Projects.Datasets.deleteVersion, "deleteDatasetVersion", "java");
@@clientName(Azure.AI.Projects.Datasets.createOrUpdateVersion, "createOrUpdateDatasetVersion", "java");
@@clientName(Azure.AI.Projects.Datasets.listVersions, "listDatasetVersions", "java");

@@clientName(Azure.AI.Projects.Deployments.get, "getDeployment", "java");
@@clientName(Azure.AI.Projects.Deployments.list, "listDeployments", "java");

@@clientName(Azure.AI.Projects.Evaluations.create, "createEvaluation", "java");
@@clientName(Azure.AI.Projects.Evaluations.get, "getEvaluation", "java");
@@clientName(Azure.AI.Projects.Evaluations.list, "listEvaluations", "java");

@@clientName(Azure.AI.Projects.Indexes.listLatest, "listLatestIndexVersions", "java");
@@clientName(Azure.AI.Projects.Indexes.getVersion, "getIndexVersion", "java");
@@clientName(Azure.AI.Projects.Indexes.deleteVersion, "deleteIndexVersion", "java");
@@clientName(Azure.AI.Projects.Indexes.createOrUpdateVersion, "createOrUpdateIndexVersion", "java");
@@clientName(Azure.AI.Projects.Indexes.listVersions, "listIndexVersions", "java");

@@clientName(Azure.AI.Projects.RedTeams.create, "createRedTeam", "java");
@@clientName(Azure.AI.Projects.RedTeams.get, "getRedTeam", "java");
@@clientName(Azure.AI.Projects.RedTeams.list, "listRedTeams", "java");
