import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./BatchAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Batch;
/**
 * Contains information about a pool.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(BatchAccount)
@Azure.ResourceManager.Private.armResourceInternal(PoolProperties)
@includeInapplicableMetadataInPayload(false)
model Pool extends ProxyResource {
  /**
   * The pool name. This must be unique within the account.
   */
  @maxLength(64)
  @minLength(1)
  @pattern("^[a-zA-Z0-9_-]+$")
  @path
  @key("poolName")
  @segment("pools")
  name: string;

  /**
   * The type of identity used for the Batch Pool.
   */
  identity?: BatchPoolIdentity;

  /**
   * The properties associated with the pool.
   */
  @extension("x-ms-client-flatten", true)
  properties?: PoolProperties;
}

@armResourceOperations
interface Pools {
  /**
   * Gets information about the specified pool.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Pool_Get")
  get is ArmResourceRead<Pool>;

  /**
   * Creates a new pool inside the specified account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Pool_Create")
  create is ArmResourceCreateOrReplaceSync<
    Pool,
    {
      ...BaseParameters<Pool>;

      /**
       * The entity state (ETag) version of the pool to update. A value of "*" can be used to apply the operation only if the pool already exists. If omitted, this operation will always be applied.
       */
      @header
      `If-Match`?: string;

      /**
       * Set to '*' to allow a new pool to be created, but to prevent updating an existing pool. Other values will be ignored.
       */
      @header
      `If-None-Match`?: string;
    }
  >;

  /**
   * Updates the properties of an existing pool.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("Pool_Update")
  update is ArmCustomPatchSync<
    Pool,
    Pool,
    {
      ...BaseParameters<Pool>;

      /**
       * The entity state (ETag) version of the pool to update. This value can be omitted or set to "*" to apply the operation unconditionally.
       */
      @header
      `If-Match`?: string;
    }
  >;

  /**
   * Deletes the specified pool.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Pool_Delete")
  delete is ArmResourceDeleteAsync<
    Pool,
    BaseParameters<Pool>,
    ArmLroLocationHeader
  >;

  /**
   * Lists all of the pools in the specified account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Pool_ListByBatchAccount")
  listByBatchAccount is ArmResourceListByParent<
    Pool,
    {
      ...BaseParameters<Pool>;

      /**
       * The maximum number of items to return in the response.
       */
      @query("maxresults")
      maxresults?: int32;

      /**
       * Comma separated list of properties that should be returned. e.g. "properties/provisioningState". Only top level properties under properties/ are valid for selection.
       */
      @query("$select")
      $select?: string;

      /**
       * OData filter expression. Valid properties for filtering are:
       *
       *  name
       *  properties/allocationState
       *  properties/allocationStateTransitionTime
       *  properties/creationTime
       *  properties/provisioningState
       *  properties/provisioningStateTransitionTime
       *  properties/lastModified
       *  properties/vmSize
       *  properties/interNodeCommunication
       *  properties/scaleSettings/autoScale
       *  properties/scaleSettings/fixedScale
       */
      @query("$filter")
      $filter?: string;
    }
  >;

  /**
   * Disables automatic scaling for a pool.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Pool_DisableAutoScale")
  disableAutoScale is ArmResourceActionSync<Pool, void, Pool>;

  /**
   * This does not restore the pool to its previous state before the resize operation: it only stops any further changes being made, and the pool maintains its current state. After stopping, the pool stabilizes at the number of nodes it was at when the stop operation was done. During the stop operation, the pool allocation state changes first to stopping and then to steady. A resize operation need not be an explicit resize pool request; this API can also be used to halt the initial sizing of the pool when it is created.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Pool_StopResize")
  stopResize is ArmResourceActionSync<Pool, void, Pool>;
}

@@projectedName(Pools.create::parameters.resource, "json", "parameters");
@@extension(Pools.create::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(Pools.create::parameters.resource,
  "Additional parameters for pool creation."
);
@@projectedName(Pools.update::parameters.properties, "json", "parameters");
@@extension(Pools.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(Pools.update::parameters.properties,
  "Pool properties that should be updated. Properties that are supplied will be updated, any property not supplied will be unchanged."
);
