import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";
using Azure.ClientGenerator.Core;
using Http;
using Azure.ResourceManager;
using Microsoft.NotificationHubs;

@@clientName(Microsoft.NotificationHubs,
  "NotificationHubsManagementClient",
  "javascript"
);

/**
 * override for NamespaceResources.list
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op namespaceResourcesList(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...Azure.ResourceManager.Legacy.Provider,
  resourceGroupName: string,

  /**
   * Skip token for subsequent requests.
   */
  @query("$skipToken")
  $skipToken?: string,

  /**
   * Maximum number of results to return.
   */
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
  @query("$top")
  @Azure.ClientGenerator.Core.Legacy.clientDefaultValue(100)
  $top?: int32 = 100,
): NamespaceListResult;

@@override(NamespaceResources.list, namespaceResourcesList, "javascript");

/**
 * override for NamespaceResources.listAll
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op namespaceResourcesListAll(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  /**
   * Skip token for subsequent requests.
   */
  @query("$skipToken")
  $skipToken?: string,

  /**
   * Maximum number of results to return.
   */
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
  @query("$top")
  @Azure.ClientGenerator.Core.Legacy.clientDefaultValue(100)
  $top?: int32 = 100,
): NamespaceListResult;

@@override(NamespaceResources.listAll, namespaceResourcesListAll, "javascript");

/**
 * override for NotificationHubResources.list
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op notificationHubResourcesList(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  resourceGroupName: string,
  ...Azure.ResourceManager.Legacy.Provider,
  namespaceName: string,

  /**
   * Skip token for subsequent requests.
   */
  @query("$skipToken")
  $skipToken?: string,

  /**
   * Maximum number of results to return.
   */
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
  @query("$top")
  @Azure.ClientGenerator.Core.Legacy.clientDefaultValue(100)
  $top?: int32 = 100,
): NamespaceListResult | Azure.ResourceManager.CommonTypes.ErrorResponse;

@@override(NotificationHubResources.list,
  notificationHubResourcesList,
  "javascript"
);
