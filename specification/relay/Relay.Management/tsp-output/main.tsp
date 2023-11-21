import "@typespec/rest";
import "@typespec/http";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
@service({
  title: "Relay API",
  version: "2021-11-01",
})
@server(
  "{$host}",
  "Use these API to manage Azure Relay resources through Azure Resource Manager.",
  {
    $host: string,
  }
)
@doc("Use these API to manage Azure Relay resources through Azure Resource Manager.")
namespace RelayAPI;
