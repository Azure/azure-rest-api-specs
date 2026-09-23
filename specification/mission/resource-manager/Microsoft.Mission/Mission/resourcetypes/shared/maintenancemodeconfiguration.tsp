import "@typespec/versioning";
import "./principal.tsp";

using TypeSpec.Versioning;

@doc("Microsoft Mission Resource Provider management API.")
namespace Microsoft.Mission;

@added(Microsoft.Mission.Versions.v2026_05_01_preview)
@doc("Maintenance Mode Configuration")
union MaintenanceModeConfiguration {
  string,

  @doc("MaintenanceModeConfiguration On")
  On: "On",

  @doc("MaintenanceModeConfiguration CanNotDelete")
  CanNotDelete: "CanNotDelete",

  @doc("MaintenanceModeConfiguration Off")
  Off: "Off",

  @doc("MaintenanceModeConfiguration General")
  General: "General",

  @doc("MaintenanceModeConfiguration Advanced")
  Advanced: "Advanced",
}

@added(Microsoft.Mission.Versions.v2026_05_01_preview)
@doc("Maintenance Mode Justification")
union MaintenanceModeJustification {
  string,

  @doc("MaintenanceModeJustification Networking")
  Networking: "Networking",

  @doc("MaintenanceModeJustification Governance")
  Governance: "Governance",

  @doc("MaintenanceModeJustification Off")
  Off: "Off",
}

@doc("Maintenance Mode")
model MaintenanceModeConfigurationModel {
  #suppress "@azure-tools/typespec-azure-core/no-unnamed-types" "Backwards compatibility - Existing union"
  @typeChangedFrom(
    Microsoft.Mission.Versions.v2026_05_01_preview,
    "On" | "CanNotDelete" | "Off" | "General" | "Advanced" | string
  )
  @doc("Current mode of Maintenance Mode Configuration")
  mode: MaintenanceModeConfiguration = MaintenanceModeConfiguration.Off;

  @doc("The user, group or service principal object affected by Maintenance Mode")
  principals?: Principal[] = #[];

  #suppress "@azure-tools/typespec-azure-core/no-unnamed-types" "Backwards compatibility - Existing union"
  @typeChangedFrom(
    Microsoft.Mission.Versions.v2026_05_01_preview,
    "Networking" | "Governance" | "Off" | string
  )
  @doc("Justification for entering or exiting Maintenance Mode")
  justification?: MaintenanceModeJustification = MaintenanceModeJustification.Off;
}

@doc("Maintenance Mode Patch Model")
model MaintenanceModeConfigurationPatchModel
  is UpdateableProperties<OmitDefaults<MaintenanceModeConfigurationModel>>;
