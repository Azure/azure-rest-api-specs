import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./NamespaceResource.tsp";
import "./NamespaceAuthorizationRule.tsp";
import "./NamespaceNotificationHubAuthorizationRule.tsp";
import "./NotificationHubResource.tsp";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
@armProviderNamespace
@service({
  title: "NotificationHubsManagementClient",
})
@versioned(Versions)
@doc("Azure NotificationHub client")
namespace Microsoft.NotificationHubs;

@doc("The available API versions.")
enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2017_04_01: "2017-04-01",
}
