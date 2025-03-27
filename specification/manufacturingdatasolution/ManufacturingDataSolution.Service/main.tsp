import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "./resources/QueryApis.tsp";
import "./resources/AdminApis.tsp";
import "./resources/ServiceConfigApis.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core.Traits;

@service(#{ title: "Microsoft.Industry.Manufacturing.MDS.Solution" })
@server(
  "https://mds-{mdsUniqueId}.{location}.cloudapp.azure.com/",
  "Manufacturing Data Solution global endpoint.",
  {
    mdsUniqueId: string,
    location: string = "mds.azure.com",
  }
)
@useAuth(AadToken)
@versioned(MdsSolution.Versions)
namespace MdsSolution;

alias DefaultServiceTraits = NoRepeatableRequests &
  NoConditionalRequests &
  NoClientRequestId;

alias Operations = Azure.Core.ResourceOperations<
  DefaultServiceTraits,
  Azure.Core.Foundations.ErrorResponse
>;

alias DefaultAzureCoreVersion = Azure.Core.Versions.v1_0_Preview_2;

@doc("Manufacturing Data Solution service versions.")
enum Versions {
  @useDependency(DefaultAzureCoreVersion)
  `2025-03-01`,
}

@doc("The Azure Active Directory OAuth2 Flow")
model AadToken
  is OAuth2Auth<[
    {
      type: OAuth2FlowType.authorizationCode;
      authorizationUrl: "https://login.microsoftonline.com/common/oauth2/v2.0/authorize";
      tokenUrl: "https://login.microsoftonline.com/common/oauth2/token";
      scopes: ["https://mds.azure.com/.default"];
    }
  ]>;
