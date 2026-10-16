import "../common/models.tsp";
import "../common/service.tsp";

using TypeSpec.Versioning;

namespace Azure.AI.Projects;

@doc("Enum to determine the type of data.")
union DatasetType {
  string,

  @doc("URI file.")
  uri_file: "uri_file",

  @doc("URI folder.")
  uri_folder: "uri_folder",
}

/** The authored content carried by a Dataset version, independent of its storage type. */
union DatasetKind {
  string,

  /** A manifest of evaluation tasks. */
  taskset: "taskset",
}

/** Evaluation-content validation state for a Dataset version. */
union DatasetValidationStatus {
  /** Validation has not begun. */
  pending: "pending",

  /** Validation is processing the current content. */
  in_progress: "in_progress",

  /** The current content passed validation. */
  succeeded: "succeeded",

  /** The content failed validation. */
  failed: "failed",
}

/** An actionable validation failure without disclosing private Task content. */
model DatasetValidationError {
  /** Machine-readable failure category. */
  code: string;

  /** Explanation of the invalid Task or manifest. */
  message: string;

  /** Task identifier, when a specific Task caused the error. */
  task_id?: string;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance"
@doc("DatasetVersion Definition")
@Rest.resource("datasets")
@discriminator("type")
model DatasetVersion {
  /** The purpose of this Dataset version; `taskset` identifies evaluation Task content. */
  @removed(Versions.v1)
  kind?: DatasetKind;

  /** Current validation state of the Task content. */
  @removed(Versions.v1)
  @visibility(Lifecycle.Read)
  validation_status?: DatasetValidationStatus;

  /** Errors produced by content validation, if any. */
  @removed(Versions.v1)
  @visibility(Lifecycle.Read)
  validation_errors?: DatasetValidationError[];

  /** Digest of the exact content approved by successful validation. */
  @removed(Versions.v1)
  @visibility(Lifecycle.Read)
  content_digest?: string;

  #suppress "@azure-tools/typespec-client-generator-core/csharp-no-url-suffix" "Name kept for backward compatibility"
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

  @doc("Deprecated: the service never read this value and silently ignored it. Use TemporaryBlobReference instead.")
  BlobReference: "BlobReference",

  @doc("Temporary blob reference.")
  TemporaryBlobReference: "TemporaryBlobReference",
}

@doc("The type of credential used to access the storage account.")
union PendingUploadCredentialType {
  string,

  @doc("SAS credential type.")
  sas: "SAS",
}

#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
@doc("Represents a request for a pending upload.")
model PendingUploadRequest {
  @doc("If PendingUploadId is not provided, a random GUID will be used.")
  pendingUploadId?: string;

  @doc("Azure Storage Account connection name to use for generating temporary SAS token")
  connectionName?: string;

  @doc("The type of pending upload.")
  pendingUploadType: PendingUploadType.BlobReference;
}

#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
@doc("Represents the response for a pending upload request")
model PendingUploadResponse {
  @doc("Container-level read, write, list SAS.")
  blobReference: BlobReference;

  @doc("ID for this upload request.")
  pendingUploadId: string;

  @doc("Version of asset to be created if user did not specify version when initially creating upload")
  version?: string;

  @doc("The type of pending upload.")
  pendingUploadType: PendingUploadType.BlobReference;
}

@doc("Blob reference details.")
model BlobReference {
  #suppress "@azure-tools/typespec-client-generator-core/csharp-no-url-suffix" "Name kept for backward compatibility"
  @doc("Blob URI path for client to upload data. Example: `https://blob.windows.core.net/Container/Path`")
  blobUri: url;

  @doc("ARM ID of the storage account to use.")
  storageAccountArmId: string;

  @doc("Credential info to access the storage account.")
  credential: SasCredential;
}

#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
@doc("Represents a reference to a blob for consumption")
model AssetCredentialResponse {
  @doc("Credential info to access the storage account.")
  blobReference: BlobReference;
}
