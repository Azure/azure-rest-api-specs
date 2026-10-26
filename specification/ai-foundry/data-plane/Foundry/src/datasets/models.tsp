import "../common/models.tsp";
import "../common/service.tsp";
import "../common/servicepatterns.tsp";
import "../task-sets/models.tsp";

using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Azure.AI.Projects;

@doc("Enum to determine the type of data.")
union DatasetType {
  string,

  @doc("URI file.")
  uri_file: "uri_file",

  @doc("URI folder.")
  uri_folder: "uri_folder",

  /** Evaluation Tasks validated and stored by the evaluation service. */
  @removed(Versions.v1)
  @extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
  taskset: "taskset",
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance"
@doc("DatasetVersion Definition")
@Rest.resource("datasets")
@discriminator("type")
model DatasetVersion {
  #suppress "@azure-tools/typespec-client-generator-core/csharp-no-url-suffix" "Name kept for backward compatibility"
  @added(Versions.v1)
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

  #suppress "@azure-tools/typespec-client-generator-core/csharp-no-url-suffix" "Name kept for backward compatibility"
  @removed(Versions.v1)
  @doc("URI of the data ([example](https://go.microsoft.com/fwlink/?linkid=2202330))")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @minLength(1)
  @pattern("[a-zA-Z0-9_]")
  dataUri: string;
}

@doc("FileDatasetVersion Definition")
model FolderDatasetVersion extends DatasetVersion {
  @doc("Dataset type")
  type: DatasetType.uri_folder;

  #suppress "@azure-tools/typespec-client-generator-core/csharp-no-url-suffix" "Name kept for backward compatibility"
  @removed(Versions.v1)
  @doc("URI of the data ([example](https://go.microsoft.com/fwlink/?linkid=2202330))")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @minLength(1)
  @pattern("[a-zA-Z0-9_]")
  dataUri: string;
}

/** Validation state of a `taskset` Dataset version. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
union TasksetValidationStatus {
  string,

  /** Waiting for validation. */
  queued: "queued",

  /** Validation is running. */
  in_progress: "in_progress",

  /** Every Task is valid; the version is usable and immutable. */
  succeeded: "succeeded",

  /** Validation failed; the version is never usable. */
  failed: "failed",
}

/**
 * A version of evaluation Tasks. Versions are service-assigned and immutable: native `PATCH` and
 * `credentials` return `400 operation_not_supported_for_type`. Use it from a Job or Run only after
 * `validation_status` is `succeeded`; otherwise they return `409 dataset_version_not_ready`.
 */
@removed(Versions.v1)
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model TasksetDatasetVersion extends DatasetVersion {
  /** Dataset type. */
  type: DatasetType.taskset;

  /** The validation state. */
  @visibility(Lifecycle.Read)
  validation_status: TasksetValidationStatus;

  /**
   * Set when validation fails, with code `invalid_tasks` or `validation_timeout`. `details` holds the
   * first 100 problems in Task order, each with a `param` such as `lines[11].graders[0].actual`,
   * `tasks[3].id` or `delete_task_ids[0]`.
   */
  @visibility(Lifecycle.Read)
  error?: ApiError;

  /** The version this one edits, or null. */
  @visibility(Lifecycle.Read)
  base_version: string | null;

  /** The number of Tasks, set when validation succeeds. */
  @visibility(Lifecycle.Read)
  task_count: int32 | null;

  /** Lowercase hex SHA-256 over the canonical (RFC 8785) Tasks in order, set when validation succeeds. */
  @visibility(Lifecycle.Read)
  content_digest: string | null;

  /** The time when the version was created. */
  @visibility(Lifecycle.Read)
  created_at: FoundryTimestamp;

  /** The time when validation finished, or null. */
  @visibility(Lifecycle.Read)
  finished_at: FoundryTimestamp | null;
}

/** Request body that creates a Dataset version with a service-assigned version. */
@discriminator("type")
@removed(Versions.v1)
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model NewDatasetVersion {
  /** The Dataset type; the first version fixes the type for the name. */
  type: DatasetType;
}

/**
 * Creates a `taskset` version. Without `base_version`, supply exactly one of `tasks` or
 * `pending_upload_id`. With `base_version`, supply at most one of them, plus optional
 * `delete_task_ids`, and change at least one Task: a Task whose `id` matches a base Task replaces
 * it in place, new Tasks follow in order, and deleted IDs are removed. Invalid Task content never
 * returns `400`; it fails the version with `invalid_tasks`.
 */
@removed(Versions.v1)
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model NewTasksetDatasetVersion extends NewDatasetVersion {
  /** Dataset type. */
  type: DatasetType.taskset;

  /** A description of this version. */
  @maxLength(1024)
  description?: string;

  /** Tags for this version: at most 32 keys of up to 64 characters, values up to 256 characters. */
  tags?: Record<string>;

  /** Inline Tasks. */
  @minItems(1)
  @maxItems(1000)
  tasks?: Task[];

  /** A finished upload from `start_pending_upload` holding UTF-8 JSONL Tasks, one per line; used by one version only. */
  pending_upload_id?: string;

  /** A concrete succeeded version to edit; `latest` is rejected. */
  base_version?: string;

  /** Base Task IDs to remove. */
  @maxItems(1000)
  delete_task_ids?: string[];
}

/** A write URL for a `taskset` upload; no version exists until a version create claims it. */
@removed(Versions.v1)
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model TasksetPendingUpload {
  /** The upload ID to pass as `pending_upload_id`. */
  pending_upload_id: string;

  /** A write-only HTTPS URL for one block blob. */
  upload_url: url;

  /** The time when the upload expires. */
  expires_at: FoundryTimestamp;
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
