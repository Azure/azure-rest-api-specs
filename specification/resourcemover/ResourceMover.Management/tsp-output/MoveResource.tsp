import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./MoveCollection.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.Migrate;
@doc("Defines the move resource.")
@parentResource(MoveCollection)
model MoveResource is ProxyResource<MoveResourceProperties> {
  @doc("The Move Resource Name.")
  @path
  @key("moveResourceName")
  @segment("moveResources")
  name: string;
}

@armResourceOperations
interface MoveResources {
  @doc("Gets the Move Resource.")
  get is ArmResourceRead<MoveResource>;
  @doc("Creates or updates a Move Resource in the move collection.")
  create is ArmResourceCreateOrUpdateAsync<MoveResource>;
  @doc("Deletes a Move Resource from the move collection.")
  delete is ArmResourceDeleteAsync<MoveResource>;
  @doc("Lists the Move Resources in the move collection.")
  list is ArmResourceListByParent<
    MoveResource,
    {
      ...BaseParameters<MoveResource>;

      @doc("The filter to apply on the operation. For example, you can use $filter=Properties/ProvisioningState eq 'Succeeded'.")
      @query("$filter")
      $filter?: string;
    }
  >;
}
