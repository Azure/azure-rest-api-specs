using Http;
using Rest;
using Azure.Core;
using Azure.Core.Traits;

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
  },
  TraitContext.List
>;

/** Error responses for the listSecrets operation. */
alias ListSecretsErrors = UnauthorizedErrorResult | InternalServerErrorResult;

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

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "The controller exposes /keys and /peek subroutes, while PUT may return either 200 or 201."
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "Operation names mirror the implemented /keys, /peek, and PUT secret endpoints."
@tag("secrets")
interface SecretsOperations {
  /** Deletes an entire secret. */
  @summary("Deletes an entire secret.")
  deleteSecret is SecretDeleteOperations.ResourceDelete<Secret>;

  /** Lists all secrets in the sandbox group. */
  @summary("Lists all secrets in the sandbox group.")
  listSecrets is SecretListOperations.ResourceList<Secret, ListSecretTraits>;

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
