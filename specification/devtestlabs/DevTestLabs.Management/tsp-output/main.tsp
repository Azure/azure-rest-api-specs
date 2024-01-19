import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./Lab.tsp";
import "./Schedule.tsp";
import "./Schedule.tsp";
import "./Schedule.tsp";
import "./Schedule.tsp";
import "./ArtifactSource.tsp";
import "./ArmTemplate.tsp";
import "./Artifact.tsp";
import "./LabCost.tsp";
import "./CustomImage.tsp";
import "./Formula.tsp";
import "./NotificationChannel.tsp";
import "./Policy.tsp";
import "./ServiceRunner.tsp";
import "./User.tsp";
import "./Disk.tsp";
import "./DtlEnvironment.tsp";
import "./Secret.tsp";
import "./ServiceFabric.tsp";
import "./LabVirtualMachine.tsp";
import "./VirtualNetwork.tsp";
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
namespace Microsoft.DevTestLab;

@doc("The available API versions.")
enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  @doc("The 2018-09-15 API version.")
  v2018_09_15: "2018-09-15",
}
