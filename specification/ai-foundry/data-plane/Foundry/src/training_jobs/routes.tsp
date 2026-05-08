import "./models.tsp";
import "../common/models.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core.Traits;

namespace Azure.AI.Projects;

alias TrainingJobsPreviewHeader = WithRequiredFoundryPreviewHeader<FoundryFeaturesOptInKeys.training_jobs_v1_preview>;

alias JobsFilterQueryParams = {
  @doc("Filter by job type (e.g. 'Command').")
  @query
  job_type?: JobType;

  @doc("Filter jobs by tag in the format 'key=value' (e.g., 'framework=pytorch').")
  @query
  tag?: string;

  @doc("Specifies which view type to apply when listing jobs.")
  @query
  list_view_type?: ListViewType;

  @doc("Comma-separated user property names and optionally values. Example: prop1,prop2=value2.")
  @query
  properties?: string;

  ...CommonPageQueryParameters;
};

@doc("Optional related training job data to include in a get response.")
union TrainingJobInclude {
  string,

  @doc("Inline the latest execution attempt. The same data is available from /training_jobs/{job_name}/attempts/latest.")
  latest_attempt: "latest_attempt",
}

alias TrainingJobGetQueryParams = {
  ...TrainingJobsPreviewHeader;

  @doc("Additional related data to include in the response. Use latest_attempt to inline the latest execution attempt.")
  @query
  include?: TrainingJobInclude;
};

@doc("Training job attempt identifier. Use 'latest' for the latest attempt.")
union JobAttemptIdentifier {
  string,

  @doc("The latest training job attempt.")
  latest: "latest",
}

@tag("TrainingJobs")
interface TrainingJobs {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "We need explicit definition for header support"
  @doc("List training jobs.")
  @get
  @route("/training_jobs")
  @list
  list is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.training_jobs_v1_preview,
    JobsFilterQueryParams,
    TrainingJobPagedResult<Job>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "We need explicit definition for header support"
  @doc("Get a training job by name.")
  @get
  @route("/training_jobs/{job_name}")
  get is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.training_jobs_v1_preview,
    {
      @doc("The training job name.")
      @path
      job_name: string;

      @doc("Additional related data to include in the response. Use latest_attempt to inline the latest execution attempt.")
      @query
      include?: TrainingJobInclude;
    },
    OkResponse<Job>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Job services are projected from run history service instances."
  @doc("List service endpoints for the current view of a training job.")
  @get
  @route("/training_jobs/{job_name}/services")
  showServices is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.training_jobs_v1_preview,
    {
      @doc("The training job name.")
      @path
      job_name: string;

      ...JobServicesQueryParameters;
    },
    TrainingJobServiceCollection
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Jobs use Operation-Id based idempotent submission."
  @doc("Create and execute a model training job.")
  @post
  @route("/training_jobs")
  create is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.training_jobs_v1_preview,
    {
      @doc("Idempotency key used to safely retry job creation.")
      @header("Operation-Id")
      operation_id?: string;

      @doc("The training job to create.")
      @bodyRoot
      job: JobCreate;
    },
    ResourceCreatedResponse<Job>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "LRO delete returns 202 with Location and Operation-Location headers for polling, or 204 when job not found"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Delete LRO returns 202 with Location header, 204 with no body"
  @doc("Delete a training job by name. Returns 202 Accepted with Location and Operation-Location headers to poll for completion, or 204 if the job does not exist.")
  @delete
  @route("/training_jobs/{job_name}")
  beginDelete is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.training_jobs_v1_preview,
    {
      @doc("The training job name.")
      @path
      job_name: string;
    },
    JobDeleteAcceptedResponse | Http.NoContentResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "LRO cancel returns 200 synchronously or 202 with Location and Operation-Location headers for async polling"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Cancel LRO returns 200 or 202 with Location header, no body"
  @doc("Cancel a training job by name. Returns 200 if cancelled immediately, or 202 Accepted with Location and Operation-Location headers to poll for completion.")
  @post
  @route("/training_jobs/{job_name}:cancel")
  beginCancel is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.training_jobs_v1_preview,
    {
      @doc("The training job name.")
      @path
      job_name: string;
    },
    Http.OkResponse | JobCancelAcceptedResponse
  >;
} // interface TrainingJobs

