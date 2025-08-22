import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./NetAppAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.NetApp;
/**
 * Capacity pool resource
 */
@parentResource(NetAppAccount)
model CapacityPool
  is Azure.ResourceManager.TrackedResource<PoolProperties, false> {
  ...ResourceNameParameter<
    Resource = CapacityPool,
    KeyName = "poolName",
    SegmentName = "capacityPools",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,63}$"
  >;
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
}

@armResourceOperations
interface CapacityPools {
  /**
   * Get details of the specified capacity pool
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Pools_Get")
  get is ArmResourceRead<CapacityPool>;

  /**
   * Create or Update a capacity pool
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Pools_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    CapacityPool,
    LroHeaders = ArmLroLocationHeader<FinalResult = CapacityPool> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Patch the specified capacity pool
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Pools_Update")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<CapacityPool, PatchModel = CapacityPoolPatch>;

  /**
   * Delete the specified capacity pool
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Pools_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<CapacityPool>;

  /**
   * List all capacity pools in the NetApp Account
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Pools_List")
  list is ArmResourceListByParent<
    CapacityPool,
    Response = ArmResponse<CapacityPoolList>
  >;
}

@@maxLength(CapacityPool.name, 64);
@@minLength(CapacityPool.name, 1);
@@doc(CapacityPool.name, "The name of the capacity pool");
@@doc(CapacityPool.properties, "Capacity pool properties");
@@doc(CapacityPools.createOrUpdate::parameters.resource,
  "Capacity pool object supplied in the body of the operation."
);
@@doc(CapacityPools.update::parameters.properties,
  "Capacity pool object supplied in the body of the operation."
);
