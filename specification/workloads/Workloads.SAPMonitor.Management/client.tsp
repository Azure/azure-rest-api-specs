import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Azure.Core;
using Microsoft.Workloads;

@@clientName(Microsoft.Workloads, "SapMonitorsMgmtClient", "python");

@@clientName(Microsoft.Workloads, "SapMonitorsMgmtClient", "java");

// C# customizations preserve the names and resource data shape shipped in
// Azure.ResourceManager.Workloads before SAP Monitor moved to its own package.
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flattening preserves the shipped C# resource data shape."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  Monitor.properties,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flattening preserves the shipped C# resource data shape."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  ProviderInstance.properties,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flattening preserves the shipped C# resource data shape."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  SapLandscapeMonitorResource.properties,
  "csharp"
);

@@clientName(Monitor, "SapMonitor", "csharp");
@@clientName(ProviderInstance, "SapProviderInstance", "csharp");
@@clientName(SapLandscapeMonitorResource, "SapLandscapeMonitor", "csharp");
@@clientName(UpdateMonitorRequest, "SapMonitorPatch", "csharp");
@@clientName(Health, "WorkloadsSapMonitorHealth", "csharp");
@@clientName(
  ProviderSpecificProperties,
  "SapProviderInstanceSpecificProperties",
  "csharp"
);

@@clientName(RoutingPreference, "SapRoutingPreference", "csharp");
@@clientName(SslPreference, "SapSslPreference", "csharp");
@@clientName(
  Db2ProviderInstanceProperties,
  "DB2ProviderInstanceProperties",
  "csharp"
);
@@clientName(
  PrometheusHaClusterProviderInstanceProperties,
  "PrometheusHAClusterProviderInstanceProperties",
  "csharp"
);

@@clientName(MonitorProperties.monitorSubnet, "MonitorSubnetId", "csharp");
@@alternateType(MonitorProperties.appLocation, azureLocation, "csharp");
@@alternateType(
  MonitorProperties.logAnalyticsWorkspaceArmId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(
  MonitorProperties.monitorSubnet,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(MonitorProperties.msiArmId, armResourceIdentifier, "csharp");
@@alternateType(
  MonitorProperties.storageAccountArmId,
  armResourceIdentifier,
  "csharp"
);

@@alternateType(HanaDbProviderInstanceProperties.dbPasswordUri, url, "csharp");
@@alternateType(
  HanaDbProviderInstanceProperties.sslCertificateUri,
  url,
  "csharp"
);
@@alternateType(
  SapNetWeaverProviderInstanceProperties.sapPasswordUri,
  url,
  "csharp"
);
@@alternateType(
  SapNetWeaverProviderInstanceProperties.sslCertificateUri,
  url,
  "csharp"
);
@@alternateType(
  PrometheusOsProviderInstanceProperties.prometheusUrl,
  url,
  "csharp"
);
@@alternateType(
  PrometheusOsProviderInstanceProperties.sslCertificateUri,
  url,
  "csharp"
);
@@alternateType(Db2ProviderInstanceProperties.dbPasswordUri, url, "csharp");
@@alternateType(Db2ProviderInstanceProperties.sslCertificateUri, url, "csharp");
@@alternateType(
  PrometheusHaClusterProviderInstanceProperties.prometheusUrl,
  url,
  "csharp"
);
@@alternateType(
  PrometheusHaClusterProviderInstanceProperties.sslCertificateUri,
  url,
  "csharp"
);
@@alternateType(
  MsSqlServerProviderInstanceProperties.dbPasswordUri,
  url,
  "csharp"
);
@@alternateType(
  MsSqlServerProviderInstanceProperties.sslCertificateUri,
  url,
  "csharp"
);
@@alternateType(OracleProviderInstanceProperties.dbPasswordUri, url, "csharp");
@@alternateType(
  OracleProviderInstanceProperties.sslCertificateUri,
  url,
  "csharp"
);

@@clientName(Alert, "SapMonitorAlert", "csharp");
@@clientName(AlertProperties, "SapMonitorAlertProperties", "csharp");
@@clientName(AlertTemplate, "SapMonitorAlertTemplate", "csharp");
@@clientName(
  AlertTemplateProperties,
  "SapMonitorAlertTemplateProperties",
  "csharp"
);
@@clientName(AlertQueryParameter, "SapMonitorAlertQueryContent", "csharp");
@@clientName(AlertRuleProperties, "SapMonitorAlertRuleProperties", "csharp");
@@clientName(ConditionalOperator, "AlertRuleConditionalOperator", "csharp");
@@clientName(
  DefaultThresholdInputOption,
  "AlertTemplateDefaultThresholdInputOption",
  "csharp"
);
@@clientName(
  AlertTemplateQueryInputParameter,
  "AlertTemplateQueryInputContent",
  "csharp"
);
@@clientName(
  AppServicePlanConfiguration,
  "SapMonitorAppServicePlanConfiguration",
  "csharp"
);
@@clientName(AppServicePlanTier, "SapMonitorAppServicePlanTier", "csharp");
@@clientName(
  WorkloadMonitorProvisioningState,
  "WorkloadsSapMonitorProvisioningState",
  "csharp"
);
