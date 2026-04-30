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

alias JobOperations = FoundryAzureOperations<{}>;

@tag("Jobs")
interface Jobs {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "We need explicit definition for header support"
  @doc("List Jobs.")
  @Rest.listsResource(Job)
  list is Azure.Core.Foundations.ResourceList<
    Job,
    JobsFilterQueryParams & JobsPreviewHeader,
    Azure.Core.Page<Job>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "We need explicit definition for header support"
  @doc("Get a Job by name.")
  @get
  get is Azure.Core.Foundations.ResourceOperation<
    Job,
    {
      ...JobsPreviewHeader;
    },
    Azure.Core.Foundations.ResourceOkResponse<Job>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Jobs use Operation-Id based idempotent submission."
  @doc("Create and execute a model training Job.")
  @post
  @route("/jobs")
  createTrainingJob is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.jobs_v1_preview,
    {
      @doc("Idempotency key used to safely retry job creation.")
      @header("Operation-Id")
      operationId?: string;

      @doc("The job to create.")
      @bodyRoot
      job: Job;
    },
    ResourceCreatedResponse<Job>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "LRO delete returns 202 with Location header for polling, or 204 when job not found"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Delete LRO returns 202 with Location header, 204 with no body"
  @doc("Delete a Job by name. Returns 202 Accepted with a Location header to poll for completion, or 204 if the job does not exist.")
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
  @doc("Cancel a Job by name. Returns 200 if cancelled immediately, or 202 Accepted with a Location header to poll for completion.")
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
} // interface Jobs

@tag("Jobs")
interface JobAttempts {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Job attempts are projected from job execution history."
  @doc("List execution attempts for a job.")
  @get
  @route("/jobs/{jobName}/attempts")
  listJobAttempts is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.jobs_v1_preview,
    {
      @doc("The job name.")
      @path jobName: string;

      ...JobChildListQueryParameters;
    },
    Azure.Core.Page<JobAttempt>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Job attempts are projected from job execution history."
  @doc("Get one execution attempt for a job.")
  @get
  @route("/jobs/{jobName}/attempts/{attemptId}")
  getJobAttempt is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.jobs_v1_preview,
    {
      @doc("The job name.")
      @path jobName: string;

      @doc("The attempt identifier.")
      @path attemptId: string;
    },
    JobAttempt
  >;
}

@tag("Jobs")
interface JobArtifacts {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Job artifacts are projected from the job data container."
  @doc("List artifacts for the current view of a job.")
  @get
  @route("/jobs/{jobName}/artifacts")
  listJobArtifacts is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.jobs_v1_preview,
    {
      @doc("The job name.")
      @path jobName: string;

      ...JobArtifactListQueryParameters;
    },
    Azure.Core.Page<JobArtifact>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Job artifacts are projected from the job data container."
  @doc("Get metadata for a job artifact.")
  @get
  @route("/jobs/{jobName}/artifacts/{artifactPath}:metadata")
  getJobArtifactMetadata is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.jobs_v1_preview,
    {
      @doc("The job name.")
      @path jobName: string;

      @doc("The artifact path.")
      @path artifactPath: string;
    },
    JobArtifact
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Job artifacts are projected from the job data container."
  @doc("Get download information for a job artifact.")
  @get
  @route("/jobs/{jobName}/artifacts/{artifactPath}:contentInfo")
  getJobArtifactContentInfo is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.jobs_v1_preview,
    {
      @doc("The job name.")
      @path jobName: string;

      @doc("The artifact path.")
      @path artifactPath: string;
    },
    JobArtifactContentInfo
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Job artifacts are projected from the job data container."
  #suppress "@azure-tools/typespec-azure-core/byos" "Job artifact content is produced by the job and streamed back to the caller."
  @doc("Download job artifact content.")
  @get
  @route("/jobs/{jobName}/artifacts/{artifactPath}:content")
  downloadJobArtifact is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.jobs_v1_preview,
    {
      @doc("The job name.")
      @path jobName: string;

      @doc("The artifact path.")
      @path artifactPath: string;
    },
    bytes
  >;
}

