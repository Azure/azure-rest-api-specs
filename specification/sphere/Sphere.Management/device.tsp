import "@typespec/rest";
import "@typespec/openapi";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;

namespace Microsoft.AzureSphere;

// Devices
@doc("An device resource belonging to a device group resource.")
@parentResource(DeviceGroup)
model Device is ProxyResource<DeviceProperties> {
  @doc("Device name")
  @pattern("^[a-zA-Z0-9-]{128}$")
  @key("deviceName")
  @path
  @segment("devices")
  name: string;
}

interface ProxyResourceOperationsDevice<
  TResource extends ArmResource,
  TListParameters extends {} = {}
> {
  @doc("Get a Device. Use '.unassigned' or '.default' for the device group and product names when a device does not belong to a device group and product.")
  get is ArmResourceRead<Device>;
  @doc("Create a Device. Use '.unassigned' or '.default' for the device group and product names to claim a device to the catalog only.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<Device>;
  @doc("List Device resources by DeviceGroup. '.default' and '.unassigned' are system defined values and cannot be used for product or device group name.")
  list is ArmResourceListByParent<
    TResource,
    TListParameters & BaseParameters<TResource>
  >;
  delete is ArmResourceDeleteAsync<Device>;
  @doc("Update a Device. Use '.unassigned' or '.default' for the device group and product names to move a device to the catalog level.")
  update is CustomArmResourcePatchAsync<Device, DevicePatchProperties>;
}

@armResourceOperations
interface Devices extends ProxyResourceOperationsDevice<Device> {
  @autoRoute
  @removed(Versions.v2024_04_01)
  @renamedFrom(Versions.v2024_04_01, "generateCapabilityImage")
  @armResourceAction(Device)
  @action("generateCapabilityImage")
  @post
  @doc("Generates the capability image for the device. Use '.unassigned' or '.default' for the device group and product names to generate the image for a device that does not belong to a specific device group and product.")
  @extension("x-ms-long-running-operation", true)
  @extension(
    "x-ms-long-running-operation-options",
    {
      `final-state-via`: "location",
    }
  )
  deprecatedGenerateCapabilityImage(
    ...ResourceInstanceParameters<Device>,

    @doc("Generate capability image request body.")
    @body
    generateDeviceCapabilityRequest: GenerateCapabilityImageRequest,
  ): ArmResponse<SignedCapabilityImageResponse> | ArmAcceptedResponse | ErrorResponse;

  #suppress "@azure-tools/typespec-providerhub/non-breaking-versioning" "preview api"
  @autoRoute
  @sharedRoute
  @added(Versions.v2024_04_01)
  @armResourceAction(Device)
  @post
  @doc("Generates the capability image for the device. Use '.unassigned' or '.default' for the device group and product names to generate the image for a device that does not belong to a specific device group and product.")
  @extension("x-ms-long-running-operation", true)
  @extension(
    "x-ms-long-running-operation-options",
    {
      `final-state-via`: "location",
    }
  )
  generateCapabilityImage(
    ...ResourceInstanceParameters<Device>,

    @doc("Generate capability image request body.")
    @body
    generateDeviceCapabilityRequest: GenerateCapabilityImageRequest,
  ): ArmResponse<SignedCapabilityImageResponse> | ArmAcceptedLroResponse | ErrorResponse;
}

@doc("The properties of device")
model DeviceProperties {
  @doc("Device ID")
  @visibility("create", "read")
  deviceId?: string;

  @doc("SKU of the chip")
  @visibility("read")
  chipSku?: string;

  @doc("OS version available for installation when update requested")
  @visibility("read")
  lastAvailableOsVersion?: string;

  @doc("OS version running on device when update requested")
  @visibility("read")
  lastInstalledOsVersion?: string;

  @doc("Time when update requested and new OS version available")
  @visibility("read")
  lastOsUpdateUtc?: utcDateTime;

  @doc("Time when update was last requested")
  @visibility("read")
  lastUpdateRequestUtc?: utcDateTime;

  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
}

// Device models
@doc("Request of the action to create a signed device capability image")
model GenerateCapabilityImageRequest {
  @doc("List of capabilities to create")
  capabilities: CapabilityType[];
}

@doc("Signed device capability image response")
model SignedCapabilityImageResponse {
  @doc("The signed device capability image as a UTF-8 encoded base 64 string.")
  @visibility("read")
  image?: string;
}

@doc("Capability image type")
enum CapabilityType {
  /** Application development capability */
  ApplicationDevelopment,

  /** Field servicing capability */
  FieldServicing,
}

@doc("The properties of device patch")
model DevicePatchProperties {
  @doc("Device group id")
  deviceGroupId: string;
}
