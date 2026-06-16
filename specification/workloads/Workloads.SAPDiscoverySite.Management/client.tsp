import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@@clientName(Microsoft.Workloads, "MigrationDiscoverySapMgmtClient", "python");

@@clientName(Microsoft.Workloads, "MigrationDiscoverySapMgmtClient", "java");

@@clientName(Microsoft.Workloads.SAPDiscoverySite, "SapDiscoverySite", "java");
@@clientName(Microsoft.Workloads.SAPDiscoverySiteProperties,
  "SapDiscoverySiteProperties",
  "java"
);
@@clientName(Microsoft.Workloads.SAPDiscoverySites,
  "SapDiscoverySites",
  "java"
);
@@clientName(Microsoft.Workloads.SAPInstance, "SapInstance", "java");
@@clientName(Microsoft.Workloads.SAPInstanceProperties,
  "SapInstanceProperties",
  "java"
);
@@clientName(Microsoft.Workloads.SAPInstances, "SapInstances", "java");
@@clientName(Microsoft.Workloads.SAPMigrateError, "SapMigrateError", "java");
