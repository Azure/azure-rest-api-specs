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

@tag("CommandJob")
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

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Artifact sub-resource path; cannot be expressed with standard resource operations."
  @doc("List artifact descriptors for a job, including its log files, without returning download credentials. Logs are ordinary artifacts under the `azureml-logs/`, `user_logs/` and `system_logs/` directories. Follow `nextLink` unchanged to retrieve subsequent pages.")
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

    @doc("Maximum number of artifacts in one page, from 1 to 500. The service may return fewer items. Supported only for jobs routed to the Foundry Training Job backend, which uses 100 when omitted. Omit this parameter for legacy Run History jobs; specifying it on that route is rejected.")
    @query("maxpagesize")
    @pageSize
    @minValue(1)
    @maxValue(500)
    maxPageSize?: int32,
  ): ArtifactList;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Artifact sub-resource path; cannot be expressed with standard resource operations."
  @doc("Get content access information for one artifact identified by its exact path. Returns a download URI and the byte length when available; this operation does not list a directory or return a page of artifacts.")
  @route("/training_jobs/{name}/artifacts/contentinfo")
  @get
  getArtifactContentInformation(
    ...FoundryDataPlaneApiVersionParameter,
    ...JobsPreviewHeader,

    @doc("The name of the Job.")
    @path
    name: string,

    @doc("The required, case-sensitive path of one artifact relative to the job's artifact container, such as `user_logs/std_log.txt`. A directory prefix is not accepted.")
    @query
    @minLength(1)
    path: string,
  ): ArtifactContentInformation;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "PUT create-or-update pattern required by the Job API wire format"
  @doc("Create and execute a Job. For update case, the Tags in the definition passed in will replace Tags in the existing job.")
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
  @actionSeparator("/")
  beginCancel is Azure.Core.Foundations.ResourceOperation<
    Job,
    {
      ...JobsPreviewHeader;
    },
    Http.OkResponse | JobCancelAcceptedResponse
  >;
} // interface Jobs
