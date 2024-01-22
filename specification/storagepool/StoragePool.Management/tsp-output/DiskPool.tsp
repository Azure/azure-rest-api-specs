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

namespace Microsoft.StoragePool;
/**
 * Response for Disk Pool request.
 */
model DiskPool is TrackedResource<DiskPoolProperties> {
  /**
   * The name of the Disk Pool.
   */
  @path
  @key("diskPoolName")
  @segment("diskPools")
  name: string;

  /**
   * List of Azure resource ids that manage this resource.
   */
  @visibility("read")
  managedByExtended?: string[];

  ...Azure.ResourceManager.ResourceSku;
  ...Azure.ResourceManager.ManagedBy;
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
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    DiskPool,
    BaseParameters<DiskPool>,
    ArmAsyncOperationHeader
  >;

  /**
   * Update a Disk pool.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<
    DiskPool,
    DiskPoolUpdate,
    BaseParameters<DiskPool>,
    ArmAsyncOperationHeader
  >;

  /**
   * Delete a Disk pool; attached disks are not affected. This delete operation can take 10 minutes to complete. This is expected service behavior.
   */
  delete is ArmResourceDeleteAsync<
    DiskPool,
    BaseParameters<DiskPool>,
    ArmAsyncOperationHeader
  >;

  /**
   * Gets a list of DiskPools in a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DiskPools_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<DiskPool>;

  /**
   * Gets a list of Disk Pools in a subscription
   */
  listBySubscription is ArmListBySubscription<DiskPool>;

  /**
   * The operation to start a Disk Pool. This start operation can take 10 minutes to complete. This is expected service behavior.
   */
  start is ArmResourceActionAsync<
    DiskPool,
    void,
    void,
    BaseParameters<DiskPool>,
    ArmAsyncOperationHeader
  >;

  /**
   * Shuts down the Disk Pool and releases the compute resources. You are not billed for the compute resources that this Disk Pool uses. This operation can take 10 minutes to complete. This is expected service behavior.
   */
  deallocate is ArmResourceActionAsync<
    DiskPool,
    void,
    void,
    BaseParameters<DiskPool>,
    ArmAsyncOperationHeader
  >;

  /**
   * Upgrade replaces the underlying virtual machine hosts one at a time. This operation can take 10-15 minutes to complete. This is expected service behavior.
   */
  upgrade is ArmResourceActionAsync<
    DiskPool,
    void,
    void,
    BaseParameters<DiskPool>,
    ArmAsyncOperationHeader
  >;

  /**
   * Gets the network endpoints of all outbound dependencies of a Disk Pool
   */
  // FIXME: DiskPools_ListOutboundNetworkDependenciesEndpoints could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StoragePool/diskPools/{diskPoolName}/outboundNetworkDependenciesEndpoints")
  @get
  listOutboundNetworkDependenciesEndpoints is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;

      /**
       * The name of the resource group. The name is case insensitive.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._]*[0-9A-Za-z]$")
      @path
      resourceGroupName: string;

      /**
       * The name of the Disk Pool.
       */
      @path
      diskPoolName: string;
    },
    OutboundEnvironmentEndpointList
  >;
}

@@projectedName(DiskPools.createOrUpdate::parameters.resource,
  "json",
  "diskPoolCreatePayload"
);
@@extension(DiskPools.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "diskPoolCreatePayload"
);
@@doc(DiskPools.createOrUpdate::parameters.resource,
  "Request payload for Disk Pool create operation"
);
@@projectedName(DiskPools.update::parameters.properties,
  "json",
  "diskPoolUpdatePayload"
);
@@extension(DiskPools.update::parameters.properties,
  "x-ms-client-name",
  "diskPoolUpdatePayload"
);
@@doc(DiskPools.update::parameters.properties,
  "Request payload for Disk Pool update operation."
);
