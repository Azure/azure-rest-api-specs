import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "../main.tsp";
import "../common/models.tsp";
import "@typespec/openapi";

using TypeSpec.OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

namespace Azure.AI.Projects;

@doc("Model Deployment Definition")
@resource("deployments")
model Deployment {
  @doc("Name of the deployment")
  @visibility("read")
  @key("name")
  name: string;

  @doc("Publisher-specific name of the deployed model")
  @visibility("read")
  modelName: string;

  @doc("Publisher-specific version of the deployed model")
  @visibility("read")
  modelVersion: string;

  @doc("Name of the deployed model's publisher")
  @visibility("read")
  modelPublisher: string;

  @doc("Capabilities of deployed model")
  @visibility("read")
  capabilities: Record<string>;

  @doc("Sku of the model deployment")
  @visibility("read")
  sku: Sku;

  @doc("Name of the connection the deployment comes from")
  @visibility("read")
  connectionName?: string;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance"
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
