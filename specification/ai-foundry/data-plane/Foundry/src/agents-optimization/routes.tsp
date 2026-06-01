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
  @summary("Create an agent optimization job.")
  @doc("Creates an optimization job. Returns 201 with the queued job. Honours `Operation-Id` for idempotent retry.")
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

  @summary("Get info about an agent optimization job.")
  @doc("Gets an optimization job by id. Returns 202 while in progress, 200 when terminal.")
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

  @summary("List agent optimization jobs.")
  @doc("Lists optimization jobs. Supports cursor pagination and optional status / agentName filters.")
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

  @summary("Cancel an agent optimization job.")
  @doc("Request cancellation. Idempotent on terminal states.")
  @route("agent_optimization_jobs/{jobId}:cancel")
  @extension("x-ms-foundry-meta", AgentOptimizationRequiredPreviews)
  cancel is cancelJobPreview<
    FoundryFeaturesOptInKeys.agents_optimization_v1_preview,
    OptimizationJob
  >;

  @summary("Delete an agent optimization job.")
  @doc("Deletes the job and its candidate artifacts. Cancels first if non-terminal.")
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

  @summary("List candidates for an optimization job.")
  @doc("Lists candidates produced by a job.")
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

  @summary("Get a candidate by id.")
  @doc("Gets a single candidate's metadata, manifest, and promotion info.")
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

  @summary("Get candidate deploy config.")
  @doc("Gets the candidate's deploy config JSON. Used to compose `agents.create_version(...)` from a candidate.")
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

  @summary("Get candidate evaluation results.")
  @doc("Gets full per-task evaluation results for a candidate.")
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

  @summary("Get a candidate file.")
  @doc("Streams a specific file from the candidate's blob directory.")
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

  @summary("Promote a candidate.")
  @doc("Promotes a candidate, recording the deployment timestamp and target agent version.")
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
