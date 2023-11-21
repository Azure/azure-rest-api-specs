import "@typespec/rest";
import "@typespec/http";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
@service({
  title: "PowerBIDedicated",
  version: "2021-01-01",
})
@server(
  "{$host}",
  "PowerBI Dedicated Web API provides a RESTful set of web services that enables users to create, retrieve, update, and delete Power BI dedicated capacities",
  {
    $host: string,
  }
)
@doc("""
PowerBI Dedicated Web API provides a RESTful set of web services that enables
users to create, retrieve, update, and delete Power BI dedicated capacities
""")
namespace PowerBIDedicated;
