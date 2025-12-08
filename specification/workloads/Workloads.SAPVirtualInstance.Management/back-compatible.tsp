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
@@clientName(SAPVirtualInstances.getSizingRecommendations,
  "InvokeSizingRecommendations"
);
@@clientName(SAPVirtualInstances.getSapSupportedSku, "InvokeSapSupportedSku");
@@clientName(SAPVirtualInstances.getDiskConfigurations,
  "InvokeDiskConfigurations"
);
@@clientName(SAPVirtualInstances.getAvailabilityZoneDetails,
  "InvokeAvailabilityZoneDetails"
);

@@Azure.ClientGenerator.Core.Legacy.flattenProperty(SAPApplicationServerInstance.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(SAPCentralServerInstance.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(SAPVirtualInstance.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(SAPDatabaseInstance.properties,
  "autorest"
);
