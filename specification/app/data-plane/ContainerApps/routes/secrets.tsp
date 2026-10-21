using Http;
using Rest;
using Azure.Core;
using Azure.Core.Traits;
using Versioning;

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

/** Query parameters for listing secrets. */
alias ListSecretTraits = QueryParametersTrait<
  {
    /** Continuation token for paginated results. */
    @query @continuationToken skipToken?: string;

    /** Number of secrets per page, from 1 to 100. Defaults to 25 when skipToken is absent; when provided with skipToken, it must match the token's page size. */
    @added(ApiVersions.v2026_10_01_preview)
    @minValue(1)
    @maxValue(100)
    @query
    pageSize?: int32;
  },
  TraitContext.List
>;

/** Error responses for the listSecrets operation. */
alias ListSecretsErrors =
  | BadRequestErrorResult
  | UnauthorizedErrorResult
  | InternalServerErrorResult;

/** Shared operation traits for listing secrets. */
alias SecretListOperations = ResourceOperations<
  DataPlaneStandardTraits,
  ListSecretsErrors
>;

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
  | InternalServerErrorResult
  | ServiceUnavailableErrorResult;

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

/**
 * An error envelope instantiated only in versions that return its status code.
 * @template StatusCode The HTTP error status code.
 */
@error
model SecretErrorResult<StatusCode extends int32> {
  /** The HTTP error status code. */
  @statusCode statusCode: StatusCode;

  ...Foundations.ErrorResponse;
}

/** Error responses for the putSecret operation. */
alias PutSecretErrors =
  | BadRequestErrorResult
  | UnauthorizedErrorResult
  | SecretErrorResult<403>
  | NotFoundErrorResult
  | ConflictErrorResult
  | TooManyRequestsErrorResult
  | InternalServerErrorResult
  | ServiceUnavailableErrorResult;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "The controller exposes /keys and /peek subroutes, while PUT may return either 200 or 201."
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "Operation names mirror the implemented /keys, /peek, and PUT secret endpoints."
@tag("secrets")
interface SecretsOperations {
  /** Deletes an entire secret. */
  @summary("Deletes an entire secret.")
  deleteSecret is SecretDeleteOperations.ResourceDelete<Secret>;

  /** Lists all secrets in the sandbox group. */
  @summary("Lists all secrets in the sandbox group.")
  @returnTypeChangedFrom(
    ApiVersions.v2026_10_01_preview,

      | Foundations.CustomPage<
          Secret,
          DataPlaneStandardTraits & ListSecretTraits
        >
      | UnauthorizedErrorResult
      | InternalServerErrorResult
  )
  listSecrets is SecretListOperations.ResourceList<Secret, ListSecretTraits>;

  /** Lists key names of a secret (values are not returned). */
  @summary("Lists key names of a secret (values are not returned).")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/secrets/{secretId}/keys")
  @get
  getSecretKeys is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** The secret identifier. */
      @path secretId: SecretId;
    },
    GetSecretKeysResult,
    DataPlaneStandardTraits,
    GetSecretKeysErrors
  >;

  /** Peeks (retrieves) all secret values. */
  @summary("Peeks (retrieves) all secret values.")
  @action("peek")
  @actionSeparator("/")
  @returnTypeChangedFrom(
    ApiVersions.v2026_10_01_preview,

      | (PostSecretPeekResult & {})
      | UnauthorizedErrorResult
      | NotFoundErrorResult
      | InternalServerErrorResult
  )
  postSecretPeek is SecretPeekOperations.ResourceAction<
    Secret,
    {},
    PostSecretPeekResult
  >;

  /** Upserts key-value pairs in a secret. */
  @summary("Upserts key-value pairs in a secret.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/secrets/{secretId}")
  @put
  @returnTypeChangedFrom(
    ApiVersions.v2026_10_01_preview,

      | PutSecretResult
      | BadRequestErrorResult
      | UnauthorizedErrorResult
      | InternalServerErrorResult
  )
  putSecret is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** The secret identifier. */
      @path secretId: SecretId;

      /** The secret key-value pairs to store. */
      @body body: CreateSecretContent;
    },
    PutSecretResult,
    DataPlaneStandardTraits,
    PutSecretErrors
  >;
}
