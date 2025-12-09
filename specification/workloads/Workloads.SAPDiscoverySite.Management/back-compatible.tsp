import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Workloads;

@@clientName(SAPDiscoverySites, "SapDiscoverySites", "autorest");
@@clientName(SAPInstances, "SapInstances", "autorest");

@@Azure.ClientGenerator.Core.Legacy.flattenProperty(SAPDiscoverySite.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(SAPInstance.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ServerInstance.properties,
  "autorest"
);
