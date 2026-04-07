import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./common/provisioningState.tsp";
import "./common/status.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.Core;

namespace Microsoft.DeviceRegistry;

@added(Versions.v2026_11_01_preview)
@parentResource(Namespace)
@doc("New device definition.")
model NewDevice is TrackedResource<NewDeviceProperties> {
  @doc("The name of the new device.")
  @key("newDeviceName")
  @segment("newDevices")
  @pattern("^[0-9a-zA-Z][a-zA-Z0-9-]*$")
  @path
  @minLength(3)
  @maxLength(63)
  name: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
  @doc("Resource Tag.")
  @visibility(Lifecycle.Read)
  etag?: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
  @doc("The extended location.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  extendedLocation?: ExtendedLocation;
}

@added(Versions.v2026_11_01_preview)
@doc("Defines the new device properties.")
model NewDeviceProperties {
  @doc("A unique identifier for the device.")
  @visibility(Lifecycle.Read)
  uuid?: string;

  @doc("Contains metadata about how this device resource was discovered or provisioned.")
  @visibility(Lifecycle.Read)
  origin?: NewDeviceOrigin;

  @doc("Whether a discovered or created device has been accepted for use.")
  accepted?: NewDeviceAcceptedStatus;

  @doc("Indicates if the resource is enabled or not.")
  enabled?: NewDeviceEnabledStatus;

  @doc("The Device ID provided by the customer. This is also used by IoT Hub to hold the IoT Hub device ID.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  externalDeviceId?: string;

  @doc("Device manufacturer.")
  manufacturer?: string;

  @doc("Device model.")
  `model`?: string;

  @doc("Device operating system.")
  operatingSystem?: string;

  @doc("Device operating system version.")
  operatingSystemVersion?: string;

  @doc("Policy used to issue device certificates.")
  policy?: NewDeviceCredentialPolicy;

  @doc("Provisioning state of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@added(Versions.v2026_11_01_preview)
@doc("Contains metadata about how this device resource was discovered or provisioned.")
model NewDeviceOrigin {
  @doc("The origin type.")
  type?: NewDeviceOriginType;

  @doc("The source identifier for the origin.")
  sourceId?: string;
}

@added(Versions.v2026_11_01_preview)
@doc("The type of origin for a device.")
union NewDeviceOriginType {
  string,

  @doc("The device was discovered or provisioned through Azure IoT Operations.")
  AIO: "AIO",

  @doc("The device was provisioned through Device Provisioning Service.")
  DPS: "DPS",

  @doc("The device was created through Azure Resource Manager.")
  ARM: "ARM",
}

@added(Versions.v2026_11_01_preview)
@doc("Indicates whether a device has been accepted for use.")
union NewDeviceAcceptedStatus {
  string,

  @doc("The device has been accepted.")
  Accepted: "Accepted",

  @doc("The device has not been accepted.")
  NotAccepted: "NotAccepted",
}

@added(Versions.v2026_11_01_preview)
@doc("Indicates if the resource is enabled or disabled.")
union NewDeviceEnabledStatus {
  string,

  @doc("The resource is enabled.")
  Enabled: "Enabled",

  @doc("The resource is disabled.")
  Disabled: "Disabled",
}

@added(Versions.v2026_11_01_preview)
@doc("Defines the policy used to issue device certificates.")
model NewDeviceCredentialPolicy {
  @doc("Resource Id of the Policy.")
  resourceId?: armResourceIdentifier<[
    {
      type: "Microsoft.DeviceRegistry/namespaces/credentials/policies";
    }
  ]>;
}

@added(Versions.v2026_11_01_preview)
@doc("Response for the get extended location sync status operation.")
model NewDeviceExtendedLocationSyncStatusResponse {
  @doc("The sync status of the cloud resource.")
  cloudResource?: NewDeviceSyncResourceStatus;

  @doc("The sync status of the extended location resource.")
  extendedLocationResource?: NewDeviceSyncResourceStatus;
}

@added(Versions.v2026_11_01_preview)
@doc("Sync status for a resource.")
model NewDeviceSyncResourceStatus {
  @doc("The version of the resource.")
  version?: int64;

  @doc("The last transition time of the resource.")
  lastTransitionTime?: utcDateTime;
}

@added(Versions.v2026_11_01_preview)
@doc("Response for the get endpoint status operation.")
model NewDeviceEndpointStatusResponse {
  @doc("The endpoint status information.")
  endpoints?: DeviceStatusEndpoints;
}

@added(Versions.v2026_11_01_preview)
@armResourceOperations
interface NewDevices {
  get is ArmResourceRead<NewDevice>;
  createOrReplace is ArmResourceCreateOrReplaceAsync<NewDevice>;
  update is ArmResourcePatchAsync<NewDevice, NewDeviceProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<NewDevice>;
  listByResourceGroup is ArmResourceListByParent<NewDevice>;

  @doc("Get the extended location sync status of the device.")
  getExtendedLocationSyncStatus is ArmResourceActionAsync<
    NewDevice,
    void,
    NewDeviceExtendedLocationSyncStatusResponse,
    LroHeaders = ArmAsyncOperationHeader &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  @doc("Get the endpoint status of the device.")
  getEndpointStatus is ArmResourceActionSync<
    NewDevice,
    void,
    NewDeviceEndpointStatusResponse
  >;
}
