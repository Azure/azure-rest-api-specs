import "@azure-tools/typespec-client-generator-core";

using Microsoft.EdgeZones;

// Flatten properties for backward compatibility
<<<<<<< HEAD
=======
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
>>>>>>> upstream/main
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ExtendedZone.properties,
  "autorest"
);
