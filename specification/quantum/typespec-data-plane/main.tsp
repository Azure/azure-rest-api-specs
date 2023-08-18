import "@typespec/rest";
import "@typespec/http";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
@service({
  title: "Quantum Client",
  version: "2022-09-12-preview",
})
@server(
  "{$host}",
  "Azure Quantum REST API client",
  {
    $host: string,
  }
)
@doc("Azure Quantum REST API client")
namespace QuantumClient;
