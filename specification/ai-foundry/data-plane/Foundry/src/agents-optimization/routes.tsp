// Routes for the AgentsOptimization data-plane surface.
// Follows the Foundry job-lifecycle pattern from servicepatterns.tsp
// (same pattern as data_generation_jobs, evaluation suites).

import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Azure.AI.Projects;

// ---------------------------------------------------------------------------
// Preview feature gating
// ---------------------------------------------------------------------------

const AgentOptimizationRequiredPreviews = #{
  conditional_previews: #[
    FoundryFeaturesOptInKeys.agents_optimization_v1_preview
  ],
};

// ---------------------------------------------------------------------------
// Job CRUD operations (shared job templates from servicepatterns.tsp)
// ---------------------------------------------------------------------------

#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "OpenAI-based operations are not conventionally versioned"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "OpenAI-based operations are definitionally non-standard"
#suppress "@azure-tools/typespec-azure-core/long-running-polling-operation-required" "LRO polling is handled by the client via Operation-Location"
@tag("AgentOptimizationJobs")
interface AgentOptimizationJobs {
  /**
   * Creates an agent optimization job and returns the queued job.
   * Honors `Operation-Id` for idempotent retry.
   */
  @summary("Create an agent optimization job")
  @route("agent_optimization_jobs")
  @extension("x-ms-foundry-meta", AgentOptimizationRequiredPreviews)
  @post
  create is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.agents_optimization_v1_preview,
    {
      ...WithOperationId;

      @doc("The optimization job inputs.")
      @body
      inputs: OptimizationJobInputs;
    },
    JobCreatedResponse<OptimizationJob>
  >;

  /**
   * Retrieves the specified agent optimization job.
   * Returns 202 while the job is in progress and 200 after it reaches a terminal state.
   */
  @summary("Get an agent optimization job")
  @route("agent_optimization_jobs/{jobId}")
  @extension("x-ms-foundry-meta", AgentOptimizationRequiredPreviews)
  @get
  get is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.agents_optimization_v1_preview,
    {
      /** The ID of the job. */
      @path jobId: string;
    },
    OptimizationJob & {
      @statusCode _: 200 | 202;
      @header("Retry-After") retryAfter?: int32;
    }
  >;

  /**
   * Returns agent optimization jobs with cursor pagination and optional lifecycle or agent filters.
   */
  @summary("List agent optimization jobs")
  @route("agent_optimization_jobs")
  @extension("x-ms-foundry-meta", AgentOptimizationRequiredPreviews)
  list is listJobsPreview<
    FoundryFeaturesOptInKeys.agents_optimization_v1_preview,
    OptimizationJob,
    {
      @doc("Filter to jobs in this lifecycle state.")
      @query
      status?: JobStatus;

      @doc("Filter to jobs targeting this agent name.")
      @query
      agent_name?: string;
    }
  >;

  /**
   * Requests cancellation of the specified agent optimization job.
   * The operation remains idempotent after the job reaches a terminal state.
   */
  @summary("Cancel an agent optimization job")
  @route("agent_optimization_jobs/{jobId}:cancel")
  @extension("x-ms-foundry-meta", AgentOptimizationRequiredPreviews)
  cancel is cancelJobPreview<
    FoundryFeaturesOptInKeys.agents_optimization_v1_preview,
    OptimizationJob
  >;

  /**
   * Deletes the specified agent optimization job and its candidate artifacts.
   * Cancels the job first when it is still in a non-terminal state.
   */
  @summary("Delete an agent optimization job")
  @route("agent_optimization_jobs/{jobId}")
  @extension("x-ms-foundry-meta", AgentOptimizationRequiredPreviews)
  @delete
  delete is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.agents_optimization_v1_preview,
    {
      @doc("The ID of the job to delete.")
      @path
      jobId: string;

      @doc("When true, force-delete even if the job is in a non-terminal state.")
      @query
      force?: boolean;
    },
    NoContentResponse
  >;

  // ---------------------------------------------------------------------------
  // Candidate sub-resource operations
  // ---------------------------------------------------------------------------

  /**
   * Returns the candidates produced by the specified optimization job.
   */
  @summary("List optimization job candidates")
  @route("agent_optimization_jobs/{jobId}/candidates")
  @extension("x-ms-foundry-meta", AgentOptimizationRequiredPreviews)
  @get
  @list
  listCandidates is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.agents_optimization_v1_preview,
    {
      @doc("The optimization job id.")
      @path
      jobId: string;

      ...CommonPageQueryParameters;
    },
    AgentsPagedResult<OptimizationCandidate>
  >;

  /**
   * Retrieves metadata, manifest information, and promotion details for the specified candidate.
   */
  @summary("Get an optimization candidate")
  @route("agent_optimization_jobs/{jobId}/candidates/{candidateId}")
  @extension("x-ms-foundry-meta", AgentOptimizationRequiredPreviews)
  @get
  getCandidate is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.agents_optimization_v1_preview,
    {
      @doc("The optimization job id.")
      @path
      jobId: string;

      @doc("The candidate id.")
      @path
      candidateId: string;
    },
    CandidateMetadata
  >;

  /**
   * Retrieves the deploy configuration JSON for the specified candidate.
   * Clients can use it to compose `agents.create_version(...)` requests.
   */
  @summary("Get an optimization candidate config")
  @route("agent_optimization_jobs/{jobId}/candidates/{candidateId}/config")
  @extension("x-ms-foundry-meta", AgentOptimizationRequiredPreviews)
  @get
  getCandidateConfig is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.agents_optimization_v1_preview,
    {
      @doc("The optimization job id.")
      @path
      jobId: string;

      @doc("The candidate id.")
      @path
      candidateId: string;
    },
    CandidateDeployConfig
  >;

  /**
   * Retrieves full per-task evaluation results for the specified candidate.
   */
  @summary("Get optimization candidate results")
  @route("agent_optimization_jobs/{jobId}/candidates/{candidateId}/results")
  @extension("x-ms-foundry-meta", AgentOptimizationRequiredPreviews)
  @get
  getCandidateResults is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.agents_optimization_v1_preview,
    {
      @doc("The optimization job id.")
      @path
      jobId: string;

      @doc("The candidate id.")
      @path
      candidateId: string;
    },
    CandidateResults
  >;

  /**
   * Streams the specified file from the candidate's blob directory.
   */
  @summary("Get an optimization candidate file")
  @route("agent_optimization_jobs/{jobId}/candidates/{candidateId}/files")
  @extension("x-ms-foundry-meta", AgentOptimizationRequiredPreviews)
  @get
  getCandidateFile is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.agents_optimization_v1_preview,
    {
      @doc("The optimization job id.")
      @path
      jobId: string;

      @doc("The candidate id.")
      @path
      candidateId: string;

      @doc("Relative path of the file to download (e.g. 'files/examples.jsonl').")
      @query
      path: string;
    },
    bytes
  >;

  /**
   * Promotes the specified candidate and records the deployment timestamp and target agent version.
   */
  @summary("Promote an optimization candidate")
  @route("agent_optimization_jobs/{jobId}/candidates/{candidateId}:promote")
  @extension("x-ms-foundry-meta", AgentOptimizationRequiredPreviews)
  @post
  promoteCandidate is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.agents_optimization_v1_preview,
    {
      @doc("The optimization job id.")
      @path
      jobId: string;

      @doc("The candidate id to promote.")
      @path
      candidateId: string;

      @doc("Promotion details.")
      @body
      candidate_request: PromoteCandidateRequest;
    },
    PromoteCandidateResponse
  >;
}
