using Http;
using Rest;
using Azure.Core;
using Azure.Core.Traits;

namespace ContainerAppsSandbox;

/** Errors returned by deleteCredential. */
alias DeleteCredentialErrors = NotFoundErrorResult;

/** Standard resource operations for deleting credentials. */
alias CredentialDeleteOperations = ResourceOperations<
  DataPlaneStandardTraits,
  DeleteCredentialErrors
>;

/** Query parameters for listing credentials. */
alias ListCredentialTraits = QueryParametersTrait<
  {
    /** Continuation token for paginated results. */
    @query @continuationToken skipToken?: string;
  },
  TraitContext.List
>;

/** Standard resource operations for listing credentials. */
alias CredentialListOperations = ResourceOperations<
  DataPlaneStandardTraits,
  never
>;

/** Errors returned by getCredential. */
alias GetCredentialErrors = NotFoundErrorResult;

/** Standard resource operations for reading credentials. */
alias CredentialGetOperations = ResourceOperations<
  DataPlaneStandardTraits,
  GetCredentialErrors
>;

/** OK. */
model PutCredentialResult {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: SandboxGroupCredential;
}

/** Errors returned by putCredential. */
alias PutCredentialErrors = BadRequestErrorResult;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Custom operations preserve the source OpenAPI response status codes, query parameters, and route shapes."
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "Operation names are derived from the established source routes to keep generated names deterministic."
@tag("credentials")
interface CredentialsOperations {
  /** Deletes a credential in a sandbox group. */
  @summary("Deletes a credential in a sandbox group.")
  deleteCredential is CredentialDeleteOperations.ResourceDelete<SandboxGroupCredential>;

  /** Lists all credentials in a sandbox group. */
  @summary("Lists all credentials in a sandbox group.")
  listCredentials is CredentialListOperations.ResourceList<
    SandboxGroupCredential,
    ListCredentialTraits
  >;

  /** Gets a specific credential by name in a sandbox group. */
  @summary("Gets a specific credential by name in a sandbox group.")
  getCredential is CredentialGetOperations.ResourceRead<SandboxGroupCredential>;

  /** Creates or updates a credential in a sandbox group. If the credential already exists, it will be updated; otherwise, a new credential will be created. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Operation names are derived from the established source routes to keep generated names deterministic."
  @summary("Creates or updates a credential in a sandbox group.\nIf the credential already exists, it will be updated; otherwise, a new credential will be created.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/credentials/{credentialName}")
  @put
  putCredential is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** credentialName parameter. */
      @path credentialName: string;

      /** Request body. */
      @body body: CreateSandboxGroupCredentialContent;
    },
    PutCredentialResult,
    DataPlaneStandardTraits,
    PutCredentialErrors
  >;
}
