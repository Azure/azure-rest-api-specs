import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;
using Azure.Core;

namespace Azure.AI.Projects;

alias SimulationJobListFilterQueryParams = {
  /** The agent name query parameter. */
  @query("agent_name")
  @doc("Filter by the target agent name associated with the simulation job.")
  agent_name?: string;

  /** The agent version query parameter. */
  @query("agent_version")
  @doc("Filter by the target agent version associated with the simulation job.")
  agent_version?: string;

  /** The configuration name query parameter. */
  @query("configuration_name")
  @doc("Filter by the name of the simulation configuration associated with the job.")
  configuration_name?: string;

  /** The configuration version query parameter. */
  @query("configuration_version")
  @doc("Filter by the version of the simulation configuration associated with the job.")
  configuration_version?: string;
};

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Simulation jobs use project-standard operation templates."
@tag("SimulationJobs")
interface SimulationJobs {
  @summary("Create a simulation job")
  @operationId("createSimulationJob")
  @route("/simulation_jobs")
  @extension("x-ms-foundry-meta", SimulationsRequiredPreviews)
  @pollingOperation(SimulationJobs.getSimulationJob)
  createSimulationJob is postJobPreview<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    SimulationRun
  >;

  @summary("Get a simulation job")
  @operationId("getSimulationJob")
  @route("/simulation_jobs/{jobId}")
  @extension("x-ms-foundry-meta", SimulationsRequiredPreviews)
  getSimulationJob is queryJobStatusPreview<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    SimulationRun
  >;

  @summary("List simulation jobs")
  @operationId("listSimulationJobs")
  @get
  @list
  @route("/simulation_jobs")
  @extension("x-ms-foundry-meta", SimulationsRequiredPreviews)
  listSimulationJobs is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    {
      ...CommonPageQueryParameters;
      ...SimulationJobListFilterQueryParams;
    },
    FoundryPagedResult<SimulationRun>
  >;

  @summary("List simulation job items")
  @operationId("listSimulationJobItems")
  @get
  @list
  @route("/simulation_jobs/{jobId}/items")
  @extension("x-ms-foundry-meta", SimulationsRequiredPreviews)
  listSimulationJobItems is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    {
      @path
      jobId: string;

      ...CommonPageQueryParameters;
    },
    FoundryPagedResult<SimulationRunItem>
  >;

  @summary("Cancel a simulation job")
  @operationId("cancelSimulationJob")
  @route("/simulation_jobs/{jobId}:cancel")
  @extension("x-ms-foundry-meta", SimulationsRequiredPreviews)
  cancelSimulationJob is cancelJobPreview<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    SimulationRun
  >;

  @summary("Delete a simulation job")
  @operationId("deleteSimulationJob")
  @route("/simulation_jobs/{jobId}")
  @extension("x-ms-foundry-meta", SimulationsRequiredPreviews)
  deleteSimulationJob is deleteJobPreview<FoundryFeaturesOptInKeys.evaluations_v1_preview>;
}