@tag("Jobs")
interface JobAttemptArtifacts {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Attempt artifacts are projected from the attempt data container."
  @doc("List artifacts for a specific job attempt.")
  @get
  @route("/jobs/{jobName}/attempts/{attemptId}/artifacts")
  listJobAttemptArtifacts is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.jobs_v1_preview,
    {
      @doc("The job name.")
      @path jobName: string;

      @doc("The attempt identifier.")
      @path attemptId: string;

      ...JobArtifactListQueryParameters;
    },
    Azure.Core.Page<JobArtifact>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Attempt artifacts are projected from the attempt data container."
  @doc("Get metadata for an artifact from a specific job attempt.")
  @get
  @route("/jobs/{jobName}/attempts/{attemptId}/artifacts/{artifactPath}:metadata")
  getJobAttemptArtifactMetadata is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.jobs_v1_preview,
    {
      @doc("The job name.")
      @path jobName: string;

      @doc("The attempt identifier.")
      @path attemptId: string;

      @doc("The artifact path.")
      @path artifactPath: string;
    },
    JobArtifact
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Attempt artifacts are projected from the attempt data container."
  @doc("Get download information for an artifact from a specific job attempt.")
  @get
  @route("/jobs/{jobName}/attempts/{attemptId}/artifacts/{artifactPath}:contentInfo")
  getJobAttemptArtifactContentInfo is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.jobs_v1_preview,
    {
      @doc("The job name.")
      @path jobName: string;

      @doc("The attempt identifier.")
      @path attemptId: string;

      @doc("The artifact path.")
      @path artifactPath: string;
    },
    JobArtifactContentInfo
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Attempt artifacts are projected from the attempt data container."
  #suppress "@azure-tools/typespec-azure-core/byos" "Job artifact content is produced by the job and streamed back to the caller."
  @doc("Download artifact content from a specific job attempt.")
  @get
  @route("/jobs/{jobName}/attempts/{attemptId}/artifacts/{artifactPath}:content")
  downloadJobAttemptArtifact is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.jobs_v1_preview,
    {
      @doc("The job name.")
      @path jobName: string;

      @doc("The attempt identifier.")
      @path attemptId: string;

      @doc("The artifact path.")
      @path artifactPath: string;
    },
    bytes
  >;
}

@tag("Jobs")
interface JobMetrics {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Job metrics are projected from the job data container."
  @doc("List metrics emitted by the current view of a job.")
  @get
  @route("/jobs/{jobName}/metrics")
  listJobMetrics is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.jobs_v1_preview,
    {
      @doc("The job name.")
      @path jobName: string;

      ...JobChildListQueryParameters;
    },
    Azure.Core.Page<JobMetric>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Job metrics are projected from the job data container."
  @doc("Get the latest values for metrics emitted by the current view of a job.")
  @get
  @route("/jobs/{jobName}/metrics:lastValues")
  getJobMetricLastValues is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.jobs_v1_preview,
    {
      @doc("The job name.")
      @path jobName: string;
    },
    Azure.Core.Page<JobMetricLastValue>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Job metrics are projected from the job data container."
  @doc("Get the full history for a job metric.")
  @get
  @route("/jobs/{jobName}/metrics/{metricName}")
  getJobMetric is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.jobs_v1_preview,
    {
      @doc("The job name.")
      @path jobName: string;

      @doc("The metric name.")
      @path metricName: string;

      ...JobMetricQueryParameters;
    },
    Azure.Core.Page<JobMetricPoint>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Job metrics are projected from the job data container."
  @doc("Get aggregate values for a job metric.")
  @get
  @route("/jobs/{jobName}/metrics/{metricName}:aggregates")
  getJobMetricAggregates is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.jobs_v1_preview,
    {
      @doc("The job name.")
      @path jobName: string;

      @doc("The metric name.")
      @path metricName: string;

      ...JobMetricQueryParameters;
    },
    Azure.Core.Page<JobMetricAggregate>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Job metrics are projected from the job data container."
  @doc("Get sampled values for a job metric.")
  @get
  @route("/jobs/{jobName}/metrics/{metricName}:samples")
  getJobMetricSamples is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.jobs_v1_preview,
    {
      @doc("The job name.")
      @path jobName: string;

      @doc("The metric name.")
      @path metricName: string;

      ...JobMetricQueryParameters;
    },
    JobMetricSample
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Job metrics are projected from the job data container."
  @doc("Get one sampled value or window for a job metric.")
  @get
  @route("/jobs/{jobName}/metrics/{metricName}:sample")
  getJobMetricSample is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.jobs_v1_preview,
    {
      @doc("The job name.")
      @path jobName: string;

      @doc("The metric name.")
      @path metricName: string;

      ...JobMetricQueryParameters;
    },
    JobMetricSample
  >;
}

