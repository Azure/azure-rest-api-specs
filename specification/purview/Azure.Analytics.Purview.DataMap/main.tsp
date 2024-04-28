import "@typespec/rest";
import "@typespec/http";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;

@service({
  title: "Azure Analytics Purview Data Map",
})
@server(
  "{endpoint}/datamap/api",
  "Purview Data Map Service is a fully managed cloud service whose users can discover the data sources they need and understand the data sources they find. At the same time, Data Map helps organizations get more value from their existing investments.",
  {
    endpoint: string,
  }
)
@doc("""
Purview Data Map Service is a fully managed cloud service whose users can
discover the data sources they need and understand the data sources they find.
At the same time, Data Map helps organizations get more value from their
existing investments. This spec defines REST API of Purview Data Map Service.
""")
@useAuth(AuthToken)
@versioned(ApiVersions)
namespace PurviewDataMap;

@doc("Service API versions")
enum ApiVersions {
  @doc("2023-09-01 service API version")
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  v2023_09_01: "2023-09-01",
}

alias AuthToken = OAuth2Auth<[
  {
    type: OAuth2FlowType.implicit;
    authorizationUrl: "https://login.microsoftonline.com/common/oauth2/authorize";
    scopes: ["https://purview.azure.net/.default"];
  }
]>;
