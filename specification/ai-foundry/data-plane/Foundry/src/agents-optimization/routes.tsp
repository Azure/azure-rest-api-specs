// Routes for the AgentsOptimization data-plane surface.
// Follows the Foundry job-lifecycle pattern from servicepatterns.tsp
// (same pattern as data_generation_jobs, evaluation suites).

import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Azure.AI.Projects;

// ---------------------------------------------------------------------------
// Job CRUD operations (shared job templates from servicepatterns.tsp)
// ---------------------------------------------------------------------------

#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "OpenAI-based operations are not conventionally versioned"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "OpenAI-based operations are definitionally non-standard"
#suppress "@azure-tools/typespec-azure-core/long-running-polling-operation-required" "LRO polling is handled by the client via Operation-Location"
@removed(Versions.v1)
@tag("AgentOptimizationJobs")
interface AgentOptimizationJobs {
  @summary("Creates an agent optimization job.")
  @doc("Create an optimization job. Returns 201 with the queued job. Honours `Operation-Id` for idempotent retry.")
  @route("agent_optimization_jobs")
  @extension("x-ms-foundry-meta", AgentsOptimizationPreview)
  create is postJobPreview<
    FoundryFeaturesOptInKeys.agents_optimization_v2_preview,
    OptimizationJob
  >;

  @summary("Get info about an agent optimization job.")
  @doc("Get an optimization job by id.")
  @route("agent_optimization_jobs/{jobId}")
  @extension("x-ms-foundry-meta", AgentsOptimizationPreview)
  get is queryJobStatusPreview<
    FoundryFeaturesOptInKeys.agents_optimization_v2_preview,
    OptimizationJob
  >;

  @summary("Returns a list of agent optimization jobs.")
  @doc("List optimization jobs. Supports cursor pagination and optional status / agent_name filters.")
  @route("agent_optimization_jobs")
  @extension("x-ms-foundry-meta", AgentsOptimizationPreview)
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

  @summary("Cancels an agent optimization job.")
  @doc("Request cancellation of a running or queued job. Returns an error if the job is already in a terminal state.")
  @route("agent_optimization_jobs/{jobId}:cancel")
  @extension("x-ms-foundry-meta", AgentsOptimizationPreview)
  cancel is cancelJobPreview<
    FoundryFeaturesOptInKeys.agents_optimization_v2_preview,
    OptimizationJob
  >;

  @summary("Deletes an agent optimization job.")
  @doc("Delete the job and its candidate artifacts. Cancels first if non-terminal.")
  @route("agent_optimization_jobs/{jobId}")
  @extension("x-ms-foundry-meta", AgentsOptimizationPreview)
  delete is deleteJobPreview<FoundryFeaturesOptInKeys.agents_optimization_v2_preview>;

}
