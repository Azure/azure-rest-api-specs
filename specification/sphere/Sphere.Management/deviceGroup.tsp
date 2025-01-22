import "@azure-tools/typespec-client-generator-core";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.ClientGenerator.Core;

namespace Microsoft.AzureSphere;
/**
 * An device group resource belonging to a product resource.
 */
@parentResource(Product)
model DeviceGroup is ProxyResource<DeviceGroupProperties> {
  /**
   * Name of device group.
   */
  @pattern("^[A-Za-z0-9]{1,2}$|^[A-Za-z0-9][A-Za-z0-9\\s]{1,48}[A-Za-z0-9]$|^\\.default$|^\\.unassigned$")
  @path
  @key("deviceGroupName")
  @segment("deviceGroups")
  @visibility("read")
  name: string;
}

@armResourceOperations
interface DeviceGroups {
  /**
   * Get a DeviceGroup. '.default' and '.unassigned' are system defined values and cannot be used for product or device group name.
   */
  get is ArmResourceRead<DeviceGroup>;

  /**
   * Create a DeviceGroup. '.default' and '.unassigned' are system defined values and cannot be used for product or device group name.
   */
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE ON NEXT UPDATE"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    DeviceGroup,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Update a DeviceGroup. '.default' and '.unassigned' are system defined values and cannot be used for product or device group name.
   */
  @parameterVisibility
  update is ArmCustomPatchAsync<DeviceGroup, DeviceGroupUpdate>;

  /**
   * Delete a DeviceGroup. '.default' and '.unassigned' are system defined values and cannot be used for product or device group name.
   */
  #suppress "deprecated" "For backward compatible"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatible"
  delete is ArmResourceDeleteAsync<DeviceGroup>;

  /**
   * List DeviceGroup resources by Product. '.default' and '.unassigned' are system defined values and cannot be used for product name.
   */
  listByProduct is ArmResourceListByParent<
    DeviceGroup,
    {
      ...Azure.ResourceManager.Foundations.BaseParameters<DeviceGroup>;
      ...CustomFilterQueryParameter;
      ...CustomTopQueryParameter;
      ...CustomSkipQueryParameter;
      ...CustomMaxPageSizeQueryParameter;
    }
  >;

  /**
   * Bulk claims the devices. Use '.unassigned' or '.default' for the device group and product names when bulk claiming devices to a catalog only.
   */
  claimDevices is ArmResourceActionNoResponseContentAsync<
    DeviceGroup,
    ClaimDevicesRequest
  >;

  /**
   * Counts devices in device group. '.default' and '.unassigned' are system defined values and cannot be used for product or device group name.
   */
  countDevices is ArmResourceActionSync<
    DeviceGroup,
    void,
    CountDevicesResponse
  >;
}

@@doc(DeviceGroups.claimDevices::parameters.body,
  "Bulk claim devices request body."
);
@@clientName(DeviceGroups.claimDevices::parameters.body, "claimDevicesRequest");
