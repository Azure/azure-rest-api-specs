// Routes for the AgentsOptimization data-plane surface.
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

#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "OpenAI-based operations are not conventionally versioned"
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
    FoundryFeaturesOptInKeys.agents_optimization_v2_preview,
    OptimizationJob
  >;

  /**
   * Retrieves an optimization job by its identifier.
   */
  @summary("Get an agent optimization job")
  @route("agent_optimization_jobs/{jobId}")
  @extension("x-ms-foundry-meta", AgentOptimizationRequiredPreviews)
  get is queryJobStatusPreview<
    FoundryFeaturesOptInKeys.agents_optimization_v2_preview,
    OptimizationJob
  >;

  /**
   * Lists optimization jobs with cursor pagination and optional status or agent name filters.
   */
  @summary("List agent optimization jobs")
  @route("agent_optimization_jobs")
  @extension("x-ms-foundry-meta", AgentOptimizationRequiredPreviews)
  list is listJobsPreview<
    FoundryFeaturesOptInKeys.agents_optimization_v2_preview,
    OptimizationJobListItem,
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
   * Requests cancellation of a running or queued job and returns an error if the job is already in a terminal state.
   */
  @summary("Cancel an agent optimization job")
  @route("agent_optimization_jobs/{jobId}:cancel")
  @extension("x-ms-foundry-meta", AgentOptimizationRequiredPreviews)
  cancel is cancelJobPreview<
    FoundryFeaturesOptInKeys.agents_optimization_v2_preview,
    OptimizationJob
  >;

  /**
   * Deletes the job and its candidate artifacts, canceling the job first if it is non-terminal.
   */
  @summary("Delete an agent optimization job")
  @route("agent_optimization_jobs/{jobId}")
  @extension("x-ms-foundry-meta", AgentOptimizationRequiredPreviews)
  delete is deleteJobPreview<FoundryFeaturesOptInKeys.agents_optimization_v2_preview>;
}
