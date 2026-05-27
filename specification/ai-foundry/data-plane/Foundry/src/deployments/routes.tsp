import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.Core.Traits;

namespace Azure.AI.Projects;

alias DeploymentServiceTraits = SupportsClientRequestId &
  NoRepeatableRequests &
  NoConditionalRequests;

alias DeploymentOperations = Azure.Core.ResourceOperations<DeploymentServiceTraits>;

@tag("Deployments")
interface Deployments {
  @summary("Get a deployment")
  @doc("Gets a deployed model.")
  get is DeploymentOperations.ResourceRead<Deployment>;

  @summary("List all deployments")
  @doc("Lists all deployed models in the project")
  list is DeploymentOperations.ResourceList<
    Deployment,
    ListQueryParametersTrait<{
      @doc("Model publisher to filter models by")
      @query("modelPublisher")
      modelPublisher?: string;

      @doc("Model name (the publisher specific name) to filter models by")
      @query("modelName")
      modelName?: string;

      @doc("Type of deployment to filter list by")
      @query("deploymentType")
      deploymentType?: DeploymentType;
    }>
  >;
}
