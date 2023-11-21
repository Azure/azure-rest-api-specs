import "@typespec/rest";
import "@typespec/http";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
@service({
  title: "Security Insights",
  version: "2022-12-01-preview",
})
@server(
  "{$host}",
  "API spec for Microsoft.SecurityInsights (Azure Security Insights) resource provider",
  {
    $host: string,
  }
)
@doc("""
API spec for Microsoft.SecurityInsights (Azure Security Insights) resource
provider
""")
namespace SecurityInsights;
