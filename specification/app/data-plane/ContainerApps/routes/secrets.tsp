using Http;
using Azure.Core;

namespace ContainerAppsSandbox;

/** No Content. */
model DeleteSecretResult {
  /** HTTP response status code. */
  @statusCode statusCode: 204;
}

/** Errors returned by deleteSecret. */
alias DeleteSecretErrors =
  | ErrorResult<401>
  | ErrorResult<404>
  | ErrorResult<500>;

/** OK. */
model GetSecretsResult {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: SecretListResponse;
}

/** Errors returned by getSecrets. */
alias GetSecretsErrors = ErrorResult<401> | ErrorResult<500>;

/** OK. */
model GetSecretKeysResult {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: SecretKeysResponse;
}

/** Errors returned by getSecretKeys. */
alias GetSecretKeysErrors =
  | ErrorResult<401>
  | ErrorResult<404>
  | ErrorResult<500>;

/** OK. */
model PostSecretPeekResult {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: SecretPeekResponse;
}

/** Errors returned by postSecretPeek. */
alias PostSecretPeekErrors =
  | ErrorResult<401>
  | ErrorResult<404>
  | ErrorResult<500>;

/** OK. */
model PutSecretResult200 {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: Secret;
}

/** Created. */
model PutSecretResult201 {
  /** HTTP response status code. */
  @statusCode statusCode: 201;

  /** Response body. */
  @body body: Secret;
}

/** Successful responses returned by putSecret. */
alias PutSecretResult = PutSecretResult200 | PutSecretResult201;

/** Errors returned by putSecret. */
alias PutSecretErrors = ErrorResult<400> | ErrorResult<401> | ErrorResult<500>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Custom operations preserve the source OpenAPI response status codes, bare arrays, and route shapes."
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "Operation names are derived from the established source routes to keep generated names deterministic."
@tag("secrets")
interface SecretsOperations {
  /** Deletes an entire secret. */
  @summary("Deletes an entire secret.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/secrets/{secretId}")
  @delete
  deleteSecret is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** secretId parameter. */
      @path secretId: string;
    },
    DeleteSecretResult,
    DataPlaneStandardTraits,
    DeleteSecretErrors
  >;

  /** Lists all secrets in the sandbox group. */
  @summary("Lists all secrets in the sandbox group.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/secrets")
  @get
  getSecrets is Foundations.Operation<
    {
      ...AzureResourceScope;
    },
    GetSecretsResult,
    DataPlaneStandardTraits,
    GetSecretsErrors
  >;

  /** Lists key names of a secret (values are not returned). */
  @summary("Lists key names of a secret (values are not returned).")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/secrets/{secretId}/keys")
  @get
  getSecretKeys is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** secretId parameter. */
      @path secretId: string;
    },
    GetSecretKeysResult,
    DataPlaneStandardTraits,
    GetSecretKeysErrors
  >;

  /** Peeks (retrieves) all secret values. */
  @summary("Peeks (retrieves) all secret values.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/secrets/{secretId}/peek")
  @post
  postSecretPeek is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** secretId parameter. */
      @path secretId: string;
    },
    PostSecretPeekResult,
    DataPlaneStandardTraits,
    PostSecretPeekErrors
  >;

  /** Upserts key-value pairs in a secret. */
  @summary("Upserts key-value pairs in a secret.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/secrets/{secretId}")
  @put
  putSecret is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** secretId parameter. */
      @path secretId: string;

      /** Request body. */
      @body body: CreateSecretContent;
    },
    PutSecretResult,
    DataPlaneStandardTraits,
    PutSecretErrors
  >;
}
