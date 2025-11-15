import "@azure-tools/typespec-client-generator-core";

using Microsoft.DependencyMap;

// Discriminated type
// @@Azure.ClientGenerator.Core.Legacy.flattenProperty(DiscoverySourceResource.properties,
//   "autorest"
// );
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(MapsResource.properties,
  "autorest"
);
