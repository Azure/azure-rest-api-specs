import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./AuthConfig.tsp";
import "./ConnectedEnvironment.tsp";
import "./Certificate.tsp";
import "./Certificate.tsp";
import "./DaprComponent.tsp";
import "./DaprComponent.tsp";
import "./ConnectedEnvironmentStorage.tsp";
import "./ContainerApp.tsp";
import "./ContainerApp.tsp";
import "./Revision.tsp";
import "./Revision.tsp";
import "./Replica.tsp";
import "./Diagnostics.tsp";
import "./Diagnostics.tsp";
import "./ManagedEnvironment.tsp";
import "./ManagedEnvironment.tsp";
import "./Job.tsp";
import "./JobExecution.tsp";
import "./ManagedCertificate.tsp";
import "./ManagedEnvironmentStorage.tsp";
import "./SourceControl.tsp";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
@armProviderNamespace
@service({
  title: "ContainerApps API Client",
})
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v3)
@doc("// FIXME: (miissing-service-description) Add service description")
namespace Microsoft.App;

@doc("The available API versions.")
enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  @doc("The 2023-05-01 API version.")
  v2023_05_01: "2023-05-01",
}
