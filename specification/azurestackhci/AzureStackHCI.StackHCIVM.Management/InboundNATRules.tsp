import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.AzureStackHCI;
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@doc("InboundNATRule resource.")
@added(Versions.v2025_09_01_preview)
@parentResource(LoadBalancer)
model InboundNATRule is ProxyResource<InboundNATRuleProperties> {
  @doc("Name of the inbound NAT rule.")
  @pattern("^[a-zA-Z0-9]$|^[a-zA-Z0-9][-._a-zA-Z0-9]{0,62}[a-zA-Z0-9]$")
  @path
  @key("inboundNATRuleName")
  @segment("inboundNATRules")
  @visibility(Lifecycle.Read)
  name: string;

  @doc("The extendedLocation of the resource.")
  extendedLocation?: ExtendedLocation;
}

@armResourceOperations
@added(Versions.v2025_09_01_preview)
interface InboundNATRules {
  @doc("Gets the specified inbound NAT rule.")
  get is ArmResourceRead<InboundNATRule>;

  @doc("Creates or updates a inbound NAT rule in the specified resource group.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<InboundNATRule>;

  @doc("Deletes the specified inbound NAT rule.")
  delete is ArmResourceDeleteWithoutOkAsync<InboundNATRule>;

  @doc("Gets all inbound NAT rules in a Load Balancer.")
  listByNetworkSecurityGroup is ArmResourceListByParent<InboundNATRule>;
}
