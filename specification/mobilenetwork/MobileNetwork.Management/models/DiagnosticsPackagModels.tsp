import "../common/CommonModels.tsp";

namespace Microsoft.MobileNetwork;

@doc("The status of the diagnostics package collection.")
union DiagnosticsPackageStatus {
  @doc("Diagnostics package collection is not started.")
  NotStarted: "NotStarted",

  @doc("Diagnostics package collection is in-progress.")
  Collecting: "Collecting",

  @doc("Diagnostics package has been collected.")
  Collected: "Collected",

  @doc("Error on collecting diagnostics package.")
  Error: "Error",

  string,
}

@doc("Diagnostics package properties.")
model DiagnosticsPackagePropertiesFormat {
  @doc("The provisioning state of the diagnostics package resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("The status of the diagnostics package collection.")
  @visibility("read")
  status?: DiagnosticsPackageStatus;

  @doc("The reason for the current state of the diagnostics package collection.")
  @visibility("read")
  reason?: string;
}
