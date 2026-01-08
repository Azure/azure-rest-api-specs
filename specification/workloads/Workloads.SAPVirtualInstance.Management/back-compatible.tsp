import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Workloads;

@@clientName(SAPVirtualInstances, "SapVirtualInstances", "autorest");
@@clientName(SAPDatabaseInstances, "SapDatabaseInstances", "autorest");
@@clientName(SAPCentralServerInstances,
  "SapCentralServerInstances",
  "autorest"
);
@@clientName(SAPApplicationServerInstance,
  "SAPApplicationServerInstance",
  "autorest"
);
@@clientName(SAPApplicationServerInstances,
  "SapApplicationServerInstances",
  "autorest"
);
@@clientName(SAPVirtualInstances.invokeSizingRecommendations, "getSizingRecommendations", "!autorest");
@@clientName(SAPVirtualInstances.invokeSapSupportedSku, "getSapSupportedSku", "!autorest");
@@clientName(SAPVirtualInstances.invokeDiskConfigurations, "getDiskConfigurations", "!autorest");
@@clientName(SAPVirtualInstances.invokeAvailabilityZoneDetails, "getAvailabilityZoneDetails", "!autorest");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(SAPApplicationServerInstance.properties,
  "autorest"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(SAPCentralServerInstance.properties,
  "autorest"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(SAPVirtualInstance.properties,
  "autorest"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(SAPDatabaseInstance.properties,
  "autorest"
);
