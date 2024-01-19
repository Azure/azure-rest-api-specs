import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Registry.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ContainerRegistry;
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
  create is ArmResourceCreateOrUpdateAsync<
    Token,
    BaseParameters<Token>,
    ArmAsyncOperationHeader
  >;

  @doc("Updates a token with the specified parameters.")
  update is ArmCustomPatchAsync<
    Token,
    TokenUpdateParameters,
    BaseParameters<Token>,
    ArmAsyncOperationHeader
  >;

  @doc("Deletes a token from a container registry.")
  delete is ArmResourceDeleteAsync<
    Token,
    BaseParameters<Token>,
    ArmLroLocationHeader
  >;

  @doc("Lists all the tokens for the specified container registry.")
  list is ArmResourceListByParent<Token>;
}

@@projectedName(Tokens.create::parameters.resource,
  "json",
  "tokenCreateParameters"
);
@@extension(Tokens.create::parameters.resource,
  "x-ms-client-name",
  "tokenCreateParameters"
);
@@doc(Tokens.create::parameters.resource,
  "The parameters for creating a token."
);
@@projectedName(Tokens.update::parameters.properties,
  "json",
  "tokenUpdateParameters"
);
@@extension(Tokens.update::parameters.properties,
  "x-ms-client-name",
  "tokenUpdateParameters"
);
@@doc(Tokens.update::parameters.properties,
  "The parameters for updating a token."
);
