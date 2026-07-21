import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Migrate;

@doc("A wave selection item with name and optional display name.")
@added(ApiVersions.v2026_06_01_preview)
model WaveSelectionItem {
  @doc("The ARM-compliant wave resource name used to create the wave.")
  waveName: string;

  @doc("Optional friendly name used during wave creation.")
  waveDisplayName?: string;
}

@doc("Request body for creating waves from a wave plan.")
@added(ApiVersions.v2026_06_01_preview)
model CreateWavesFromPlanRequest {
  @doc("The assessment ARM ID to capture migration preference, saving and scope.")
  assessmentArmId: string;

  @doc("The migration path preference.")
  migrationPath: string;

  @doc("The wave selection list. If null or empty, all waves from the wave plan will be included.")
  @identifiers(#["waveName"])
  waveSelection?: WaveSelectionItem[];
}

@doc("Response for the create waves from plan operation.")
@added(ApiVersions.v2026_06_01_preview)
model CreateWavesFromPlanResponse {
  @doc("The total number of waves in the wave plan.")
  @visibility(Lifecycle.Read)
  totalWaves: int32;

  @doc("The count of successfully created waves.")
  @visibility(Lifecycle.Read)
  succeededWaves: int32;

  @doc("The count of failed wave creations.")
  @visibility(Lifecycle.Read)
  failedWaves: int32;

  @doc("The count of skipped waves.")
  @visibility(Lifecycle.Read)
  skippedWaves: int32;

  @doc("The read-only SAS URI for the exported error CSV.")
  @visibility(Lifecycle.Read)
  sasUri?: string;

  @doc("The expiry timestamp (UTC) for the error CSV SAS URI.")
  @visibility(Lifecycle.Read)
  expirationTime?: utcDateTime;
}
