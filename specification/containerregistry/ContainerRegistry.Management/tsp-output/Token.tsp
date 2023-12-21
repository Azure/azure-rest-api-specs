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
@doc("An object that represents a token for a container registry.")
@parentResource(Registry)
model Token is ProxyResource<TokenProperties> {
  @doc("The name of the token.")
  @maxLength(50)
  @minLength(5)
  @pattern("^[a-zA-Z0-9-]*$")
  @path
  @key("tokenName")
  @segment("tokens")
  name: string;
}

@armResourceOperations
interface Tokens {
  @doc("Gets the properties of the specified token.")
  get is ArmResourceRead<Token>;
  @doc("Creates a token for a container registry with the specified parameters.")
  create is ArmResourceCreateOrUpdateAsync<Token>;
  @doc("Updates a token with the specified parameters.")
  update is ArmResourcePatchAsync<Token, TokenProperties>;
  @doc("Deletes a token from a container registry.")
  delete is ArmResourceDeleteAsync<Token>;
  @doc("Lists all the tokens for the specified container registry.")
  list is ArmResourceListByParent<Token>;
}
