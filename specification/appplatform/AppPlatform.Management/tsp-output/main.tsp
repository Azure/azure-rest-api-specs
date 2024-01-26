import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./ServiceResource.tsp";
import "./ConfigServerResource.tsp";
import "./ConfigurationServiceResource.tsp";
import "./ServiceRegistryResource.tsp";
import "./BuildService.tsp";
import "./Build.tsp";
import "./BuildResult.tsp";
import "./SupportedBuildpackResource.tsp";
import "./SupportedStackResource.tsp";
import "./BuildpackBindingResource.tsp";
import "./BuilderResource.tsp";
import "./BuildServiceAgentPoolResource.tsp";
import "./MonitoringSettingResource.tsp";
import "./AppResource.tsp";
import "./BindingResource.tsp";
import "./StorageResource.tsp";
import "./CertificateResource.tsp";
import "./CustomDomainResource.tsp";
import "./DeploymentResource.tsp";
import "./GatewayResource.tsp";
import "./GatewayRouteConfigResource.tsp";
import "./GatewayCustomDomainResource.tsp";
import "./ApiPortalResource.tsp";
import "./ApiPortalCustomDomainResource.tsp";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
/**
 * REST API for Azure Spring Apps
 */
@armProviderNamespace
@useAuth(AadOauth2Auth<["user_impersonation"]>)
@service({
  title: "AppPlatformManagementClient",
})
@versioned(Versions)
namespace Microsoft.AppPlatform;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2022-12-01 API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2022_12_01: "2022-12-01",
}
