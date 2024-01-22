import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./NamespaceResource.tsp";
import "./SharedAccessAuthorizationRuleResource.tsp";
import "./SharedAccessAuthorizationRuleResource.tsp";
import "./NotificationHubResource.tsp";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
/**
 * Azure NotificationHub client
 */
@armProviderNamespace
@service({
  title: "NotificationHubsManagementClient",
})
@versioned(Versions)
namespace Microsoft.NotificationHubs;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2017-04-01 API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2017_04_01: "2017-04-01",
}
