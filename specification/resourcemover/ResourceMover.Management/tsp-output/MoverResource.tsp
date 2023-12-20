import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./MoverResourceSet.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.ResourceMover;
@doc("Defines the move resource.")
@parentResource(MoverResourceSet)
model MoverResource is ProxyResource<MoveResourceProperties> {
  @doc("The Move Resource Name.")
  @path
  @key("moveResourceName")
  @segment("moveResources")
  name: string;
}

@armResourceOperations
interface MoverResources {
  @doc("Gets the Move Resource.")
  get is ArmResourceRead<
    MoverResource,
    {
      ...BaseParameters<MoverResource>;

      @doc("The Move Collection Name.")
      @path
      moverResourceSetName: string;

      @doc("The Move Resource Name.")
      @path
      moverResourceName: string;
    }
  >;
  @doc("Creates or updates a Move Resource in the move collection.")
  create is ArmResourceCreateOrUpdateAsync<
    MoverResource,
    {
      ...BaseParameters<MoverResource>;

      @doc("The Move Collection Name.")
      @path
      moverResourceSetName: string;

      @doc("The Move Resource Name.")
      @path
      moverResourceName: string;
    }
  >;
  @doc("Deletes a Move Resource from the move collection.")
  delete is ArmResourceDeleteAsync<
    MoverResource,
    {
      ...BaseParameters<MoverResource>;

      @doc("The Move Collection Name.")
      @path
      moverResourceSetName: string;

      @doc("The Move Resource Name.")
      @path
      moverResourceName: string;
    }
  >;
  @doc("Lists the Move Resources in the move collection.")
  list is ArmResourceListByParent<
    MoverResource,
    {
      ...BaseParameters<MoverResource>;

      @doc("The Move Collection Name.")
      @path
      moverResourceSetName: string;

      @doc("The filter to apply on the operation. For example, you can use $filter=Properties/ProvisioningState eq 'Succeeded'.")
      @query("$filter")
      $filter?: string;
    }
  >;
}
