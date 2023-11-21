import "@typespec/rest";
import "@typespec/http";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
@service({
  title: "HealthbotClient",
  version: "2021-06-10",
})
@server(
  "{$host}",
  "Azure Health Bot is a cloud platform that empowers developers in Healthcare organizations to build and deploy their compliant, AI-powered virtual health assistants and health bots, that help them improve processes and reduce costs.",
  {
    $host: string,
  }
)
@doc("""
Azure Health Bot is a cloud platform that empowers developers in Healthcare
organizations to build and deploy their compliant, AI-powered virtual health
assistants and health bots, that help them improve processes and reduce costs.
""")
namespace HealthbotClient;
