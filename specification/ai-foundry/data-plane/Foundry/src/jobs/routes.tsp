import "./models.tsp";
import "../common/models.tsp";
import "../common/servicepatterns.tsp";

using TypeSpec.Http;
using Azure.ClientGenerator.Core;

namespace Azure.AI.Projects;

alias JobsFilterQueryParams = {
  @doc("Filter by job type (e.g. 'Command').")
  @query
  jobType?: JobType;

  @doc("Filter jobs by the presence of a tag key, regardless of its value (e.g., 'framework').")
  @query
  tag?: string;

  @doc("Legacy-compatible archive view. FTJ jobs are never archived: ActiveOnly (the default) and All return the same non-deleted jobs, and ArchivedOnly returns an empty page after validation of the other query options.")
  @query
  listViewType?: ListViewType;

  @doc("Comma-separated exact user-property filters in 'key=value' format (e.g., 'prop1=value1,prop2=value2'). All valid filters must match. Entries without both a key and a value are ignored.")
  @query
  properties?: string;
};

alias TrainingJobNameParameter = {
  @doc("The name of the Job. This is case-sensitive.")
  @path
  name: string;
};

// Every training_jobs operation requires the Jobs preview opt-in and returns the training jobs error response.
#suppress "@azure-tools/typespec-azure-core/no-response-body" "FTJ cancellation acknowledges the request with 200 and no response body."
op TrainingJobsOperation<
  Params extends Reflection.Model,
  Response
> is FoundryDataPlaneRequiredPreviewOperation<
  FoundryFeaturesOptInKeys.jobs_v1_preview,
  Params,
  Response,
  TrainingJobsErrorResponse
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundry data-plane operations use the FoundryDataPlaneOperation templates rather than Azure Core resource operations."
@tag("CommandJob")
@doc("Manage command jobs backed by the Foundry Training Job service. The public `/training_jobs` routes require FTJ-only gateway routing and do not expose legacy Run History operations. Resource requests complete independently of the asynchronous training execution.")
interface Jobs {
  @doc("List job resources using the FTJ-only gateway route. Follow nextLink unchanged for subsequent pages. Artifact page sizing is configured separately by listArtifacts; this operation does not advertise an artifact maxpagesize parameter or legacy Run History page-size behavior.")
  @route("/training_jobs")
  @get
  @list
  list is TrainingJobsOperation<JobsFilterQueryParams, Azure.Core.Page<Job>>;

  @doc("Get a job resource by name, including execution state in `properties.status` and stored failure diagnostics in `properties.error` when available. HTTP 200 means the resource was read successfully, not that training succeeded: Failed and Canceled jobs also return 200. This is a resource read, not an operation-status monitor. To observe training or cancellation, repeat this request at a client-selected interval; the service does not specify an execution-polling interval and runtime-dependent stages may be skipped. Only Completed, Failed, and Canceled are terminal execution states; tolerate additional values without assuming completion. On Failed, inspect the structured diagnostic codes/message, then list log artifacts and request content information for the selected exact path before downloading it. Missing diagnostics or logs do not imply success. Cancellation can finish as Completed or Failed rather than Canceled. A missing or soft-deleted job returns 404.")
  @route("/training_jobs/{name}")
  @get
  get is TrainingJobsOperation<TrainingJobNameParameter, Job>;

  @doc("List artifact descriptors for a job, including its log files, without returning download credentials. Logs are ordinary artifacts under the `azureml-logs/`, `user_logs/` and `system_logs/` directories. Follow `nextLink` unchanged to retrieve subsequent pages. Returns 400 if `maxpagesize` is outside 1 to 500, and 404 if the job is missing or deleted. A directory prefix with no matching artifacts returns 200 with an empty `value` array. Failures use the training jobs error response.")
  @route("/training_jobs/{name}/artifacts")
  @get
  @list
  listArtifacts is TrainingJobsOperation<
    {
      ...TrainingJobNameParameter;

      @doc("Optional directory path relative to the job's artifact container. A non-empty path is treated as a directory prefix with a trailing slash; for example, `outputs` selects artifacts under `outputs/`, not `outputs-extra/`.")
      @query
      path?: string;

      @doc("An opaque continuation token supplied in the preceding response's `nextLink`. Prefer following `nextLink` unchanged rather than constructing this parameter.")
      @query("$skipToken")
      skipToken?: string;

      @doc("Maximum number of artifacts in one page, from 1 to 500. The service may return fewer items and uses 100 when omitted. Values outside this range are rejected with 400; valid values are supported by this FTJ-only API.")
      @query("maxpagesize")
      @pageSize
      @minValue(1)
      @maxValue(500)
      maxPageSize?: int32;
    },
    ArtifactList
  >;

