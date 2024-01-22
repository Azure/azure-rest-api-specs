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
 * A member of the Fleet. It contains a reference to an existing Kubernetes cluster on Azure.
 */
@parentResource(Fleet)
model FleetMember is ProxyResource<FleetMemberProperties> {
  /**
   * The name of the Fleet member resource.
   */
  @maxLength(50)
  @minLength(1)
  @pattern("^[a-z0-9]([-a-z0-9]*[a-z0-9])?$")
  @path
  @key("fleetMemberName")
  @segment("members")
  name: string;

  ...Azure.ResourceManager.EntityTag;
}

@armResourceOperations
interface FleetMembers {
  /**
   * Get a FleetMember
   */
  get is ArmResourceRead<FleetMember>;

  /**
   * Create a FleetMember
   */
  create is ArmResourceCreateOrReplaceAsync<
    FleetMember,
    {
      ...BaseParameters<FleetMember>;

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
   * Update a FleetMember
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<
    FleetMember,
    FleetMemberUpdate,
    {
      ...BaseParameters<FleetMember>;

      /**
       * The request should only proceed if an entity matches this string.
       */
      @header
      ifMatch?: string;
    },
    ArmLroLocationHeader
  >;

  /**
   * Delete a FleetMember
   */
  delete is ArmResourceDeleteAsync<
    FleetMember,
    {
      ...BaseParameters<FleetMember>;

      /**
       * The request should only proceed if an entity matches this string.
       */
      @header
      ifMatch?: string;
    },
    ArmLroLocationHeader
  >;

  /**
   * List FleetMember resources by Fleet
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("FleetMembers_ListByFleet")
  listByFleet is ArmResourceListByParent<FleetMember>;
}
