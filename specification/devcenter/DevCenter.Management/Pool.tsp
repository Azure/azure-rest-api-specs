import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Project.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DevCenter;
/**
 * A pool of Virtual Machines.
 */
@parentResource(Project)
model Pool is Azure.ResourceManager.TrackedResource<PoolProperties> {
  ...ResourceNameParameter<
    Resource = Pool,
    KeyName = "poolName",
    SegmentName = "pools",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9-_.]{2,62}$"
  >;
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
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Pool>;

  /**
   * Partially updates a machine pool
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    Pool,
    PatchModel = PoolUpdate,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader,
    Response = PoolUpdate | ArmAcceptedLroResponse<
      "Resource update request accepted.",
      ArmAsyncOperationHeader<FinalResult = PoolUpdate>
    >
  >;

  /**
   * Deletes a machine pool
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    Pool,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Lists pools for a project
   */
  listByProject is ArmResourceListByParent<
    Pool,
    Parameters = {
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
  runHealthChecks is ArmResourceActionAsyncBase<
    Pool,
    void,
    ArmAcceptedLroResponse<LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader>,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<Pool>
  >;
}

@@maxLength(Pool.name, 63);
@@minLength(Pool.name, 3);
@@doc(Pool.name, "Name of the pool.");
@@doc(Pool.properties, "Pool properties");
@@doc(Pools.createOrUpdate::parameters.resource, "Represents a machine pool");
@@doc(Pools.update::parameters.properties, "Represents a machine pool");
