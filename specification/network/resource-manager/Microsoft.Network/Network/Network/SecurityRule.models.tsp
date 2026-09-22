import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./shared-models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
/**
 * Network security rule.
 */
@featureFile(Features.virtualNetwork)
@parentResource(NetworkSecurityGroup)
model SecurityRule is SubResourceInstance<SecurityRulePropertiesFormat> {
  @visibility(Lifecycle.Read)
  @path
  @key("securityRuleName")
  @segment("securityRules")
  name: string;

  /**
   * A unique read-only string that changes whenever the resource is updated.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;
}

@@doc(
  SecurityRule.name,
  "The name of the resource that is unique within a resource group. This name can be used to access the resource."
);
