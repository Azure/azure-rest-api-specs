import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

using Microsoft.Workloads;

<<<<<<< HEAD
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
=======
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Alert.properties,
  "autorest"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(AlertTemplate.properties,
  "autorest"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Monitor.properties,
  "autorest"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ProviderInstance.properties,
  "autorest"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
>>>>>>> upstream/main
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(SapLandscapeMonitorResource.properties,
  "autorest"
);
