import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@@clientName(Microsoft.SecretSyncController,
  "SecretsStoreExtensionMgmt",
  "python"
);
@@clientName(Microsoft.SecretSyncController,
  "SecretsStoreExtensionMgmtClient",
  "java"
);
@@clientName(Microsoft.SecretSyncController,
  "SecretsStoreExtensionManagementClient",
  "javascript"
);
