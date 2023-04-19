import "@typespec/rest";
import "@typespec/versioning";
import "./routes.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;

@service({
  title: "BatchServiceClient",
})



@doc("A client for issuing REST requests to the Azure Batch service.")
@useAuth(AADToken)
@versioned(BatchService.Versions)
namespace BatchService;

enum Versions {
   @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  `2022-10-01.16.0`,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Model types must use camelCase"
@doc("The Azure Active Directory OAuth2 Flow")
model AADToken
  is OAuth2Auth<[
    {
      type: OAuth2FlowType.implicit;
      authorizationUrl: "https://login.microsoftonline.com/common/oauth2/authorize";
      scopes: ["https://batch.core.windows.net//.default"];
    }
  ]>;
