import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace Azure.ResourceManager.ContainerInstance;

interface LocationOperations {
  @doc("Get the usage for a subscription")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ContainerInstance/locations/{location}/usages")
  @get
  ListUsage is Azure.Core.Foundations.Operation<
    {
      @doc("Subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;

      @doc("The identifier for the physical azure location.")
      @path
      location: string;
    },
    UsageListResult
  >;

  @summary("Get the list of cached images.")
  @doc("Get the list of cached images on specific OS type for a subscription in a region.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ContainerInstance/locations/{location}/cachedImages")
  @get
  ListCachedImages is Azure.Core.Foundations.Operation<
    {
      @doc("Subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;

      @doc("The identifier for the physical azure location.")
      @path
      location: string;
    },
    CachedImagesListResult
  >;

  @summary("Get the list of capabilities of the location.")
  @doc("Get the list of CPU/memory/GPU capabilities of a region.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ContainerInstance/locations/{location}/capabilities")
  @get
  ListCapabilities is Azure.Core.Foundations.Operation<
    {
      @doc("Subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;

      @doc("The identifier for the physical azure location.")
      @path
      location: string;
    },
    CapabilitiesListResult
  >;
}

interface SubnetServiceAssociationLinkOperations {
  @summary("Delete container group virtual network association links.")
  @doc("Delete container group virtual network association links. The operation does not delete other resources provided by the user.")
  @route("/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/Microsoft.Network/virtualNetworks/{virtualNetworkName}/subnets/{subnetName}/providers/Microsoft.ContainerInstance/serviceAssociationLinks/default")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("Subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the virtual network.")
      @path
      virtualNetworkName: string;

      @doc("The name of the subnet.")
      @path
      subnetName: string;
    },
    void
  >;
}
