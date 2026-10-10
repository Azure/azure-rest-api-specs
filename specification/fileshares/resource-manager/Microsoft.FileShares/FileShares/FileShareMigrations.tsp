import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.FileShares;

@added(Versions.v2026_09_01)
@doc("Summary of the current migration state for the file share.")
model MigrationState {
  @visibility(Lifecycle.Read)
  @doc("Indicates whether a redundancy conversion is in progress for the file share.")
  redundancyConversionInProgress: boolean;
}

@added(Versions.v2026_09_01)
@doc("Parameters for starting a redundancy conversion.")
model StartRedundancyConversionRequest {
  @doc("Properties containing the redundancy conversion input.")
  properties: StartRedundancyConversionInput;
}

@added(Versions.v2026_09_01)
@doc("Input for starting a redundancy conversion.")
model StartRedundancyConversionInput {
  @doc("The requested target redundancy for the conversion.")
  targetRedundancy: Redundancy;
}

@added(Versions.v2026_09_01)
@doc("Status of the redundancy conversion.")
union RedundancyConversionStatus {
  string,

  @doc("The redundancy conversion has been submitted.")
  SubmittedForConversion: "SubmittedForConversion",

  @doc("The redundancy conversion is in progress.")
  InProgress: "InProgress",

  @doc("The redundancy conversion has completed.")
  Complete: "Complete",

  @doc("The redundancy conversion has failed.")
  Failed: "Failed",
}

@added(Versions.v2026_09_01)
@doc("Response containing the status and details of the current or most recent redundancy conversion.")
model RedundancyConversionStatusResponse {
  @doc("Properties containing the redundancy conversion status output.")
  properties: RedundancyConversionStatusOutput;
}

@added(Versions.v2026_09_01)
@doc("The status and details of the current or most recent redundancy conversion.")
model RedundancyConversionStatusOutput {
  @visibility(Lifecycle.Read)
  @doc("The target redundancy requested for the redundancy conversion.")
  targetRedundancy: Redundancy;

  @visibility(Lifecycle.Read)
  @doc("The current status of the redundancy conversion.")
  conversionStatus: RedundancyConversionStatus;

  @visibility(Lifecycle.Read)
  @doc("The reason the redundancy conversion failed.")
  conversionFailedReason?: string;

  @visibility(Lifecycle.Read)
  @doc("Detailed information about why the redundancy conversion failed.")
  conversionFailedDetailedReason?: string;
}
