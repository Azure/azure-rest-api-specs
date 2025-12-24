// cheat-sheet - https://microsoft.github.io/typespec/standard-library/http/cheat-sheet
// tsp compile main.tsp --emit @azure-tools/typespec-autorest

import "@typespec/http";
import "@typespec/versioning";
import "./typespec/routes.tsp";
import "./typespec/accesstokens.tsp";
import "./typespec/testruns.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;

@server(
  "{endpoint}",
  "Playwright Service API Endpoint",
  {
    @doc("""
      Playwright Service API endpoint (protocol and hostname) formatted as https://{region}.api.playwright.microsoft.com.
      The region corresponds to your Azure Playwright workspace location. You can find this value in your Azure Playwright workspace properties under `dataplaneUri`.
      """)
    endpoint: string,
  }
)
@useAuth(
  [
    OAuth2Auth<[
      {
        type: OAuth2FlowType.implicit,
        description: "OAuth2 Implicit flow for client-side applications. Suitable for single-page applications and scenarios where client secrets cannot be securely stored.",
        authorizationUrl: "https://login.microsoftonline.com/common/oauth2/authorize",
        scopes: ["https://playwright.microsoft.com/.default"],
      }
    ]>,
    OAuth2Auth<[
      {
        type: OAuth2FlowType.authorizationCode,
        description: "OAuth2 Authorization Code flow for server-side applications. Recommended for applications that can securely store client secrets.",
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

@doc("Available versions of the Playwright Service API.")
enum Versions {
  @doc("Preview version 2025-07-01-preview with experimental features.")
  v2025_07_01_preview: "2025-07-01-preview",

  @doc("Stable version 2025-09-01 with general availability features.")
  v2025_09_01: "2025-09-01",

  @doc("Preview version 2026-01-01-preview with experimental features.")
  v2026_01_01_preview: "2026-01-01-preview",
}
