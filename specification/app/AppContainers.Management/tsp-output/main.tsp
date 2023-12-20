import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./ContainerAppAuthConfig.tsp";
import "./ContainerAppConnectedEnvironment.tsp";
import "./ContainerAppConnectedEnvironmentCertificate.tsp";
import "./ContainerAppManagedEnvironmentCertificate.tsp";
import "./ContainerAppConnectedEnvironmentDaprComponent.tsp";
import "./ContainerAppManagedEnvironmentDaprComponent.tsp";
import "./ContainerAppConnectedEnvironmentStorage.tsp";
import "./ContainerApp.tsp";
import "./ContainerAppDetectorProperty.tsp";
import "./ContainerAppRevision.tsp";
import "./ContainerAppDetectorPropertyRevision.tsp";
import "./ContainerAppReplica.tsp";
import "./ContainerAppDetector.tsp";
import "./ContainerAppManagedEnvironmentDetector.tsp";
import "./ContainerAppManagedEnvironmentDetectorResourceProperty.tsp";
import "./ContainerAppManagedEnvironment.tsp";
import "./ContainerAppJob.tsp";
import "./ContainerAppJobExecution.tsp";
import "./ContainerAppManagedCertificate.tsp";
import "./ContainerAppManagedEnvironmentStorage.tsp";
import "./ContainerAppSourceControl.tsp";
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
namespace Azure.ResourceManager.AppContainers;

@doc("The available API versions.")
enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2023_05_01: "2023-05-01",
}
