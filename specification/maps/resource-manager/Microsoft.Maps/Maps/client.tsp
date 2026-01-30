import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;

@@clientName(Microsoft.Maps, "AzureMapsManagementClient", "javascript,python");

// Preserve legacy Java names for renamed encryption identity models.
@@clientName(Azure.ResourceManager.CommonTypes.KeyEncryptionKeyIdentity,
  "CustomerManagedKeyEncryptionKeyIdentity",
  "java"
);
@@clientName(Azure.ResourceManager.CommonTypes.KeyEncryptionKeyIdentityType,
  "IdentityType",
  "java"
);

@@clientName(Azure.ResourceManager.CommonTypes.CustomerManagedKeyEncryption,
  "EncryptionCustomerManagedKeyEncryption",
  "python"
);
@@clientName(Azure.ResourceManager.CommonTypes.KeyEncryptionKeyIdentity,
  "EncryptionCustomerManagedKeyEncryptionKeyIdentity",
  "python"
);
@@clientName(Azure.ResourceManager.CommonTypes.KeyEncryptionKeyIdentityType,
  "EncryptionCustomerManagedKeyEncryptionKeyIdentityType",
  "python"
);
