import "./models.tsp";
import "../common/models.tsp";
import "../jobs/models.tsp";

using TypeSpec.Http;

namespace Azure.AI.Projects;

@tag("Clusters")
interface Clusters {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Ray sessions are cluster actions backed by underlying command jobs."
  @doc("Start an interactive Ray session on a compute cluster.")
  @post
  @route("/clusters/{clusterName}:start_ray_session")
  startRaySession is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.jobs_v1_preview,
    {
      @doc("The compute cluster name.")
      @path
      clusterName: string;

      @doc("Idempotency key used to safely retry Ray session startup.")
      @header("Operation-Id")
      operationId?: string;

      @doc("Ray session start request.")
      @bodyRoot
      request: RaySessionStart;
    },
    ResourceCreatedResponse<Job>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Ray session stop is a cluster action backed by training job cancellation."
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Ray session stop returns 200 synchronously or 202 with polling headers when cancellation is asynchronous."
  @doc("Stop an interactive Ray session on a compute cluster.")
  @post
  @route("/clusters/{clusterName}/ray_sessions/{sessionName}:stop")
  stopRaySession is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.jobs_v1_preview,
    {
      @doc("The compute cluster name.")
      @path
      clusterName: string;

      @doc("The Ray session name.")
      @path
      sessionName: string;
    },
    Http.OkResponse | JobCancelAcceptedResponse
  >;
}