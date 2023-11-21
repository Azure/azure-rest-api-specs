import "@typespec/rest";
import "@typespec/http";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
@service({
  title: "appliances",
  version: "2022-10-27",
})
@server(
  "{$host}",
  "The appliances Rest API spec.",
  {
    $host: string,
  }
)
@doc("The appliances Rest API spec.")
namespace appliances;
