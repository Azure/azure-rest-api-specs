import "./models.tsp";
import "../common/models.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core.Traits;

namespace Azure.AI.Projects;

alias JobsPreviewHeader = WithRequiredFoundryPreviewHeader<FoundryFeaturesOptInKeys.jobs_v1_preview>;

alias JobsFilterQueryParams = {
  @doc("Filter by job type (e.g. 'Command').")
  @query
  jobType?: JobType;

  @doc("Filter jobs by tag in the format 'key=value' (e.g., 'framework=pytorch').")
  @query
  tag?: string;

  @doc("Specifies which view type to apply when listing jobs.")
  @query
  listViewType?: ListViewType;

  @doc("Comma-separated user property names and optionally values. Example: prop1,prop2=value2.")
  @query
  properties?: string;
};

@tag("TrainingJobs")
interface TrainingJobs {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "We need explicit definition for header support"
  @doc("List training jobs.")
  @Rest.listsResource(Job)
  list is Azure.Core.Foundations.ResourceList<
    Job,
    JobsFilterQueryParams & JobsPreviewHeader,
    Azure.Core.Page<Job>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "We need explicit definition for header support"
  @doc("Get a training job by name.")
  @get
  get is Azure.Core.Foundations.ResourceOperation<
    Job,
    {
      ...JobsPreviewHeader;
    },
    Azure.Core.Foundations.ResourceOkResponse<Job>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Jobs use Operation-Id based idempotent submission."
  @doc("Create and execute a model training job.")
  @post
  @route("/trainingJobs")
  create is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.jobs_v1_preview,
    {
      @doc("Idempotency key used to safely retry job creation.")
      @header("Operation-Id")
      operationId?: string;

      @doc("The training job to create.")
      @bodyRoot
      job: Job;
    },
    ResourceCreatedResponse<Job>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "LRO delete returns 202 with Location header for polling, or 204 when job not found"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Delete LRO returns 202 with Location header, 204 with no body"
  @doc("Delete a training job by name. Returns 202 Accepted with a Location header to poll for completion, or 204 if the job does not exist.")
  @delete
  beginDelete is Azure.Core.Foundations.ResourceOperation<
    Job,
    {
      ...JobsPreviewHeader;
    },
    JobDeleteAcceptedResponse | Http.NoContentResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "LRO cancel returns 200 synchronously or 202 with Location header for async polling"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Cancel LRO returns 200 or 202 with Location header, no body"
  @doc("Cancel a training job by name. Returns 200 if cancelled immediately, or 202 Accepted with a Location header to poll for completion.")
  @post
  @Rest.action("cancel")
  @actionSeparator(":")
  beginCancel is Azure.Core.Foundations.ResourceOperation<
    Job,
    {
      ...JobsPreviewHeader;
    },
    Http.OkResponse | JobCancelAcceptedResponse
  >;
} // interface TrainingJobs

@tag("TrainingJobs")
interface TrainingJobOperations {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundry job operations are exposed as data-plane polling routes under trainingJobs."
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "The operation result route can return 202/200 with no body or a terminal operation resource."
  @doc("Poll the result of an asynchronous training job operation.")
  @get
  @route("/trainingJobs/operations/{operationId}/result")
  getOperationResult is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.jobs_v1_preview,
    {
      @doc("The operation identifier returned by a training job create, cancel, or delete request.")
      @path
      operationId: string;
    },
    JobOperationResource | JobOperationAcceptedResponse | Http.OkResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundry job operations are exposed as data-plane polling routes under trainingJobs."
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "The operation status route can return 200 with no body or an operation resource."
  @doc("Poll the status of an asynchronous training job operation.")
  @get
  @route("/trainingJobs/operations/{operationId}/status")
  getOperationStatus is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.jobs_v1_preview,
    {
      @doc("The operation identifier returned by a training job create, cancel, or delete request.")
      @path
      operationId: string;
    },
    JobOperationResource | Http.OkResponse
  >;
}

