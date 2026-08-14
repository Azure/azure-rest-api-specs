import "@typespec/http";
import "@typespec/rest";
import "@typespec/openapi3";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./common.tsp";
import "./models/sandbox.tsp";
import "./operations/sandbox.tsp";
import "./routes/azure-scoped.tsp";
import "./routes/user-scoped.tsp";
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
@useAuth(AzureDataPlaneS2SAuth)
namespace AzureDevCompute;

/** Microsoft Entra ID client-credentials authentication for Azure data-plane service-to-service operations. */
model AzureDataPlaneS2SAuth
  is OAuth2Auth<[
    {
      type: OAuth2FlowType.clientCredentials;
      tokenUrl: "https://login.microsoftonline.com/common/oauth2/v2.0/token";
      scopes: ["https://management.azuredevcompute.io/.default"];
    }
  ]>;

/** Microsoft Entra ID authorization-code authentication for user-scoped operations. */
model UserEntraAuth
  is OAuth2Auth<[
    {
      type: OAuth2FlowType.authorizationCode;
      authorizationUrl: "https://login.microsoftonline.com/common/oauth2/v2.0/authorize";
      tokenUrl: "https://login.microsoftonline.com/common/oauth2/v2.0/token";
      scopes: ["https://management.azuredevcompute.io/.default"];
    }
  ]>;

/** ADC bearer token authentication for user-scoped operations. */
model UserBearerAuth is BearerAuth;

/** GitHub token authentication using the Authorization header. */
model UserGitHubAuth {
  /** HTTP authentication scheme type. */
  type: AuthType.http;

  /** GitHub authorization scheme. */
  scheme: "GitHub";
}

/** ADC API key authentication. */
model UserApiKeyAuth is ApiKeyAuth<ApiKeyLocation.header, "x-ms-api-key">;

/** ADC portal authentication cookie. */
model UserPortalCookieAuth is ApiKeyAuth<
  ApiKeyLocation.cookie,
  "adc_portal_auth"
>;

/**
 * Authentication alternatives accepted by user-scoped HTTP operations.
 * Runtime client-certificate authentication is not representable in OpenAPI 3.0.
 */
alias UserScopedAuth =
  | UserEntraAuth
  | UserBearerAuth
  | UserGitHubAuth
  | UserApiKeyAuth
  | UserPortalCookieAuth;

/** Supported ADC Data Plane API versions. */
enum ApiVersions {
  /** The 2026-08-01-preview API version. */
  @previewVersion
  v2026_08_01_Preview: "2026-08-01-preview",
}
