// cheat-sheet - https://microsoft.github.io/typespec/standard-library/http/cheat-sheet
// tsp compile main.tsp --emit @azure-tools/typespec-autorest

import "@typespec/http";
import "@typespec/versioning";
import "./routes.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;

@server(
  "{endpoint}",
  "Playwright Service API Endpoint",
  {
    @doc("""
      Supported Playwright Service API Endpoints (protocol and hostname) formatted as https://{region}.api.playwright.microsoft.com.
      You can also find this value in the Azure Playwright Workspace property, such as `dataplaneUri`.
      """)
    endpoint: string,
  }
)
@useAuth(
  [
    OAuth2Auth<[
      {
        type: OAuth2FlowType.implicit,
        description: "We can use OAuth2 Implicit flow to get the auth token for calling the APIs.",
        authorizationUrl: "https://login.microsoftonline.com/common/oauth2/authorize",
        scopes: ["https://playwright.microsoft.com/.default"],
      }
    ]>,
    OAuth2Auth<[
      {
        type: OAuth2FlowType.authorizationCode,
        description: "We can use OAuth2 Authorization Code flow to get the auth token for calling the APIs.",
        authorizationUrl: "https://login.microsoftonline.com/common/oauth2/authorize",
        tokenUrl: "https://login.microsoftonline.com/common/v2.0/oauth2/token",
        scopes: ["https://playwright.microsoft.com/.default"],
      }
    ]>
  ]
)
@service(#{ title: "Playwright Service API" })
@versioned(Playwright.Versions)
namespace Playwright;

@doc("Playwright Service API Versions.")
enum Versions {
  @doc("Version 2025-07-01-preview")
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  v2025_07_01_preview: "2025-07-01-preview",
}
