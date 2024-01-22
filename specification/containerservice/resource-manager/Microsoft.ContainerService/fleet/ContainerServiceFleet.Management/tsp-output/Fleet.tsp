import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ContainerService;
/**
 * The Fleet resource.
 */
model Fleet is TrackedResource<FleetProperties> {
  /**
   * The name of the Fleet resource.
   */
  @maxLength(63)
  @minLength(1)
  @pattern("^[a-z0-9]([-a-z0-9]*[a-z0-9])?$")
  @path
  @key("fleetName")
  @segment("fleets")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
  ...Azure.ResourceManager.EntityTag;
}

@armResourceOperations
interface Fleets {
  /**
   * Gets a Fleet.
   */
  get is ArmResourceRead<Fleet>;

  /**
   * Creates or updates a Fleet.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Fleet,
    {
      ...BaseParameters<Fleet>;

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
   * Update a Fleet
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<
    Fleet,
    FleetPatch,
    {
      ...BaseParameters<Fleet>;

      /**
       * The request should only proceed if an entity matches this string.
       */
      @header
      ifMatch?: string;
    },
    ArmLroLocationHeader
  >;

  /**
   * Delete a Fleet
   */
  delete is ArmResourceDeleteAsync<
    Fleet,
    {
      ...BaseParameters<Fleet>;

      /**
       * The request should only proceed if an entity matches this string.
       */
      @header
      ifMatch?: string;
    },
    ArmLroLocationHeader
  >;

  /**
   * Lists fleets in the specified subscription and resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Fleets_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<Fleet>;

  /**
   * Lists fleets in the specified subscription.
   */
  listBySubscription is ArmListBySubscription<Fleet>;

  /**
   * Lists the user credentials of a Fleet.
   */
  listCredentials is ArmResourceActionSync<Fleet, void, FleetCredentialResults>;
}
