import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";

import "../models/NrfDeploymentModels.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.MobileNetwork;

@doc("Azure for Operators 5G Core Network Repository Function (NRF) Deployment Resource")
@resource("nrfDeployments")
model NrfDeploymentResource
  is TrackedResource<NrfDeploymentResourceProperties> {
  @doc("The name of the NRF Deployment")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$")
  @minLength(1)
  @maxLength(63)
  @key("nrfDeploymentName")
  @path
  @segment("nrfDeployments")
  @visibility("create", "read")
  name: string;
}

@armResourceOperations(NrfDeploymentResource)
interface NrfDeployments {
  get is ArmResourceRead<NrfDeploymentResource>;
  createOrUpdate is ArmResourceCreateOrUpdate2Async<NrfDeploymentResource>;
  updateTags is ArmTagsPatchSync<NrfDeploymentResource>;
  delete is ArmResourceDeleteWithoutOkAsync<NrfDeploymentResource>;
  @doc("List all Network Repository Function Deployments by Resource Group.")
  listByResourceGroup is ArmResourceListByParent<NrfDeploymentResource>;
  @doc("List all Network Repository Function Deployments by Subscription ID.")
  listBySubscription is ArmListBySubscription<NrfDeploymentResource>;
}
