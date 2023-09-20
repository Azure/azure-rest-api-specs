import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "./environments/routes.tsp";

using Azure.Core;
using TypeSpec.Versioning;
using TypeSpec.Rest;
using TypeSpec.Http;

@useDependency(Versions.v1_0_Preview_2)
@service({
  title: "DevCenter",
  version: "2023-04-01",
})
@server(
  "{endpoint}",
  "DevCenter service",
  {
    endpoint: string,
  }
)
@doc("DevCenter service")
namespace DevCenter;
