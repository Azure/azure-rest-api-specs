import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Microsoft.OperationalInsights;

@@clientName(
  Microsoft.OperationalInsights,
  "OperationalInsightsManagementClient",
  "javascript,java"
);
@@clientName(
  Microsoft.OperationalInsights,
  "LogAnalyticsManagementClient",
  "python"
);
@@clientName(LogAnalyticsQueryPacks.search, "listSearch", "javascript");

@@clientName(NetworkSecurityPerimeterConfigurations.getNSP, "getNsp", "java");
@@clientName(NetworkSecurityPerimeterConfigurations.listNSP, "listNsp", "java");
@@clientName(
  NetworkSecurityPerimeterConfigurations.reconcileNSP,
  "reconcileNsp",
  "java"
);

@@clientName(DestinationMetaData, "DestinationMetadata", "java");

@@alternateType(
  Azure.ResourceManager.CommonTypes.AccessRuleProperties.subscriptions,
  global.AccessRulePropertiesSubscriptionsItem[],
  "java,python"
);

@@clientName(
  Microsoft.OperationalInsights.ProvisioningStateEnum,
  "SummaryLogsProvisioningState",
  "java,python"
);
@@clientName(
  OperationalInsightsTableProvisioningState,
  "ProvisioningStateEnum",
  "java,python"
);

// Fix etag casing for backward compatibility
@@clientName(Microsoft.OperationalInsights.SearchMetadata.eTag, "etag", "java");
