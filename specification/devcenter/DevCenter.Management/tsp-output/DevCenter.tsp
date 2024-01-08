import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.DevCenter;
@doc("Represents a devcenter resource.")
model DevCenter is TrackedResource<DevCenterProperties> {
  @doc("The name of the devcenter.")
  @key("devCenterName")
  @segment("devcenters")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface DevCenters {
  @doc("Gets a devcenter.")
  get is ArmResourceRead<DevCenter>;
  @doc("Creates or updates a devcenter resource")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<DevCenter>;
  @doc("Partially updates a devcenter.")
  update is ArmCustomPatchAsync<DevCenter, DevCenterUpdate>;
  @doc("Deletes a devcenter")
  delete is ArmResourceDeleteAsync<DevCenter>;
  @doc("Lists all devcenters in a resource group.")
  listByResourceGroup is ArmResourceListByParent<
    DevCenter,
    {
      ...BaseParameters<DevCenter>;

      @doc("The maximum number of resources to return from the operation. Example: '$top=10'.")
      @query("$top")
      $top?: int32;
    }
  >;
  @doc("Lists all devcenters in a subscription.")
  listBySubscription is ArmListBySubscription<DevCenter>;
}

@armResourceOperations
interface Images {
  @doc("Lists images for a devcenter.")
  // FIXME: Images_ListByDevCenter could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DevCenter/devcenters/{devCenterName}/images")
  @get
  ListByDevCenter is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The name of the devcenter.")
      @path
      devCenterName: string;

      @doc("The maximum number of resources to return from the operation. Example: '$top=10'.")
      @query("$top")
      $top?: int32;
    },
    ResourceListResult<Image>
  >;
}
