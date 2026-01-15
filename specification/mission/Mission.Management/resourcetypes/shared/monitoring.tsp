using Azure.ResourceManager;

@doc("Microsoft Mission Resource Provider management API.")
namespace Microsoft.Mission;

@doc("List of destination types for monitoring logs")
union MonitoringDestinationType {
  string,

  @doc("MonitoringDestinationType Type CommunityWorkspace")
  CommunityWorkspace: "CommunityWorkspace",

  @doc("MonitoringDestinationType Type EnclaveWorkspace")
  EnclaveWorkspace: "EnclaveWorkspace",

  @doc("MonitoringDestinationType Type CustomWorkspace")
  CustomWorkspace: "CustomWorkspace",
}

@doc("Monitoring Destination Patch Model")
model MonitoringDestinationPatchModel
  is UpdateableProperties<OmitDefaults<MonitoringDestination>>;

@doc("Monitoring destination configuration with multiple workspaces")
model MonitoringDestination {
  @doc("The type of monitoring workspace destination")
  destinationType: MonitoringDestinationType = MonitoringDestinationType.EnclaveWorkspace;

  @doc("Log analytics workspace resource ID for custom workspace")
  customWorkspaceResourceId?: LogAnalyticsResourceId;

  @doc("Custom name for diagnostic settings")
  diagnosticSettingsName?: string;
}

@doc("Monitoring Settings Patch Model")
model MonitoringSettingsPatchModel {
  @doc("Log Analytics workspace destinations where diagnostic logs will be stored.")
  @identifiers(#[])
  diagnosticDestinations?: MonitoringDestinationPatchModel[];

  @doc("Log Analytics workspace destination where virtual network flow logs will be stored.")
  flowLogDestination?: MonitoringDestinationPatchModel;
}

@doc("Monitoring Settings")
model MonitoringSettingsModel {
  @doc("Log Analytics workspace destinations where diagnostic logs will be stored.")
  @identifiers(#[])
  diagnosticDestinations?: MonitoringDestination[];

  @doc("Log Analytics workspace destination where virtual network flow logs will be stored.")
  flowLogDestination?: MonitoringDestination;
}
