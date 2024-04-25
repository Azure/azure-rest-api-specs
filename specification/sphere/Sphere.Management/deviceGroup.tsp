import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./product.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

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
  createOrUpdate is ArmResourceCreateOrReplaceAsync<DeviceGroup>;

  /**
   * Update a DeviceGroup. '.default' and '.unassigned' are system defined values and cannot be used for product or device group name.
   */
  @parameterVisibility("read")
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
      ...BaseParameters<DeviceGroup>;
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
@@encodedName(DeviceGroups.claimDevices::parameters.body,
  "application/json",
  "claimDevicesRequest"
);
@@extension(DeviceGroups.claimDevices::parameters.body,
  "x-ms-client-name",
  "claimDevicesRequest"
);
