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
#suppress "@azure-tools/typespec-azure-core/no-openapi" "Need to mark this as nullable"
@OpenAPI.extension("x-nullable", true)
model Error {
  /**
   * The error code.
   */
  @visibility("read")
  code?: string;

  /**
   * The error message.
   */
  @visibility("read")
  message?: string;

  /**
   * The key vault server error.
   */
  @visibility("read")
  @encodedName("application/json", "innererror")
  innerError?: Error;
}

/**
 * The key vault error exception.
 */
@error
model KeyVaultError {
  /**
   * The key vault server error.
   */
  @visibility("read")
  error?: Error;
}
