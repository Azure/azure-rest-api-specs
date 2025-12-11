import "./principal.tsp";

@doc("Microsoft Mission Resource Provider management API.")
namespace Microsoft.Mission;

@doc("Maintenance Mode")
model MaintenanceModeConfigurationModel {
  #suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "Backwards compatibility - Existing union"
  @doc("Current mode of Maintenance Mode Configuration")
  mode: "On" | "CanNotDelete" | "Off" | "General" | "Advanced" | string = "Off";

  @doc("The user, group or service principal object affected by Maintenance Mode")
  principals?: Principal[] = #[];

  #suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "Backwards compatibility - Existing union"
  @doc("Justification for entering or exiting Maintenance Mode")
  justification?: "Networking" | "Governance" | "Off" | string = "Off";
}

@doc("Maintenance Mode Patch Model")
model MaintenanceModeConfigurationPatchModel
  is UpdateableProperties<OmitDefaults<MaintenanceModeConfigurationModel>>;
