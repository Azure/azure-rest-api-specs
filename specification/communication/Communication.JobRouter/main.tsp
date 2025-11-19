// cheat-sheet - https://microsoft.github.io/typespec/standard-library/http/cheat-sheet
// tsp compile main.tsp --emit @azure-tools/typespec-autorest

import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

@useAuth(AadOauth2Auth<["https://communication.azure.com/.default"]>)
@service(#{ title: "Azure Communication Routing Service" })
@server(
  "{endpoint}",
  "Azure Communication Routing Service",
  {
    @doc("Uri of your Communication resource")
    endpoint: string,
  }
)
@versioned(Versions)
@doc("Azure Communication Routing Service")
namespace AzureCommunicationRoutingService;
