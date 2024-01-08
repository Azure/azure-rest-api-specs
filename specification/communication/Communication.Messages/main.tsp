import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./routes.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

@useAuth(
  ApiKeyAuth<ApiKeyLocation.header, "Authorization"> | OAuth2Auth<[
    {
      type: OAuth2FlowType.authorizationCode,
      authorizationUrl: "https://login.microsoftonline.com/common/v2.0/oauth2/authorize",
      tokenUrl: "https://login.microsoftonline.com/common/v2.0/oauth2/token",
      scopes: ["https://communication.azure.com//.default"],
    }
  ]>
)
@service({
  title: "CommunicationMessagesService",
})
@server(
  "{endpoint}",
  "Azure Communication Messages Service",
  {
    @doc("The communication resource, for example https://my-resource.communication.azure.com")
    endpoint: url,
  }
)
@versioned(Versions)
@doc("Azure Communication Messages Service")
namespace AzureCommunicationMessagesService;