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
#suppress "@azure-tools/typespec-azure-core/casing-style" "IP is a short form. The casing is correct."
@doc("InboundNATRule resource.")
@parentResource(LoadBalancer)
@added(Versions.v2025_09_01_preview)
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

#suppress "@azure-tools/typespec-azure-core/casing-style" "IP is a short form. The casing is correct."
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
