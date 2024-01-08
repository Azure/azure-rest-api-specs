import "./apis/location.tsp";
import "./apis/network.tsp";
import "./apis/number.tsp";
import "./apis/simswap.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core;

@useAuth(
  [
    OAuth2Auth<[
      {
        type: OAuth2FlowType.implicit,
        authorizationUrl: "https://login.microsoftonline.com/common/oauth2/authorize",
        scopes: ["https://management.azure.com//.default"],
      }
    ]>
  ]
)
@service({
  title: "Programmable Connectivity",
})
@server(
  "{endpoint}",
  "Azure Programmable Connectivity Endpoint.",
  {
    @doc("An Azure Programmable Connectivity Endpoint providing access to Network APIs, for example https://{region}.apcgatewayapi.azure.com")
    endpoint: string,
  }
)
@versioned(APCVersions)
namespace Azure.ProgrammableConnectivity;

enum APCVersions {
  @doc("Version 2023-03-01-preview")
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2021_03_01_preview: "v2021_03_01_preview",
}
