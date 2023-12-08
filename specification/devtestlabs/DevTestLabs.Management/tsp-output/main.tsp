import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./DevTestLab.tsp";
import "./DevTestLabGlobalSchedule.tsp";
import "./DevTestLabSchedule.tsp";
import "./DevTestLabServiceFabricSchedule.tsp";
import "./DevTestLabVmSchedule.tsp";
import "./DevTestLabArtifactSource.tsp";
import "./DevTestLabArmTemplate.tsp";
import "./DevTestLabArtifact.tsp";
import "./DevTestLabCost.tsp";
import "./DevTestLabCustomImage.tsp";
import "./DevTestLabFormula.tsp";
import "./DevTestLabNotificationChannel.tsp";
import "./DevTestLabPolicy.tsp";
import "./DevTestLabServiceRunner.tsp";
import "./DevTestLabUser.tsp";
import "./DevTestLabDisk.tsp";
import "./DevTestLabEnvironment.tsp";
import "./DevTestLabSecret.tsp";
import "./DevTestLabServiceFabric.tsp";
import "./DevTestLabVm.tsp";
import "./DevTestLabVirtualNetwork.tsp";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
@armProviderNamespace
@service({
  title: "DevTestLabsClient",
})
@versioned(Versions)
@doc("The DevTest Labs Client.")
namespace Azure.ResourceManager.DevTestLabs;

@doc("The available API versions.")
enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2018_09_15: "2018-09-15",
}
