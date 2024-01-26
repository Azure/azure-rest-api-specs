import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./AzureDevOpsConnector.tsp";
import "./AzureDevOpsRepo.tsp";
import "./AzureDevOpsOrg.tsp";
import "./AzureDevOpsProject.tsp";
import "./GitHubConnector.tsp";
import "./GitHubRepo.tsp";
import "./GitHubOwner.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
/**
 * REST APIs for Defender for DevOps
 */
@armProviderNamespace
@useAuth(AadOauth2Auth<["user_impersonation"]>)
@service({
  title: "Microsoft.SecurityDevOps",
})
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v3)
namespace Microsoft.SecurityDevOps;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2022-09-01-preview API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2022_09_01_preview: "2022-09-01-preview",
}
