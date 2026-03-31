// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;

namespace Microsoft.ContainerInstance;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface ContainerGroupsOperationGroup {
  /**
   * Get a list of container groups in the specified subscription. This operation returns properties of each container group including containers, image registry credentials, restart policy, IP address type, OS type, state, and volumes.
   */
  @summary("Get a list of container groups in the specified subscription.")
  @autoRoute
  @get
  @list
  @action("containerGroups")
  list is ArmProviderActionSync<
    Response = ContainerGroupListResult,
    Scope = SubscriptionActionScope,
    Error = CloudError
  >;
  /**
   * Get a list of container groups in a specified subscription and resource group. This operation returns properties of each container group including containers, image registry credentials, restart policy, IP address type, OS type, state, and volumes.
   */
  @summary("Get a list of container groups in the specified subscription and resource group.")
  @autoRoute
  @get
  @list
  @action("containerGroups")
  listByResourceGroup is ArmProviderActionSync<
    Response = ContainerGroupListResult,
    Scope = Extension.ResourceGroup,
    Error = CloudError
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface LocationOperationGroup {
  /**
   * Get the usage for a subscription
   */
  @autoRoute
  @get
  @list
  @action("usages")
  listUsage is ArmProviderActionSync<
    Response = UsageListResult,
    Scope = SubscriptionActionScope,
    Error = CloudError,
    Parameters = LocationParameter
  >;
  /**
   * Get the list of cached images on specific OS type for a subscription in a region.
   */
  @summary("Get the list of cached images.")
  @autoRoute
  @list
  @get
  @action("cachedImages")
  listCachedImages is ArmProviderActionSync<
    Response = CachedImagesListResult,
    Scope = SubscriptionActionScope,
    Error = CloudError,
    Parameters = LocationParameter
  >;
  /**
   * Get the list of CPU/memory/GPU capabilities of a region.
   */
  @summary("Get the list of capabilities of the location.")
  @autoRoute
  @get
  @list
  @action("capabilities")
  listCapabilities is ArmProviderActionSync<
    Response = CapabilitiesListResult,
    Scope = SubscriptionActionScope,
    Error = CloudError,
    Parameters = LocationParameter
  >;
}

alias VirtualNetwork = Extension.ExternalResource<
  "Microsoft.Network",
  "virtualNetworks",
  "virtualNetworkName",
  NamePattern = "The name of the virtual network."
>;

alias Subnet = Extension.ExternalChildResource<
  VirtualNetwork,
  "subnets",
  "subnetName",
  NamePattern = "The name of the subnet."
>;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface SubnetServiceAssociationLinkOperationGroup {
  /**
   * Delete container group virtual network association links. The operation does not delete other resources provided by the user.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "For backward compatibility"
  @summary("Delete container group virtual network association links.")
  @route("/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/Microsoft.Network/virtualNetworks/{virtualNetworkName}/subnets/{subnetName}/providers/Microsoft.ContainerInstance/serviceAssociationLinks/default")
  @delete
  delete(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * The name of the virtual network.
     */
    @segment("virtualNetworks")
    virtualNetworkName: string,

    /**
     * The name of the subnet.
     */
    @segment("subnets")
    subnetName: string,
  ): OkResponse | ArmAcceptedLroResponse | NoContentResponse | CloudError;
}
