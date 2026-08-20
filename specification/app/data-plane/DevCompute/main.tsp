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
@useAuth(AzureDataPlaneS2sAuth)
namespace AzureDevCompute;

/** Microsoft Entra ID client-credentials authentication for Azure data-plane service-to-service operations. */
model AzureDataPlaneClientCredentialsFlow {
  /** OAuth2 client-credentials flow type. */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "The standard OAuth2FlowType member emits a Swagger enum without the x-ms-enum metadata required by OAV; this property-level extension preserves the existing authentication wire contract."
  #suppress "@azure-tools/typespec-azure-core/no-openapi-client-extensions" "The standard OAuth2FlowType member emits a Swagger enum without the x-ms-enum metadata required by OAV; this property-level extension preserves the existing authentication wire contract."
  @TypeSpec.OpenAPI.extension(
    "x-ms-enum",
    #{ name: "DevComputeOAuth2FlowType", modelAsString: false }
  )
  type: OAuth2FlowType.clientCredentials;

  /** Microsoft Entra ID token endpoint. */
  #suppress "@azure-tools/typespec-client-generator-core/csharp-no-url-suffix"
  tokenUrl: "https://login.microsoftonline.com/common/oauth2/v2.0/token";

  /** OAuth2 scopes required by the service. */
  scopes: ["https://management.azuredevcompute.io/.default"];
}

/** Microsoft Entra ID client-credentials authentication for Azure data-plane service-to-service operations. */
model AzureDataPlaneS2sAuth
  is OAuth2Auth<[AzureDataPlaneClientCredentialsFlow]>;

/** Supported ADC Data Plane API versions. */
enum ApiVersions {
  /** The 2026-08-01-preview API version. */
  #suppress "@azure-tools/typespec-azure-core/preview-version-last-member" "The preview contract predates the stable contract and contains members removed by the stable release."
  @Azure.Core.previewVersion
  v2026_08_01_preview: "2026-08-01-preview",

  /** The 2026-09-01 API version. */
  v2026_09_01: "2026-09-01",
}
