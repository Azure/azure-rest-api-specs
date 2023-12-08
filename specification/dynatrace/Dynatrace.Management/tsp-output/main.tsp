import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./DynatraceMonitor.tsp";
import "./DynatraceTagRule.tsp";
import "./DynatraceSingleSignOn.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
@armProviderNamespace
@service({
  title: "Dynatrace.Observability",
})
@versioned(Versions)
@doc("// FIXME: (miissing-service-description) Add service description")
namespace Azure.ResourceManager.Dynatrace;

@doc("The available API versions.")
enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2021_09_01: "2021-09-01",
}