@tag("TrainingJobs")
interface TrainingJobRuns {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Job runs are projected from job execution history."
  @doc("List runs for a training job.")
  @get
  @route("/trainingJobs/{jobName}/runs")
  listRuns is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.jobs_v1_preview,
    {
      @doc("The training job name.")
      @path
      jobName: string;

      ...JobChildListQueryParameters;
    },
    Azure.Core.Page<JobRun>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Job runs are projected from job execution history."
  @doc("Get one run for a training job.")
  @get
  @route("/trainingJobs/{jobName}/runs/{runId}")
  getRun is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.jobs_v1_preview,
    {
      @doc("The training job name.")
      @path
      jobName: string;

      @doc("The run identifier.")
      @path
      runId: string;
    },
    JobRun
  >;
}

@tag("TrainingJobs")
interface TrainingJobArtifacts {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Job artifacts are projected from the job data container."
  @doc("List artifacts for the current view of a training job.")
  @get
  @route("/trainingJobs/{jobName}/artifacts")
  listArtifacts is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.jobs_v1_preview,
    {
      @doc("The training job name.")
      @path
      jobName: string;

      ...JobArtifactListQueryParameters;
    },
    Azure.Core.Page<JobArtifact>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Job artifacts are projected from the job data container."
  @doc("Get metadata for a training job artifact.")
  @get
  @route("/trainingJobs/{jobName}/artifacts:metadata")
  getArtifactMetadata is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.jobs_v1_preview,
    {
      @doc("The training job name.")
      @path
      jobName: string;

      @doc("The artifact path.")
      @query
      path: string;
    },
    JobArtifact
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Job artifacts are projected from the job data container."
  @doc("Get download information for a training job artifact.")
  @get
  @route("/trainingJobs/{jobName}/artifacts:contentInfo")
  getArtifactContentInfo is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.jobs_v1_preview,
    {
      @doc("The training job name.")
      @path
      jobName: string;

      @doc("The artifact path.")
      @query
      path: string;
    },
    JobArtifactContentInfo
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Job artifacts are projected from the job data container."
  #suppress "@azure-tools/typespec-azure-core/byos" "Job artifact content is produced by the job and streamed back to the caller."
  @doc("Download training job artifact content.")
  @get
  @route("/trainingJobs/{jobName}/artifacts:content")
  downloadArtifact is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.jobs_v1_preview,
    {
      @doc("The training job name.")
      @path
      jobName: string;

      @doc("The artifact path.")
      @query
      path: string;
    },
    bytes
  >;
}

@tag("TrainingJobs")
interface TrainingJobRunArtifacts {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Run artifacts are projected from the run data container."
  @doc("List artifacts for a specific training job run.")
  @get
  @route("/trainingJobs/{jobName}/runs/{runId}/artifacts")
  listRunArtifacts is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.jobs_v1_preview,
    {
      @doc("The training job name.")
      @path
      jobName: string;

      @doc("The run identifier.")
      @path
      runId: string;

      ...JobArtifactListQueryParameters;
    },
    Azure.Core.Page<JobArtifact>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Run artifacts are projected from the run data container."
  @doc("Get metadata for an artifact from a specific training job run.")
  @get
  @route("/trainingJobs/{jobName}/runs/{runId}/artifacts:metadata")
  getRunArtifactMetadata is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.jobs_v1_preview,
    {
      @doc("The training job name.")
      @path
      jobName: string;

      @doc("The run identifier.")
      @path
      runId: string;

      @doc("The artifact path.")
      @query
      path: string;
    },
    JobArtifact
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Run artifacts are projected from the run data container."
  @doc("Get download information for an artifact from a specific training job run.")
  @get
  @route("/trainingJobs/{jobName}/runs/{runId}/artifacts:contentInfo")
  getRunArtifactContentInfo is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.jobs_v1_preview,
    {
      @doc("The training job name.")
      @path
      jobName: string;

      @doc("The run identifier.")
      @path
      runId: string;

      @doc("The artifact path.")
      @query
      path: string;
    },
    JobArtifactContentInfo
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Run artifacts are projected from the run data container."
  #suppress "@azure-tools/typespec-azure-core/byos" "Job artifact content is produced by the job and streamed back to the caller."
  @doc("Download artifact content from a specific training job run.")
  @get
  @route("/trainingJobs/{jobName}/runs/{runId}/artifacts:content")
  downloadRunArtifact is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.jobs_v1_preview,
    {
      @doc("The training job name.")
      @path
      jobName: string;

      @doc("The run identifier.")
      @path
      runId: string;

      @doc("The artifact path.")
      @query
      path: string;
    },
    bytes
  >;
}

