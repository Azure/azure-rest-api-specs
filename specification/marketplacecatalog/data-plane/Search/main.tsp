import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./models.tsp";
import "./routes.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;

@doc("Microsoft Marketplace Discovery APIs")
@service(#{ title: "Search" })
@server("https://catalogapi.azure.com")
@versioned(Versions)
@useAuth(DiscoveryApiKey)
namespace Search;

@doc("The currently supported API versions for the Microsoft Marketplace Discovery APIs.")
enum Versions {
  @doc("The 2025-05-01 service API version")
  `2025-05-01`,
}
