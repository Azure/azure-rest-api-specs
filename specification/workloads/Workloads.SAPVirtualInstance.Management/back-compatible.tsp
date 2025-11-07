import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
namespace Microsoft.Workloads;

@@clientName(SAPVirtualInstances, "SapVirtualInstances", "autorest");
@@clientName(SAPDatabaseInstances, "SapDatabaseInstances", "autorest");
@@clientName(SAPCentralServerInstances,
  "SapCentralServerInstances",
  "autorest"
);
@@clientName(SAPApplicationServerInstances,
  "SapApplicationServerInstances",
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(SAPApplicationServerInstance.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(SAPCentralServerInstance.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(SAPDatabaseInstance.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(SAPVirtualInstance.properties,
  "autorest"
);
