import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";

import "../models/VnfAgentDeploymentModels.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.MobileNetwork;

@added(Versions.v2024_05_15_preview)
@doc("Azure for Operators Virtual Network Function (VNF) Agent Deployment Resource")
@resource("vnfAgentDeployments")
model VnfAgentDeploymentResource
  is TrackedResource<VnfAgentDeploymentResourceProperties> {
  @doc("The name of the Virtual Network Function (VNF) Agent Deployment")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$")
  @minLength(1)
  @maxLength(63)
  @key("vnfAgentDeploymentName")
  @path
  @segment("vnfAgentDeployment")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  name: string;
}

@added(Versions.v2024_05_15_preview)
@armResourceOperations(VnfAgentDeploymentResource)
interface VnfAgentDeployments {
  get is ArmResourceRead<VnfAgentDeploymentResource>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<VnfAgentDeploymentResource>;
  updateTags is ArmTagsPatchSync<VnfAgentDeploymentResource>;
  delete is ArmResourceDeleteWithoutOkAsync<VnfAgentDeploymentResource>;
  @doc("List all Virtual Network Function (VNF) Agent Deployments by Resource Group.")
  listByResourceGroup is ArmResourceListByParent<VnfAgentDeploymentResource>;
  @doc("List all Virtual Network Function (VNF) Agent Deployments by Subscription ID.")
  listBySubscription is ArmListBySubscription<VnfAgentDeploymentResource>;
}
