import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";

import "../models/ObservabilityServiceModels.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.MobileNetwork;

@doc("Azure for Operators 5G Core Observability Service Resource")
@resource("observabilityServices")
model ObservabilityServiceResource
  is TrackedResource<ObservabilityServiceResourceProperties> {
  @doc("The name of the Observability Service")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$")
  @minLength(1)
  @maxLength(63)
  @key("observabilityServiceName")
  @path
  @segment("observabilityServices")
  @visibility("create", "read")
  name: string;
}

@armResourceOperations(ObservabilityServiceResource)
interface ObservabilityServices {
  get is ArmResourceRead<ObservabilityServiceResource>;
  createOrUpdate is ArmResourceCreateOrUpdate2Async<ObservabilityServiceResource>;
  updateTags is ArmTagsPatchSync<ObservabilityServiceResource>;
  delete is ArmResourceDeleteWithoutOkAsync<ObservabilityServiceResource>;
  @doc("List all Observability Services by Resource Group.")
  listByResourceGroup is ArmResourceListByParent<ObservabilityServiceResource>;
  @doc("List all Observability Services by Subscription ID.")
  listBySubscription is ArmListBySubscription<ObservabilityServiceResource>;
}
