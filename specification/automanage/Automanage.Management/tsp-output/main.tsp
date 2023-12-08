import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./AutomanageBestPractice.tsp";
import "./AutomanageConfigurationProfile.tsp";
import "./AutomanageConfigurationProfileVersion.tsp";
import "./AutomanageVmConfigurationProfileAssignment.tsp";
import "./AutomanageHcrpConfigurationProfileAssignment.tsp";
import "./AutomanageHciClusterConfigurationProfileAssignment.tsp";
import "./AutomanageVmConfigurationProfileAssignmentReport.tsp";
import "./AutomanageHcrpConfigurationProfileAssignmentReport.tsp";
import "./AutomanageHciClusterConfigurationProfileAssignmentReport.tsp";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
@armProviderNamespace
@service({
  title: "AutomanageClient",
})
@versioned(Versions)
@doc("Automanage Client")
namespace Azure.ResourceManager.Automanage;

@doc("The available API versions.")
enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2022_05_04: "2022-05-04",
}
