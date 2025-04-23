import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Azure.AI.Projects;

@doc("Metadata pertaining to creation and last modification of the resource.")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v_latest)
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

@doc("The available sorting options when requesting a list of response objects.")
union ListSortOrder {
  string,

  @doc("Specifies an ascending sort order.")
  ascending: "asc",

  @doc("Specifies a descending sort order.")
  descending: "desc",
}

@doc("List View Type Definition")
union ListViewType {
  string,

  @doc("List only active items.")
  ActiveOnly: "ActiveOnly",

  @doc("List only archived items.")
  ArchivedOnly: "ArchivedOnly",

  @doc("List all items.")
  All: "All",
}

alias AssetBase = {
  @doc("Asset stage")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  stage?: string;

  @doc("A unique identifier for the asset, assetId probably?")
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

  @doc("Temporary Blob Reference is the only supported type.")
  temporaryBlobReference: "TemporaryBlobReference",
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

  @doc("Name of Azure blob storage connection to use for generating temporary SAS token")
  connectionName?: string;

  @doc("TemporaryBlobReference is the only supported type.")
  pendingUploadType: PendingUploadType.temporaryBlobReference;
}

@doc("Represents the response for a pending upload request")
model PendingUploadResponse {
  @doc("Container-level read, write, list SAS.")
  blobReferenceForConsumption: BlobReferenceForConsumption;

  @doc("ID for this upload request.")
  pendingUploadId: string;

  @doc("Version of dataset to be created if user did not specify version when initially creating upload")
  datasetVersion?: string;

  @doc("TemporaryBlobReference is the only supported type")
  pendingUploadType: PendingUploadType.temporaryBlobReference;
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

@doc("Represents a reference to a blob for consumption")
model BlobReferenceForConsumption {
  @doc("Blob URI path for client to upload data. Example: https://blob.windows.core.net/Container/Path")
  blobUri: Uri;

  @doc("ARM ID of the storage account to use.")
  storageAccountArmId: string;

  @doc("Credential info to access the storage account.")
  credential: SasCredential;
}

// Asset Download Models
@doc("Asset Credential Request")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v_latest)
model AssetCredentialRequest {
  @doc("Blob URI")
  BlobUri: string;
}

@doc("Blob Reference Credential Type")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v_latest)
union BlobReferenceCredentialType {
  string,

  @doc("Shared Access Signature")
  SAS: "SAS",
}

@doc("Represents a reference to a blob for consumption")
model AssetCredentialResponse {
  @doc("Credential info to access the storage account.")
  blobReferenceForConsumption: BlobReferenceForConsumption;
}
