import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Microsoft.OperationalInsights;

@@clientName(Microsoft.OperationalInsights,
  "OperationalInsightsManagementClient",
  "javascript,java"
);
@@clientName(LogAnalyticsQueryPacks.search, "listSearch", "javascript");

@@clientName(NetworkSecurityPerimeterConfigurations.getNSP, "getNsp", "java");
@@clientName(NetworkSecurityPerimeterConfigurations.listNSP, "listNsp", "java");
@@clientName(NetworkSecurityPerimeterConfigurations.reconcileNSP,
  "reconcileNsp",
  "java"
);

@@clientName(DestinationMetaData, "DestinationMetadata", "java");

@@alternateType(Azure.ResourceManager.CommonTypes.AccessRuleProperties.subscriptions,
  global.AccessRulePropertiesSubscriptionsItem[],
  "java"
);

// Rename existing ProvisioningStateEnum to ProvisioningState for Java to deduplicate
@@clientName(Microsoft.OperationalInsights.ProvisioningStateEnum,
  "ProvisioningState",
  "java"
);

// Create compatible ProvisioningStateEnum for backward compatibility
#suppress "@azure-tools/typespec-azure-core/no-enum" "Backward compatibility for Java SDK by merging provisioning state values"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "Mirror enum for backward compatibility"
enum CompatibleProvisioningStateEnum {
  Updating: "Updating",
  InProgress: "InProgress",
  Succeeded: "Succeeded",
  Deleting: "Deleting",
  Failed: "Failed",
  Canceled: "Canceled",
}
@@clientName(CompatibleProvisioningStateEnum, "ProvisioningStateEnum", "java");

@@alternateType(Microsoft.OperationalInsights.TableProperties.provisioningState,
  CompatibleProvisioningStateEnum,
  "java"
);
@@alternateType(Microsoft.OperationalInsights.SummaryLogsProperties.provisioningState,
  CompatibleProvisioningStateEnum,
  "java"
);

// Fix etag casing for backward compatibility
@@clientName(Microsoft.OperationalInsights.SearchMetadata.eTag, "etag", "java");
