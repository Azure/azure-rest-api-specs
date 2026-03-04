import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.AzureStackHCI;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-openapi" "TODO - x-ms-azure-resource is this needed?"
@doc("The LoadBalancer resource definition.")
@extension("x-ms-azure-resource", true)
@added(Versions.v2025_09_01_preview)
model LoadBalancer is TrackedResource<LoadBalancerProperties> {
  @doc("Name of the load balancer")
  @pattern("^[a-zA-Z0-9]$|^[a-zA-Z0-9][-._a-zA-Z0-9]{0,62}[a-zA-Z0-9]$")
  @path
  @key("loadBalancerName")
  @segment("loadBalancers")
  @visibility(Lifecycle.Read)
  name: string;

  @doc("The extendedLocation of the resource.")
  extendedLocation?: ExtendedLocation;
}

@armResourceOperations
@added(Versions.v2025_09_01_preview)
interface LoadBalancers {
  @doc("The operation to get a loadBalancer.")
  get is ArmResourceRead<LoadBalancer>;

  @doc("The operation to create or update a loadBalancer. Please note some properties can be set only during LoadBalancer creation.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<LoadBalancer>;

  @doc("Updates a loadBalancer tags.")
  updateTags is ArmTagsPatchAsync<LoadBalancer, TagsObject>;

  @doc("The operation to delete a loadBalancer.")
  delete is ArmResourceDeleteWithoutOkAsync<LoadBalancer>;

  @doc("Lists all of the loadBalancers in the specified resource group. Use the nextLink property in the response to get the next page of LoadBalancer.")
  listByResourceGroup is ArmResourceListByParent<LoadBalancer>;

  @doc("Lists all of the loadBalancers in the specified subscription. Use the nextLink property in the response to get the next page of LoadBalancer.")
  listAll is ArmListBySubscription<LoadBalancer>;
}
