import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;

@@clientName(Microsoft.Maps, "AzureMapsManagementClient", "javascript");

// Preserve legacy Java names for renamed encryption identity models.
@@clientName(Azure.ResourceManager.CommonTypes.KeyEncryptionKeyIdentity,
  "CustomerManagedKeyEncryptionKeyIdentity",
  "java"
);
@@clientName(Azure.ResourceManager.CommonTypes.KeyEncryptionKeyIdentityType,
  "IdentityType",
  "java"
);
