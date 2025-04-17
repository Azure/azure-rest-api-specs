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
@service(#{ title: "Programmable Connectivity" })
@server(
  "{endpoint}",
  "Azure Programmable Connectivity Endpoint.",
  {
    @doc("An Azure Programmable Connectivity Endpoint providing access to Network APIs, for example https://{region}.apcgatewayapi.azure.com")
    endpoint: string,
  }
)
@versioned(APCVersions)
@doc("Azure Programmable Connectivity (APC) provides a unified interface to the Network APIs of multiple Telecom Operators. Note that Operators may deprecate a Network API with less advance notice than the Azure standard, in which case APC will also deprecate that Network API.")
namespace Azure.ProgrammableConnectivity;

@doc("APC Versions")
enum APCVersions {
  @doc("Version 2024-02-09-preview")
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2024_02_09_preview: "2024-02-09-preview",
}
