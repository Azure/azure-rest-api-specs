import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./DevCenter.tsp";
import "./Project.tsp";
import "./AttachedNetworkConnection.tsp";
import "./AttachedNetworkConnection.tsp";
import "./Gallery.tsp";
import "./Image.tsp";
import "./ImageVersion.tsp";
import "./Catalog.tsp";
import "./EnvironmentType.tsp";
import "./AllowedEnvironmentType.tsp";
import "./ProjectEnvironmentType.tsp";
import "./DevBoxDefinition.tsp";
import "./DevBoxDefinition.tsp";
import "./Pool.tsp";
import "./Schedule.tsp";
import "./NetworkConnection.tsp";
import "./HealthCheckStatusDetails.tsp";
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
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v4)
@doc("DevCenter Management API")
namespace Microsoft.DevCenter;

@doc("The available API versions.")
enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  @doc("The 2023-04-01 API version.")
  v2023_04_01: "2023-04-01",
}
