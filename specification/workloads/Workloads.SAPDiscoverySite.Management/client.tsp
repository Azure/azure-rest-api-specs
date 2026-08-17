import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Azure.Core;

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
@@clientName(
  Microsoft.Workloads.ConfigurationData,
  "ConfigurationDetail",
  "csharp"
);
@@clientName(
  Microsoft.Workloads.DataSource,
  "SapDiscoveryDataSource",
  "csharp"
);
@@clientName(
  Microsoft.Workloads.DatabaseType,
  "SapDiscoveryDatabaseType",
  "csharp"
);
@@clientName(
  Microsoft.Workloads.ErrorDefinition,
  "SapDiscoveryErrorDetail",
  "csharp"
);
@@clientName(
  Microsoft.Workloads.ExcelPerformanceData,
  "ExcelPerformanceDetail",
  "csharp"
);
@@clientName(
  Microsoft.Workloads.ExtendedLocation,
  "SapDiscoveryExtendedLocation",
  "csharp"
);
@@clientName(
  Microsoft.Workloads.NativePerformanceData,
  "NativePerformanceDetail",
  "csharp"
);
@@clientName(
  Microsoft.Workloads.OperatingSystem,
  "SapDiscoveryOperatingSystem",
  "csharp"
);
@@clientName(
  Microsoft.Workloads.PerformanceData,
  "PerformanceDetail",
  "csharp"
);
@@clientName(
  Microsoft.Workloads.ProvisioningState,
  "SapDiscoveryProvisioningState",
  "csharp"
);
@@clientName(
  Microsoft.Workloads.SAPDiscoverySite,
  "SapDiscoverySite",
  "csharp"
);
@@clientName(Microsoft.Workloads.SAPInstance, "SapInstance", "csharp");
@@clientName(Microsoft.Workloads.SAPMigrateError, "SapMigrateError", "csharp");
@@clientName(
  Microsoft.Workloads.ServerInstance,
  "SapDiscoveryServerInstance",
  "csharp"
);
@@clientName(Microsoft.Workloads.DatabaseType.Db2, "DB2", "csharp");
@@clientName(Microsoft.Workloads.DatabaseType.HANA, "Hana", "csharp");
@@clientName(Microsoft.Workloads.DatabaseType.SAPASE, "SapAse", "csharp");
@@clientName(Microsoft.Workloads.DatabaseType.SAPDB, "SapDB", "csharp");
@@clientName(Microsoft.Workloads.DatabaseType.SAPMaxDB, "SapMaxDB", "csharp");
@@clientName(
  Microsoft.Workloads.ExtendedLocation.type,
  "ExtendedLocationType",
  "csharp"
);
@@clientName(Microsoft.Workloads.OperatingSystem.IBMAIX, "IbmAix", "csharp");
@@clientName(Microsoft.Workloads.OperatingSystem.SUSE, "Suse", "csharp");
@@clientName(Microsoft.Workloads.SapInstanceType.APP, "App", "csharp");
@@clientName(Microsoft.Workloads.SapInstanceType.ASCS, "Ascs", "csharp");
@@clientName(Microsoft.Workloads.SapInstanceType.SCS, "Scs", "csharp");
@@clientName(Microsoft.Workloads.SapInstanceType.WEBDISP, "Webdisp", "csharp");

@@alternateType(
  Azure.ResourceManager.CommonTypes.Resource.id,
  armResourceIdentifier,
  "csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  Microsoft.Workloads.SAPDiscoverySite.properties,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  Microsoft.Workloads.SAPInstance.properties,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  Microsoft.Workloads.ServerInstance.properties,
  "csharp"
);
