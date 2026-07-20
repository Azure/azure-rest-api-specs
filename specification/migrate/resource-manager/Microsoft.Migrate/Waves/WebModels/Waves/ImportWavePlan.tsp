import "@typespec/versioning";
import "../../Common/Enums/Enums.tsp";

using TypeSpec.Versioning;

namespace Microsoft.Migrate;

@added(ApiVersions.v2026_06_01_preview)
@doc("Request body for the importWavePlan action.")
model ImportWavePlanRequest {
  @doc("ARM Id of the source assessment. Must belong to the same subscription, resource group, and migrate project as the request URL.")
  assessmentArmId: string;

  @doc("Migration path that the supplied wave plan applies to. Allowed values include PaaSPreferred, PaaSCentric, IaaSCentric, RecommendedPath, AzureVM, Avs, SqlDatabase, SqlMI, AzureSQLVM, AzureAppService, AzureAppServiceContainer, AKS, Modernize, LiftAndShift.")
  migrationPath: string;

  @doc("SAS-signed URL to the customer-uploaded CSV. The recommended way to obtain this URL is to call fetchSASUri, PUT the CSV payload to the URL it returns, then pass that same URL verbatim here. The URL is fetched once during import and is neither persisted on the resulting wave plan nor echoed back on read.")
  sasUri: string;
}

@added(ApiVersions.v2026_06_01_preview)
@doc("Response body for the importWavePlan action.")
model ImportWavePlanResponse {
  @doc("Server-allocated friendly identifier for the imported wave plan. Output-only.")
  @visibility(Lifecycle.Read)
  wavePlanName: string;

  @doc("The status of the last operation on the wave plan.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("How the wave plan was produced. Always Imported for plans produced by importWavePlan.")
  @visibility(Lifecycle.Read)
  planSource: PlanSource;

  @doc("ARM Id of the source assessment the wave plan was imported for. Echoed from the request.")
  @visibility(Lifecycle.Read)
  assessmentArmId: string;

  @doc("Migration path the wave plan was imported for. Echoed from the request. Allowed values include PaaSPreferred, PaaSCentric, IaaSCentric, RecommendedPath, AzureVM, Avs, SqlDatabase, SqlMI, AzureSQLVM, AzureAppService, AzureAppServiceContainer, AKS, Modernize, LiftAndShift.")
  @visibility(Lifecycle.Read)
  migrationPath: string;

  @doc("Time-bound SAS URL to the parsed wave-plan JSON. Expires at expirationTime; never persisted on the wave-plan document.")
  @visibility(Lifecycle.Read)
  sasUri: string;

  @doc("UTC instant after which sasUri ceases to be valid.")
  @visibility(Lifecycle.Read)
  expirationTime: utcDateTime;
}
