import "@typespec/rest";
import "@typespec/openapi";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";

import "../common/service.tsp";
import "../common/models.tsp";

using TypeSpec.Rest;

namespace Azure.AI.Projects;

@doc("Model Deployment Definition")
@resource("deployments")
@discriminator("type")
model Deployment {
  @doc("The type of the deployment")
  type: DeploymentType;

  @doc("Name of the deployment")
  @visibility(Lifecycle.Read)
  @key("name")
  name: string;
}

@doc("Model Deployment Definition")
model ModelDeployment extends Deployment {
  @doc("The type of the deployment")
  type: DeploymentType.ModelDeployment;

  @doc("Publisher-specific name of the deployed model")
  @visibility(Lifecycle.Read)
  modelName: string;

  @doc("Publisher-specific version of the deployed model")
  @visibility(Lifecycle.Read)
  modelVersion: string;

  @doc("Name of the deployed model's publisher")
  @visibility(Lifecycle.Read)
  modelPublisher: string;

  @doc("Capabilities of deployed model")
  @visibility(Lifecycle.Read)
  capabilities: Record<string>;

  @doc("Sku of the model deployment")
  @visibility(Lifecycle.Read)
  sku: Sku;

  @doc("Name of the connection the deployment comes from")
  @visibility(Lifecycle.Read)
  connectionName?: string;
}

@doc("Sku information")
model Sku {
  @doc("Sku capacity")
  capacity: int64;

  @doc("Sku family")
  family: string;

  @doc("Sku name")
  name: string;

  @doc("Sku size")
  size: string;

  @doc("Sku tier")
  tier: string;
}

union DeploymentType {
  string,

  @doc("Model deployment")
  ModelDeployment: "ModelDeployment",
}
