import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./BatchAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Batch;
/**
 * Contains information about a pool.
 */
@parentResource(BatchAccount)
model Pool is Azure.ResourceManager.ProxyResource<PoolProperties> {
  ...ResourceNameParameter<
    Resource = Pool,
    KeyName = "poolName",
    SegmentName = "pools",
    NamePattern = "^[a-zA-Z0-9_-]+$"
  >;

  /**
   * The type of identity used for the Batch Pool.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Legacy design"
  identity?: BatchPoolIdentity;

  /**
   * The ETag of the resource, used for concurrency statements.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Legacy design"
  @visibility(Lifecycle.Read)
  etag?: string;

  /**
   * The tags of the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Legacy design"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "legacy design"
  tags?: Record<string>;
}

@armResourceOperations
@tag("Pool")
interface Pools {
  /**
   * Gets information about the specified pool.
   */
  get is ArmResourceRead<
    Pool,
    Response = ArmResourceUpdatedResponse<Pool> & {
      /**
       * The ETag HTTP response header. This is an opaque string. You can use it to detect whether the resource has changed between requests. In particular, you can pass the ETag to one of the If-Match or If-None-Match headers.
       */
      @header("ETag")
      etag?: string;
    },
    Error = CloudError
  >;

  /**
   * Creates a new pool inside the specified account.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "Legacy behavior"
  create is ArmResourceCreateOrReplaceSync<
    Pool,
    Parameters = {
      /**
       * The entity state (ETag) version of the pool to update. A value of "*" can be used to apply the operation only if the pool already exists. If omitted, this operation will always be applied.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "Legacy casing"
      @header("If-Match")
      `If-Match`?: string;

      /**
       * Set to '*' to allow a new pool to be created, but to prevent updating an existing pool. Other values will be ignored.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "Legacy casing"
      @header("If-None-Match")
      `If-None-Match`?: string;
    },
    Response = ArmResourceUpdatedResponse<Pool> & {
      /**
       * The ETag HTTP response header. This is an opaque string. You can use it to detect whether the resource has changed between requests. In particular, you can pass the ETag to one of the If-Match or If-None-Match headers.
       */
      @header("ETag")
      etag?: string;
    },
    Error = CloudError
  >;

  /**
   * Updates the properties of an existing pool.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    Pool,
    PatchModel = Pool,
    Parameters = {
      /**
       * The entity state (ETag) version of the pool to update. This value can be omitted or set to "*" to apply the operation unconditionally.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "Legacy casing"
      @header("If-Match")
      `If-Match`?: string;
    },
    Response = ArmResourceUpdatedResponse<Pool> & {
      /**
       * The ETag HTTP response header. This is an opaque string. You can use it to detect whether the resource has changed between requests. In particular, you can pass the ETag to one of the If-Match or If-None-Match headers.
       */
      @header("ETag")
      etag?: string;
    },
    Error = CloudError
  >;

  /**
   * Deletes the specified pool.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "Legacy design"
  delete is ArmResourceDeleteWithoutOkAsync<
    Pool,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Lists all of the pools in the specified account.
   */
  listByBatchAccount is ArmResourceListByParent<
    Pool,
    Parameters = {
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
    },
    Response = ArmResponse<ListPoolsResult>,
    Error = CloudError
  >;

  /**
   * Disables automatic scaling for a pool.
   */
  disableAutoScale is ArmResourceActionSync<
    Pool,
    void,
    Response = ArmResponse<Pool> & {
      /**
       * The ETag HTTP response header. This is an opaque string. You can use it to detect whether the resource has changed between requests. In particular, you can pass the ETag to one of the If-Match or If-None-Match headers.
       */
      @header("ETag")
      etag?: string;
    },
    Error = CloudError
  >;

  /**
   * This does not restore the pool to its previous state before the resize operation: it only stops any further changes being made, and the pool maintains its current state. After stopping, the pool stabilizes at the number of nodes it was at when the stop operation was done. During the stop operation, the pool allocation state changes first to stopping and then to steady. A resize operation need not be an explicit resize pool request; this API can also be used to halt the initial sizing of the pool when it is created.
   */
  stopResize is ArmResourceActionSync<
    Pool,
    void,
    Response = ArmResponse<Pool> & {
      /**
       * The ETag HTTP response header. This is an opaque string. You can use it to detect whether the resource has changed between requests. In particular, you can pass the ETag to one of the If-Match or If-None-Match headers.
       */
      @header("ETag")
      etag?: string;
    },
    Error = CloudError
  >;
}

@@maxLength(Pool.name, 64);
@@minLength(Pool.name, 1);
@@doc(Pool.name, "The pool name. This must be unique within the account.");
@@doc(Pool.properties, "The properties associated with the pool.");
@@doc(Pools.create::parameters.resource,
  "Additional parameters for pool creation."
);
@@doc(Pools.update::parameters.properties,
  "Pool properties that should be updated. Properties that are supplied will be updated, any property not supplied will be unchanged."
);
@@summary(Pools.stopResize, "Stops an ongoing resize operation on the pool.");
