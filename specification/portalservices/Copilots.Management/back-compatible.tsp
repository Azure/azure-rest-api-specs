import "@azure-tools/typespec-client-generator-core";

using Microsoft.PortalServices;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(CopilotResource.properties,
  "autorest"
);
