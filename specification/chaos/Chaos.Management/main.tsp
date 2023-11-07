import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./Capability.tsp";
import "./CapabilityType.tsp";
import "./Experiment.tsp";
import "./ExperimentStatus.tsp";
import "./ExperimentExecutionDetail.tsp";
import "./TargetType.tsp";
import "./Target.tsp";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
@armProviderNamespace
@service({
  title: "ChaosManagementClient",
})
@versioned(Versions)
@doc("Chaos Management Client")
namespace Microsoft.Chaos;

@doc("The available API versions.")
enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2023_09_01_preview: "2023-09-01-preview",
}
