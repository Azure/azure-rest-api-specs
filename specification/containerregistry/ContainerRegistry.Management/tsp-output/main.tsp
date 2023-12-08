import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./ContainerRegistry.tsp";
import "./ContainerRegistryPrivateLinkResource.tsp";
import "./ContainerRegistryPrivateEndpointConnection.tsp";
import "./ContainerRegistryReplication.tsp";
import "./ScopeMap.tsp";
import "./ContainerRegistryToken.tsp";
import "./ContainerRegistryWebhook.tsp";
import "./ContainerRegistryAgentPool.tsp";
import "./ContainerRegistryRun.tsp";
import "./ContainerRegistryTaskRun.tsp";
import "./ContainerRegistryTask.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
@armProviderNamespace
@service({
  title: "ContainerRegistryManagementClient",
})
@doc("// FIXME: (miissing-service-description) Add service description")
namespace Azure.ResourceManager.ContainerRegistry;
