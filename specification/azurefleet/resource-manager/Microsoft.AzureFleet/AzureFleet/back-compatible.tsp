import "@azure-tools/typespec-client-generator-core";

namespace Microsoft.AzureFleet;

@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Fleet.properties,
  "autorest"
);
