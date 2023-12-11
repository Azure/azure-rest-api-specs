import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./WebSite.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.AppService;
@doc("Hybrid Connection for an App Service app.")
@parentResource(WebSite)
model WebSiteHybridConnection
  is ProxyResource<RelayServiceConnectionEntityProperties> {
  @doc("Name of the hybrid connection.")
  @path
  @key("entityName")
  @segment("hybridconnection")
  name: string;
}

@armResourceOperations
interface WebSiteHybridConnections {
  @doc("Description for Gets a hybrid connection configuration by its name.")
  getRelayServiceConnection is ArmResourceRead<WebSiteHybridConnection>;
  @doc("Description for Creates a new hybrid connection configuration (PUT), or updates an existing one (PATCH).")
  createOrUpdateRelayServiceConnection is ArmResourceCreateOrReplaceSync<WebSiteHybridConnection>;
  @doc("Description for Creates a new hybrid connection configuration (PUT), or updates an existing one (PATCH).")
  updateRelayServiceConnection is ArmResourcePatchSync<
    WebSiteHybridConnection,
    RelayServiceConnectionEntityProperties
  >;
  @doc("Description for Deletes a relay service connection by its name.")
  deleteRelayServiceConnection is ArmResourceDeleteSync<WebSiteHybridConnection>;
}
