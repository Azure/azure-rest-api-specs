import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";

import "../models/SmfDeploymentModels.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.MobileNetwork;

@doc("Azure for Operators 5G Core Session Management Function (SMF) Deployment Resource")
@resource("smfDeployments")
model SmfDeploymentResource
  is TrackedResource<SmfDeploymentResourceProperties> {
  @doc("The name of the SMF Deployment")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$")
  @minLength(1)
  @maxLength(63)
  @key("smfDeploymentName")
  @path
  @segment("smfDeployment")
  @visibility("create", "read")
  name: string;
}

@armResourceOperations(SmfDeploymentResource)
interface SmfDeployments {
  get is ArmResourceRead<SmfDeploymentResource>;
  createOrUpdate is ArmResourceCreateOrUpdate2Async<SmfDeploymentResource>;
  updateTags is ArmTagsPatchSync<SmfDeploymentResource>;
  delete is ArmResourceDeleteWithoutOkAsync<SmfDeploymentResource>;
  @doc("List all Session Management Function Deployments by Resource Group.")
  listByResourceGroup is ArmResourceListByParent<SmfDeploymentResource>;
  @doc("List all Session Management Function Deployments by Subscription ID.")
  listBySubscription is ArmListBySubscription<SmfDeploymentResource>;
}
