import "@typespec/rest";
import "@typespec/http";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
@service({
  title: "AzureAnalysisServices",
  version: "2017-08-01",
})
@server(
  "{$host}",
  "The Azure Analysis Services Web API provides a RESTful set of web services that enables users to create, retrieve, update, and delete Analysis Services servers",
  {
    $host: string,
  }
)
@doc("""
The Azure Analysis Services Web API provides a RESTful set of web services that
enables users to create, retrieve, update, and delete Analysis Services servers
""")
namespace AzureAnalysisServices;
