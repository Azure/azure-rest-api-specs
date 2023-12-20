import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedInstance.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Sql;
@doc("A server configuration option")
@parentResource(ManagedInstance)
model ManagedInstanceServerConfigurationOption
  is ProxyResource<ServerConfigurationOptionProperties> {
  @doc("The name of the server configuration option.")
  @path
  @key("serverConfigurationOptionName")
  @segment("serverConfigurationOptions")
  name: ServerConfigurationOptionName;
}

@armResourceOperations
interface ManagedInstanceServerConfigurationOptions {
  @doc("Gets managed instance server configuration option.")
  get is ArmResourceRead<ManagedInstanceServerConfigurationOption>;
  @doc("Updates managed instance server configuration option.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ManagedInstanceServerConfigurationOption>;
  @doc("Gets a list of managed instance server configuration options.")
  listByManagedInstance is ArmResourceListByParent<ManagedInstanceServerConfigurationOption>;
}
