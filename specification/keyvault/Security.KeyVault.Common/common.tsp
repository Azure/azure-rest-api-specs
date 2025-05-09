import "@azure-tools/typespec-azure-core";
import "@typespec/openapi";

using Azure.Core;
using TypeSpec.OpenAPI;

alias KeyVaultOperation<
  TParams extends Reflection.Model,
  TResponse,
  Traits extends Reflection.Model = {},
  TError = Error
> = Foundations.Operation<TParams, TResponse, Traits, KeyVaultError>;

/**
 * The key vault server error.
 */
#suppress "@azure-tools/typespec-azure-core/no-nullable" "Intentionally nullable model"
union Error {
  null,
  {
    /**
     * The error code.
     */
    @visibility(Lifecycle.Read)
    code?: string,

    /**
     * The error message.
     */
    @visibility(Lifecycle.Read)
    message?: string,

    /**
     * The key vault server error.
     */
    @visibility(Lifecycle.Read)
    @encodedName("application/json", "innererror")
    innerError?: Error,
  },
}

/**
 * The key vault error exception.
 */
@error
model KeyVaultError {
  /**
   * The key vault server error.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Intentionally nullable model"
  @visibility(Lifecycle.Read)
  error?: Error;
}
