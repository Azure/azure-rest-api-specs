import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./models.tsp";
import "./routes.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core;

@useAuth(
  OAuth2Auth<[
    {
      type: OAuth2FlowType.implicit,
      authorizationUrl: "https://login.microsoftonline.com/common/oauth2/authorize",
      scopes: ["user_impersonation"],
    }
  ]>
)
@service(#{ title: "CommunicationIdentityClient" })
@server(
  "{endpoint}",
  "Azure Communication Identity Service",
  {
    @doc("The communication resource, for example https://my-resource.communication.azure.com")
    endpoint: url,
  }
)
@versioned(Versions)
@doc("Azure Communication Identity Service")
namespace Azure.Communication.IdentityService;
