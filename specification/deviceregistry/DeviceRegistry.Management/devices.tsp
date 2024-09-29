import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./common/provisioningState.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.DeviceRegistry;

@doc("Device Model as ARM resource.")
model Device is TrackedResource<DeviceProperties> {
  @doc("Name of the device.")
  @key("deviceName")
  @segment("devices")
  @path
  @minLength(3)
  @maxLength(64)
  name: string;

  // etag not included in TrackedResource
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
  @doc("Resource Tag.")
  @visibility("read")
  etag?: string;
}

@doc("Defines the device properties.")
model DeviceProperties {
  @doc("Gets a unique identifier for this resource.")
  @visibility("read")
  uuid?: string;

  @doc("Indicates if the resource and identity are enabled or not. A disabled device cannot authenticate with AAD.")
  enabled?: boolean = true;

  @doc("Gets the device Id provided by customer.")
  @visibility("read", "create")
  externalDeviceId?: string;

  @doc("Device Template Id used to create a device.")
  @visibility("read", "create")
  deviceTemplateId?: string;

  @doc("The AAD group the device is a member of.")
  deviceGroupId?: string;

  @doc("Hardware manufacturer name.")
  @visibility("read")
  manufacturer?: string;

  @doc("Hardware model name.")
  @visibility("read")
  `model`?: string;

  @doc("operating system name.")
  @visibility("read")
  operatingSystem?: string;

  @doc("operating system version.")
  @visibility("read", "create")
  operatingSystemVersion?: string;

  @doc("Identity for the resource.")
  @visibility("read", "create")
  identity?: DeviceIdentity;

  @doc("Property bag containing the device's unassigned and assigned endpoints.")
  endpoints?: DeviceEndpoints;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record"
  @doc("A set of key-value pairs that contain custom attributes set by the customer.")
  attributes?: Record<unknown>;

  @doc("Provisioning state of the resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("The backing AAD identity for the device used for authentication to other services.")
model DeviceIdentity {
  @doc("Principal id for the device resource.")
  @visibility("read")
  principalId?: string;

  @doc("Tenant id for the AAD tenant.")
  @visibility("read")
  tenantId?: string;
}

@doc("Property bag containing the device's unassigned and assigned endpoints.")
model DeviceEndpoints {
  @doc("Actively used endpoints a device can use to connect to several services.")
  @extension("x-ms-identifiers", ["type", "address"])
  assigned: Endpoint[];

  @doc("List of most recently removed endpoints.")
  @extension("x-ms-identifiers", ["type", "address"])
  @visibility("read", "create")
  unassigned?: Endpoint[];
}

@doc("Connection endpoint url a device can use to connect to a service.")
model Endpoint {
  @doc("Type of connection endpoint.")
  type?: string;

  @doc("Fully qualified domain name.")
  address?: string;
}

@armResourceOperations
interface Devices {
  get is ArmResourceRead<Device>;
  createOrReplace is ArmResourceCreateOrReplaceAsync<Device>;
  update is ArmResourcePatchAsync<Device, DeviceProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<Device>;
  listByResourceGroup is ArmResourceListByParent<Device>;
  listBySubscription is ArmListBySubscription<Device>;
}
