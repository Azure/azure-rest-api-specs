import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./registryDevices.tsp";
import "../common/deviceCapabilityTypes.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.DeviceRegistry;

// ──────────────────────────────────────────────
// Device capability resource (control-plane proxy resource)
// Shared types are defined in
// specification/deviceregistry/common/deviceCapabilityTypes.tsp.
// ──────────────────────────────────────────────

@added(Versions.v2026_11_02_preview)
@parentResource(RegistryDevice)
@doc("""
  A device capability resource represents the device's connection to a service such as IoT Hub
  or Device Update. It stores settings for the connection, including whether the service is
  enabled for the device and the authentication profile the device uses to communicate
  with the service.
  """)
model RegistryDeviceCapability is ProxyResource<DeviceCapabilityProperties> {
  @doc("""
    The name of the device capability. For \"IoT Hub\" device capabilities created through the
    Device Provisioning Service, this name corresponds to the IoT Hub endpoint name assigned in
    the Namespace resource.
    """)
  @key("capabilityName")
  @segment("capabilities")
  @pattern("^[0-9a-zA-Z][a-zA-Z0-9-]*$")
  @path
  @minLength(3)
  @maxLength(63)
  name: string;
}

@@added(DeviceCapabilityProperties, Versions.v2026_11_02_preview);
@@added(DeviceCapabilityEnablementState, Versions.v2026_11_02_preview);
@@added(IotHubDeviceCapabilityProperties, Versions.v2026_11_02_preview);
@@added(UpdateDeviceCapabilityProperties, Versions.v2026_11_02_preview);
@@added(CapabilityProvisioningState, Versions.v2026_11_02_preview);
@@added(CapabilityType, Versions.v2026_11_02_preview);

@added(Versions.v2026_11_02_preview)
@armResourceOperations
interface RegistryDeviceCapabilities {
  get is ArmResourceRead<RegistryDeviceCapability>;
  listByDevice is ArmResourceListByParent<RegistryDeviceCapability>;
}
