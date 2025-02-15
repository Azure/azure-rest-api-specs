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

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance"
@doc("Model Deployment Definition")
model Model extends ResourceBase {
  @doc("Name of the specific model that is deployed")
  @visibility("read")
  modelName: string;

  @doc("Name of the model publisher")
  @visibility("read")
  modelPublisher: string;

  @doc("Model format")
  @visibility("read")
  modelFormat: string;

  @doc("Sku of the model deployment")
  @visibility("read")
  sku: Sku;
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

