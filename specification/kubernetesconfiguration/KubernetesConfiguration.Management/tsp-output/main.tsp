import "@typespec/rest";
import "@typespec/http";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
@service({
  title: "SourceControlConfigurationClient",
  version: "2022-11-01",
})
@server(
  "{$host}",
  "KubernetesConfiguration Client",
  {
    $host: string,
  }
)
@doc("KubernetesConfiguration Client")
namespace SourceControlConfigurationClient;
