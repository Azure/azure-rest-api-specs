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

/**
 * Table's current provisioning state. If set to 'updating', indicates a resource lock due to ongoing operation, forbidding any update to the table until the ongoing operation is concluded.
 */
union CompatibleProvisioningStateEnum {
  string,

  /**
   * Table schema is still being built and updated, table is currently locked for any changes till the procedure is done.
   */
  Updating: "Updating",

  /**
   * Table schema is stable and without changes, table data is being updated.
   */
  InProgress: "InProgress",

  /**
   * Table state is stable and without changes, table is unlocked and open for new updates.
   */
  Succeeded: "Succeeded",

  /**
   * Table state is deleting.
   */
  Deleting: "Deleting",

  /**
   * Table state is failed.
   */
  Failed: "Failed",

  /**
   * Table state is canceled.
   */
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
