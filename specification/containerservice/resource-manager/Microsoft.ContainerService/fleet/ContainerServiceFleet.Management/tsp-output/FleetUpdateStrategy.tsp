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
/**
 * Defines a multi-stage process to perform update operations across members of a Fleet.
 */
@parentResource(Fleet)
model FleetUpdateStrategy is ProxyResource<FleetUpdateStrategyProperties> {
  /**
   * The name of the UpdateStrategy resource.
   */
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
  /**
   * Get a FleetUpdateStrategy
   */
  get is ArmResourceRead<FleetUpdateStrategy>;

  /**
   * Create a FleetUpdateStrategy
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    FleetUpdateStrategy,
    {
      ...BaseParameters<FleetUpdateStrategy>;

      /**
       * The request should only proceed if an entity matches this string.
       */
      @header
      ifMatch?: string;

      /**
       * The request should only proceed if no entity matches this string.
       */
      @header
      ifNoneMatch?: string;
    },
    ArmAsyncOperationHeader
  >;

  /**
   * Delete a FleetUpdateStrategy
   */
  delete is ArmResourceDeleteAsync<
    FleetUpdateStrategy,
    {
      ...BaseParameters<FleetUpdateStrategy>;

      /**
       * The request should only proceed if an entity matches this string.
       */
      @header
      ifMatch?: string;
    },
    ArmAsyncOperationHeader
  >;

  /**
   * List FleetUpdateStrategy resources by Fleet
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("FleetUpdateStrategies_ListByFleet")
  listByFleet is ArmResourceListByParent<FleetUpdateStrategy>;
}
