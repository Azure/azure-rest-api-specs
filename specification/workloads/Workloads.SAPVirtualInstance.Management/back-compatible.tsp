import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Workloads;

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