@tag("TrainingJobs")
interface TrainingJobMetrics {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Job metrics are projected from the job data container."
  @doc("List metrics emitted by the current view of a training job.")
  @get
  @route("/trainingJobs/{jobName}/metrics")
  listMetrics is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.jobs_v1_preview,
    {
      @doc("The training job name.")
      @path
      jobName: string;

      ...JobChildListQueryParameters;
    },
    Azure.Core.Page<JobMetric>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Job metrics are projected from the job data container."
  @doc("Get the latest values for metrics emitted by the current view of a training job.")
  @get
  @route("/trainingJobs/{jobName}/metrics:lastValues")
  getMetricLastValues is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.jobs_v1_preview,
    {
      @doc("The training job name.")
      @path
      jobName: string;
    },
    Azure.Core.Page<JobMetricLastValue>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Job metrics are projected from the job data container."
  @doc("Get the full history for a training job metric.")
  @get
  @route("/trainingJobs/{jobName}/metrics/{metricName}")
  getMetric is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.jobs_v1_preview,
    {
      @doc("The training job name.")
      @path
      jobName: string;

      @doc("The metric name.")
      @path
      metricName: string;

      ...JobMetricQueryParameters;
    },
    Azure.Core.Page<JobMetricPoint>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Job metrics are projected from the job data container."
  @doc("Get aggregate values for a training job metric.")
  @get
  @route("/trainingJobs/{jobName}/metrics/{metricName}:aggregates")
  getMetricAggregates is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.jobs_v1_preview,
    {
      @doc("The training job name.")
      @path
      jobName: string;

      @doc("The metric name.")
      @path
      metricName: string;

      ...JobMetricQueryParameters;
    },
    Azure.Core.Page<JobMetricAggregate>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Job metrics are projected from the job data container."
  @doc("Get sampled values for a training job metric.")
  @get
  @route("/trainingJobs/{jobName}/metrics/{metricName}:samples")
  getMetricSamples is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.jobs_v1_preview,
    {
      @doc("The training job name.")
      @path
      jobName: string;

      @doc("The metric name.")
      @path
      metricName: string;

      ...JobMetricQueryParameters;
    },
    JobMetricSample
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Job metrics are projected from the job data container."
  @doc("Get one sampled value or window for a training job metric.")
  @get
  @route("/trainingJobs/{jobName}/metrics/{metricName}:sample")
  getMetricSample is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.jobs_v1_preview,
    {
      @doc("The training job name.")
      @path
      jobName: string;

      @doc("The metric name.")
      @path
      metricName: string;

      ...JobMetricQueryParameters;
    },
    JobMetricSample
  >;
}

