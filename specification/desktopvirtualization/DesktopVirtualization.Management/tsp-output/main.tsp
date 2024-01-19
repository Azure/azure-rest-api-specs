import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./Workspace.tsp";
import "./PrivateEndpointConnectionWithSystemData.tsp";
import "./PrivateEndpointConnectionWithSystemData.tsp";
import "./ScalingPlan.tsp";
import "./ScalingPlanPooledSchedule.tsp";
import "./ScalingPlanPersonalSchedule.tsp";
import "./ApplicationGroup.tsp";
import "./Application.tsp";
import "./Desktop.tsp";
import "./HostPool.tsp";
import "./UserSession.tsp";
import "./SessionHost.tsp";
import "./MsixPackage.tsp";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
@armProviderNamespace
@service({
  title: "Desktop Virtualization API Client",
})
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v3)
@doc("// FIXME: (miissing-service-description) Add service description")
namespace Microsoft.DesktopVirtualization;

@doc("The available API versions.")
enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  @doc("The 2023-09-05 API version.")
  v2023_09_05: "2023-09-05",
}
