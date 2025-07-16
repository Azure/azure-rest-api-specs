import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Microsoft.AzureStackHCI;
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@doc("LoadBalancerRule resource.")
@parentResource(LoadBalancer)
@added(Versions.v2025_09_01_preview)
model LoadBalancerRule is ProxyResource<LoadBalancerRuleProperties> {
  @doc("Name of the loadbalancer rule.")
  @pattern("^[a-zA-Z0-9]$|^[a-zA-Z0-9][-._a-zA-Z0-9]{0,62}[a-zA-Z0-9]$")
  @path
  @key("loadBalancerRuleName")
  @segment("loadBalancerRules")
  @visibility(Lifecycle.Read)
  name: string;

  @doc("The extendedLocation of the resource.")
  extendedLocation?: ExtendedLocation;
}

@armResourceOperations
@added(Versions.v2025_09_01_preview)
interface LoadBalancerRules {
  @doc("Gets the specified loadBalancer Rule.")
  get is ArmResourceRead<LoadBalancerRule>;

  @doc("Creates or updates a loadBalancer Rule in the specified resource group.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<LoadBalancerRule>;

  @doc("Deletes the specified loadBalancer Rule.")
  delete is ArmResourceDeleteWithoutOkAsync<LoadBalancerRule>;

  @doc("Gets all loadBalancer Rules in a Load Balancer.")
  listByLoadBalancer is ArmResourceListByParent<LoadBalancerRule>;
}
