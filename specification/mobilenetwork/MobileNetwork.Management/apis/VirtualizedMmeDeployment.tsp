import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";

import "../models/VirtualizedMmeDeploymentModels.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.MobileNetwork;

@added(Versions.v2024_05_15_preview)
@doc("Azure for Operators 5G Core virtual Mobility Management Entity (MME) Deployment Resource")
@resource("virtualizedMmeDeployments")
model VirtualizedMmeDeploymentResource
  is TrackedResource<VirtualizedMmeDeploymentResourceProperties> {
  @doc("The name of the Virtualized MME Deployment")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$")
  @minLength(1)
  @maxLength(63)
  @key("virtualizedMmeDeploymentName")
  @path
  @segment("virtualizedMmeDeployments")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  name: string;
}

@added(Versions.v2024_05_15_preview)
@armResourceOperations(VirtualizedMmeDeploymentResource)
interface VirtualizedMmeDeployments {
  get is ArmResourceRead<VirtualizedMmeDeploymentResource>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<VirtualizedMmeDeploymentResource>;
  updateTags is ArmTagsPatchSync<VirtualizedMmeDeploymentResource>;
  delete is ArmResourceDeleteWithoutOkAsync<VirtualizedMmeDeploymentResource>;
  listByResourceGroup is ArmResourceListByParent<VirtualizedMmeDeploymentResource>;
  listBySubscription is ArmListBySubscription<VirtualizedMmeDeploymentResource>;
}
