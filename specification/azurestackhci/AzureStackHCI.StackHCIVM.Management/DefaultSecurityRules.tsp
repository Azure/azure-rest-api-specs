import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./NetworkSecurityGroups.tsp";

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
model DefaultSecurityRule is TrackedResource<SecurityRuleProperties> {
  @doc("Name of the default security rule.")
  @maxLength(80)
  @minLength(1)
  @pattern("^[a-zA-Z0-9]$|^[a-zA-Z0-9][-._a-zA-Z0-9]{0,78}[_a-zA-Z0-9]$")
  @path
  @key("defaultSecurityRuleName")
  @segment("defaultsecurityrules")
  @visibility("read")
  name: string;

  ...EntityTag
}

@armResourceOperations
interface DefaultSecurityRules {
  @doc("Gets the specified Default Security Rule by name.")
  get is ArmResourceRead<DefaultSecurityRule>;

  @doc("Gets all Default Security Rules in a Network Security Group.")
  list is ArmResourceListByParent<DefaultSecurityRule>;
}

