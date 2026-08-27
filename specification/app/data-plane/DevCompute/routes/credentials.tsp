using Http;
using Azure.Core;

namespace AzureDevCompute;

/** No Content. */
model DeleteCredentialsResponse {
  /** HTTP response status code. */
  @statusCode statusCode: 204;
}

/** Errors returned by deleteCredentials. */
alias DeleteCredentialsErrors = ErrorResponse<404>;

/** OK. */
model ListCredentialResponse {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: SandboxGroupCredentialResponse[];
}

/** OK. */
model GetCredentialResponse {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: SandboxGroupCredentialResponse;
}

/** Errors returned by getCredentials. */
alias GetCredentialErrors = ErrorResponse<404>;

/** OK. */
model PutCredentialsResponse {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: SandboxGroupCredentialResponse;
}

/** Errors returned by putCredentials. */
alias PutCredentialsErrors = ErrorResponse<400>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Custom operations preserve the source OpenAPI response status codes, bare arrays, and route shapes."
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "Operation names are derived from the established source routes to keep generated names deterministic."
@tag("credentials")
interface CredentialsOperations {
  /** Deletes a credential in a sandbox group. */
  @summary("Deletes a credential in a sandbox group.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/credentials/{credentialName}")
  @delete
  deleteCredentials is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** credentialName parameter. */
      @path credentialName: string;
    },
    DeleteCredentialsResponse,
    DataPlaneStandardTraits,
    DeleteCredentialsErrors
  >;

  /** Lists all credentials in a sandbox group. */
  @summary("Lists all credentials in a sandbox group.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/credentials")
  @get
  listCredentials is Foundations.Operation<
    {
      ...AzureResourceScope;
    },
    ListCredentialResponse,
    DataPlaneStandardTraits,
    never
  >;

  /** Gets a specific credential by name in a sandbox group. */
  @summary("Gets a specific credential by name in a sandbox group.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/credentials/{credentialName}")
  @get
  getCredentials is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** credentialName parameter. */
      @path credentialName: string;
    },
    GetCredentialResponse,
    DataPlaneStandardTraits,
    GetCredentialErrors
  >;

  /** Creates or updates a credential in a sandbox group. If the credential already exists, it will be updated; otherwise, a new credential will be created. */
  @summary("Creates or updates a credential in a sandbox group.\nIf the credential already exists, it will be updated; otherwise, a new credential will be created.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/credentials/{credentialName}")
  @put
  putCredentials is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** credentialName parameter. */
      @path credentialName: string;

      /** Request body. */
      @body body: SandboxGroupCredentialRequest;
    },
    PutCredentialsResponse,
    DataPlaneStandardTraits,
    PutCredentialsErrors
  >;
}
