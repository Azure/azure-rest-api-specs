import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core;

@versioned(APIVersions)
@useAuth(Oauth2)
@service(#{ title: "Azure Load Testing" })
@server(
  "https://{endpoint}",
  "These APIs allow end users to create, view and run load tests using Azure Load Test Service.",
  {
    endpoint: string,
  }
)
@doc("""
  These APIs allow end users to create, view and run load tests using Azure Load Test Service.
  """)
namespace Microsoft.LoadTestService;

@doc("Azure Load Testing API versions.")
enum APIVersions {
  @doc("The 2022-11-01 version of the Azure Load Testing API.")
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  v2022_11_01: "2022-11-01",

  @doc("The 2023-04-01-preview version of the Azure Load Testing API.")
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  v2023_04_01_preview: "2023-04-01-preview",

  @doc("The 2024-03-01-preview version of the Azure Load Testing API.")
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  v2024_03_01_preview: "2024-03-01-preview",

  @doc("The 2024-05-01-preview version of the Azure Load Testing API.")
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  v2024_05_01_preview: "2024-05-01-preview",

  @doc("The 2024-07-01-preview version of the Azure Load Testing API.")
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  v2024_07_01_preview: "2024-07-01-preview",

  @doc("The 2024-12-01-preview version of the Azure Load Testing API.")
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  v2024_12_01_preview: "2024-12-01-preview",

  @doc("The 2025-03-01-preview version of the Azure Load Testing API.")
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  v2025_03_01_preview: "2025-03-01-preview",
}

@doc("OAuth 2.0 Flow with Microsoft Entra ID.")
model Oauth2
  is OAuth2Auth<[
    {
      type: OAuth2FlowType.implicit;
      authorizationUrl: "https://login.microsoftonline.com/common/oauth2/v2.0/authorize";
      scopes: ["https://cnt-prod.loadtesting.azure.com/.default"];
    }
  ]>;
