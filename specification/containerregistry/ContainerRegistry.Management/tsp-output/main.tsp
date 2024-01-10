import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./Registry.tsp";
import "./PrivateLinkResource.tsp";
import "./PrivateEndpointConnection.tsp";
import "./Replication.tsp";
import "./ScopeMap.tsp";
import "./Token.tsp";
import "./Webhook.tsp";
import "./AgentPool.tsp";
import "./Run.tsp";
import "./TaskRun.tsp";
import "./Task.tsp";

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
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v4)
@doc("// FIXME: (miissing-service-description) Add service description")
namespace Microsoft.ContainerRegistry;
