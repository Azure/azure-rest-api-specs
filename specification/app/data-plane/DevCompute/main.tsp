import "@typespec/http";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./models/common.tsp";
import "./models/sandboxes.tsp";
import "./routes/sandboxes.tsp";
import "./client.tsp";

using Http;
using Rest;
using Versioning;
using Azure.Core;

/** ADC Data Plane API. */
@service(#{ title: "ADC Data Plane API" })
@versioned(ApiVersions)
@server(
  "{endpoint}",
  "ADC Data Plane API endpoint.",
  {
    endpoint: url,
  }
)
@useAuth(
  OAuth2Auth<[
    {
      type: OAuth2FlowType.authorizationCode,
      authorizationUrl: "https://login.microsoftonline.com/common/oauth2/v2.0/authorize",
      tokenUrl: "https://login.microsoftonline.com/common/oauth2/v2.0/token",
      scopes: ["https://management.azuredevcompute.io/.default"],
    }
  ]>
)
namespace AzureDevCompute;

/** Supported ADC Data Plane API versions. */
enum ApiVersions {
  /** The 2026-08-01-preview API version. */
  #suppress "@azure-tools/typespec-azure-core/preview-version-last-member" "The preview contract predates the stable contract and contains members removed by the stable release."
  @Azure.Core.previewVersion
  v2026_08_01_preview: "2026-08-01-preview",

  /** The 2026-09-01 API version. */
  v2026_09_01: "2026-09-01",
}
