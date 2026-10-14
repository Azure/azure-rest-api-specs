using Azure.ResourceManager;
using TypeSpec.Versioning;
using Azure.Core;

@doc("Microsoft Mission Resource Provider management API.")
namespace Microsoft.Mission;

@added(Microsoft.Mission.Versions.v2025_11_01_preview)
@doc("Specifies the designation of the dedicated hub.")
union Designation {
  string,

  @doc("Designation Type Pooled")
  Pooled: "Pooled",

  @doc("Designation Type Reserved")
  Reserved: "Reserved",
}

@added(Microsoft.Mission.Versions.v2025_11_01_preview)
@doc("Dedicated Hub Base Properties")
model DedicatedHubBaseModel {
  @doc("Virtual Hub Resource ID")
  @visibility(Lifecycle.Read)
  vHubResourceId?: VirtualHubResourceId;

  @doc("Firewall Resource ID")
  @visibility(Lifecycle.Read)
  firewallResourceId?: FirewallResourceId;

  @doc("Firewall Policy Resource ID")
  @visibility(Lifecycle.Read)
  firewallPolicyResourceId?: FirewallPolicyResourceId;

  @doc("Designation of hub resource allocation (Pooled or Reserved)")
  designation?: Designation;
}

@added(Microsoft.Mission.Versions.v2025_11_01_preview)
@doc("Describes the properties of a Dedicated Hub.")
model DedicatedHubProperties is DedicatedHubBaseModel {
  @doc("The status of the last operation.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@added(Microsoft.Mission.Versions.v2025_11_01_preview)
@doc("Dedicated Hub patchable Properties")
model DedicatedHubPatchProperties
  is UpdateableProperties<OmitDefaults<DedicatedHubBaseModel>>;

@added(Microsoft.Mission.Versions.v2025_11_01_preview)
@doc("Dedicated Hub Patch Resource")
model DedicatedHubPatchModel {
  @doc("The DedicatedHub resource.")
  properties?: DedicatedHubPatchProperties;

  ...Azure.ResourceManager.Foundations.ArmTagsProperty;
}
