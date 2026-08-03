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
@doc("Request body for the getWavePlans action.")
model GetWavePlansRequest {
  @doc("ARM Id of the source assessment. Required.")
  assessmentArmId: string;

  @doc("Optional migration path. When provided, restricts results to the supplied (assessmentArmId, migrationPath) combination; when omitted, returns wave plans across every migration path that has plans for the assessment. Allowed values include PaaSPreferred, PaaSCentric, IaaSCentric, RecommendedPath, AzureVM, Avs, SqlDatabase, SqlMI, AzureSQLVM, AzureAppService, AzureAppServiceContainer, AKS, Modernize, LiftAndShift.")
  migrationPath?: string;
}

@added(ApiVersions.v2026_06_01_preview)
@doc("Response body for the getWavePlans action.")
model GetWavePlansResponse {
  @doc("List of wave plan summary items. Returned in a single page; ordered by wavePlanVersion descending within each migration path.")
  @identifiers(#[])
  value: Array<WavePlanSummary>;
}

@added(ApiVersions.v2026_06_01_preview)
@doc("Summary metadata for a single wave plan returned by getWavePlans, plus a time-bound SAS URL to stream the wave-plan JSON.")
model WavePlanSummary {
  @doc("Server-allocated friendly identifier for the wave plan.")
  @visibility(Lifecycle.Read)
  wavePlanName: string;

  @doc("The status of the last operation on the wave plan.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("How the wave plan was produced.")
  @visibility(Lifecycle.Read)
  planSource: PlanSource;

  @doc("ARM Id of the source assessment.")
  @visibility(Lifecycle.Read)
  assessmentArmId: string;

  @doc("Migration path the wave plan was produced for. Allowed values include PaaSPreferred, PaaSCentric, IaaSCentric, RecommendedPath, AzureVM, Avs, SqlDatabase, SqlMI, AzureSQLVM, AzureAppService, AzureAppServiceContainer, AKS, Modernize, LiftAndShift.")
  @visibility(Lifecycle.Read)
  migrationPath: string;

  @doc("Time-bound SAS URL to the wave-plan JSON for this item. Minted on demand on every response; never persisted on the wave-plan document.")
  @visibility(Lifecycle.Read)
  sasUri: string;

  @doc("UTC instant after which sasUri ceases to be valid.")
  @visibility(Lifecycle.Read)
  expirationTime: utcDateTime;
}