@tag("TrainingJobs")
interface TrainingJobOperations {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundry job operations are exposed as data-plane polling routes under training_jobs."
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "The operation result route can return 202/200 with no body or a terminal operation resource."
  @doc("Poll the result of an asynchronous training job operation.")
  @get
  @route("/training_jobs/operations/{operation_id}/result")
  getOperationResult is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.training_jobs_v1_preview,
    {
      @doc("The operation identifier returned by a training job create, cancel, or delete request.")
      @path
      operation_id: string;
    },
    JobOperationResource | JobOperationAcceptedResponse | Http.OkResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundry job operations are exposed as data-plane polling routes under training_jobs."
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "The operation status route can return 200 with no body or an operation resource."
  @doc("Poll the status of an asynchronous training job operation.")
  @get
  @route("/training_jobs/operations/{operation_id}/status")
  getOperationStatus is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.training_jobs_v1_preview,
    {
      @doc("The operation identifier returned by a training job create, cancel, or delete request.")
      @path
      operation_id: string;
    },
    JobOperationResource | Http.OkResponse
  >;
}

@tag("TrainingJobs")
interface TrainingJobAttempts {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Job attempts are projected from job execution history."
  @doc("List attempts for a training job.")
  @get
  @route("/training_jobs/{job_name}/attempts")
  listAttempts is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.training_jobs_v1_preview,
    {
      @doc("The training job name.")
      @path
      job_name: string;

      ...JobContinuationListQueryParameters;
    },
    TrainingJobPagedResult<JobAttempt>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Job attempts are projected from job execution history."
  @doc("Get one attempt for a training job.")
  @get
  @route("/training_jobs/{job_name}/attempts/{attempt_id}")
  getAttempt is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.training_jobs_v1_preview,
    {
      @doc("The training job name.")
      @path
      job_name: string;

      @doc("The attempt identifier, or 'latest' for the latest attempt.")
      @path
      attempt_id: JobAttemptIdentifier;
    },
    JobAttempt
  >;
}

