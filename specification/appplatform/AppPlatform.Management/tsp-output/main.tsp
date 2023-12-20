import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./AppPlatformService.tsp";
import "./AppPlatformConfigServer.tsp";
import "./AppPlatformConfigurationService.tsp";
import "./AppPlatformServiceRegistry.tsp";
import "./AppPlatformBuildService.tsp";
import "./AppPlatformBuild.tsp";
import "./AppPlatformBuildResult.tsp";
import "./AppPlatformSupportedBuildpack.tsp";
import "./AppPlatformSupportedStack.tsp";
import "./AppPlatformBuildpackBinding.tsp";
import "./AppPlatformBuilder.tsp";
import "./AppPlatformBuildServiceAgentPool.tsp";
import "./AppPlatformMonitoringSetting.tsp";
import "./AppPlatformApp.tsp";
import "./AppPlatformBinding.tsp";
import "./AppPlatformStorage.tsp";
import "./AppPlatformCertificate.tsp";
import "./AppPlatformCustomDomain.tsp";
import "./AppPlatformDeployment.tsp";
import "./AppPlatformGateway.tsp";
import "./AppPlatformGatewayRouteConfig.tsp";
import "./AppPlatformGatewayCustomDomain.tsp";
import "./AppPlatformApiPortal.tsp";
import "./AppPlatformApiPortalCustomDomain.tsp";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
@armProviderNamespace
@service({
  title: "AppPlatformManagementClient",
})
@versioned(Versions)
@doc("REST API for Azure Spring Apps")
namespace Azure.ResourceManager.AppPlatform;

@doc("The available API versions.")
enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2022_12_01: "2022-12-01",
}
