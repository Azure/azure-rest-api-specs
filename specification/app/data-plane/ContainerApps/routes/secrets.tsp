using Http;
using Rest;
using Azure.Core;

namespace ContainerAppsSandbox;

/** Error responses for the deleteSecret operation. */
alias DeleteSecretErrors =
  | UnauthorizedErrorResult
  | NotFoundErrorResult
  | InternalServerErrorResult;

/** Shared operation traits for deleting secrets. */
alias SecretDeleteOperations = ResourceOperations<
  DataPlaneStandardTraits,
  DeleteSecretErrors
>;

/** The HTTP 200 response for the getSecrets operation. */
model GetSecretsResult {
  /** The HTTP 200 status code. */
  @statusCode statusCode: 200;

  /** The returned secrets. */
  @body body: SecretListResponse;
}

/** Error responses for the getSecrets operation. */
alias GetSecretsErrors = UnauthorizedErrorResult | InternalServerErrorResult;

/** The HTTP 200 response for the getSecretKeys operation. */
model GetSecretKeysResult {
  /** The HTTP 200 status code. */
  @statusCode statusCode: 200;

  /** The returned secret keys. */
  @body body: SecretKeysResponse;
}

/** Error responses for the getSecretKeys operation. */
alias GetSecretKeysErrors =
  | UnauthorizedErrorResult
  | NotFoundErrorResult
  | InternalServerErrorResult;

/** The HTTP 200 response for the postSecretPeek operation. */
model PostSecretPeekResult {
  /** The HTTP 200 status code. */
  @statusCode statusCode: 200;

  /** The returned secret values. */
  @body body: SecretPeekResponse;
}

/** Error responses for the postSecretPeek operation. */
alias PostSecretPeekErrors =
  | UnauthorizedErrorResult
  | NotFoundErrorResult
  | InternalServerErrorResult;

/** Shared operation traits for peeking secrets. */
alias SecretPeekOperations = ResourceOperations<
  DataPlaneStandardTraits,
  PostSecretPeekErrors
>;

/** The HTTP 200 response for the putSecret operation. */
model PutSecretResult200 {
  /** The HTTP 200 status code. */
  @statusCode statusCode: 200;

  /** The returned secret. */
  @body body: Secret;
}

/** The HTTP 201 response for the putSecret operation. */
model PutSecretResult201 {
  /** The HTTP 201 status code. */
  @statusCode statusCode: 201;

  /** The returned secret. */
  @body body: Secret;
}

/** Successful responses for the putSecret operation. */
alias PutSecretResult = PutSecretResult200 | PutSecretResult201;

/** Error responses for the putSecret operation. */
alias PutSecretErrors =
  | BadRequestErrorResult
  | UnauthorizedErrorResult
  | InternalServerErrorResult;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Custom operations preserve the source OpenAPI response status codes, bare arrays, and route shapes."
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "Operation names are derived from the established source routes to keep generated names deterministic."
@tag("secrets")
interface SecretsOperations {
  /** Deletes an entire secret. */
  @summary("Deletes an entire secret.")
  deleteSecret is SecretDeleteOperations.ResourceDelete<Secret>;

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

      /** The secret identifier. */
      @path secretId: string;
    },
    GetSecretKeysResult,
    DataPlaneStandardTraits,
    GetSecretKeysErrors
  >;

  /** Peeks (retrieves) all secret values. */
  @summary("Peeks (retrieves) all secret values.")
  @action("peek")
  @actionSeparator("/")
  postSecretPeek is SecretPeekOperations.ResourceAction<
    Secret,
    {},
    PostSecretPeekResult
  >;

  /** Upserts key-value pairs in a secret. */
  @summary("Upserts key-value pairs in a secret.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/secrets/{secretId}")
  @put
  putSecret is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** The secret identifier. */
      @path secretId: string;

      /** The secret key-value pairs to store. */
      @body body: CreateSecretContent;
    },
    PutSecretResult,
    DataPlaneStandardTraits,
    PutSecretErrors
  >;
}
