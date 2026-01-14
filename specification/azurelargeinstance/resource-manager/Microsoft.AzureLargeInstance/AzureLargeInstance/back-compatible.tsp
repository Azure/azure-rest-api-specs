// Contains overrides to make the Autorest Swagger2.0 back compatible

using Microsoft.AzureLargeInstance;

<<<<<<< HEAD
=======
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
>>>>>>> upstream/main
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(AzureLargeInstance.properties,
  "autorest"
);

<<<<<<< HEAD
=======
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
>>>>>>> upstream/main
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(AzureLargeStorageInstance.properties,
  "autorest"
);
