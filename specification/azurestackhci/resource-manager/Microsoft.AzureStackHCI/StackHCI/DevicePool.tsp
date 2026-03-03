import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "@typespec/http";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.Versioning;

namespace Microsoft.AzureStackHCI;

/**
 * DevicePool details.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state"
@added(Versions.v2026_03_01_preview)
model DevicePool
  is Azure.ResourceManager.TrackedResource<DevicePoolProperties> {
  ...ResourceNameParameter<
    Resource = DevicePool,
    KeyName = "devicePoolName",
    SegmentName = "devicePools",
    NamePattern = "^[a-zA-Z0-9-_]{3,63}$"
  >;
  ...ManagedServiceIdentityProperty;
}

@added(Versions.v2026_03_01_preview)
@armResourceOperations
interface DevicePools {
  /**
   * Get a DevicePool
   */
  get is ArmResourceRead<DevicePool>;

  /**
   * Create a DevicePool
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<DevicePool>;

  /**
   * Delete a DevicePool
   */
  delete is ArmResourceDeleteWithoutOkAsync<DevicePool>;

  /**
   * Update a devicePool
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<DevicePool, DevicePoolPatch>;

  /**
   * List all device pools in a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<DevicePool>;

  /**
   * List all device pools in a subscription.
   */
  listBySubscription is ArmListBySubscription<DevicePool>;

  /**
   * Claiming devices of the pool.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "The final response has no content, so 204 is returned."
  claimDevices is ArmResourceActionNoContentAsync<
    DevicePool,
    ClaimDeviceRequest
  >;

  /**
   * Releasing devices of the pool.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "The final response has no content, so 204 is returned."
  releaseDevices is ArmResourceActionNoContentAsync<
    DevicePool,
    ReleaseDeviceRequest
  >;
}
