import "../common/CommonModels.tsp";

namespace Microsoft.MobileNetwork;

@doc("The status of the diagnostics package collection.")
enum DiagnosticsPackageStatus {
  @doc("Diagnostics package collection is not started.")
  NotStarted,

  @doc("Diagnostics package collection is in-progress.")
  Collecting,

  @doc("Diagnostics package has been collected.")
  Collected,

  @doc("Error on collecting diagnostics package.")
  Error,
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
