import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.Core;
using TypeSpec.Versioning;

@armProviderNamespace("Microsoft.AzureStackHCI")
namespace Microsoft.AzureStackHCI;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state"
@doc("DevicePool details.")
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

  @doc("Update a devicePool")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<DevicePool, DevicePoolPatch>;

  @doc("List all device pools in a resource group.")
  listByResourceGroup is ArmResourceListByParent<DevicePool>;

  @doc("List all device pools in a subscription.")
  listBySubscription is ArmListBySubscription<DevicePool>;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "The final response has no content, so 204 is returned."
  @doc("Claiming devices of the pool.")
  claimDevices is ArmResourceActionNoContentAsync<
    DevicePool,
    ClaimDeviceRequest
  >;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "The final response has no content, so 204 is returned."
  @doc("Releasing devices of the pool.")
  releaseDevices is ArmResourceActionNoContentAsync<
    DevicePool,
    ReleaseDeviceRequest
  >;
}
