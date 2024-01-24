import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Project.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DevCenter;
/**
 * A pool of Virtual Machines.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Project)
@Azure.ResourceManager.Private.armResourceInternal(PoolProperties)
@includeInapplicableMetadataInPayload(false)
model Pool extends TrackedResourceBase {
  /**
   * Name of the pool.
   */
  @path
  @key("poolName")
  @segment("pools")
  name: string;

  /**
   * Pool properties
   */
  @extension("x-ms-client-flatten", true)
  properties?: PoolProperties;
}

@armResourceOperations
interface Pools {
  /**
   * Gets a machine pool
   */
  get is ArmResourceRead<Pool>;

  /**
   * Creates or updates a machine pool
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Pool,
    BaseParameters<Pool>,
    ArmAsyncOperationHeader
  >;

  /**
   * Partially updates a machine pool
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<
    Pool,
    PoolUpdate,
    BaseParameters<Pool>,
    ArmAsyncOperationHeader
  >;

  /**
   * Deletes a machine pool
   */
  delete is ArmResourceDeleteAsync<
    Pool,
    BaseParameters<Pool>,
    ArmAsyncOperationHeader
  >;

  /**
   * Lists pools for a project
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Pools_ListByProject")
  listByProject is ArmResourceListByParent<
    Pool,
    {
      ...BaseParameters<Pool>;

      /**
       * The maximum number of resources to return from the operation. Example: '$top=10'.
       */
      @query("$top")
      $top?: int32;
    }
  >;

  /**
   * Triggers a refresh of the pool status.
   */
  runHealthChecks is ArmResourceActionAsync<
    Pool,
    void,
    void,
    BaseParameters<Pool>,
    ArmAsyncOperationHeader
  >;
}

@@projectedName(Pools.createOrUpdate::parameters.resource, "json", "body");
@@extension(Pools.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(Pools.createOrUpdate::parameters.resource, "Represents a machine pool");
@@projectedName(Pools.update::parameters.properties, "json", "body");
@@extension(Pools.update::parameters.properties, "x-ms-client-name", "body");
@@doc(Pools.update::parameters.properties, "Represents a machine pool");
