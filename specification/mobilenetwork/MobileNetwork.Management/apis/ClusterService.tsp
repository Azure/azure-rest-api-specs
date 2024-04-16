import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";

import "../models/ClusterServiceModels.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.MobileNetwork;

@doc("Azure for Operators 5G Core Cluster Service Resource")
@resource("clusterServices")
model ClusterServiceResource
  is TrackedResource<ClusterServiceResourceProperties> {
  @doc("The name of the Cluster Service")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$")
  @minLength(1)
  @maxLength(63)
  @key("clusterServiceName")
  @path
  @segment("clusterServices")
  @visibility("create", "read")
  name: string;
}

@armResourceOperations(ClusterServiceResource)
interface ClusterServices {
  get is ArmResourceRead<ClusterServiceResource>;
  createOrUpdate is ArmResourceCreateOrUpdate2Async<ClusterServiceResource>;
  updateTags is ArmTagsPatchSync<ClusterServiceResource>;
  delete is ArmResourceDeleteWithoutOkAsync<ClusterServiceResource>;
  @doc("List all Cluster Services by Resource Group.")
  listByResourceGroup is ArmResourceListByParent<ClusterServiceResource>;
  @doc("List all Cluster Services by Subscription ID.")
  listBySubscription is ArmListBySubscription<ClusterServiceResource>;
}
