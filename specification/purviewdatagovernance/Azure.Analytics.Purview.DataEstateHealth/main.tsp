import "@typespec/rest";
import "@typespec/http";
import "./routes.tsp";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Http;
using TypeSpec.Versioning;

/**
 * Creates a data plane client for Purview Data Estate Health.
 */
@service(#{ title: "PurviewDataEstateHealth" })
@server(
  "{endpoint}/datagovernance/dataestate",
  "Purview Data Estate Health Service provides health monitoring, data quality assessments, governance controls, and estate management across Azure data assets.",
  {
    @doc("The endpoint of the Purview Data Estate Health service. Example: https://api.purview-service.microsoft.com/")
    endpoint: "https://api.purview-service.microsoft.com/",
  }
)
@doc("""
  Purview Data Estate Health Service provides health monitoring, data quality
  assessments, governance controls, and estate management across Azure data
  assets. This spec defines the REST API for the Data Access surface of the
  Data Estate Health service.
  """)
@useAuth(AuthToken)
@versioned(ApiVersions)
namespace PurviewDataEstateHealth;

@doc("Service API versions")
enum ApiVersions {
  @doc("2025-11-01-preview service API version")
  v2025_11_01_preview: "2025-11-01-preview",
}

alias AuthToken = OAuth2Auth<[
  {
    type: OAuth2FlowType.implicit;
    authorizationUrl: "https://login.microsoftonline.com/common/oauth2/authorize";
    scopes: ["https://purview.azure.net/.default"];
  }
]>;
