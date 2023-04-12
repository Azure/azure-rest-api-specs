import "@typespec/rest";
import "@typespec/versioning";
import "./routes.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;

@service({
  title: "BatchServiceClient",
  version: "2022-10-01.16.0",
})
@useAuth(AADToken)
@versioned(BatchService.Versions)
@versionedDependency([[BatchService.Versions.v2022_10_01, Azure.Core.Versions.v1_0_Preview_2]])

@doc("A client for issuing REST requests to the Azure Batch service.")
namespace BatchService;

enum Versions {
  v2022_10_01: "2022-10-01.16.0",
}
@doc("The Azure Active Directory OAuth2 Flow")
model AADToken
  is OAuth2Auth<[
    {
      type: OAuth2FlowType.implicit;
      authorizationUrl: "https://login.microsoftonline.com/common/oauth2/authorize";
      scopes: ["https://batch.core.windows.net//.default"];
    }
  ]>;