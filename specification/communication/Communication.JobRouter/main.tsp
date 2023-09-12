import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;

@service({
  title: "Azure Communication Routing Service",
})
@server(
  "{endpoint}",
  "Azure Communication Routing Service",
  {
    endpoint: string,
  }
)
@versioned(Versions)
@doc("Azure Communication Routing Service")
namespace AzureCommunicationRoutingService;
