import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";

import "../models/UpfDeploymentModels.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.MobileNetwork;

@doc("Azure for Operators 5G Core User Plane Function (UPF) Deployment Resource")
@resource("upfDeployments")
model UpfDeploymentResource
  is TrackedResource<UpfDeploymentResourceProperties> {
  @doc("The name of the UPF Deployment")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$")
  @minLength(1)
  @maxLength(63)
  @key("upfDeploymentName")
  @path
  @segment("upfDeployments")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  name: string;
}

@armResourceOperations(UpfDeploymentResource)
interface UpfDeployments {
  get is ArmResourceRead<UpfDeploymentResource>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<UpfDeploymentResource>;
  updateTags is ArmTagsPatchSync<UpfDeploymentResource>;
  delete is ArmResourceDeleteWithoutOkAsync<UpfDeploymentResource>;
  @doc("List all User Plane Function Deployments by Resource ID.")
  listByResourceGroup is ArmResourceListByParent<UpfDeploymentResource>;
  @doc("List all User Plane Function Deployments by Subscription ID.")
  listBySubscription is ArmListBySubscription<UpfDeploymentResource>;
}
