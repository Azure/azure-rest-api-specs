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

@doc("An device group resource belonging to a product resource.")
@parentResource(Product)
model DeviceGroup is ProxyResource<DeviceGroupProperties> {
  @doc("Name of device group.")
  @pattern("^[A-Za-z0-9]{1,2}$|^[A-Za-z0-9][A-Za-z0-9\\s]{1,48}[A-Za-z0-9]$|^\\.default$|^\\.unassigned$")
  @key("deviceGroupName")
  @path
  @segment("deviceGroups")
  name: string;
}

interface ProxyResourceOperationsDeviceGroups<
  TResource extends ArmResource,
  TListParameters extends {} = {}
> {
  @doc("List DeviceGroup resources by Product. '.default' and '.unassigned' are system defined values and cannot be used for product name.")
  list is ArmResourceListByParent<
    TResource,
    TListParameters & BaseParameters<TResource>
  >;
  @doc("Get a DeviceGroup. '.default' and '.unassigned' are system defined values and cannot be used for product or device group name.")
  get is ArmResourceRead<DeviceGroup>;
  @doc("Create a DeviceGroup. '.default' and '.unassigned' are system defined values and cannot be used for product or device group name.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<DeviceGroup>;
  @doc("Delete a DeviceGroup. '.default' and '.unassigned' are system defined values and cannot be used for product or device group name.")
  delete is ArmResourceDeleteAsync<DeviceGroup>;
  @doc("Update a DeviceGroup. '.default' and '.unassigned' are system defined values and cannot be used for product or device group name.")
  update is ArmResourcePatchAsync<DeviceGroup, DeviceGroupProperties>;
}

@armResourceOperations
interface DeviceGroups
  extends ProxyResourceOperationsDeviceGroups<
      DeviceGroup,
      ListQueryParameters
    > {
  @doc("Counts devices in device group. '.default' and '.unassigned' are system defined values and cannot be used for product or device group name.")
  @removed(Versions.v2024_04_01)
  @autoRoute
  @renamedFrom(Versions.v2024_04_01, "countDevices")
  @armResourceAction(DeviceGroup)
  @action("countDevices")
  @post
  deprecatedCountDevices(
    ...ResourceInstanceParameters<DeviceGroup>,
  ): ArmResponse<CountDeviceResponse> | ErrorResponse;

  #suppress "@azure-tools/typespec-providerhub/non-breaking-versioning" "preview api"
  @doc("Counts devices in device group. '.default' and '.unassigned' are system defined values and cannot be used for product or device group name.")
  @added(Versions.v2024_04_01)
  @autoRoute
  @sharedRoute
  @armResourceAction(DeviceGroup)
  @post
  countDevices(
    ...ResourceInstanceParameters<DeviceGroup>,
  ): ArmResponse<CountDevicesResponse> | ErrorResponse;

  @autoRoute
  @armResourceAction(DeviceGroup)
  @action("claimDevices")
  @removed(Versions.v2024_04_01)
  @renamedFrom(Versions.v2024_04_01, "claimDevices")
  @doc("Bulk claims the devices. Use '.unassigned' or '.default' for the device group and product names when bulk claiming devices to a catalog only.")
  @extension("x-ms-long-running-operation", true)
  @extension(
    "x-ms-long-running-operation-options",
    {
      `final-state-via`: "location",
    }
  )
  @post
  deprecatedClaimDevices(
    ...ResourceInstanceParameters<DeviceGroup>,

    @doc("Bulk claim devices request body.")
    @body
    claimDevicesRequest: ClaimDevicesRequest,
  ): ArmAcceptedResponse | ErrorResponse;

  #suppress "@azure-tools/typespec-providerhub/non-breaking-versioning" "preview api"
  @autoRoute
  @sharedRoute
  @added(Versions.v2024_04_01)
  @armResourceAction(DeviceGroup)
  @doc("Bulk claims the devices. Use '.unassigned' or '.default' for the device group and product names when bulk claiming devices to a catalog only.")
  @extension("x-ms-long-running-operation", true)
  @extension(
    "x-ms-long-running-operation-options",
    {
      `final-state-via`: "location",
    }
  )
  @post
  claimDevices(
    ...ResourceInstanceParameters<DeviceGroup>,

    @doc("Bulk claim devices request body.")
    @body
    claimDevicesRequest: ClaimDevicesRequest,
  ): ArmAcceptedLroResponse | ErrorResponse;
}

@doc("The properties of deviceGroup")
model DeviceGroupProperties {
  @doc("Description of the device group.")
  description?: string;

  @doc("Operating system feed type of the device group.")
  osFeedType?: OSFeedType;

  @doc("Update policy of the device group.")
  updatePolicy?: UpdatePolicy;

  @doc("Flag to define if the user allows for crash dump collection.")
  allowCrashDumpsCollection?: AllowCrashDumpCollection;

  @doc("Regional data boundary for the device group.")
  regionalDataBoundary?: RegionalDataBoundary;

  @visibility("read")
  @doc("Deployment status for the device group.")
  hasDeployment?: boolean;

  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
}

@doc("OS feed type values.")
enum OSFeedType {
  /** Retail OS feed type. */
  Retail,

  /** Retail evaluation OS feed type. */
  RetailEval,
}

@doc("Update policy values.")
enum UpdatePolicy {
  /** Update all policy. */
  UpdateAll,

  /** No update for 3rd party app policy. */
  No3rdPartyAppUpdates,
}

// Device group models

@doc("Request to the action call to bulk claim devices.")
model ClaimDevicesRequest {
  @doc("Device identifiers of the devices to be claimed.")
  deviceIdentifiers: string[];
}
