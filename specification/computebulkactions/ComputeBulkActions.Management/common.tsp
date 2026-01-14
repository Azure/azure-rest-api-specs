import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager;

namespace Microsoft.ComputeBulkActions;

@doc("ApiError for Fleet")
model ApiError is ApiErrorBase {
  @identifiers(#["message", "target"])
  @doc("The API error details")
  details?: Array<ApiErrorBase>;

  @doc("The API inner error")
  innererror?: InnerError;
}

@doc("API error base.")
model ApiErrorBase {
  @doc("The error code.")
  code?: string;

  @doc("The target of the particular error.")
  target?: string;

  @doc("The error message.")
  message?: string;
}

@doc("Inner error details.")
model InnerError {
  @doc("The exception type.")
  exceptionType?: string;

  @doc("The internal error message or exception dump.")
  errorDetail?: string;
}

@doc("Describes a reference to a sub-resource.")
model SubResource {
  @doc("The ID of the sub-resource.")
  id?: string;
}

@doc("Describes a reference to Key Vault Secret")
model KeyVaultSecretReference {
  @doc("The URL referencing a secret in a Key Vault.")
  secretUrl: string;

  @doc("The relative URL of the Key Vault containing the secret.")
  sourceVault: SubResource;
}
