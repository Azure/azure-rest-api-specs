import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;
using Azure.Core.Foundations;

namespace Azure.AI.Projects;

alias DeploymentServiceTraits = SupportsClientRequestId;

alias DeploymentOperations = Azure.Core.ResourceOperations<DeploymentServiceTraits>;

interface Deployments {
  @doc("Get a deployed model.")
  get is DeploymentOperations.ResourceRead<Deployment>;

  @doc("List all deployed models in the project")
  list is DeploymentOperations.ResourceList<
    Deployment,
    ListQueryParametersTrait<{
      @doc("Model publisher to filter models by")
      @query("$modelPublisher")
      modelPublisher?: string;

      @doc("Model name (the publisher specific name) to filter models by")
      @query("$modelName")
      modelName?: string;

      @doc("Flag to include models from connections in response.")
      @query("$includeConnectedModels")
      includeConnectionModels?: boolean;

      ...StandardListQueryParameters;
    }>
  >;
}
