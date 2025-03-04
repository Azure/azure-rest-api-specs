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

@removed(Versions.v2024_10_01_preview)
@doc("Device Model as ARM resource.")
model Device is TrackedResource<DeviceProperties> {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-name-pattern" "legacy"
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
  @visibility(Lifecycle.Read)
  etag?: string;
}

@removed(Versions.v2024_10_01_preview)
@doc("Defines the device properties.")
model DeviceProperties {
  @doc("Gets a unique identifier for this resource.")
  @visibility(Lifecycle.Read)
  uuid?: string;

  @doc("Indicates if the resource and identity are enabled or not. A disabled device cannot authenticate with Microsoft Entra ID.")
  enabled?: boolean = true;

  @doc("Gets the device Id provided by customer.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  externalDeviceId?: string;

  @doc("Device Template Id used to create a device.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  deviceTemplateId?: string;

  @doc("The Microsoft Entra ID group the device is a member of.")
  deviceGroupId?: string;

  @doc("Hardware manufacturer name.")
  @visibility(Lifecycle.Read)
  manufacturer?: string;

  @doc("Hardware model name.")
  @visibility(Lifecycle.Read)
  `model`?: string;

  @doc("operating system name.")
  @visibility(Lifecycle.Read)
  operatingSystem?: string;

  @doc("operating system version.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  operatingSystemVersion?: string;

  @doc("Identity for the resource.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  identity?: DeviceIdentity;

  @doc("Property bag containing the device's unassigned and assigned endpoints.")
  endpoints?: DeviceEndpoints;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record"
  @doc("A set of key-value pairs that contain custom attributes set by the customer.")
  attributes?: Record<unknown>;

  @doc("Provisioning state of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@doc("The backing Microsoft Entra ID for the device used for authentication to other services.")
model DeviceIdentity {
  @doc("Principal id for the device resource.")
  @visibility(Lifecycle.Read)
  principalId?: string;

  @doc("Tenant id for the Microsoft Entra ID tenant.")
  @visibility(Lifecycle.Read)
  tenantId?: string;
}

@doc("Property bag containing the device's unassigned and assigned endpoints.")
model DeviceEndpoints {
  @doc("Actively used endpoints a device can use to connect to several services.")
  @Azure.ResourceManager.identifiers(#["type", "address"])
  assigned: Endpoint[];

  @doc("List of most recently removed endpoints.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @Azure.ResourceManager.identifiers(#["type", "address"])
  unassigned?: Endpoint[];
}

@doc("Connection endpoint url a device can use to connect to a service.")
model Endpoint {
  @doc("Type of connection endpoint.")
  type?: string;

  @doc("Fully qualified domain name.")
  address?: string;
}

@removed(Versions.v2024_10_01_preview)
@armResourceOperations
interface Devices {
  get is ArmResourceRead<Device>;
  createOrReplace is ArmResourceCreateOrReplaceAsync<Device>;
  update is ArmResourcePatchAsync<Device, DeviceProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<Device>;
  listByResourceGroup is ArmResourceListByParent<Device>;
  listBySubscription is ArmListBySubscription<Device>;
}
