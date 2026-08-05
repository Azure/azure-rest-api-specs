import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./common/provisioningState.tsp";
import "./registryDevices.tsp";
import "../common/deviceAttributeTypes.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.DeviceRegistry;

// ──────────────────────────────────────────────
// Device attribute resource (control-plane proxy resource)
// The discriminated property models (`DeviceAttributeProperties` and its
// `reportedBy` subtypes) and the Azure Device Update payload models are
// defined in specification/deviceregistry/common/deviceAttributeTypes.tsp.
// ──────────────────────────────────────────────

@added(Versions.v2026_11_02_preview)
@parentResource(RegistryDevice)
@doc("""
  A device attribute resource stores cloud-side metadata for a device, such as software versions reported
  by Azure Device Update or user-defined device attributes used to select the devices during management
  workflows. It is separate from live device telemetry.
  """)
model RegistryDeviceAttribute is ProxyResource<DeviceAttributeProperties> {
  @doc("The name of the device attribute.")
  @key("attributeName")
  @segment("attributes")
  @pattern("^[0-9a-zA-Z][a-zA-Z0-9-]*$")
  @path
  @minLength(3)
  @maxLength(63)
  name: string;
}

// Version-gate the shared device attribute types (defined in common) for the control-plane.
@@added(DeviceAttributeReportedType, Versions.v2026_11_02_preview);
@@added(DeviceAttributeProperties, Versions.v2026_11_02_preview);
@@added(UpdateDeviceAttributeProperties, Versions.v2026_11_02_preview);
@@added(UserDeviceAttributeProperties, Versions.v2026_11_02_preview);
@@added(DeviceUpdateId, Versions.v2026_11_02_preview);
@@added(AgentInfo, Versions.v2026_11_02_preview);
@@added(UpdateJobInfo, Versions.v2026_11_02_preview);
@@added(UpdateJobState, Versions.v2026_11_02_preview);

@added(Versions.v2026_11_02_preview)
@armResourceOperations
interface RegistryDeviceAttributes {
  get is ArmResourceRead<RegistryDeviceAttribute>;
  createOrReplace is ArmResourceCreateOrReplaceSync<RegistryDeviceAttribute>;
  delete is ArmResourceDeleteSync<RegistryDeviceAttribute>;
  listByDevice is ArmResourceListByParent<RegistryDeviceAttribute>;
}
