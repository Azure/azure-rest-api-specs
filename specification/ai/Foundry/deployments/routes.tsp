import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./models.tsp";

using TypeSpec.Http;
using Azure.Core.Traits;
using TypeSpec.Versioning;

namespace Azure.AI.Projects;

alias DeploymentServiceTraits = SupportsClientRequestId &
  NoRepeatableRequests &
  NoConditionalRequests;

alias DeploymentOperations = Azure.Core.ResourceOperations<DeploymentServiceTraits>;

@added(Versions.v2025_05_01)
interface Deployments {
  @doc("Get a deployed model.")
  get is DeploymentOperations.ResourceRead<Deployment>;

  @doc("List all deployed models in the project")
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
