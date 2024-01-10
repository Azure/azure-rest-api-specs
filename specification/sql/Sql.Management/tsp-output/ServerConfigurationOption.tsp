import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedInstance.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.Sql;
@doc("A server configuration option")
@parentResource(ManagedInstance)
model ServerConfigurationOption
  is ProxyResource<ServerConfigurationOptionProperties> {
  @doc("The name of the server configuration option.")
  @key("serverConfigurationOptionName")
  @segment("serverConfigurationOptions")
  name: ServerConfigurationOptionName;
}

@armResourceOperations
interface ServerConfigurationOptions {
  @doc("Gets managed instance server configuration option.")
  get is ArmResourceRead<ServerConfigurationOption>;

  @doc("Updates managed instance server configuration option.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ServerConfigurationOption>;

  @doc("Gets a list of managed instance server configuration options.")
  listByManagedInstance is ArmResourceListByParent<ServerConfigurationOption>;
}
