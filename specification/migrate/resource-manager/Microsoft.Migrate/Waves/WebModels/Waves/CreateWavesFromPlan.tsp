import "@typespec/versioning";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "../../Common/Enums/Enums.tsp";

using TypeSpec.Versioning;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Migrate;

@added(ApiVersions.v2026_06_01_preview)
@doc("Request body for the createWavesFromPlan action.")
model CreateWavesFromPlanRequest {
  @doc("ARM Id of the source assessment. Used together with migrationPath so the server can resolve the latest Active wave plan for the (assessmentArmId, migrationPath) tuple at LRO start.")
  assessmentArmId: string;

  @doc("Migration path of the wave plan to create waves from. Allowed values include PaaSPreferred, PaaSCentric, IaaSCentric, RecommendedPath, AzureVM, Avs, SqlDatabase, SqlMI, AzureSQLVM, AzureAppService, AzureAppServiceContainer, AKS, Modernize, LiftAndShift.")
  migrationPath: string;

  @doc("Optional subset of waves from the resolved plan to create, identified by waveName plus the desired waveDisplayName for each. When omitted, all waves in the resolved plan are created.")
  @identifiers(#["waveName"])
  waveSelection?: Array<WaveSelectionItem>;
}

@added(ApiVersions.v2026_06_01_preview)
@doc("Identifies a single wave from the resolved wave plan to create, together with the display name that should be applied to the resulting wave resource.")
model WaveSelectionItem {
  @doc("Name of the wave in the resolved wave plan to create. Must match a wave entry produced by the source plan.")
  waveName: string;

  @doc("Display name to assign to the wave resource that is created. Free-form, human-readable label surfaced in tooling.")
  waveDisplayName: string;
}

@added(ApiVersions.v2026_06_01_preview)
@doc("Response body for the createWavesFromPlan action. Top-level counters describe the outcome; when at least one wave failed, sasUri and expirationTime carry a pointer to a per-invocation outcome-report CSV. On all-success or all-skipped runs both fields are omitted.")
model CreateWavesFromPlanResponse {
  @doc("Total number of waves the operation attempted to create.")
  @visibility(Lifecycle.Read)
  totalWaves: int32;

  @doc("Number of waves that were created successfully.")
  @visibility(Lifecycle.Read)
  succeededWaves: int32;

  @doc("Number of waves that failed to create.")
  @visibility(Lifecycle.Read)
  failedWaves: int32;

  @doc("Number of waves that were skipped (for example, a wave with the same name already existed and the conflict policy was skip).")
  @visibility(Lifecycle.Read)
  skippedWaves: int32;

  @doc("Time-bound, read-only SAS URL to a per-invocation outcome-report CSV enumerating each failed wave with a failureReason and remediation column. Present only when failedWaves is greater than zero.")
  @visibility(Lifecycle.Read)
  sasUri?: string;

  @doc("UTC instant after which sasUri ceases to be valid. Present only when sasUri is present.")
  @visibility(Lifecycle.Read)
  expirationTime?: utcDateTime;
}
