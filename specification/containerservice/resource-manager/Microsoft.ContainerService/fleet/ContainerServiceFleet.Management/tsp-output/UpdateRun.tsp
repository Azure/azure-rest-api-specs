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
 * A multi-stage process to perform update operations across members of a Fleet.
 */
@parentResource(Fleet)
model UpdateRun is ProxyResource<UpdateRunProperties> {
  /**
   * The name of the UpdateRun resource.
   */
  @maxLength(50)
  @minLength(1)
  @pattern("^[a-z0-9]([-a-z0-9]*[a-z0-9])?$")
  @path
  @key("updateRunName")
  @segment("updateRuns")
  name: string;

  ...Azure.ResourceManager.EntityTag;
}

@armResourceOperations
interface UpdateRuns {
  /**
   * Get a UpdateRun
   */
  get is ArmResourceRead<UpdateRun>;

  /**
   * Create a UpdateRun
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    UpdateRun,
    {
      ...BaseParameters<UpdateRun>;

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
   * Delete a UpdateRun
   */
  delete is ArmResourceDeleteAsync<
    UpdateRun,
    {
      ...BaseParameters<UpdateRun>;

      /**
       * The request should only proceed if an entity matches this string.
       */
      @header
      ifMatch?: string;
    },
    ArmLroLocationHeader
  >;

  /**
   * List UpdateRun resources by Fleet
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("UpdateRuns_ListByFleet")
  listByFleet is ArmResourceListByParent<UpdateRun>;

  /**
   * Starts an UpdateRun.
   */
  start is ArmResourceActionAsync<
    UpdateRun,
    void,
    UpdateRun,
    {
      ...BaseParameters<UpdateRun>;

      /**
       * The request should only proceed if an entity matches this string.
       */
      @header
      ifMatch?: string;
    },
    ArmLroLocationHeader
  >;

  /**
   * Stops an UpdateRun.
   */
  stop is ArmResourceActionAsync<
    UpdateRun,
    void,
    UpdateRun,
    {
      ...BaseParameters<UpdateRun>;

      /**
       * The request should only proceed if an entity matches this string.
       */
      @header
      ifMatch?: string;
    },
    ArmLroLocationHeader
  >;
}
