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
  title: "Microsoft.App service",
})
@server(
  "{endpoint}",
  "Session pool management endpoint.",
  {
    @doc("The management endpoint of the session pool.")
    endpoint: string,
  }
)
@versioned(Microsoft.App.Versions)
namespace Microsoft.App;

@doc("The Microsoft.App service versions.")
enum Versions {
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @doc("The 2024-09-01 version of the Microsoft.App service.")
  `2024-09-01`,
}