@tag("Jobs")
interface JobAttemptMetrics {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Attempt metrics are projected from the attempt data container."
  @doc("List metrics emitted by a specific job attempt.")
  @get
  @route("/jobs/{jobName}/attempts/{attemptId}/metrics")
  listJobAttemptMetrics is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.jobs_v1_preview,
    {
      @doc("The job name.")
      @path jobName: string;

      @doc("The attempt identifier.")
      @path attemptId: string;

      ...JobChildListQueryParameters;
    },
    Azure.Core.Page<JobMetric>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Attempt metrics are projected from the attempt data container."
  @doc("Get latest metric values for a specific job attempt.")
  @get
  @route("/jobs/{jobName}/attempts/{attemptId}/metrics:lastValues")
  getJobAttemptMetricLastValues is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.jobs_v1_preview,
    {
      @doc("The job name.")
      @path jobName: string;

      @doc("The attempt identifier.")
      @path attemptId: string;
    },
    Azure.Core.Page<JobMetricLastValue>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Attempt metrics are projected from the attempt data container."
  @doc("Get the full history for a metric from a specific job attempt.")
  @get
  @route("/jobs/{jobName}/attempts/{attemptId}/metrics/{metricName}")
  getJobAttemptMetric is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.jobs_v1_preview,
    {
      @doc("The job name.")
      @path jobName: string;

      @doc("The attempt identifier.")
      @path attemptId: string;

      @doc("The metric name.")
      @path metricName: string;

      ...JobMetricQueryParameters;
    },
    Azure.Core.Page<JobMetricPoint>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Attempt metrics are projected from the attempt data container."
  @doc("Get aggregate metric values from a specific job attempt.")
  @get
  @route("/jobs/{jobName}/attempts/{attemptId}/metrics/{metricName}:aggregates")
  getJobAttemptMetricAggregates is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.jobs_v1_preview,
    {
      @doc("The job name.")
      @path jobName: string;

      @doc("The attempt identifier.")
      @path attemptId: string;

      @doc("The metric name.")
      @path metricName: string;

      ...JobMetricQueryParameters;
    },
    Azure.Core.Page<JobMetricAggregate>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Attempt metrics are projected from the attempt data container."
  @doc("Get sampled metric values from a specific job attempt.")
  @get
  @route("/jobs/{jobName}/attempts/{attemptId}/metrics/{metricName}:samples")
  getJobAttemptMetricSamples is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.jobs_v1_preview,
    {
      @doc("The job name.")
      @path jobName: string;

      @doc("The attempt identifier.")
      @path attemptId: string;

      @doc("The metric name.")
      @path metricName: string;

      ...JobMetricQueryParameters;
    },
    JobMetricSample
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Attempt metrics are projected from the attempt data container."
  @doc("Get one sampled value or window from a specific job attempt.")
  @get
  @route("/jobs/{jobName}/attempts/{attemptId}/metrics/{metricName}:sample")
  getJobAttemptMetricSample is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.jobs_v1_preview,
    {
      @doc("The job name.")
      @path jobName: string;

      @doc("The attempt identifier.")
      @path attemptId: string;

      @doc("The metric name.")
      @path metricName: string;

      ...JobMetricQueryParameters;
    },
    JobMetricSample
  >;
}

@tag("Jobs")
interface JobOutputs {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Job outputs are projected from job outputs and asset relationships."
  @doc("List outputs produced by a job.")
  @get
  @route("/jobs/{jobName}/outputs")
  listJobOutputs is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.jobs_v1_preview,
    {
      @doc("The job name.")
      @path jobName: string;

      ...JobChildListQueryParameters;
    },
    Azure.Core.Page<JobOutputReference>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Job outputs are projected from job outputs and asset relationships."
  @doc("Get one output produced by a job.")
  @get
  @route("/jobs/{jobName}/outputs/{outputName}")
  getJobOutput is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.jobs_v1_preview,
    {
      @doc("The job name.")
      @path jobName: string;

      @doc("The output name.")
      @path outputName: string;
    },
    JobOutputReference
  >;
}

@tag("Jobs")
interface JobAttemptOutputs {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Attempt outputs are projected from attempt output state and asset relationships."
  @doc("List outputs produced by a specific job attempt.")
  @get
  @route("/jobs/{jobName}/attempts/{attemptId}/outputs")
  listJobAttemptOutputs is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.jobs_v1_preview,
    {
      @doc("The job name.")
      @path jobName: string;

      @doc("The attempt identifier.")
      @path attemptId: string;

      ...JobChildListQueryParameters;
    },
    Azure.Core.Page<JobOutputReference>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Attempt outputs are projected from attempt output state and asset relationships."
  @doc("Get one output produced by a specific job attempt.")
  @get
  @route("/jobs/{jobName}/attempts/{attemptId}/outputs/{outputName}")
  getJobAttemptOutput is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.jobs_v1_preview,
    {
      @doc("The job name.")
      @path jobName: string;

      @doc("The attempt identifier.")
      @path attemptId: string;

      @doc("The output name.")
      @path outputName: string;
    },
    JobOutputReference
  >;
}
