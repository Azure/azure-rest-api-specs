import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";

import "../models/AmfDeploymentModels.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.MobileNetwork;

@doc("Azure for Operators 5G Core Access and Mobility Function (AMF) Deployment Resource")
@resource("amfDeployments")
model AmfDeploymentResource
  is TrackedResource<AmfDeploymentResourceProperties> {
  @doc("The name of the AMF Deployment")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$")
  @minLength(1)
  @maxLength(63)
  @key("amfDeploymentName")
  @path
  @segment("amfDeployments")
  @visibility("create", "read")
  name: string;
}

@armResourceOperations(AmfDeploymentResource)
interface AmfDeployments {
  get is ArmResourceRead<AmfDeploymentResource>;
  createOrUpdate is ArmResourceCreateOrUpdate2Async<AmfDeploymentResource>;
  updateTags is ArmTagsPatchSync<AmfDeploymentResource>;
  delete is ArmResourceDeleteWithoutOkAsync<AmfDeploymentResource>;
  @doc("List all Access and Mobility Function Deployments by Resource Group.")
  listByResourceGroup is ArmResourceListByParent<AmfDeploymentResource>;
  @doc("List all Access and Mobility Function Deployments by Subscription ID.")
  listBySubscription is ArmListBySubscription<AmfDeploymentResource>;
}