@tag("TrainingJobs")
interface TrainingJobRunMetrics {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Run metrics are projected from the run data container."
  @doc("List metrics emitted by a specific training job run.")
  @get
  @route("/trainingJobs/{jobName}/runs/{runId}/metrics")
  listRunMetrics is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.jobs_v1_preview,
    {
      @doc("The training job name.")
      @path
      jobName: string;

      @doc("The run identifier.")
      @path
      runId: string;

      ...JobChildListQueryParameters;
    },
    Azure.Core.Page<JobMetric>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Run metrics are projected from the run data container."
  @doc("Get latest metric values for a specific training job run.")
  @get
  @route("/trainingJobs/{jobName}/runs/{runId}/metrics:lastValues")
  getRunMetricLastValues is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.jobs_v1_preview,
    {
      @doc("The training job name.")
      @path
      jobName: string;

      @doc("The run identifier.")
      @path
      runId: string;
    },
    Azure.Core.Page<JobMetricLastValue>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Run metrics are projected from the run data container."
  @doc("Get the full history for a metric from a specific training job run.")
  @get
  @route("/trainingJobs/{jobName}/runs/{runId}/metrics/{metricName}")
  getRunMetric is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.jobs_v1_preview,
    {
      @doc("The training job name.")
      @path
      jobName: string;

      @doc("The run identifier.")
      @path
      runId: string;

      @doc("The metric name.")
      @path
      metricName: string;

      ...JobMetricQueryParameters;
    },
    Azure.Core.Page<JobMetricPoint>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Run metrics are projected from the run data container."
  @doc("Get aggregate metric values from a specific training job run.")
  @get
  @route("/trainingJobs/{jobName}/runs/{runId}/metrics/{metricName}:aggregates")
  getRunMetricAggregates is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.jobs_v1_preview,
    {
      @doc("The training job name.")
      @path
      jobName: string;

      @doc("The run identifier.")
      @path
      runId: string;

      @doc("The metric name.")
      @path
      metricName: string;

      ...JobMetricQueryParameters;
    },
    Azure.Core.Page<JobMetricAggregate>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Run metrics are projected from the run data container."
  @doc("Get sampled metric values from a specific training job run.")
  @get
  @route("/trainingJobs/{jobName}/runs/{runId}/metrics/{metricName}:samples")
  getRunMetricSamples is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.jobs_v1_preview,
    {
      @doc("The training job name.")
      @path
      jobName: string;

      @doc("The run identifier.")
      @path
      runId: string;

      @doc("The metric name.")
      @path
      metricName: string;

      ...JobMetricQueryParameters;
    },
    JobMetricSample
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Run metrics are projected from the run data container."
  @doc("Get one sampled value or window from a specific training job run.")
  @get
  @route("/trainingJobs/{jobName}/runs/{runId}/metrics/{metricName}:sample")
  getRunMetricSample is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.jobs_v1_preview,
    {
      @doc("The training job name.")
      @path
      jobName: string;

      @doc("The run identifier.")
      @path
      runId: string;

      @doc("The metric name.")
      @path
      metricName: string;

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
  @route("/trainingJobs/{jobName}/outputs")
  listOutputs is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.jobs_v1_preview,
    {
      @doc("The training job name.")
      @path
      jobName: string;

      ...JobChildListQueryParameters;
    },
    Azure.Core.Page<JobOutputReference>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Job outputs are projected from job outputs and asset relationships."
  @doc("Get one output produced by a training job.")
  @get
  @route("/trainingJobs/{jobName}/outputs/{outputName}")
  getOutput is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.jobs_v1_preview,
    {
      @doc("The training job name.")
      @path
      jobName: string;

      @doc("The output name.")
      @path
      outputName: string;
    },
    JobOutputReference
  >;
}

@tag("TrainingJobs")
interface TrainingJobRunOutputs {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Run outputs are projected from run output state and asset relationships."
  @doc("List outputs produced by a specific training job run.")
  @get
  @route("/trainingJobs/{jobName}/runs/{runId}/outputs")
  listRunOutputs is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.jobs_v1_preview,
    {
      @doc("The training job name.")
      @path
      jobName: string;

      @doc("The run identifier.")
      @path
      runId: string;

      ...JobChildListQueryParameters;
    },
    Azure.Core.Page<JobOutputReference>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Run outputs are projected from run output state and asset relationships."
  @doc("Get one output produced by a specific training job run.")
  @get
  @route("/trainingJobs/{jobName}/runs/{runId}/outputs/{outputName}")
  getRunOutput is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.jobs_v1_preview,
    {
      @doc("The training job name.")
      @path
      jobName: string;

      @doc("The run identifier.")
      @path
      runId: string;

      @doc("The output name.")
      @path
      outputName: string;
    },
    JobOutputReference
  >;
}
