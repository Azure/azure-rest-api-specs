import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AzureStackHCI;
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@doc("Default Security Rule resource.")
@includeInapplicableMetadataInPayload(false)
@parentResource(NetworkSecurityGroup)
model DefaultSecurityRule is ProxyResource<SecurityRuleProperties> {
  @doc("Name of the default security rule.")
  @path
  @key("defaultSecurityRuleName")
  @segment("defaultSecurityRules")
  @visibility("read")
  name: string;

  @doc("The extendedLocation of the resource.")
  extendedLocation?: ExtendedLocation;
}

@armResourceOperations
interface DefaultSecurityRules {
  @doc("Gets the specified Default Security Rule by name.")
  get is ArmResourceRead<DefaultSecurityRule>;

  @doc("Gets all Default Security Rules in a Network Security Group.")
  list is ArmResourceListByParent<DefaultSecurityRule>;
}
