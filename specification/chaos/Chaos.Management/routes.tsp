import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;

namespace Microsoft.Chaos;

@armResourceOperations
interface OperationStatuses {
  @doc("Get the status of an operation.")
  get is ArmResourceRead<Azure.ResourceManager.ArmOperationStatus>;
}
