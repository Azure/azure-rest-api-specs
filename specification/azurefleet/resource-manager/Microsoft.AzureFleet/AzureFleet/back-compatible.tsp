import "@azure-tools/typespec-client-generator-core";

using Microsoft.AzureFleet;

<<<<<<< HEAD
=======
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
>>>>>>> upstream/main
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Fleet.properties,
  "autorest"
);
