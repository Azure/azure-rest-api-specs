import "./models.tsp";
import "../common/models.tsp";
import "../common/servicepatterns.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core.Traits;

namespace Azure.AI.Projects;

alias JobsPreviewHeader = WithRequiredFoundryPreviewHeader<FoundryFeaturesOptInKeys.jobs_v1_preview>;

alias JobsFilterQueryParams = {
  @doc("Filter by job type (e.g. 'Command').")
  @query
  jobType?: JobType;

  @doc("Filter jobs by the presence of a tag key, regardless of its value (e.g., 'framework').")
  @query
  tag?: string;

  @doc("Specifies which view type to apply when listing jobs.")
  @query
  listViewType?: ListViewType;

  @doc("Comma-separated exact user-property filters in 'key=value' format (e.g., 'prop1=value1,prop2=value2'). All valid filters must match. Entries without both a key and a value are ignored.")
  @query
  properties?: string;
};

alias JobOperations = FoundryAzureOperations<{}>;

@tag("CommandJob")
@doc("Manage command jobs backed by the Foundry Training Job service. The public `/training_jobs` routes require FTJ-only gateway routing and do not expose legacy Run History operations. Resource requests complete independently of the asynchronous training execution.")
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
  @doc("Get a job resource by name, including its execution state in `properties.status`. This is a resource read, not an operation-status monitor. To observe training or cancellation, repeat this request at a client-selected interval; the service does not specify an execution-polling interval. `Completed`, `Failed`, and `Canceled` are terminal execution states. A missing or soft-deleted job returns 404.")
  @get
  get is Azure.Core.Foundations.ResourceOperation<
    Job,
    {
      ...JobsPreviewHeader;
    },
    Azure.Core.Foundations.ResourceOkResponse<Job>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Artifact sub-resource path; cannot be expressed with standard resource operations."
  @doc("List artifact descriptors for a job, including its log files, without returning download credentials. Logs are ordinary artifacts under the `azureml-logs/`, `user_logs/` and `system_logs/` directories. Follow `nextLink` unchanged to retrieve subsequent pages. Returns 400 if `maxpagesize` is outside 1 to 500, and 404 if the job is missing or deleted. A directory prefix with no matching artifacts returns 200 with an empty `value` array. Failures use the shared Azure error response.")
  @route("/training_jobs/{name}/artifacts")
  @get
  @list
  listArtifacts(
    ...FoundryDataPlaneApiVersionParameter,
    ...JobsPreviewHeader,

    @doc("The name of the Job.")
    @path
    name: string,

    @doc("Optional directory path relative to the job's artifact container. A non-empty path is treated as a directory prefix with a trailing slash; for example, `outputs` selects artifacts under `outputs/`, not `outputs-extra/`.")
    @query
    path?: string,

    @doc("An opaque continuation token supplied in the preceding response's `nextLink`. Prefer following `nextLink` unchanged rather than constructing this parameter.")
    @query("$skipToken")
    skipToken?: string,

    @doc("Maximum number of artifacts in one page, from 1 to 500. The service may return fewer items and uses 100 when omitted. Values outside this range are rejected with 400; valid values are supported by this FTJ-only API.")
    @query("maxpagesize")
    @pageSize
    @minValue(1)
    @maxValue(500)
    maxPageSize?: int32,
  ): ArtifactList | Azure.Core.Foundations.ErrorResponse;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Artifact sub-resource path; cannot be expressed with standard resource operations."
  @doc("Get content access information for one artifact identified by its exact path. Returns a download URI and the byte length when available; this operation does not list a directory or return a page of artifacts. Returns 400 if `path` is omitted, empty, or whitespace-only. Returns 404 if the job is missing or deleted, or no artifact exists at the exact case-sensitive path. Failures use the shared Azure error response.")
  @route("/training_jobs/{name}/artifacts/contentinfo")
  @get
  getArtifactContentInformation(
    ...FoundryDataPlaneApiVersionParameter,
    ...JobsPreviewHeader,

    @doc("The name of the Job.")
    @path
    name: string,

    @doc("The required, case-sensitive path of one artifact relative to the job's artifact container, such as `user_logs/std_log.txt`. A directory prefix is not accepted. An omitted, empty, or whitespace-only path is rejected with 400; a non-matching exact path returns 404.")
    @query
    @minLength(1)
    path: string,
  ): ArtifactContentInformation | Azure.Core.Foundations.ErrorResponse;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "PUT create-or-update pattern required by the Job API wire format"
  @doc("Create or update a job resource. Returns 201 when the resource is created or 200 when it is updated; these responses do not wait for training to finish. Use `get` to observe execution state. On update, the supplied tags replace the existing tags.")
  @put
  createOrUpdate is Azure.Core.Foundations.ResourceOperation<
    Job,
    {
      ...JobsPreviewHeader;

      @doc("The job to create or update.")
      @bodyRoot
      job: Job;
    },
    Azure.Core.Foundations.ResourceCreatedOrOkResponse<Job>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Explicit FTJ resource operation preserves the required preview header."
  @doc("Soft-delete a job resource by name. Returns 204 with no body when the resource is marked deleted, including when it is already deleted or missing. Deleting an active submitted job can return 409; cancel the job and observe a terminal execution state before retrying deletion. The request does not return an operation monitor or wait for physical cleanup. A subsequent `get` returns 404; no delete polling is required.")
  @delete
  delete is Azure.Core.Foundations.ResourceOperation<
    Job,
    {
      ...JobsPreviewHeader;
    },
    Http.NoContentResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Explicit FTJ resource action preserves the required preview header."
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "FTJ cancellation acknowledges the request with 200 and no response body."
  @doc("Request cancellation of a job. Returns 200 with no body after the cancellation request is processed, or if the job is already terminal. This acknowledgement does not guarantee that training has stopped or will end as `Canceled`. Use `get` to observe execution state; `Completed` or `Failed` may be observed if execution finishes before cancellation takes effect. A missing or deleted job returns 404, and a job that has not been submitted can return 409. Request failures use the normal API error response, not an asynchronous operation result. No operation monitor or polling URL is returned.")
  @post
  @Rest.action("cancel")
  @actionSeparator("/")
  cancel is Azure.Core.Foundations.ResourceOperation<
    Job,
    {
      ...JobsPreviewHeader;
    },
    Http.OkResponse
  >;
} // interface Jobs
