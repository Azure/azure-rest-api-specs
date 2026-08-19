// Routes for the AgentsOptimization data-plane surface (V3Preview).
// Follows the Foundry job-lifecycle pattern from servicepatterns.tsp
// (same pattern as data_generation_jobs, evaluation suites).

import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

using Azure.Core;

namespace Azure.AI.Projects;

// ---------------------------------------------------------------------------
// Job CRUD operations (shared job templates from servicepatterns.tsp)
// ---------------------------------------------------------------------------

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "OpenAI-based operations are definitionally non-standard"
@tag("AgentOptimizationJobs")
interface AgentOptimizationJobs {
  /**
   * Creates an optimization job and returns the queued job. Honors `Operation-Id` for idempotent retry.
   */
  @summary("Create an agent optimization job")
  @route("agent_optimization_jobs")
  @extension("x-ms-foundry-meta", AgentOptimizationRequiredPreviews)
  @pollingOperation(AgentOptimizationJobs.get)
  create is postJobPreview<
    FoundryFeaturesOptInKeys.agents_optimization_v3_preview,
    AgentOptimizationJob
  >;

  /**
   * Estimates dataset row count, per-layer model call volumes, and (when pricing is available) cost bands for an optimization job with the given inputs, without submitting the job.
   */
  @summary("Estimate an agent optimization job")
  @route("agent_optimization_jobs:estimate")
  @extension("x-ms-foundry-meta", AgentOptimizationRequiredPreviews)
  estimate is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.agents_optimization_v3_preview,
    {
      /** The inputs to estimate against. */
      @body inputs: AgentOptimizationEstimateJobInputs;
    },
    AgentOptimizationEstimateResponse
  >;

  /**
   * Retrieves an optimization job by its identifier.
   */
  @summary("Get an agent optimization job")
  @route("agent_optimization_jobs/{jobId}")
  @extension("x-ms-foundry-meta", AgentOptimizationRequiredPreviews)
  get is queryJobStatusPreview<
    FoundryFeaturesOptInKeys.agents_optimization_v3_preview,
    AgentOptimizationJob
  >;

  /**
   * Lists optimization jobs with cursor pagination and optional status or agent name filters.
   */
  @summary("List agent optimization jobs")
  @route("agent_optimization_jobs")
  @extension("x-ms-foundry-meta", AgentOptimizationRequiredPreviews)
  list is listJobsPreview<
    FoundryFeaturesOptInKeys.agents_optimization_v3_preview,
    AgentOptimizationJob,
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
   * Requests cancellation of a running or queued job. Returns 409 Conflict if the job is already in a terminal state.
   */
  @summary("Cancel an agent optimization job")
  @route("agent_optimization_jobs/{jobId}:cancel")
  @extension("x-ms-foundry-meta", AgentOptimizationRequiredPreviews)
  cancel is cancelJobPreview<
    FoundryFeaturesOptInKeys.agents_optimization_v3_preview,
    AgentOptimizationJob
  >;

  /**
   * Deletes the job and its candidate artifacts, canceling the job first if it is non-terminal.
   */
  @summary("Delete an agent optimization job")
  @route("agent_optimization_jobs/{jobId}")
  @extension("x-ms-foundry-meta", AgentOptimizationRequiredPreviews)
  delete is deleteJobPreview<FoundryFeaturesOptInKeys.agents_optimization_v3_preview>;
}

// ---------------------------------------------------------------------------
// Candidate sub-resource operations
// ---------------------------------------------------------------------------

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "OpenAI-based operations are definitionally non-standard"
@tag("AgentOptimizationJobs")
interface AgentOptimizationJobCandidates {
  /**
   * Lists candidates for the given optimization job with cursor pagination. Each item is an `AgentOptimizationCandidate` — mutation *keys* identify which agent attributes changed, but the customer-supplied mutation *values* are returned as `null` unless the client passes `expand=mutations`. Per-task result files are always fetched via GET /candidates/{candidateId}.
   */
  @summary("List candidates for an agent optimization job")
  @route("agent_optimization_jobs/{jobId}/candidates")
  @extension("x-ms-foundry-meta", AgentOptimizationRequiredPreviews)
  listCandidates is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.agents_optimization_v3_preview,
    {
      /** The ID of the parent optimization job. */
      @path jobId: string;

      /** Comma-separated list of expand keys. Pass `mutations` to populate the values of `AgentOptimizationCandidate.mutations`; omit to receive only the mutation keys with null values. Additional expand keys may be added in future previews. */
      @query expand?: string;

      ...CommonPageQueryParameters;
    },
    AgentsPagedResult<AgentOptimizationCandidate>
  >;

  /**
   * Retrieves a single candidate. Mutation values are always included when a client hits the GET endpoint directly; the `expand` parameter exists for consistency with LIST but is optional here.
   */
  @summary("Get a candidate for an agent optimization job")
  @route("agent_optimization_jobs/{jobId}/candidates/{candidateId}")
  @extension("x-ms-foundry-meta", AgentOptimizationRequiredPreviews)
  getCandidate is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.agents_optimization_v3_preview,
    {
      /** The ID of the parent optimization job. */
      @path jobId: string;

      /** The candidate identifier. */
      @path candidateId: string;

      /** Comma-separated list of expand keys. Provided for consistency with LIST; mutations values are populated on this endpoint regardless of the parameter. */
      @query expand?: string;
    },
    AgentOptimizationCandidate
  >;

  /**
   * Promotes a candidate onto a Foundry agent version, applying the candidate's mutations to the agent's registered configuration. For prompt agents the target agent is derived from the job's stored baseline configuration and the request body fields are ignored.
   */
  @summary("Promote a candidate for an agent optimization job")
  @route("agent_optimization_jobs/{jobId}/candidates/{candidateId}:promote")
  @extension("x-ms-foundry-meta", AgentOptimizationRequiredPreviews)
  promoteCandidate is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.agents_optimization_v3_preview,
    {
      /** The ID of the parent optimization job. */
      @path jobId: string;

      /** The candidate identifier. */
      @path candidateId: string;

      /** Target agent information for the promotion. */
      @body promotion: PromoteAgentOptimizationCandidateRequest;
    },
    PromoteAgentOptimizationCandidateResponse
  >;
}
