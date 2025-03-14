import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";

import "../models/SdmDeploymentModels.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.MobileNetwork;

@added(Versions.v2024_05_15_preview)
@doc("Azure for Operators 5G Core Subscriber Data Management Function (SDM) Deployment Resource")
@resource("sdmDeployments")
model SdmDeploymentResource
  is TrackedResource<SdmDeploymentResourceProperties> {
  @doc("The name of the SDM Deployment")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$")
  @minLength(1)
  @maxLength(63)
  @key("sdmDeploymentName")
  @path
  @segment("sdmDeployment")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  name: string;
}

@added(Versions.v2024_05_15_preview)
@armResourceOperations(SdmDeploymentResource)
interface SdmDeployments {
  get is ArmResourceRead<SdmDeploymentResource>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<SdmDeploymentResource>;
  updateTags is ArmTagsPatchSync<SdmDeploymentResource>;
  delete is ArmResourceDeleteWithoutOkAsync<SdmDeploymentResource>;
  @doc("List all Subscriber Data Management Deployments by Resource Group.")
  listByResourceGroup is ArmResourceListByParent<SdmDeploymentResource>;
  @doc("List all Subscriber Data Management Deployments by Subscription ID.")
  listBySubscription is ArmListBySubscription<SdmDeploymentResource>;
}
