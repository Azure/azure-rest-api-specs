import "@azure-tools/typespec-client-generator-core";

using Microsoft.EdgeZones;

// Flatten properties for backward compatibility
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ExtendedZone.properties,
  "autorest"
);
