import "@typespec/versioning";
import "../../Common/Enums/Enums.tsp";

using TypeSpec.Versioning;

namespace Microsoft.Migrate;

@doc("Request body for the generateWavePlan action.")
@added(ApiVersions.v2025_12_01_preview)
model GenerateWavePlanRequest {
  @doc("ARM Id of the assessment for which the wave plan report is to be generated. Required from API version 2026-06-01-preview onwards.")
  assessmentArmId?: string;

  @doc("Migration path for which the wave plan report is to be generated. Required from API version 2026-06-01-preview onwards. Allowed values include PaaSPreferred, PaaSCentric, IaaSCentric, RecommendedPath, AzureVM, Avs, SqlDatabase, SqlMI, AzureSQLVM, AzureAppService, AzureAppServiceContainer, AKS, Modernize, LiftAndShift.")
  migrationPath?: string;
}

@doc("Response body for the generateWavePlan action.")
@added(ApiVersions.v2025_12_01_preview)
model GenerateWavePlanResponse {
  @doc("Time-bound SAS URL to the wave-plan artifact. Expires at expirationTime; never persisted on the wave-plan document.")
  @visibility(Lifecycle.Read)
  sasUri: string;

  @doc("UTC instant after which sasUri ceases to be valid.")
  @visibility(Lifecycle.Read)
  expirationTime: utcDateTime;

  @added(ApiVersions.v2026_06_01_preview)
  @doc("Server-allocated friendly identifier for the wave plan. Output-only.")
  @visibility(Lifecycle.Read)
  wavePlanName: string;

  @added(ApiVersions.v2026_06_01_preview)
  @doc("The status of the last operation on the wave plan.")
  @visibility(Lifecycle.Read)
  provisioningState: ProvisioningState;

  @added(ApiVersions.v2026_06_01_preview)
  @doc("How the wave plan was produced. Always SystemGenerated for plans produced by generateWavePlan.")
  @visibility(Lifecycle.Read)
  planSource: PlanSource;

  @added(ApiVersions.v2026_06_01_preview)
  @doc("ARM Id of the source assessment the wave plan was generated from. Echoed from the request.")
  @visibility(Lifecycle.Read)
  assessmentArmId: string;

  @added(ApiVersions.v2026_06_01_preview)
  @doc("Migration path the wave plan was generated for. Echoed from the request. Allowed values include PaaSPreferred, PaaSCentric, IaaSCentric, RecommendedPath, AzureVM, Avs, SqlDatabase, SqlMI, AzureSQLVM, AzureAppService, AzureAppServiceContainer, AKS, Modernize, LiftAndShift.")
  @visibility(Lifecycle.Read)
  migrationPath?: string;
}