@tag("TrainingJobs")
interface TrainingJobAttemptArtifacts {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Attempt artifacts are projected from the attempt data container."
  @doc("List artifacts for a training job attempt. Use 'latest' for the latest attempt.")
  @get
  @route("/training_jobs/{job_name}/attempts/{attempt_id}/artifacts")
  listAttemptArtifacts is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.training_jobs_v1_preview,
    {
      @doc("The training job name.")
      @path
      job_name: string;

      @doc("The attempt identifier, or 'latest' for the latest attempt.")
      @path
      attempt_id: JobAttemptIdentifier;

      ...JobArtifactListQueryParameters;
    },
    TrainingJobPagedResult<JobArtifact>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Attempt artifacts are projected from the attempt data container."
  @doc("Get metadata for an artifact from a training job attempt. Use 'latest' for the latest attempt.")
  @get
  @route("/training_jobs/{job_name}/attempts/{attempt_id}/artifacts/metadata")
  getAttemptArtifactMetadata is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.training_jobs_v1_preview,
    {
      @doc("The training job name.")
      @path
      job_name: string;

      @doc("The attempt identifier, or 'latest' for the latest attempt.")
      @path
      attempt_id: JobAttemptIdentifier;

      @doc("The artifact path.")
      @query
      path: string;
    },
    JobArtifact
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Attempt artifacts are projected from the attempt data container."
  @doc("Get download information for an artifact from a training job attempt. Use 'latest' for the latest attempt.")
  @get
  @route("/training_jobs/{job_name}/attempts/{attempt_id}/artifacts/content_info")
  getAttemptArtifactContentInfo is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.training_jobs_v1_preview,
    {
      @doc("The training job name.")
      @path
      job_name: string;

      @doc("The attempt identifier, or 'latest' for the latest attempt.")
      @path
      attempt_id: JobAttemptIdentifier;

      @doc("The artifact path.")
      @query
      path: string;
    },
    JobArtifactContentInfo
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Attempt artifacts are projected from the attempt data container."
  @doc("List download information for artifacts under a path prefix from a training job attempt. Use 'latest' for the latest attempt.")
  @get
  @route("/training_jobs/{job_name}/attempts/{attempt_id}/artifacts/content_info_by_prefix")
  getAttemptArtifactContentInfoByPrefix is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.training_jobs_v1_preview,
    {
      @doc("The training job name.")
      @path
      job_name: string;

      @doc("The attempt identifier, or 'latest' for the latest attempt.")
      @path
      attempt_id: JobAttemptIdentifier;

      ...JobArtifactContentInfoByPrefixQueryParameters;
    },
    TrainingJobPagedResult<JobArtifactContentInfo>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Attempt artifacts are projected from the attempt data container."
  #suppress "@azure-tools/typespec-azure-core/byos" "Job artifact content is produced by the job and streamed back to the caller."
  @doc("Download artifact content from a training job attempt. Use 'latest' for the latest attempt.")
  @get
  @route("/training_jobs/{job_name}/attempts/{attempt_id}/artifacts/content")
  downloadAttemptArtifact is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.training_jobs_v1_preview,
    {
      @doc("The training job name.")
      @path
      job_name: string;

      @doc("The attempt identifier, or 'latest' for the latest attempt.")
      @path
      attempt_id: JobAttemptIdentifier;

      @doc("The artifact path.")
      @query
      path: string;
    },
    bytes
  >;
}

@tag("TrainingJobs")
interface TrainingJobAttemptMetrics {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Attempt metrics are projected from the attempt data container."
  @doc("List metrics emitted by a training job attempt. Use 'latest' for the latest attempt.")
  @get
  @route("/training_jobs/{job_name}/attempts/{attempt_id}/metrics")
  listAttemptMetrics is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.training_jobs_v1_preview,
    {
      @doc("The training job name.")
      @path
      job_name: string;

      @doc("The attempt identifier, or 'latest' for the latest attempt.")
      @path
      attempt_id: JobAttemptIdentifier;

      ...JobMetricListQueryParameters;
    },
    TrainingJobPagedResult<JobMetric>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Attempt metrics are projected from the attempt data container."
  @doc("Get latest metric values for a training job attempt. Use 'latest' for the latest attempt.")
  @get
  @route("/training_jobs/{job_name}/attempts/{attempt_id}/metrics/last_values")
  getAttemptMetricLastValues is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.training_jobs_v1_preview,
    {
      @doc("The training job name.")
      @path
      job_name: string;

      @doc("The attempt identifier, or 'latest' for the latest attempt.")
      @path
      attempt_id: JobAttemptIdentifier;
    },
    TrainingJobPagedResult<JobMetricLastValue>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Attempt metrics are projected from the attempt data container."
  @doc("Get the full history for a metric from a training job attempt. Use 'latest' for the latest attempt.")
  @get
  @route("/training_jobs/{job_name}/attempts/{attempt_id}/metrics/{metric_name}")
  getAttemptMetric is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.training_jobs_v1_preview,
    {
      @doc("The training job name.")
      @path
      job_name: string;

      @doc("The attempt identifier, or 'latest' for the latest attempt.")
      @path
      attempt_id: JobAttemptIdentifier;

      @doc("The metric name.")
      @path
      metric_name: string;

      ...JobMetricQueryParameters;
    },
    TrainingJobPagedResult<JobMetricPoint>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Attempt metrics are projected from the attempt data container."
  @doc("Get aggregate metric values from a training job attempt. Use 'latest' for the latest attempt.")
  @get
  @route("/training_jobs/{job_name}/attempts/{attempt_id}/metrics/{metric_name}/aggregates")
  getAttemptMetricAggregates is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.training_jobs_v1_preview,
    {
      @doc("The training job name.")
      @path
      job_name: string;

      @doc("The attempt identifier, or 'latest' for the latest attempt.")
      @path
      attempt_id: JobAttemptIdentifier;

      @doc("The metric name.")
      @path
      metric_name: string;

      ...JobMetricQueryParameters;
    },
    TrainingJobPagedResult<JobMetricAggregate>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Attempt metrics are projected from the attempt data container."
  @doc("Get sampled metric values from a training job attempt. Use 'latest' for the latest attempt.")
  @get
  @route("/training_jobs/{job_name}/attempts/{attempt_id}/metrics/{metric_name}/samples")
  getAttemptMetricSamples is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.training_jobs_v1_preview,
    {
      @doc("The training job name.")
      @path
      job_name: string;

      @doc("The attempt identifier, or 'latest' for the latest attempt.")
      @path
      attempt_id: JobAttemptIdentifier;

      @doc("The metric name.")
      @path
      metric_name: string;

      ...JobMetricQueryParameters;
    },
    JobMetricSample
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Attempt metrics are projected from the attempt data container."
  @doc("Get one sampled value or window from a training job attempt. Use 'latest' for the latest attempt.")
  @get
  @route("/training_jobs/{job_name}/attempts/{attempt_id}/metrics/{metric_name}/sample")
  getAttemptMetricSample is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.training_jobs_v1_preview,
    {
      @doc("The training job name.")
      @path
      job_name: string;

      @doc("The attempt identifier, or 'latest' for the latest attempt.")
      @path
      attempt_id: JobAttemptIdentifier;

      @doc("The metric name.")
      @path
      metric_name: string;

      ...JobMetricQueryParameters;
    },
    JobMetricSample
  >;
}

