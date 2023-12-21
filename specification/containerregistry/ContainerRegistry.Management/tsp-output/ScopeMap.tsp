import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Registry.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.ContainerRegistry;
@doc("An object that represents a scope map for a container registry.")
@parentResource(Registry)
model ScopeMap is ProxyResource<ScopeMapProperties> {
  @doc("The name of the scope map.")
  @maxLength(50)
  @minLength(5)
  @pattern("^[a-zA-Z0-9-_]*$")
  @path
  @key("scopeMapName")
  @segment("scopeMaps")
  name: string;
}

@armResourceOperations
interface ScopeMaps {
  @doc("Gets the properties of the specified scope map.")
  get is ArmResourceRead<ScopeMap>;
  @doc("Creates a scope map for a container registry with the specified parameters.")
  create is ArmResourceCreateOrUpdateAsync<ScopeMap>;
  @doc("Updates a scope map with the specified parameters.")
  update is ArmResourcePatchAsync<ScopeMap, ScopeMapProperties>;
  @doc("Deletes a scope map from a container registry.")
  delete is ArmResourceDeleteAsync<ScopeMap>;
  @doc("Lists all the scope maps for the specified container registry.")
  list is ArmResourceListByParent<ScopeMap>;
}
