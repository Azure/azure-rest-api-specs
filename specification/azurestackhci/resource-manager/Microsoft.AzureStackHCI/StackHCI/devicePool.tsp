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

  @doc("Add Devices to the pool.")
  addDevices is ArmResourceActionNoResponseContentAsync<
    DevicePool,
    ListOfDevicesRequest
  >;

  @doc("Remove Devices to the pool.")
  removeDevices is ArmResourceActionNoResponseContentAsync<
    DevicePool,
    ListOfDevicesRequest
  >;

  @doc("Claiming devices of the pool.")
  claimDevices is ArmResourceActionNoResponseContentAsync<
    DevicePool,
    ClaimDeviceRequest
  >;

  @doc("Releasing devices of the pool.")
  releaseDevices is ArmResourceActionNoResponseContentAsync<
    DevicePool,
    ReleaseDeviceRequest
  >;
}

@added(Versions.v2026_03_01_preview)
@doc("Request for Add/Remove Devices to the pool.")
model ListOfDevicesRequest {
  @doc("List of resource ids of the devices to be modified")
  devices: Azure.Core.armResourceIdentifier[];
}

@added(Versions.v2026_03_01_preview)
@doc("Request for claiming devices of the pool.")
model ClaimDeviceRequest {
  @doc("List of resource ids of the devices to be modified")
  devices: Azure.Core.armResourceIdentifier[];

  @doc("Resource Id of group device belongs to.")
  claimedBy?: string;
}

@added(Versions.v2026_03_01_preview)
@doc("Request for releasing devices of the pool.")
model ReleaseDeviceRequest {
  @doc("List of resource ids of the devices to be modified")
  devices: Azure.Core.armResourceIdentifier[];
}

@added(Versions.v2026_03_01_preview)
@doc("Properties for device pool.")
model DevicePoolProperties {
  @doc("The provisioning state of a resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("Unique, immutable resource id.")
  @visibility(Lifecycle.Read)
  cloudId?: string;

  @doc("List of machines in device pool.")
  @Azure.ResourceManager.identifiers(#[])
  devices?: DeviceDetail[];

  @doc("Custom Location Resource Id for the pool")
  @visibility(Lifecycle.Read)
  customLocationResourceId?: Azure.Core.armResourceIdentifier;

  @doc("Custom Location Name for the pool, default: <DevicePoolName>-CL")
  customLocationName?: string;

  @doc("Managed resource group name for the pool")
  managedResourceGroup?: string;

  @doc("operation status details for device pool.")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  operationDetails?: OperationDetail[];
}

@added(Versions.v2026_03_01_preview)
@doc("Properties for patching Device Pool.")
model DevicePoolPatch {
  ...Azure.ResourceManager.Foundations.ArmTagsProperty;
  ...Azure.ResourceManager.ManagedServiceIdentityProperty;
}

@added(Versions.v2026_03_01_preview)
@doc("Device details.")
model DeviceDetail {
  @doc("Resource Id of the device.")
  deviceResourceId?: Azure.Core.armResourceIdentifier;

  @doc("Resource Id of group device belongs to.")
  @visibility(Lifecycle.Read)
  claimedBy?: string;
}
