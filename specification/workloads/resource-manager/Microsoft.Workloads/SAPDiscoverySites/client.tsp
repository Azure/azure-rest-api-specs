import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Azure.Core;
using Microsoft.Workloads;

@@clientName(Microsoft.Workloads, "MigrationDiscoverySapMgmtClient", "python");

@@clientName(Microsoft.Workloads, "MigrationDiscoverySapMgmtClient", "java");

@@clientName(Microsoft.Workloads.SAPDiscoverySite, "SapDiscoverySite", "java");
@@clientName(
  Microsoft.Workloads.SAPDiscoverySiteProperties,
  "SapDiscoverySiteProperties",
  "java"
);
@@clientName(
  Microsoft.Workloads.SAPDiscoverySites,
  "SapDiscoverySites",
  "java"
);
@@clientName(Microsoft.Workloads.SAPInstance, "SapInstance", "java");
@@clientName(
  Microsoft.Workloads.SAPInstanceProperties,
  "SapInstanceProperties",
  "java"
);
@@clientName(Microsoft.Workloads.SAPInstances, "SapInstances", "java");
@@clientName(Microsoft.Workloads.SAPMigrateError, "SapMigrateError", "java");

// Preserve the names shipped by the previous C# SDK generator.
@@clientName(ConfigurationData, "ConfigurationDetail", "csharp");
@@clientName(DataSource, "SapDiscoveryDataSource", "csharp");
@@clientName(DatabaseType, "SapDiscoveryDatabaseType", "csharp");
@@clientName(ErrorDefinition, "SapDiscoveryErrorDetail", "csharp");
@@clientName(ExcelPerformanceData, "ExcelPerformanceDetail", "csharp");
@@clientName(ExtendedLocation, "SapDiscoveryExtendedLocation", "csharp");
@@clientName(NativePerformanceData, "NativePerformanceDetail", "csharp");
@@clientName(OperatingSystem, "SapDiscoveryOperatingSystem", "csharp");
@@clientName(PerformanceData, "PerformanceDetail", "csharp");
@@clientName(ProvisioningState, "SapDiscoveryProvisioningState", "csharp");
@@clientName(SAPDiscoverySite, "SapDiscoverySite", "csharp");
@@clientName(SAPInstance, "SapInstance", "csharp");
@@clientName(SAPMigrateError, "SapMigrateError", "csharp");
@@clientName(ServerInstance, "SapDiscoveryServerInstance", "csharp");
@@clientName(DatabaseType.Db2, "DB2", "csharp");
@@clientName(DatabaseType.HANA, "Hana", "csharp");
@@clientName(DatabaseType.SAPASE, "SapAse", "csharp");
@@clientName(DatabaseType.SAPDB, "SapDB", "csharp");
@@clientName(DatabaseType.SAPMaxDB, "SapMaxDB", "csharp");
@@clientName(ExtendedLocation.type, "ExtendedLocationType", "csharp");
@@clientName(OperatingSystem.IBMAIX, "IbmAix", "csharp");
@@clientName(OperatingSystem.SUSE, "Suse", "csharp");
@@clientName(SapInstanceType.APP, "App", "csharp");
@@clientName(SapInstanceType.ASCS, "Ascs", "csharp");
@@clientName(SapInstanceType.SCS, "Scs", "csharp");
@@clientName(SapInstanceType.WEBDISP, "Webdisp", "csharp");

@@alternateType(
  Azure.ResourceManager.CommonTypes.Resource.id,
  armResourceIdentifier,
  "csharp"
);

// to keep exact same property name as previous GA
@@clientName(
  ExcelPerformanceData.totalSourceDbSizeGB,
  exact("TotalSourceDbSizeGB"),
  "csharp"
);
