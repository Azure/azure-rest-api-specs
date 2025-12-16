import "@azure-tools/typespec-client-generator-core";

using Microsoft.EdgeZones;

// Flatten properties for backward compatibility
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ExtendedZone.properties,
  "autorest"
);
