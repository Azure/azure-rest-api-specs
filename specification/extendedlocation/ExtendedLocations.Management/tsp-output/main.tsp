import "@typespec/rest";
import "@typespec/http";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
@service({
  title: "customLocations",
  version: "2021-08-15",
})
@server(
  "{$host}",
  "The customLocations Rest API spec.",
  {
    $host: string,
  }
)
@doc("The customLocations Rest API spec.")
namespace customLocations;
