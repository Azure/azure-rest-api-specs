import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";

import "../models/UpfDeploymentModels.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
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
  @visibility("create", "read")
  name: string;
}

@armResourceOperations(UpfDeploymentResource)
interface UpfDeployments {
  get is ArmResourceRead<UpfDeploymentResource>;
  createOrUpdate is ArmResourceCreateOrUpdate2Async<UpfDeploymentResource>;
  updateTags is ArmTagsPatchSync<UpfDeploymentResource>;
  delete is ArmResourceDeleteWithoutOkAsync<UpfDeploymentResource>;
  @doc("List all User Plane Function Deployments by Resource ID.")
  listByResourceGroup is ArmResourceListByParent<UpfDeploymentResource>;
  @doc("List all User Plane Function Deployments by Subscription ID.")
  listBySubscription is ArmListBySubscription<UpfDeploymentResource>;
}
