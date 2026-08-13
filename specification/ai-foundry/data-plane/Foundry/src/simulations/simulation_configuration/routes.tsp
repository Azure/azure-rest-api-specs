import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Azure.AI.Projects;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Simulation configurations use project-standard operation templates."
@tag("SimulationConfigurations")
interface SimulationConfigurations {
  @summary("Create a simulation configuration")
  @operationId("createSimulationConfiguration")
  @post
  @route("/simulation_configurations")
  @extension("x-ms-foundry-meta", SimulationsRequiredPreviews)
  createSimulationConfiguration is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    {
      @bodyRoot
      payload: SimulationConfiguration;
    },
    Response<200> & SimulationConfiguration
  >;

  @summary("Get a simulation configuration")
  @operationId("getSimulationConfiguration")
  @get
  @route("/simulation_configurations/{configuration_name}/versions/{configuration_version}")
  @extension("x-ms-foundry-meta", SimulationsRequiredPreviews)
  getSimulationConfiguration is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    {
      @path
      configuration_name: string;

      @path
      configuration_version: string;
    },
    SimulationConfiguration
  >;

  @summary("List simulation configurations")
  @operationId("listSimulationConfigurations")
  @get
  @list
  @route("/simulation_configurations")
  @extension("x-ms-foundry-meta", SimulationsRequiredPreviews)
  listSimulationConfigurations is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    {
      ...CommonPageQueryParameters;
    },
    FoundryPagedResult<SimulationConfiguration>
  >;

  @summary("Update a simulation configuration")
  @operationId("updateSimulationConfiguration")
  @post
  @route("/simulation_configurations/{configuration_name}/versions/{configuration_version}")
  @extension("x-ms-foundry-meta", SimulationsRequiredPreviews)
  updateSimulationConfiguration is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    {
      @path
      configuration_name: string;

      @path
      configuration_version: string;

      @bodyRoot
      payload: SimulationConfiguration;
    },
    Response<200> & SimulationConfiguration
  >;

  @summary("Delete a simulation configuration")
  @operationId("deleteSimulationConfiguration")
  @delete
  @route("/simulation_configurations/{configuration_name}/versions/{configuration_version}")
  @extension("x-ms-foundry-meta", SimulationsRequiredPreviews)
  deleteSimulationConfiguration is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    {
      @path
      configuration_name: string;

      @path
      configuration_version: string;
    },
    NoContentResponse
  >;
}
