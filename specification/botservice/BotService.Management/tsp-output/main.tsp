import "@typespec/rest";
import "@typespec/http";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
@service({
  title: "Azure Bot Service",
  version: "2022-09-15",
})
@server(
  "{$host}",
  "Azure Bot Service is a platform for creating smart conversational agents.",
  {
    $host: string,
  }
)
@doc("Azure Bot Service is a platform for creating smart conversational agents.")
namespace AzureBotService;
