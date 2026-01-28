import "@typespec/openapi";
import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";

import "../common/models.tsp";
import "../common/service.tsp";

namespace Azure.AI.Projects;

@doc("Enum to determine the type of data.")
union DatasetType {
  string,

  @doc("URI file.")
  uri_file: "uri_file",

  @doc("URI folder.")
  uri_folder: "uri_folder",
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance"
@doc("DatasetVersion Definition")
@Rest.resource("datasets")
@discriminator("type")
model DatasetVersion {
  @doc("URI of the data ([example](https://go.microsoft.com/fwlink/?linkid=2202330))")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @minLength(1)
  @pattern("[a-zA-Z0-9_]")
  dataUri: string;

  @doc("Dataset type")
  type: DatasetType;

  @doc("Indicates if the dataset holds a reference to the storage, or the dataset manages storage itself. If true, the underlying data will not be deleted when the dataset version is deleted")
  @visibility(Lifecycle.Read)
  isReference?: boolean;

  @doc("The Azure Storage Account connection name. Required if startPendingUploadVersion was not called before creating the Dataset")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  connectionName?: string;

  ...AssetBase;
}

@doc("FileDatasetVersion Definition")
model FileDatasetVersion extends DatasetVersion {
  @doc("Dataset type")
  type: DatasetType.uri_file;
}

@doc("FileDatasetVersion Definition")
model FolderDatasetVersion extends DatasetVersion {
  @doc("Dataset type")
  type: DatasetType.uri_folder;
}

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

@doc("Blob reference details.")
model BlobReference {
  @doc("Blob URI path for client to upload data. Example: `https://blob.windows.core.net/Container/Path`")
  blobUri: url;

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
