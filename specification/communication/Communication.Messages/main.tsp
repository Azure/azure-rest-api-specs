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
  AadOauth2Auth<["https://communication.azure.com/.default"]> | ApiKeyAuth<
    ApiKeyLocation.header,
    "Authorization"
  >
)
@service({
  title: "CommunicationMessagesClient",
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
@doc("Azure Communication Messages Service test")
namespace Azure.Communication.MessagesService;
