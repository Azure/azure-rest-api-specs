import "@azure-tools/typespec-client-generator-core";

using Microsoft.PortalServices;

@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Assistant.properties,
  "autorest"
);
