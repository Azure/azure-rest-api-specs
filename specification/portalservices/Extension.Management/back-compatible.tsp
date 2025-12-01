import "@azure-tools/typespec-client-generator-core";

using Microsoft.PortalServices;

@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ExtensionDeployment.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ExtensionSlot.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ExtensionVersion.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(PortalExtension.properties,
  "autorest"
);
