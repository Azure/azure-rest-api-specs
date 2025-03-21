import "@typespec/rest";
import "@typespec/http";
import "./routes.sas.tsp";
import "./routes.stac.tsp";
import "./routes.tiler.tsp";
import "./inma.tsp";
import "./models.common.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;

#suppress "@azure-tools/typespec-autorest/unsupported-http-auth-scheme" ""
@service(#{ title: "Microsoft Planetary Computer Pro" })
@useAuth(
  [
    OAuth2Auth<[
      {
        type: OAuth2FlowType.implicit,
        authorizationUrl: "https://login.microsoftonline.com/common/oauth2/authorize",
        scopes: ["https://geocatalog.spatio.azure.com/.default"],
      }
    ]>
  ]
)
@versioned(Versions)
namespace MicrosoftPlanetaryComputerPro;
