import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Site.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.AppService;
@doc("Hybrid Connection for an App Service app.")
@parentResource(Site)
model RelayServiceConnectionEntity
  is ProxyResource<RelayServiceConnectionEntityProperties> {
  @doc("Name of the hybrid connection.")
  @path
  @key("entityName")
  @segment("hybridconnection")
  name: string;
}

@armResourceOperations
interface WebApps {
  @doc("Description for Gets a hybrid connection configuration by its name.")
  getRelayServiceConnection is ArmResourceRead<RelayServiceConnectionEntity>;
  @doc("Description for Creates a new hybrid connection configuration (PUT), or updates an existing one (PATCH).")
  createOrUpdateRelayServiceConnection is ArmResourceCreateOrReplaceSync<RelayServiceConnectionEntity>;
  @doc("Description for Creates a new hybrid connection configuration (PUT), or updates an existing one (PATCH).")
  updateRelayServiceConnection is ArmResourcePatchSync<
    RelayServiceConnectionEntity,
    RelayServiceConnectionEntityProperties
  >;
  @doc("Description for Deletes a relay service connection by its name.")
  deleteRelayServiceConnection is ArmResourceDeleteSync<RelayServiceConnectionEntity>;
}
