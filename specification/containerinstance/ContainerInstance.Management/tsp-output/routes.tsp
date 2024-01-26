import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.ContainerInstance;

interface LocationOperations {
  /**
   * Get the usage for a subscription
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ContainerInstance/locations/{location}/usages")
  @get
  listUsage is Azure.Core.Foundations.Operation<
    {
      /**
       * Subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;

      /**
       * The identifier for the physical azure location.
       */
      @path
      location: string;
    },
    UsageListResult
  >;

  /**
   * Get the list of cached images on specific OS type for a subscription in a region.
   */
  @summary("Get the list of cached images.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ContainerInstance/locations/{location}/cachedImages")
  @get
  listCachedImages is Azure.Core.Foundations.Operation<
    {
      /**
       * Subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;

      /**
       * The identifier for the physical azure location.
       */
      @path
      location: string;
    },
    CachedImagesListResult
  >;

  /**
   * Get the list of CPU/memory/GPU capabilities of a region.
   */
  @summary("Get the list of capabilities of the location.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ContainerInstance/locations/{location}/capabilities")
  @get
  listCapabilities is Azure.Core.Foundations.Operation<
    {
      /**
       * Subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;

      /**
       * The identifier for the physical azure location.
       */
      @path
      location: string;
    },
    CapabilitiesListResult
  >;
}

interface SubnetServiceAssociationLinkOperations {
  /**
   * Delete container group virtual network association links. The operation does not delete other resources provided by the user.
   */
  @summary("Delete container group virtual network association links.")
  @route("/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/Microsoft.Network/virtualNetworks/{virtualNetworkName}/subnets/{subnetName}/providers/Microsoft.ContainerInstance/serviceAssociationLinks/default")
  @delete
  delete is Azure.Core.Foundations.Operation<
    {
      /**
       * Subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;

      /**
       * The name of the resource group.
       */
      @path
      resourceGroupName: string;

      /**
       * The name of the virtual network.
       */
      @path
      virtualNetworkName: string;

      /**
       * The name of the subnet.
       */
      @path
      subnetName: string;
    },
    void
  >;
}
