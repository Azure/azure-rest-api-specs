import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/http";
import "@typespec/versioning";

using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Azure.AI.Projects;

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

alias OpenAIListRequestOptions = {
  @doc("A limit on the number of objects to be returned. Limit can range between 1 and 100, and the default is 20.")
  @query
  limit?: int32 = 20;

  @doc("A cursor for use in pagination. after is an object ID that defines your place in the list. For instance, if you make a list request and receive 100 objects, ending with obj_foo, your subsequent call can include after=obj_foo in order to fetch the next page of the list.")
  @query
  after?: string;

  @doc("A cursor for use in pagination. before is an object ID that defines your place in the list. For instance, if you make a list request and receive 100 objects, starting with obj_foo, your subsequent call can include before=obj_foo in order to fetch the previous page of the list.")
  @query
  before?: string;
};

#suppress "@azure-tools/typespec-azure-core/casing-style" "OpenAI is a case-sensitive name"
@doc("The response data for a requested list of items.")
model OpenAIPageableListOf<T> {
  @doc("The object type, which is always list.")
  object: "list";

  @doc("The requested list of items.")
  data: T[];

  @encodedName("application/json", "first_id")
  @doc("The first ID represented in this list.")
  firstId: string;

  @encodedName("application/json", "last_id")
  @doc("The last ID represented in this list.")
  lastId: string;

  @encodedName("application/json", "has_more")
  @doc("A value indicating whether there are additional values available not captured in this list.")
  hasMore: boolean;
}

@doc("Metadata pertaining to creation and last modification of the resource.")
@added(Versions.v2025_05_15_preview)
model SystemData {
  @visibility(Lifecycle.Read)
  @doc("The timestamp the resource was created at.")
  createdAt?: utcDateTime;

  @visibility(Lifecycle.Read)
  @doc("The identity that created the resource.")
  createdBy?: string;

  @visibility(Lifecycle.Read)
  @doc("The identity type that created the resource.")
  createdByType?: string;

  @visibility(Lifecycle.Read)
  @doc("The timestamp of resource last modification (UTC)")
  lastModifiedAt?: utcDateTime;
}
