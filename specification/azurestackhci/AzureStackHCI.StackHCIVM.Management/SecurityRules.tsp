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
@doc("Security Rule resource.")
@parentResource(NetworkSecurityGroup)
model SecurityRule is ProxyResource<SecurityRuleProperties> {
  @doc("Name of the security rule.")
  @pattern("^[a-zA-Z0-9]$|^[a-zA-Z0-9][-._a-zA-Z0-9]{0,62}[a-zA-Z0-9]$")
  @path
  @key("securityRuleName")
  @segment("securityRules")
  @visibility("read")
  name: string;

  @doc("The extendedLocation of the resource.")
  extendedLocation?: ExtendedLocation;
}

@armResourceOperations
interface SecurityRules {
  @doc("Gets the specified security rule.")
  get is ArmResourceRead<SecurityRule>;

  @doc("Creates or updates a security rule in the specified resource group.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<SecurityRule>;

  @doc("Deletes the specified security rule.")
  delete is ArmResourceDeleteWithoutOkAsync<SecurityRule>;

  @doc("Gets all security rules in a Network Security Group.")
  list is ArmResourceListByParent<SecurityRule>;
}
