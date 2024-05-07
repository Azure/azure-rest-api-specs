import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";

import "../models/NnssfDeploymentModels.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.MobileNetwork;

@doc("Azure for Operators 5G Core Network Slice Selection Function (NSSF) Deployment Resource")
@resource("nssfDeployments")
model NssfDeploymentResource
  is TrackedResource<NssfDeploymentResourceProperties> {
  @doc("The name of the NSSF Deployment")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$")
  @minLength(1)
  @maxLength(63)
  @key("nssfDeploymentName")
  @path
  @segment("nssfDeployments")
  @visibility("create", "read")
  name: string;
}

@armResourceOperations(NssfDeploymentResource)
interface NssfDeployments {
  get is ArmResourceRead<NssfDeploymentResource>;
  createOrUpdate is ArmResourceCreateOrUpdate2Async<NssfDeploymentResource>;
  updateTags is ArmTagsPatchSync<NssfDeploymentResource>;
  delete is ArmResourceDeleteWithoutOkAsync<NssfDeploymentResource>;
  @doc("List all Network Slice Selection Function Deployments by Resource Group.")
  listByResourceGroup is ArmResourceListByParent<NssfDeploymentResource>;
  @doc("List all Network Slice Selection Function Deployments by Subscription ID.")
  listBySubscription is ArmListBySubscription<NssfDeploymentResource>;
}
