import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.SignalR;
@doc("A class represent a resource.")
model SignalR is TrackedResource<SignalRProperties> {
  @doc("The name of the resource.")
  @path
  @key("resourceName")
  @segment("signalR")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
  ...Azure.ResourceManager.ResourceSku;
  ...Azure.ResourceManager.ResourceKind;
}

@armResourceOperations
interface SignalRS {
  @doc("Get the resource and its properties.")
  get is ArmResourceRead<SignalR>;
  @doc("Create or update a resource.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<SignalR>;
  @doc("Operation to update an exiting resource.")
  update is ArmResourcePatchAsync<SignalR, SignalRProperties>;
  @doc("Operation to delete a resource.")
  delete is ArmResourceDeleteAsync<SignalR>;
  @doc("Handles requests to list all resources in a resource group.")
  listByResourceGroup is ArmResourceListByParent<SignalR>;
  @doc("Handles requests to list all resources in a subscription.")
  listBySubscription is ArmListBySubscription<SignalR>;
  @doc("Get the access keys of the resource.")
  listKeys is ArmResourceActionSync<SignalR, void, SignalRKeys>;
  @doc("Regenerate the access key for the resource. PrimaryKey and SecondaryKey cannot be regenerated at the same time.")
  regenerateKey is ArmResourceActionNoResponseContentAsync<
    SignalR,
    RegenerateKeyParameters
  >;
  @doc("Operation to restart a resource.")
  restart is ArmResourceActionNoResponseContentAsync<SignalR, void>;
  @doc("List all available skus of the resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/signalR/{resourceName}/skus")
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

  @doc("Get the private link resources that need to be created for a resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/signalR/{resourceName}/privateLinkResources")
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
