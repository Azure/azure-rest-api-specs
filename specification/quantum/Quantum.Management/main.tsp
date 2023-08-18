import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "./routes.tsp";

using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;

@service({
  title: "Azure Quantum Management Client",
})
@server(
  "{$host}",
  "// FIXME: (miissing-service-description) Add service description",
  {
    $host: string,
  }
)
@doc("// FIXME: (miissing-service-description) Add service description")
@versioned(Versions)
@armProviderNamespace
namespace Microsoft.Quantum;

#suppress "@azure-tools/typespec-azure-core/documentation-required" "https://github.com/Azure/typespec-azure/issues/3107"
enum Versions {
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  v2022_01_10_preview: "2022-01-10-preview",
}
