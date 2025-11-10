using Azure.ResourceManager;

namespace Microsoft.ContainerRegistry;

/**
 * The properties of a private link resource.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model PrivateLinkResourceProperties {
  /**
   * The private link resource group id.
   */
  groupId?: string;

  /**
   * The private link resource required member names.
   */
  requiredMembers?: string[];

  /**
   * The private link resource Private link DNS zone name.
   */
  requiredZoneNames?: string[];
}

/**
 * The result of a request to list private link resources for a container registry.
 */
model PrivateLinkResourceListResult {
  /**
   * The list of private link resources. Since this list may be incomplete, the nextLink field should be used to request the next list of private link resources.
   */
  @pageItems
  value?: PrivateLinkResource[];

  /**
   * The URI that can be used to request the next list of private link resources.
   */
  @nextLink
  nextLink?: string;
}
