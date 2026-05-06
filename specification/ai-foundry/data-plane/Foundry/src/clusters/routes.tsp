import "./models.tsp";
import "../common/models.tsp";
import "../jobs/models.tsp";

using TypeSpec.Http;

namespace Azure.AI.Projects;

@tag("Clusters")
interface Clusters {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Interactive Ray is a cluster action that creates an underlying command job."
  @doc("Create an interactive Ray command job on a compute cluster.")
  @post
  @route("/clusters/{clusterName}:create_interactive_ray_job")
  createInteractiveRayJob is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.jobs_v1_preview,
    {
      @doc("The compute cluster name.")
      @path
      clusterName: string;

      @doc("Idempotency key used to safely retry interactive Ray job creation.")
      @header("Operation-Id")
      operationId?: string;

      @doc("Interactive Ray job creation request.")
      @bodyRoot
      request: InteractiveRayJobCreate;
    },
    ResourceCreatedResponse<Job>
  >;
}