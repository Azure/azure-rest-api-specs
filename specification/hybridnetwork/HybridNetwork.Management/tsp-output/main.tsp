import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./ConfigurationGroupSchema.tsp";
import "./ConfigurationGroupValue.tsp";
import "./NetworkFunction.tsp";
import "./Component.tsp";
import "./NetworkFunctionDefinitionGroup.tsp";
import "./NetworkFunctionDefinitionVersion.tsp";
import "./NetworkServiceDesignGroup.tsp";
import "./NetworkServiceDesignVersion.tsp";
import "./Publisher.tsp";
import "./ArtifactStore.tsp";
import "./ArtifactManifest.tsp";
import "./Site.tsp";
import "./SiteNetworkService.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
/**
 * The definitions in this swagger specification will be used to manage the Hybrid Network resources.
 */
@armProviderNamespace
@service({
  title: "HybridNetworkManagementClient",
})
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v3)
namespace Microsoft.HybridNetwork;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2023-09-01 API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2023_09_01: "2023-09-01",
}
