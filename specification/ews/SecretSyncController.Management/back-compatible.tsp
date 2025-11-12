import "@azure-tools/typespec-client-generator-core";
import "@azure-tools/typespec-azure-resource-manager";

using Microsoft.SecretSyncController;

// Flatten properties for backward compatibility
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(AzureKeyVaultSecretProviderClass.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(SecretSync.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Azure.ResourceManager.Foundations.ResourceUpdateModel.properties,
  "autorest"
);
