import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./Token.models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ContainerRegistry;
/**
 * An object that represents a token for a container registry.
 */
@parentResource(Registry)
model Token is Azure.ResourceManager.ProxyResource<TokenProperties> {
  ...ResourceNameParameter<
    Resource = Token,
    KeyName = "tokenName",
    SegmentName = "tokens",
    NamePattern = "^[a-zA-Z0-9-]*$"
  >;
}

@armResourceOperations
interface Tokens {
  /**
   * Gets the properties of the specified token.
   */
  get is ArmResourceRead<Token>;

  /**
   * Creates a token for a container registry with the specified parameters.
   */
  create is ArmResourceCreateOrReplaceAsync<Token>;

  /**
   * Updates a token with the specified parameters.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    Token,
    PatchModel = TokenUpdateParameters,
    Response = ArmResponse<Token> | ArmResourceCreatedResponse<
      Token,
      LroHeaders = ArmAsyncOperationHeader<FinalResult = Token> &
        Azure.Core.Foundations.RetryAfterHeader
    >
  >;

  /**
   * Deletes a token from a container registry.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    Token,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Lists all the tokens for the specified container registry.
   */
  @list
  list is ArmResourceListByParent<
    Token,
    Response = ArmResponse<TokenListResult>
  >;
}

@@maxLength(Token.name, 50);
@@minLength(Token.name, 5);
@@doc(Token.name, "The name of the token.");
@@doc(Token.properties, "The properties of the token.");
@@doc(Tokens.create::parameters.resource,
  "The parameters for creating a token."
);
@@doc(Tokens.update::parameters.properties,
  "The parameters for updating a token."
);
