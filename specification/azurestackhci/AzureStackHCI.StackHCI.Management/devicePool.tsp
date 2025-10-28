import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.Core;

@armProviderNamespace("Microsoft.AzureStackHCI")
namespace Microsoft.AzureStackHCI;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state"
@doc("DevicePool details.")
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

@doc("Request for Add/Remove Devices to the pool.")
model ListOfDevicesRequest {
  @doc("List of resource ids of the devices to be modified")
  devices: Azure.Core.armResourceIdentifier[];
}

@doc("Request for claiming devices of the pool.")
model ClaimDeviceRequest {
  @doc("List of resource ids of the devices to be modified")
  devices: Azure.Core.armResourceIdentifier[];

  @doc("Unique ID of the group to which the device belongs.")
  claimedBy?: string;
}

@doc("Request for releasing devices of the pool.")
model ReleaseDeviceRequest {
  @doc("List of resource ids of the devices to be modified")
  devices: Azure.Core.armResourceIdentifier[];
}

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

  @doc("operation status details for device pool.")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  operationDetails?: OperationDetail[];
}

@doc("Properties for patching Device Pool.")
model DevicePoolPatch {
  ...Azure.ResourceManager.Foundations.ArmTagsProperty;
  ...Azure.ResourceManager.ManagedServiceIdentityProperty;
}

@doc("Device details.")
model DeviceDetail {
  @doc("Resource Id of the device.")
  deviceResourceId?: Azure.Core.armResourceIdentifier;

  @doc("Unique ID of the group to which the device belongs.")
  @visibility(Lifecycle.Read)
  claimedBy?: string;
}
