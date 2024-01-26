import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./AppServiceCertificateOrder.tsp";
import "./AppServiceCertificateResource.tsp";
import "./DetectorResponse.tsp";
import "./DetectorResponse.tsp";
import "./DetectorResponse.tsp";
import "./DetectorResponse.tsp";
import "./Domain.tsp";
import "./DomainOwnershipIdentifier.tsp";
import "./TopLevelDomain.tsp";
import "./AppServiceEnvironmentResource.tsp";
import "./AseV3NetworkingConfiguration.tsp";
import "./WorkerPoolResource.tsp";
import "./WorkerPoolResource.tsp";
import "./RemotePrivateEndpointConnectionARMResource.tsp";
import "./RemotePrivateEndpointConnectionARMResource.tsp";
import "./RemotePrivateEndpointConnectionARMResource.tsp";
import "./RemotePrivateEndpointConnectionARMResource.tsp";
import "./AppServicePlan.tsp";
import "./HybridConnection.tsp";
import "./HybridConnection.tsp";
import "./HybridConnection.tsp";
import "./HybridConnectionLimits.tsp";
import "./VnetInfoResource.tsp";
import "./VnetInfoResource.tsp";
import "./VnetInfoResource.tsp";
import "./VnetGateway.tsp";
import "./VnetGateway.tsp";
import "./VnetGateway.tsp";
import "./Certificate.tsp";
import "./DiagnosticCategory.tsp";
import "./DiagnosticCategory.tsp";
import "./AnalysisDefinition.tsp";
import "./AnalysisDefinition.tsp";
import "./DetectorDefinitionResource.tsp";
import "./DetectorDefinitionResource.tsp";
import "./DeletedSite.tsp";
import "./KubeEnvironment.tsp";
import "./RecommendationRule.tsp";
import "./RecommendationRule.tsp";
import "./ResourceHealthMetadata.tsp";
import "./ResourceHealthMetadata.tsp";
import "./User.tsp";
import "./SourceControl.tsp";
import "./StaticSiteARMResource.tsp";
import "./StaticSiteBuildARMResource.tsp";
import "./StaticSiteUserProvidedFunctionAppARMResource.tsp";
import "./StaticSiteUserProvidedFunctionAppARMResource.tsp";
import "./StaticSiteCustomDomainOverviewARMResource.tsp";
import "./Site.tsp";
import "./Site.tsp";
import "./BackupItem.tsp";
import "./BackupItem.tsp";
import "./CsmPublishingCredentialsPoliciesEntity.tsp";
import "./CsmPublishingCredentialsPoliciesEntity.tsp";
import "./CsmPublishingCredentialsPoliciesEntity.tsp";
import "./CsmPublishingCredentialsPoliciesEntity.tsp";
import "./ApiKVReference.tsp";
import "./ApiKVReference.tsp";
import "./ApiKVReference.tsp";
import "./ApiKVReference.tsp";
import "./SiteLogsConfig.tsp";
import "./SiteLogsConfig.tsp";
import "./SlotConfigNamesResource.tsp";
import "./SiteConfig.tsp";
import "./SiteConfig.tsp";
import "./SiteConfig.tsp";
import "./SiteConfig.tsp";
import "./ContinuousWebJob.tsp";
import "./ContinuousWebJob.tsp";
import "./Deployment.tsp";
import "./Deployment.tsp";
import "./Identifier.tsp";
import "./Identifier.tsp";
import "./MSDeployStatus.tsp";
import "./MSDeployStatus.tsp";
import "./MSDeployStatus.tsp";
import "./MSDeployStatus.tsp";
import "./FunctionEnvelope.tsp";
import "./FunctionEnvelope.tsp";
import "./HostNameBinding.tsp";
import "./HostNameBinding.tsp";
import "./RelayServiceConnectionEntity.tsp";
import "./RelayServiceConnectionEntity.tsp";
import "./WebSiteInstanceStatus.tsp";
import "./WebSiteInstanceStatus.tsp";
import "./ProcessInfo.tsp";
import "./ProcessInfo.tsp";
import "./ProcessInfo.tsp";
import "./ProcessInfo.tsp";
import "./ProcessModuleInfo.tsp";
import "./ProcessModuleInfo.tsp";
import "./ProcessModuleInfo.tsp";
import "./ProcessModuleInfo.tsp";
import "./SwiftVirtualNetwork.tsp";
import "./SwiftVirtualNetwork.tsp";
import "./PremierAddOn.tsp";
import "./PremierAddOn.tsp";
import "./PrivateAccess.tsp";
import "./PrivateAccess.tsp";
import "./PublicCertificate.tsp";
import "./PublicCertificate.tsp";
import "./SiteExtensionInfo.tsp";
import "./SiteExtensionInfo.tsp";
import "./MigrateMySqlStatus.tsp";
import "./NetworkFeatures.tsp";
import "./SiteSourceControl.tsp";
import "./SiteSourceControl.tsp";
import "./TriggeredWebJob.tsp";
import "./TriggeredWebJob.tsp";
import "./TriggeredJobHistory.tsp";
import "./TriggeredJobHistory.tsp";
import "./WebJob.tsp";
import "./WebJob.tsp";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
/**
 * WebSite Management Client
 */
@armProviderNamespace
@useAuth(AadOauth2Auth<["user_impersonation"]>)
@service({
  title: "WebSiteManagementClient",
})
@versioned(Versions)
namespace Microsoft.CertificateRegistration;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2021-02-01 API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2021_02_01: "2021-02-01",
}
