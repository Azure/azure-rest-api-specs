import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.WebPubSub;
@doc("A class represent a resource.")
model WebPubSub is TrackedResource<WebPubSubProperties> {
  @doc("The name of the resource.")
  @key("resourceName")
  @segment("webPubSub")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
interface WebPubSub {
  @doc("Get the resource and its properties.")
  get is ArmResourceRead<WebPubSub>;
  @doc("Create or update a resource.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<WebPubSub>;
  @doc("Operation to update an exiting resource.")
  update is ArmCustomPatchAsync<WebPubSub, WebPubSub>;
  @doc("Operation to delete a resource.")
  delete is ArmResourceDeleteAsync<WebPubSub>;
  @doc("Handles requests to list all resources in a resource group.")
  listByResourceGroup is ArmResourceListByParent<WebPubSub>;
  @doc("Handles requests to list all resources in a subscription.")
  listBySubscription is ArmListBySubscription<WebPubSub>;
  @doc("Get the access keys of the resource.")
  listKeys is ArmResourceActionSync<WebPubSub, void, WebPubSubKeys>;
  @doc("Regenerate the access key for the resource. PrimaryKey and SecondaryKey cannot be regenerated at the same time.")
  regenerateKey is ArmResourceActionNoResponseContentAsync<
    WebPubSub,
    RegenerateKeyParameters
  >;
  @doc("Operation to restart a resource.")
  restart is ArmResourceActionNoResponseContentAsync<WebPubSub, void>;
  @doc("List all available skus of the resource.")
  // FIXME: WebPubSub_ListSkus could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/webPubSub/{resourceName}/skus")
  @get
  ListSkus is Azure.Core.Foundations.Operation<
    {
      @doc("Gets subscription Id which uniquely identify the Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.")
      @path
      resourceGroupName: string;

      @doc("The name of the resource.")
      @path
      resourceName: string;
    },
    SkuList
  >;
}

@armResourceOperations
interface WebPubSubPrivateLinkResources {
  @doc("Get the private link resources that need to be created for a resource.")
  // FIXME: WebPubSubPrivateLinkResources_List could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/webPubSub/{resourceName}/privateLinkResources")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("Gets subscription Id which uniquely identify the Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.")
      @path
      resourceGroupName: string;

      @doc("The name of the resource.")
      @path
      resourceName: string;
    },
    PrivateLinkResourceList
  >;
}
