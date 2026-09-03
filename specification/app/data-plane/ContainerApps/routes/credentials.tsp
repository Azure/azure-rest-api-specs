using Http;
using Azure.Core;

namespace ContainerAppsSandbox;

/** No Content. */
model DeleteCredentialResult {
  /** HTTP response status code. */
  @statusCode statusCode: 204;
}

/** Errors returned by deleteCredential. */
alias DeleteCredentialErrors = ErrorResult<404>;

/** OK. */
model ListCredentialResult {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: SandboxGroupCredential[];
}

/** OK. */
model GetCredentialResult {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: SandboxGroupCredential;
}

/** Errors returned by getCredential. */
alias GetCredentialErrors = ErrorResult<404>;

/** OK. */
model PutCredentialResult {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: SandboxGroupCredential;
}

/** Errors returned by putCredential. */
alias PutCredentialErrors = ErrorResult<400>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Custom operations preserve the source OpenAPI response status codes, bare arrays, and route shapes."
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "Operation names are derived from the established source routes to keep generated names deterministic."
@tag("credentials")
interface CredentialsOperations {
  /** Deletes a credential in a sandbox group. */
  @summary("Deletes a credential in a sandbox group.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/credentials/{credentialName}")
  @delete
  deleteCredential is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** credentialName parameter. */
      @path credentialName: string;
    },
    DeleteCredentialResult,
    DataPlaneStandardTraits,
    DeleteCredentialErrors
  >;

  /** Lists all credentials in a sandbox group. */
  @summary("Lists all credentials in a sandbox group.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/credentials")
  @get
  listCredentials is Foundations.Operation<
    {
      ...AzureResourceScope;
    },
    ListCredentialResult,
    DataPlaneStandardTraits,
    never
  >;

  /** Gets a specific credential by name in a sandbox group. */
  @summary("Gets a specific credential by name in a sandbox group.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/credentials/{credentialName}")
  @get
  getCredential is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** credentialName parameter. */
      @path credentialName: string;
    },
    GetCredentialResult,
    DataPlaneStandardTraits,
    GetCredentialErrors
  >;

  /** Creates or updates a credential in a sandbox group. If the credential already exists, it will be updated; otherwise, a new credential will be created. */
  @summary("Creates or updates a credential in a sandbox group.\nIf the credential already exists, it will be updated; otherwise, a new credential will be created.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/credentials/{credentialName}")
  @put
  putCredential is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** credentialName parameter. */
      @path credentialName: string;

      /** Request body. */
      @body body: SandboxGroupCredentialContent;
    },
    PutCredentialResult,
    DataPlaneStandardTraits,
    PutCredentialErrors
  >;
}
