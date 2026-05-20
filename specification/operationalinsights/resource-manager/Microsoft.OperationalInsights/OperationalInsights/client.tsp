import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Microsoft.OperationalInsights;

@@clientName(
  Microsoft.OperationalInsights,
  "OperationalInsightsManagementClient",
  "javascript,java"
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
  "java"
);

@@clientName(
  Microsoft.OperationalInsights.ProvisioningStateEnum,
  "SummaryLogsProvisioningState",
  "java"
);
@@clientName(
  OperationalInsightsTableProvisioningState,
  "ProvisioningStateEnum",
  "java"
);

// Fix etag casing for backward compatibility
@@clientName(Microsoft.OperationalInsights.SearchMetadata.eTag, "etag", "java");
