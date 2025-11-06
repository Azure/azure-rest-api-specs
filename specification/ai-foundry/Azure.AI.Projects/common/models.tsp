import "@typespec/http";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

namespace Azure.AI.Projects;

using TypeSpec.Http;

/** Error response for API failures. */
@error
model ApiErrorResponse {
  error: ApiError;
}

@error
model ApiError {
  /** The error code. */
  code: string;

  /** A human-readable description of the error. */
  message: string;

  /** The target of the error, if applicable. */
  target?: string;

  /** Additional details about the error. */
  details: ApiError[];

  /** The inner error, if any. */
  innererror?: ApiInnerError;
}

model ApiInnerError {
  /** The error code. */
  code: string;

  /** The inner error, if any. */
  innererror?: ApiInnerError;
}

alias AgentApiVersionParameter = {
  @query("api-version")
  @minLength(1)
  @doc("The API version to use for this operation.")
  apiVersion: string;
};

alias AcceptJsonHeader = {
  @header accept: "application/json";
};

alias CommonListObjectProperties = {
  @doc("The object type. Always 'list'.")
  object: "list";

  @firstLink
  @doc("ID of the first item in the returned page.")
  first_id: string;

  @lastLink
  @doc("ID of the last item in the returned page.")
  last_id: string;

  @doc("Whether more items are available after this page.")
  has_more: boolean;
};

#suppress "@azure-tools/typespec-azure-core/long-running-polling-operation-required" "No polling operation yet"
op AgentOperation<
  Params extends Reflection.Model,
  Response,
  ErrorResponse = ApiErrorResponse
>(...AgentApiVersionParameter, ...Params): Response | ErrorResponse;

#suppress "@azure-tools/typespec-azure-core/casing-style" "OpenAI is a case-sensitive name"
@doc("The response data for a requested list of items.")
model AgentsPagedResult<T> {
  /** The requested list of items. */
  @pageItems
  data: T[];

  /** The first ID represented in this list. */
  first_id?: string;

  /** The last ID represented in this list. */
  @continuationToken
  last_id?: string;

  /** A value indicating whether there are additional values available not captured in this list. */
  has_more: boolean;
}

alias AssetBase = {
  @doc("Asset ID, a unique identifier for the asset")
  @visibility(Lifecycle.Read)
  id?: string;

  @doc("The name of the resource")
  @visibility(Lifecycle.Read)
  @key
  name: string;

  @doc("The version of the resource")
  @visibility(Lifecycle.Read)
  version: string;

  @doc("The asset description text.")
  @visibility(Lifecycle.Create, Lifecycle.Update)
  description?: string;

  @doc("Tag dictionary. Tags can be added, removed, and updated.")
  @visibility(Lifecycle.Create, Lifecycle.Update)
  tags?: Record<string>;
};

#suppress "@azure-tools/typespec-providerhub/no-inline-model" "Need to create responses correctly"
alias ResourceCreatedResponse<T extends TypeSpec.Reflection.Model> = TypeSpec.Http.Response<201> &
  T;

#suppress "@azure-tools/typespec-providerhub/no-inline-model" "Need to create responses correctly"
alias OkResponse<T extends TypeSpec.Reflection.Model> = TypeSpec.Http.Response<200> &
  T;

// Pending upload spec

// Define a URI alias for clarity.
alias Uri = string;

@doc("The type of pending upload.")
union PendingUploadType {
  string,

  @doc("No pending upload.")
  none: "None",

  @doc("Blob Reference is the only supported type.")
  BlobReference: "BlobReference",
}

@doc("The type of credential used to access the storage account.")
union PendingUploadCredentialType {
  string,

  @doc("SAS credential type.")
  sas: "SAS",
}

@doc("Represents a request for a pending upload.")
model PendingUploadRequest {
  @doc("If PendingUploadId is not provided, a random GUID will be used.")
  pendingUploadId?: string;

  @doc("Azure Storage Account connection name to use for generating temporary SAS token")
  connectionName?: string;

  @doc("BlobReference is the only supported type.")
  pendingUploadType: PendingUploadType.BlobReference;
}

@doc("Represents the response for a pending upload request")
model PendingUploadResponse {
  @doc("Container-level read, write, list SAS.")
  blobReference: BlobReference;

  @doc("ID for this upload request.")
  pendingUploadId: string;

  @doc("Version of asset to be created if user did not specify version when initially creating upload")
  version?: string;

  @doc("BlobReference is the only supported type")
  pendingUploadType: PendingUploadType.BlobReference;
}

@doc("SAS Credential definition")
model SasCredential {
  @doc("SAS uri")
  @visibility(Lifecycle.Read)
  sasUri: string;

  @visibility(Lifecycle.Read)
  @doc("Type of credential")
  type: "SAS";
}

@doc("Blob reference details.")
model BlobReference {
  @doc("Blob URI path for client to upload data. Example: https://blob.windows.core.net/Container/Path")
  blobUri: Uri;

  @doc("ARM ID of the storage account to use.")
  storageAccountArmId: string;

  @doc("Credential info to access the storage account.")
  credential: SasCredential;
}

@doc("Represents a reference to a blob for consumption")
model AssetCredentialResponse {
  @doc("Credential info to access the storage account.")
  blobReference: BlobReference;
}
