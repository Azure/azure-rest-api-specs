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

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Nested run-history sub-resource path; cannot be expressed with standard resource operations."
  @doc("Get the runtime service instances associated with a job's node. Returns a map of service name to ServiceInstance describing interactive services (e.g. SSH, JupyterLab, VSCode, TensorBoard) currently running on the specified node.")
  @route("/jobs/{name}/history/runs/{runId}/serviceinstances/{nodeId}")
  @get
  showServices(
    ...FoundryDataPlaneApiVersionParameter,
    ...JobsPreviewHeader,

    @doc("The name of the Job.")
    @path
    name: string,

    @doc("The run identifier. For Jobs this currently matches the job name.")
    @path
    runId: string,

    @doc("Zero-based index of the compute node to query.")
    @path
    nodeId: int32,
  ): RunServiceInstances;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Nested run-history sub-resource path; cannot be expressed with standard resource operations."
  @doc("Get runtime details for a job's run, including current status, log file URLs, warnings and any error information. Used to poll job progress and to stream log output.")
  @route("/jobs/{name}/history/runs/{runId}/details")
  @get
  getRunDetails(
    ...FoundryDataPlaneApiVersionParameter,
    ...JobsPreviewHeader,

    @doc("The name of the Job.")
    @path
    name: string,

    @doc("The run identifier. For Jobs this currently matches the job name.")
    @path
    runId: string,
  ): RunDetails;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Nested run-history sub-resource path; cannot be expressed with standard resource operations."
  @doc("Get a job's run.")
  @route("/jobs/{name}/history/runs/{runId}")
  @get
  getRun(
    ...FoundryDataPlaneApiVersionParameter,
    ...JobsPreviewHeader,

    @doc("The name of the Job.")
    @path
    name: string,

    @doc("The run identifier. For Jobs this currently matches the job name.")
    @path
    runId: string,
  ): Run;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Nested run-history artifacts sub-resource path; cannot be expressed with standard resource operations."
  @doc("List artifacts produced by a job's run.")
  @route("/jobs/{name}/history/experimentids/{experimentId}/runs/{runId}/artifacts")
  @get
  listArtifacts(
    ...FoundryDataPlaneApiVersionParameter,
    ...JobsPreviewHeader,

    @doc("The name of the Job.")
    @path
    name: string,

    @doc("The id of the experiment that owns the run.")
    @path
    experimentId: string,

    @doc("The run identifier. For Jobs this currently matches the job name.")
    @path
    runId: string,

    @doc("Optional artifact path or path prefix to filter by.")
    @query
    path?: string,

    @doc("Continuation token for the next page.")
    @query
    continuationToken?: string,

    @doc("Maximum number of artifacts per page.")
    @query
    pageSize?: int32,
  ): ArtifactList;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Nested run-history artifacts sub-resource path; cannot be expressed with standard resource operations."
  @doc("Get content information for artifacts produced by a job's run.")
  @route("/jobs/{name}/history/experimentids/{experimentId}/runs/{runId}/artifacts/prefix/contentinfo")
  @get
  getArtifactContentInformation(
    ...FoundryDataPlaneApiVersionParameter,
    ...JobsPreviewHeader,

    @doc("The name of the Job.")
    @path
    name: string,

    @doc("The id of the experiment that owns the run.")
    @path
    experimentId: string,

    @doc("The run identifier. For Jobs this currently matches the job name.")
    @path
    runId: string,

    @doc("Optional artifact path prefix to filter by.")
    @query
    path?: string,

    @doc("Continuation token for the next page.")
    @query
    continuationToken?: string,
  ): ArtifactContentInformationList;

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
