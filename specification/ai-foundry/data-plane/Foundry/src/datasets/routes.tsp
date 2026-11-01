import "../common/models.tsp";
import "../common/servicepatterns.tsp";
import "./models.tsp";
import "../task-sets/models.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.ClientGenerator.Core;
using TypeSpec.Versioning;

namespace Azure.AI.Projects;

alias ListDatasetVersionsParameters = {
  /** The page size, 1-100; defaults to 20. */
  @removed(Versions.v1)
  @query
  limit?: int32 = 20;

  /** The opaque token carried in the previous page's `nextLink`; follow `nextLink` as is. */
  @removed(Versions.v1)
  @query
  continuation_token?: string;
};

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "We are using service specific operation templates"
@doc("""
  Dataset operations. For a `taskset`, native `PATCH` and `credentials` return
  `400 operation_not_supported_for_type`, deletes take no `If-Match` and return `409 dataset_in_use`
  while a Job version still needs the Dataset or version, and a version read accepts `latest` for
  the newest succeeded version.
  """)
@tag("Datasets")
interface Datasets
  extends VersionedOperations<
      DatasetVersion,
      InputParameters<DatasetVersion, "datasetVersion">,
      ListDatasetVersionsParameters,
      ListDatasetVersionsParameters
    > {
  /**
   * Creates a `taskset` version with the next service-assigned version; the first version creates
   * the Dataset. Invalid inline Tasks or a broken edit rule return `400 invalid_tasks` and create no
   * version. Inline creates are normally validated within the request and return `succeeded`;
   * otherwise, and for uploads, the version is returned `queued` with `Retry-After`. Poll the
   * returned URL until `validation_status` is terminal. A name that holds another Dataset type returns
   * `409 dataset_type_conflict`; a `base_version` that has not succeeded returns
   * `409 dataset_version_not_ready`; an inline body over 8 MiB returns `413 content_too_large`.
   */
  #suppress "@azure-tools/typespec-azure-core/long-running-polling-operation-required" "Clients poll the version URL in Operation-Location."
  @summary("Create a Dataset version")
  @post
  @route("/datasets/{name}/versions")
  @removed(Versions.v1)
  @extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
  createVersion is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    {
      ...WithOperationId;

      /** Dataset name. */
      @path name: string;

      /** The version to create. */
      @body body: NewDatasetVersion;
    },
    CreatedResponse &
      DatasetVersion & {
        /** URL of the version to poll for validation status. */
        @header("Operation-Location") operationLocation: string;

        /** URL of the created version. */
        @header("Location") location: string;

        /** Recommended delay before polling, in seconds; set only while the version is `queued` or `in_progress`. */
        @header("Retry-After") retry_after?: int32;
      }
  >;

  /** Returns a write URL for a `taskset` JSONL upload; no version is created. */
  @summary("Start a taskset upload")
  @post
  @route("/datasets/{name}/versions:start_pending_upload")
  @removed(Versions.v1)
  @extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
  startTasksetPendingUpload is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    {
      /** Dataset name. */
      @path name: string;
    },
    TasksetPendingUpload
  >;

  /**
   * Lists a succeeded `taskset` version's Tasks in version order, in canonical JSON; `after` holds a
   * Task `id`, and an `after` ID not in the version returns `400 invalid_cursor`. Another
   * validation status returns `409 dataset_version_not_ready`; a missing Dataset or version, or
   * `latest` with no succeeded version, returns `404 resource_not_found`, and an unavailable Dataset
   * service returns `503 dependency_unavailable`.
   */
  @summary("List Tasks")
  @get
  @list
  @route("/datasets/{name}/versions/{version}/tasks")
  @removed(Versions.v1)
  @extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
  listTasks is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    {
      /** Dataset name. */
      @path name: string;

      /** Dataset version, or `latest` for the newest succeeded version. */
      @path version: string;

      ...PageLimitQueryParameter;
      ...PageAfterQueryParameter;
    },
    AgentsPagedResult<Task>
  >;

  /** Retrieves one Task of a succeeded `taskset` version. */
  @summary("Get a Task")
  @get
  @route("/datasets/{name}/versions/{version}/tasks/{task_id}")
  @removed(Versions.v1)
  @extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
  getTask is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    {
      /** Dataset name. */
      @path name: string;

      /** Dataset version, or `latest` for the newest succeeded version. */
      @path version: string;

      /** Task ID. */
      @path task_id: string;
    },
    Task
  >;

  /** Initiates a new pending upload or retrieves an existing one for the specified dataset version. */
  @summary("Start a pending upload")
  @Rest.action("startPendingUpload")
  startPendingUploadVersion is FoundryResourceOperation<
    DatasetVersion,
    {
      @doc("The pending upload request parameters")
      @Http.bodyRoot
      @clientName("configuration", "csharp")
      pendingUploadRequest: PendingUploadRequest;

      @doc("The specific version id of the DatasetVersion to operate on.")
      @Rest.segment("versions")
      @Http.path
      version: string;
    },
    PendingUploadResponse
  >;

  /** Retrieves the SAS credential to access the storage account associated with a dataset version. */
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @summary("Get dataset credentials")
  @post
  @Rest.action("credentials")
  @Rest.actionSeparator("/")
  getCredentials is FoundryResourceOperation<
    DatasetVersion,
    {
      @doc("The specific version id of the DatasetVersion to operate on.")
      @Rest.segment("versions")
      @Http.path
      version: string;
    },
    AssetCredentialResponse
  >;
}
