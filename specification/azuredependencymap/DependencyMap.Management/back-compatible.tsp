// Contains overrides to make the Autorest Swagger2.0 back compatible
namespace Microsoft.DependencyMap;

// Discriminated type
// @@Azure.ClientGenerator.Core.Legacy.flattenProperty(DiscoverySourceResource.properties,
//   "autorest"
// );
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(MapsResource.properties,
  "autorest"
);
