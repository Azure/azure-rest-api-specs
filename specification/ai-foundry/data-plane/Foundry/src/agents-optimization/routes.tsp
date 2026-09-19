import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

using Azure.Core;

namespace Azure.AI.Projects;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "OpenAI-based operations are definitionally non-standard"
@tag("AgentOptimizationJobs")
interface AgentOptimizationJobs {
  /**
   * Creates an optimization job and returns the queued job. Honors `Operation-Id` for idempotent retry.
   */
  #suppress "@azure-tools/typespec-azure-core/long-running-polling-operation-required" "The response creates an asynchronously processed job resource; callers poll the returned job with GET rather than polling the create request."
  @summary("Create an agent optimization job")
  @route("agent_optimization_jobs")
  @post
  create is FoundryDataPlaneOperation<
    {
      ...WithOperationId;

      /** The optimization job inputs. */
      @body body: AgentOptimizationJobCreate;
    },
    JobCreatedResponse<AgentOptimizationJob>
  >;

  /**
   * Estimates validation-set rows, per-stage model call volumes, and cost bands without submitting the job.
   */
  @summary("Estimate an agent optimization job")
  @route("agent_optimization_jobs:estimate")
  estimate is FoundryDataPlaneOperation<
    {
      /** The inputs to estimate against. */
      @body inputs: AgentOptimizationEstimateInputs;
    },
    AgentOptimizationEstimateResponse
  >;

  /**
   * Retrieves an optimization job by its identifier.
   */
  @summary("Get an agent optimization job")
  @route("agent_optimization_jobs/{jobId}")
  get is queryJobStatus<AgentOptimizationJob>;

  /**
   * Lists optimization jobs with cursor pagination and optional status or agent name filters.
   */
  @summary("List agent optimization jobs")
  @route("agent_optimization_jobs")
  list is listJobs<
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
  cancel is cancelJob<AgentOptimizationJob>;

  /**
   * Cancels active work, then deletes the job and its candidate artifacts.
   */
  @summary("Delete an agent optimization job")
  @route("agent_optimization_jobs/{jobId}")
  delete is deleteJob<AgentOptimizationJob>;
}

// ---------------------------------------------------------------------------
// Candidate sub-resource operations
// ---------------------------------------------------------------------------

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "OpenAI-based operations are definitionally non-standard"
@tag("AgentOptimizationJobs")
interface AgentOptimizationJobCandidates {
  /**
   * Lists candidates for the given optimization job with cursor pagination, including the original baseline and generated candidates. Each `output.mutations` item identifies a changed attribute by `type`; mutation `value` fields are omitted unless the client passes `expand=mutations`.
   */
  @summary("List candidates for an agent optimization job")
  @route("agent_optimization_jobs/{jobId}/candidates")
  @list
  listCandidates is FoundryDataPlaneOperation<
    {
      /** The ID of the parent optimization job. */
      @path jobId: string;

      /** Comma-separated list of expand keys. Pass `mutations` to populate mutation `value` fields; omit to receive mutation items containing only `type`. Additional expand keys may be added in future previews. */
      @query expand?: string;

      ...CommonPageQueryParameters;
    },
    AgentsPagedResult<AgentOptimizationCandidate>
  >;

  /**
   * Retrieves a single candidate. Mutation values are always included.
   */
  @summary("Get a candidate for an agent optimization job")
  @route("agent_optimization_jobs/{jobId}/candidates/{candidateId}")
  getCandidate is FoundryDataPlaneOperation<
    {
      /** The ID of the parent optimization job. */
      @path jobId: string;

      /** The candidate identifier. */
      @path candidateId: string;

    },
    AgentOptimizationCandidate
  >;

  /**
   * Promotes a candidate to the Foundry agent stored in the parent job's target configuration. Promotion is unavailable when the job omitted target_configuration. Prompt-agent promotion creates a new agent version. Hosted-agent promotion currently records promotion metadata without deploying a new hosted-agent version.
   */
  @summary("Promote a candidate for an agent optimization job")
  @route("agent_optimization_jobs/{jobId}/candidates/{candidateId}:promote")
  @post
  promoteCandidate is FoundryDataPlaneOperation<
    {
      /** The ID of the parent optimization job. */
      @path jobId: string;

      /** The candidate identifier. */
      @path candidateId: string;
    },
    AgentOptimizationCandidate
  >;
}
