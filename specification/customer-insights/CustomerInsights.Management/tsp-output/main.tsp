import "@typespec/rest";
import "@typespec/http";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
@service({
  title: "CustomerInsightsManagementClient",
  version: "2017-04-26",
})
@server(
  "{$host}",
  "The Azure Customer Insights management API provides a RESTful set of web services that interact with Azure Customer Insights service to manage your resources. The API has entities that capture the relationship between an end user and the Azure Customer Insights service.",
  {
    $host: string,
  }
)
@doc("""
The Azure Customer Insights management API provides a RESTful set of web
services that interact with Azure Customer Insights service to manage your
resources. The API has entities that capture the relationship between an end
user and the Azure Customer Insights service.
""")
namespace CustomerInsightsManagementClient;
