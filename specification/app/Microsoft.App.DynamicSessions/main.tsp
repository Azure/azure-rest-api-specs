import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./routes.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;

@useAuth(AadOauth2Auth<["https://dynamicsessions.io/.default"]>)
@service({
  title: "Microsoft.App Dynamic Sessions service",
})
@server(
  "{endpoint}",
  "Session pool management endpoint.",
  {
    @doc("The management endpoint of the session pool.")
    endpoint: string,
  }
)
@versioned(Microsoft.App.DynamicSessions.Versions)
namespace Microsoft.App.DynamicSessions;

@doc("The Microsoft.App Dynamic Sessions service versions.")
enum Versions {
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @doc("The 2024-10-02-preview version of the Microsoft.App Dynamic Sessions service.")
  `2024-10-02-preview`,
}