  @doc("Get content access information for one artifact identified by its exact path. Returns a download URI and the byte length when available; this operation does not list a directory or return a page of artifacts. Returns 400 if `path` is omitted, empty, or whitespace-only. Returns 404 if the job is missing or deleted, or no artifact exists at the exact case-sensitive path. Failures use the training jobs error response.")
  @route("/training_jobs/{name}/artifacts:get_content_info")
  @get
  getArtifactContentInformation is TrainingJobsOperation<
    {
      ...TrainingJobNameParameter;

      @doc("The required, case-sensitive path of one artifact relative to the job's artifact container, such as `user_logs/std_log.txt`. A directory prefix is not accepted. An omitted, empty, or whitespace-only path is rejected with 400; a non-matching exact path returns 404.")
      @query
      @minLength(1)
      path: string;
    },
    ArtifactContentInformation
  >;

  @doc("Create, replay, or update a named job resource without waiting for training to finish. The first request pins the submitted configuration. Retry the same name with the same configuration to reuse the persisted job or resume an incomplete submission, rather than create another execution. Returns 201 for the create/resume path or 200 for an existing tracked job, including a no-op replay. A deleted name cannot be reused (409); use a new name for a new execution. Changing submitted command, environment, compute, code, experiment, bindings, resources, distribution, limits, services, or priority is rejected with 400. While submission is incomplete, retries must reproduce the original submitted configuration; metadata changes must wait until submission is tracked. Once tracked, running and terminal jobs permit changes only to display name, description, tags and user properties, without restarting execution. Omitted metadata stays unchanged; empty text clears display name/description. Supplied tags replace the entire map and an empty map clears it. User properties add new keys only: existing values cannot change and omitted keys are preserved. Concurrent metadata writes can return 409; read the latest job and retry the intended change. No public ETag precondition or conditional-write guarantee is provided, so a read-modify-write sequence is not protected against intervening writes. Use `get` to observe execution state.")
  @route("/training_jobs/{name}")
  @put
  createOrUpdate is TrainingJobsOperation<
    {
      ...TrainingJobNameParameter;

      @doc("The job definition for creation, same-name replay, or metadata update. Include the required command, environment and compute fields even when updating metadata. Submitted configuration values must match the existing job; optional omitted configuration stays unchanged on a tracked update. To change execution configuration, create a job with a different name.")
      @bodyRoot
      @clientName("training_job", "python")
      @clientName("trainingJob", "javascript")
      @clientName("trainingJob", "csharp")
      job: Job;
    },
    Azure.Core.Foundations.ResourceCreatedOrOkResponse<Job>
  >;

  @doc("Soft-delete a job resource by name. Returns 204 with no body when the resource is marked deleted, including when it is already deleted or missing. Deleting an active submitted job can return 409; cancel the job and observe a terminal execution state before retrying deletion. The request does not return an operation monitor or wait for physical cleanup. A subsequent `get` returns 404; no delete polling is required.")
  @route("/training_jobs/{name}")
  @delete
  delete is TrainingJobsOperation<TrainingJobNameParameter, NoContentResponse>;

  #suppress "@azure-tools/typespec-azure-core/no-response-body" "FTJ cancellation acknowledges the request with 200 and no response body."
  @doc("Request cancellation of a job. Returns 200 with no body after the cancellation request is processed, or if the job is already terminal. This acknowledgement does not guarantee that training has stopped or will end as `Canceled`. Use `get` to observe execution state; `Completed` or `Failed` may be observed if execution finishes before cancellation takes effect. A missing or deleted job returns 404, and a job that has not been submitted can return 409. Request failures use the normal API error response, not an asynchronous operation result. No operation monitor or polling URL is returned.")
  @route("/training_jobs/{name}:cancel")
  @post
  cancel is TrainingJobsOperation<TrainingJobNameParameter, OkResponse>;
} // interface Jobs
