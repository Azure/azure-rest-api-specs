// Contains overrides to make the Autorest Swagger2.0 back compatible

using Microsoft.AzureLargeInstance;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(AzureLargeInstance.properties,
  "autorest"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(AzureLargeStorageInstance.properties,
  "autorest"
);