@tag("TrainingJobs")
interface TrainingJobOutputs {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Job outputs are projected from job outputs and asset relationships."
  @doc("List outputs produced by a training job.")
  @get
  @route("/training_jobs/{job_name}/outputs")
  listOutputs is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.training_jobs_v1_preview,
    {
      @doc("The training job name.")
      @path
      job_name: string;
    },
    TrainingJobPagedResult<JobOutputReference>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Job outputs are projected from job outputs and asset relationships."
  @doc("Get one output produced by a training job.")
  @get
  @route("/training_jobs/{job_name}/outputs/{output_name}")
  getOutput is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.training_jobs_v1_preview,
    {
      @doc("The training job name.")
      @path
      job_name: string;

      @doc("The output name.")
      @path
      output_name: string;
    },
    JobOutputReference
  >;
}

@tag("TrainingJobs")
interface TrainingJobAttemptOutputs {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Attempt outputs are projected from attempt output state and asset relationships."
  @doc("List outputs produced by a specific training job attempt.")
  @get
  @route("/training_jobs/{job_name}/attempts/{attempt_id}/outputs")
  listAttemptOutputs is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.training_jobs_v1_preview,
    {
      @doc("The training job name.")
      @path
      job_name: string;

      @doc("The attempt identifier, or 'latest' for the latest attempt.")
      @path
      attempt_id: JobAttemptIdentifier;
    },
    TrainingJobPagedResult<JobOutputReference>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Attempt outputs are projected from attempt output state and asset relationships."
  @doc("Get one output produced by a specific training job attempt.")
  @get
  @route("/training_jobs/{job_name}/attempts/{attempt_id}/outputs/{output_name}")
  getAttemptOutput is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.training_jobs_v1_preview,
    {
      @doc("The training job name.")
      @path
      job_name: string;

      @doc("The attempt identifier, or 'latest' for the latest attempt.")
      @path
      attempt_id: JobAttemptIdentifier;

      @doc("The output name.")
      @path
      output_name: string;
    },
    JobOutputReference
  >;
}
