import "@azure-tools/typespec-client-generator-core";

using Microsoft.AzureFleet;

@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Fleet.properties,
  "autorest"
);
