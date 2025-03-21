import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./provisioningState.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.DeviceRegistry;

@added(Versions.v2024_10_01_preview)
@doc("Defines the device base properties.")
model DeviceBaseProperties {
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

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record"
  @doc("A set of key-value pairs that contain custom attributes set by the customer.")
  attributes?: Record<unknown>;

  @doc("Provisioning state of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" ""
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" ""
@added(Versions.v2024_10_01_preview)
@doc("Defines the device properties.")
model NamespaceDeviceProperties extends DeviceBaseProperties {
  @doc("Property bag containing the device's unassigned and assigned endpoints.")
  endpoints?: MessagingEndpoints;
}
