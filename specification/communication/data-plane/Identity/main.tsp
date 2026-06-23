import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./models.tsp";
import "./routes.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core;

#suppress "@azure-tools/typespec-azure-core/auth-required" "Auth defined in securityDefinitions only without global security array, matching original swagger to preserve SDK constructor signature"
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
