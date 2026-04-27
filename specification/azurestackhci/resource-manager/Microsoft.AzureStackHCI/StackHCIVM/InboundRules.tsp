import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
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
#suppress "@azure-tools/typespec-azure-core/no-openapi" "x-ms-azure-resource legacy"
@doc("The inbound rule resource definition.")
@extension("x-ms-azure-resource", true)
@parentResource(NatGateway)
@added(Versions.v2026_04_01_preview)
model InboundRule is ProxyResource<InboundRuleProperties> {
  @doc("Name of the inbound rule")
  @pattern("^[a-zA-Z0-9]$|^[a-zA-Z0-9][-._a-zA-Z0-9]{0,62}[a-zA-Z0-9]$")
  @path
  @key("inboundRuleName")
  @segment("inboundRules")
  @visibility(Lifecycle.Read)
  name: string;

  @doc("The extendedLocation of the resource.")
  extendedLocation?: ExtendedLocation;
}

@armResourceOperations
@added(Versions.v2026_04_01_preview)
interface InboundRules {
  @doc("The operation to get an inbound rule.")
  get is ArmResourceRead<InboundRule>;

  @doc("The operation to create or update an inbound rule. Please note some properties can be set only during inbound rule creation.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<InboundRule>;

  @doc("The operation to delete an inbound rule.")
  delete is ArmResourceDeleteWithoutOkAsync<InboundRule>;

  @doc("Lists all of the inbound rules in the specified NAT gateway. Use the nextLink property in the response to get the next page of inbound rules.")
  listByNatGateway is ArmResourceListByParent<InboundRule>;
}
