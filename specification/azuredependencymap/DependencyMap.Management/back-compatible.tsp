import "@azure-tools/typespec-client-generator-core";

using Microsoft.DependencyMap;

// Discriminated type
// @@Azure.ClientGenerator.Core.Legacy.flattenProperty(DiscoverySourceResource.properties,
//   "autorest"
// );
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(MapsResource.properties,
  "autorest"
);
