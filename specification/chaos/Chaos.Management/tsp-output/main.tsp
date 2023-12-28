import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./Capability.tsp";
import "./CapabilityType.tsp";
import "./Experiment.tsp";
import "./ExperimentStatus.tsp";
import "./ExperimentExecutionDetails.tsp";
import "./TargetType.tsp";
import "./Target.tsp";

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
// FIXME: Common type version v2 is not supportted for now.
// @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v2)
@doc("Chaos Management Client")
namespace Azure.ResourceManager.Chaos;

@doc("The available API versions.")
enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2023_04_15_preview: "2023-04-15-preview",
}
