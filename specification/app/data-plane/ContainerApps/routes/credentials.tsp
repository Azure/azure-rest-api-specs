using Http;
using Rest;
using Azure.Core;
using Azure.Core.Traits;

namespace ContainerAppsSandbox;

/** Error responses for the deleteCredential operation. */
alias DeleteCredentialErrors = NotFoundErrorResult;

/** Shared operation traits for deleting credentials. */
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

/** Shared operation traits for listing credentials. */
alias CredentialListOperations = ResourceOperations<
  DataPlaneStandardTraits,
  never
>;

/** Error responses for the getCredential operation. */
alias GetCredentialErrors = NotFoundErrorResult;

/** Shared operation traits for reading credentials. */
alias CredentialGetOperations = ResourceOperations<
  DataPlaneStandardTraits,
  GetCredentialErrors
>;

/** The HTTP 200 response for the putCredential operation. */
model PutCredentialResult {
  /** The HTTP 200 status code. */
  @statusCode statusCode: 200;

  /** The returned credential. */
  @body body: SandboxGroupCredential;
}

/** Error responses for the putCredential operation. */
alias PutCredentialErrors = BadRequestErrorResult;

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
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "The existing client method mirrors PUT /credentials/{credentialName} and is intentionally named putCredential."
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "PUT /credentials/{credentialName} accepts credential settings and always returns 200 with the stored credential."
  @summary("Creates or updates a credential in a sandbox group.\nIf the credential already exists, it will be updated; otherwise, a new credential will be created.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/credentials/{credentialName}")
  @put
  putCredential is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** The credential name. */
      @path credentialName: string;

      /** The credential configuration to store. */
      @body body: CreateSandboxGroupCredentialContent;
    },
    PutCredentialResult,
    DataPlaneStandardTraits,
    PutCredentialErrors
  >;
}
