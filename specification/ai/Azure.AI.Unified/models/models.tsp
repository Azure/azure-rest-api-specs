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

namespace Azure.AI.Unified;

@doc("Model Deployment Definition")
@resource("models")
model Model {
  @doc("Name of the deployment for the model")
  @visibility("read")
  @key("deploymentName")
  deploymentName: string;

  @doc("Publisher-specific name of the model")
  @visibility("read")
  modelName: string;

  @doc("Publisher-specific version of the model")
  @visibility("read")
  modelVersion: string;

  @doc("Name of the model publisher")
  @visibility("read")
  publisher: string;

  @doc("Capabilities of model")
  @visibility("read")
  capabilities: Record<string>;

  @doc("RAI policy enabled for model")
  @visibility("read")
  raiPolicyName: string;

  @doc("Sku of the model deployment")
  @visibility("read")
  sku: Sku;

  @doc("Name of the connection the model comes from")
  @visibility("read")
  connectionName?: string;

  @doc("System data of the resource")
  @visibility("read")
  systemData: SystemData;
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
