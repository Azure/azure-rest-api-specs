import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Fleet.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ContainerService;
@doc("Defines a multi-stage process to perform update operations across members of a Fleet.")
@parentResource(Fleet)
model FleetUpdateStrategy is ProxyResource<FleetUpdateStrategyProperties> {
  @doc("The name of the UpdateStrategy resource.")
  @maxLength(50)
  @minLength(1)
  @pattern("^[a-z0-9]([-a-z0-9]*[a-z0-9])?$")
  @path
  @key("updateStrategyName")
  @segment("updateStrategies")
  name: string;

  ...Azure.ResourceManager.EntityTag;
}

@armResourceOperations
interface FleetUpdateStrategies {
  @doc("Get a FleetUpdateStrategy")
  get is ArmResourceRead<FleetUpdateStrategy>;

  @doc("Create a FleetUpdateStrategy")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    FleetUpdateStrategy,
    {
      ...BaseParameters<FleetUpdateStrategy>;

      @doc("The request should only proceed if an entity matches this string.")
      @header
      ifMatch?: string;

      @doc("The request should only proceed if no entity matches this string.")
      @header
      ifNoneMatch?: string;
    },
    ArmAsyncOperationHeader
  >;

  @doc("Delete a FleetUpdateStrategy")
  delete is ArmResourceDeleteAsync<
    FleetUpdateStrategy,
    {
      ...BaseParameters<FleetUpdateStrategy>;

      @doc("The request should only proceed if an entity matches this string.")
      @header
      ifMatch?: string;
    },
    ArmAsyncOperationHeader
  >;

  @doc("List FleetUpdateStrategy resources by Fleet")
  listByFleet is ArmResourceListByParent<FleetUpdateStrategy>;
}
