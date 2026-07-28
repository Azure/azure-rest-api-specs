import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.Core.Traits;

namespace Azure.AI.Projects;

alias DeploymentOperations = FoundryAzureOperations<{}>;

@tag("Deployments")
interface Deployments {
  @summary("Get a deployment")
  @doc("Gets a deployed model.")
  get is DeploymentOperations.ResourceRead<Deployment>;

  /** Returns the deployed models available in the current project, optionally filtered by publisher, model name, or deployment type. */
  @summary("List deployments")
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
