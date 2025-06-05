import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Azure.Core;
using Microsoft.SecretSyncController;

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

// CSharp
@@clientName(AzureKeyVaultSecretProviderClass,
  "KeyVaultSecretProviderClass",
  "csharp"
);
@@clientName(AzureKeyVaultSecretProviderClassProperties,
  "KeyVaultSecretProviderClassProperties",
  "csharp"
);
@@clientName(ProvisioningState,
  "SecretsStoreExtensionProvisioningState",
  "csharp"
);
@@clientName(StatusConditionType, "SecretSyncConditionStatusType", "csharp");
@@alternateType(AzureKeyVaultSecretProviderClassProperties.clientId,
  uuid,
  "csharp"
);
@@alternateType(AzureKeyVaultSecretProviderClassProperties.tenantId,
  uuid,
  "csharp"
);
