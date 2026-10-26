import "../common/models.tsp";
import "../common/servicepatterns.tsp";
import "./models.tsp";
import "../task-sets/models.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.ClientGenerator.Core;
using TypeSpec.Versioning;

namespace Azure.AI.Projects;

alias ListDatasetVersionsParameters = {};

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "We are using service specific operation templates"
@doc("""
  Dataset operations. For a `taskset`, native `PATCH` and `credentials` return
  `400 operation_not_supported_for_type`, and deletes return `409 dataset_in_use` while a Job
  version still needs the Dataset or version.
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
   * Creates a `taskset` version with the next service-assigned version, records it as `queued` and
   * starts validation; the first version creates the Dataset. A name that holds another Dataset type
   * returns `409 dataset_type_conflict`; a `base_version` that has not succeeded returns
   * `409 dataset_version_not_ready`. Poll the returned URL until `validation_status` is terminal.
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

        /** Recommended delay before polling, in seconds. */
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
   * Lists a succeeded `taskset` version's Tasks in version order, in canonical JSON. Another
   * validation status returns `409 dataset_version_not_ready`.
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

      /** Dataset version. */
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

      /** Dataset version. */
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
