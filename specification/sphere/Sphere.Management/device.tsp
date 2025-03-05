using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.ClientGenerator.Core;

namespace Microsoft.AzureSphere;
/**
 * An device resource belonging to a device group resource.
 */
@parentResource(DeviceGroup)
model Device is ProxyResource<DeviceProperties> {
  /**
   * Device name
   */
  @pattern("^[a-zA-Z0-9-]{128}$")
  @path
  @key("deviceName")
  @segment("devices")
  @visibility("read")
  name: string;
}

@armResourceOperations
interface Devices {
  /**
   * Get a Device. Use '.unassigned' or '.default' for the device group and product names when a device does not belong to a device group and product.
   */
  get is ArmResourceRead<Device>;

  /**
   * Create a Device. Use '.unassigned' or '.default' for the device group and product names to claim a device to the catalog only.
   */
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE ON NEXT UPDATE"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Device,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Update a Device. Use '.unassigned' or '.default' for the device group and product names to move a device to the catalog level.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "Existing API"
  @parameterVisibility
  update is ArmCustomPatchAsync<
    Device,
    DeviceUpdate,
    LroHeaders = ArmLroLocationHeader<FinalResult = Device> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Delete a Device
   */
  #suppress "deprecated" "For backward compatible"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatible"
  delete is ArmResourceDeleteAsync<Device>;

  /**
   * List Device resources by DeviceGroup. '.default' and '.unassigned' are system defined values and cannot be used for product or device group name.
   */
  listByDeviceGroup is ArmResourceListByParent<Device>;

  /**
   * Generates the capability image for the device. Use '.unassigned' or '.default' for the device group and product names to generate the image for a device that does not belong to a specific device group and product.
   */
  generateCapabilityImage is ArmResourceActionAsync<
    Device,
    GenerateCapabilityImageRequest,
    SignedCapabilityImageResponse
  >;
}

@@doc(Devices.generateCapabilityImage::parameters.body,
  "Generate capability image request body."
);
@@clientName(Devices.generateCapabilityImage::parameters.body,
  "generateDeviceCapabilityRequest"
);
