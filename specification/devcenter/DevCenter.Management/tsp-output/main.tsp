import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./DevCenter.tsp";
import "./DevCenterProject.tsp";
import "./ProjectAttachedNetworkConnection.tsp";
import "./AttachedNetworkConnection.tsp";
import "./DevCenterGallery.tsp";
import "./DevCenterImage.tsp";
import "./ImageVersion.tsp";
import "./DevCenterCatalog.tsp";
import "./DevCenterEnvironmentType.tsp";
import "./AllowedEnvironmentType.tsp";
import "./DevCenterProjectEnvironment.tsp";
import "./DevBoxDefinition.tsp";
import "./ProjectDevBoxDefinition.tsp";
import "./DevCenterPool.tsp";
import "./DevCenterSchedule.tsp";
import "./DevCenterNetworkConnection.tsp";
import "./HealthCheckStatusDetail.tsp";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
@armProviderNamespace
@service({
  title: "DevCenter",
})
@versioned(Versions)
@doc("DevCenter Management API")
namespace Azure.ResourceManager.DevCenter;

@doc("The available API versions.")
enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2023_04_01: "2023-04-01",
}
