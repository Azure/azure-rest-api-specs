import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.CustomerInsights;
@doc("Hub resource.")
model Hub is TrackedResource<HubPropertiesFormat> {
  @doc("The name of the hub.")
  @path
  @key("hubName")
  @segment("hubs")
  name: string;
}

@armResourceOperations
interface Hubs {
  @doc("Gets information about the specified hub.")
  get is ArmResourceRead<Hub>;
  @doc("Creates a hub, or updates an existing hub.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<Hub>;
  @doc("Updates a Hub.")
  update is ArmResourcePatchSync<Hub, HubPropertiesFormat>;
  @doc("Deletes the specified hub.")
  delete is ArmResourceDeleteAsync<Hub>;
  @doc("Gets all the hubs in a resource group.")
  listByResourceGroup is ArmResourceListByParent<Hub>;
  @doc("Gets all hubs in the specified subscription.")
  list is ArmListBySubscription<Hub>;
}

@armResourceOperations
interface Images {
  @doc("Gets entity type (profile or interaction) image upload URL.")
  getUploadUrlForEntityType is ArmResourceActionSync<
    Hub,
    GetImageUploadUrlInput,
    ImageDefinition
  >;
  @doc("Gets data image upload URL.")
  getUploadUrlForData is ArmResourceActionSync<
    Hub,
    GetImageUploadUrlInput,
    ImageDefinition
  >;
}

@armResourceOperations
interface Roles {
  @doc("Gets all the roles for the hub.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CustomerInsights/hubs/{hubName}/roles")
  @get
  ListByHub is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the hub.")
      @path
      hubName: string;

      @doc("Gets subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;
    },
    RoleListResult
  >;
}
