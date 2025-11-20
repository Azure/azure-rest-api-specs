import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

using Microsoft.Workloads;

@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Alert.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(AlertTemplate.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Monitor.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ProviderInstance.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(SapLandscapeMonitorResource.properties,
  "autorest"
);
