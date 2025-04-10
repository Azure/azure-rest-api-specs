import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.StoragePool;
/**
 * Response for Disk Pool request.
 */
model DiskPool
  is Azure.ResourceManager.TrackedResource<DiskPoolProperties, false> {
  ...ResourceNameParameter<
    Resource = DiskPool,
    KeyName = "diskPoolName",
    SegmentName = "diskPools",
    NamePattern = ""
  >;

  /**
   * Determines the SKU of the Disk pool
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  sku?: Sku;

  /**
   * Azure resource id. Indicates if this resource is managed by another Azure resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  @visibility(Lifecycle.Read)
  managedBy?: string;

  /**
   * List of Azure resource ids that manage this resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  @visibility(Lifecycle.Read)
  managedByExtended?: string[];
}

@armResourceOperations
interface DiskPools {
  /**
   * Get a Disk pool.
   */
  get is ArmResourceRead<DiskPool>;

  /**
   * Create or Update Disk pool. This create or update operation can take 15 minutes to complete. This is expected service behavior.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<DiskPool>;

  /**
   * Update a Disk pool.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    DiskPool,
    PatchModel = DiskPoolUpdate,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Delete a Disk pool; attached disks are not affected. This delete operation can take 10 minutes to complete. This is expected service behavior.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    DiskPool,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse<ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader> | ArmDeletedNoContentResponse
  >;

  /**
   * Gets a list of DiskPools in a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<DiskPool>;

  /**
   * Gets a list of Disk Pools in a subscription
   */
  listBySubscription is ArmListBySubscription<DiskPool>;

  /**
   * Gets the network endpoints of all outbound dependencies of a Disk Pool
   */
  @get
  @action("outboundNetworkDependenciesEndpoints")
  listOutboundNetworkDependenciesEndpoints is ArmResourceActionSync<
    DiskPool,
    void,
    ArmResponse<OutboundEnvironmentEndpointList>
  >;

  /**
   * The operation to start a Disk Pool. This start operation can take 10 minutes to complete. This is expected service behavior.
   */
  start is ArmResourceActionAsync<
    DiskPool,
    void,
    OkResponse,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Shuts down the Disk Pool and releases the compute resources. You are not billed for the compute resources that this Disk Pool uses. This operation can take 10 minutes to complete. This is expected service behavior.
   */
  deallocate is ArmResourceActionAsync<
    DiskPool,
    void,
    OkResponse,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Upgrade replaces the underlying virtual machine hosts one at a time. This operation can take 10-15 minutes to complete. This is expected service behavior.
   */
  upgrade is ArmResourceActionAsync<
    DiskPool,
    void,
    OkResponse,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;
}

@@doc(DiskPool.name, "The name of the Disk Pool.");
@@doc(DiskPool.properties, "Properties of Disk Pool.");
@@doc(DiskPools.createOrUpdate::parameters.resource,
  "Request payload for Disk Pool create operation"
);
@@doc(DiskPools.update::parameters.properties,
  "Request payload for Disk Pool update operation."
);
