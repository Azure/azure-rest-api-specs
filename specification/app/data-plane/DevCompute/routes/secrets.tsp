using Http;
using Azure.Core;

namespace AzureDevCompute;

/** No Content. */
model DeleteSecretsResponse {
  /** HTTP response status code. */
  @statusCode statusCode: 204;
}

/** Errors returned by deleteSecrets. */
alias DeleteSecretsErrors =
  | ErrorResponse<401>
  | ErrorResponse<404>
  | InternalServerErrorNoBody;

/** OK. */
model GetSecretsResponse {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: SecretListResponse;
}

/** Errors returned by getSecrets. */
alias GetSecretsErrors = ErrorResponse<401> | InternalServerErrorNoBody;

/** OK. */
model GetSecretsKeysResponse {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: SecretKeysResponse;
}

/** Errors returned by getSecretsKeys. */
alias GetSecretsKeysErrors =
  | ErrorResponse<401>
  | ErrorResponse<404>
  | InternalServerErrorNoBody;

/** OK. */
model PostSecretsPeekResponse {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: SecretPeekResponse;
}

/** Errors returned by postSecretsPeek. */
alias PostSecretsPeekErrors =
  | ErrorResponse<401>
  | ErrorResponse<404>
  | InternalServerErrorNoBody;

/** OK. */
model PutSecretsResponse200 {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: SecretResponse;
}

/** Created. */
model PutSecretsResponse201 {
  /** HTTP response status code. */
  @statusCode statusCode: 201;

  /** Response body. */
  @body body: SecretResponse;
}

/** Successful responses returned by putSecrets. */
alias PutSecretsResponse = PutSecretsResponse200 | PutSecretsResponse201;

/** Errors returned by putSecrets. */
alias PutSecretsErrors =
  | ErrorResponse<400>
  | ErrorResponse<401>
  | InternalServerErrorNoBody;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Custom operations preserve the source OpenAPI response status codes, bare arrays, and route shapes."
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "Operation names are derived from the established source routes to keep generated names deterministic."
@tag("secrets")
interface SecretsOperations {
  /** Deletes an entire secret. */
  @summary("Deletes an entire secret.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/secrets/{secretId}")
  @delete
  deleteSecrets is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** secretId parameter. */
      @path secretId: string;
    },
    DeleteSecretsResponse,
    DataPlaneStandardTraits,
    DeleteSecretsErrors
  >;

  /** Lists all secrets in the sandbox group. */
  @summary("Lists all secrets in the sandbox group.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/secrets")
  @get
  getSecrets is Foundations.Operation<
    {
      ...AzureResourceScope;
    },
    GetSecretsResponse,
    DataPlaneStandardTraits,
    GetSecretsErrors
  >;

  /** Lists key names of a secret (values are not returned). */
  @summary("Lists key names of a secret (values are not returned).")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/secrets/{secretId}/keys")
  @get
  getSecretsKeys is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** secretId parameter. */
      @path secretId: string;
    },
    GetSecretsKeysResponse,
    DataPlaneStandardTraits,
    GetSecretsKeysErrors
  >;

  /** Peeks (retrieves) all secret values. */
  @summary("Peeks (retrieves) all secret values.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/secrets/{secretId}/peek")
  @post
  postSecretsPeek is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** secretId parameter. */
      @path secretId: string;
    },
    PostSecretsPeekResponse,
    DataPlaneStandardTraits,
    PostSecretsPeekErrors
  >;

  /** Upserts key-value pairs in a secret. */
  @summary("Upserts key-value pairs in a secret.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/secrets/{secretId}")
  @put
  putSecrets is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** secretId parameter. */
      @path secretId: string;

      /** Request body. */
      @body body: SecretUpsertRequest;
    },
    PutSecretsResponse,
    DataPlaneStandardTraits,
    PutSecretsErrors
  >;
}
