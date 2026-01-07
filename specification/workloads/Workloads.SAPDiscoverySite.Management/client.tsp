import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@@clientName(Microsoft.Workloads, "MigrationDiscoverySapMgmtClient", "python");

@@clientName(Microsoft.Workloads, "MigrationDiscoverySapMgmtClient", "java");

@@clientName(Microsoft.Workloads.SapDiscoverySite, "SapDiscoverySite", "java");
@@clientName(Microsoft.Workloads.SapDiscoverySiteProperties,
  "SapDiscoverySiteProperties",
  "java"
);
@@clientName(Microsoft.Workloads.SapDiscoverySites,
  "SapDiscoverySites",
  "java"
);
@@clientName(Microsoft.Workloads.SapInstance, "SapInstance", "java");
@@clientName(Microsoft.Workloads.SapInstanceProperties,
  "SapInstanceProperties",
  "java"
);
@@clientName(Microsoft.Workloads.SapInstances, "SapInstances", "java");
@@clientName(Microsoft.Workloads.SapMigrateError, "SapMigrateError", "java");
