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

  ...JobOrderedPageQueryParameters;
};

@doc("Optional related training job data to include in a get response.")
union TrainingJobInclude {
  string,

  @doc("Inline run-centric metadata recorded for the backing run, including execution-view inputs and outputs.")
  run_metadata: "run_metadata",

  @doc("Inline the latest execution attempt. The same data is available from /training_jobs/{job_name}/attempts/latest.")
  latest_attempt: "latest_attempt",

  @doc("Inline input dataset lineage recorded for the training job.")
  input_datasets: "input_datasets",

  @doc("Inline output dataset lineage recorded for the training job.")
  output_datasets: "output_datasets",

  @doc("Inline the backend execution definition used to run the training job.")
  execution_definition: "execution_definition",

  @doc("Inline the backend-resolved job specification.")
  resolved_specification: "resolved_specification",

  @doc("Inline parameters recorded for the training job.")
  parameters: "parameters",

  @doc("Inline settings recorded for the training job.")
  settings: "settings",

  @doc("Inline log file URI metadata for the training job.")
  log_files: "log_files",

  @doc("Inline the job cost summary.")
  job_cost: "job_cost",

  @doc("Inline the compute request recorded for the training job.")
  compute_request: "compute_request",

  @doc("Inline the compute record for the training job.")
  compute: "compute",
}

alias TrainingJobGetQueryParams = {
  ...TrainingJobsPreviewHeader;

  @doc("Additional related data to include in the response. Values are comma-separated expansion names such as run_metadata, latest_attempt, input_datasets, output_datasets, execution_definition, /nodes/{node_id}/services, log_files, and job_cost.")
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

      @doc("Additional related data to include in the response. Values are comma-separated expansion names such as run_metadata, latest_attempt, input_datasets, output_datasets, execution_definition, /nodes/{node_id}/services, log_files, and job_cost.")
      @query
      include?: TrainingJobInclude;
    },
    OkResponse<Job>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Job services are projected from run history service instances."
  @doc("List service endpoints for a selected node of a training job.")
  @get
  @route("/training_jobs/{job_name}/nodes/{node_id}/services")
  showServices is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.training_jobs_v1_preview,
    {
      @doc("The training job name.")
      @path
      job_name: string;

      @doc("The node identifier.")
      @path
      node_id: int32;
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
interface TrainingJobInputs {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Job inputs are projected from the backing run's execution-view input documents."
  @doc("List execution-view inputs recorded for a training job.")
  @get
  @route("/training_jobs/{job_name}/inputs")
  listInputs is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.training_jobs_v1_preview,
    {
      @doc("The training job name.")
      @path
      job_name: string;
    },
    TrainingJobPagedResult<JobExecutionAssetReference>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Job inputs are projected from the backing run's execution-view input documents."
  @doc("Get one execution-view input recorded for a training job.")
  @get
  @route("/training_jobs/{job_name}/inputs/{input_name}")
  getInput is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.training_jobs_v1_preview,
    {
      @doc("The training job name.")
      @path
      job_name: string;

      @doc("The input name.")
      @path
      input_name: string;
    },
    JobExecutionAssetReference
  >;
}

@tag("TrainingJobs")
interface TrainingJobAttemptInputs {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Attempt inputs are projected from execution-view input documents."
  @doc("List execution-view inputs recorded for a specific training job attempt.")
  @get
  @route("/training_jobs/{job_name}/attempts/{attempt_id}/inputs")
  listAttemptInputs is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.training_jobs_v1_preview,
    {
      @doc("The training job name.")
      @path
      job_name: string;

      @doc("The attempt identifier, or 'latest' for the latest attempt.")
      @path
      attempt_id: JobAttemptIdentifier;
    },
    TrainingJobPagedResult<JobExecutionAssetReference>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Attempt inputs are projected from execution-view input documents."
  @doc("Get one execution-view input recorded for a specific training job attempt.")
  @get
  @route("/training_jobs/{job_name}/attempts/{attempt_id}/inputs/{input_name}")
  getAttemptInput is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.training_jobs_v1_preview,
    {
      @doc("The training job name.")
      @path
      job_name: string;

      @doc("The attempt identifier, or 'latest' for the latest attempt.")
      @path
      attempt_id: JobAttemptIdentifier;

      @doc("The input name.")
      @path
      input_name: string;
    },
    JobExecutionAssetReference
  >;
}

@tag("TrainingJobs")
interface TrainingJobOutputs {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Job outputs are projected from the backing run's execution-view output documents."
  @doc("List execution-view outputs recorded for a training job.")
  @get
  @route("/training_jobs/{job_name}/outputs")
  listOutputs is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.training_jobs_v1_preview,
    {
      @doc("The training job name.")
      @path
      job_name: string;
    },
    TrainingJobPagedResult<JobExecutionAssetReference>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Job outputs are projected from the backing run's execution-view output documents."
  @doc("Get one execution-view output recorded for a training job.")
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
    JobExecutionAssetReference
  >;
}

@tag("TrainingJobs")
interface TrainingJobAttemptOutputs {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Attempt outputs are projected from execution-view output documents."
  @doc("List execution-view outputs recorded for a specific training job attempt.")
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
    TrainingJobPagedResult<JobExecutionAssetReference>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Attempt outputs are projected from execution-view output documents."
  @doc("Get one execution-view output recorded for a specific training job attempt.")
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
    JobExecutionAssetReference
  >;
}
