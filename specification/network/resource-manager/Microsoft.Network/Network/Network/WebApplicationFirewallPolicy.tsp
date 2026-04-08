import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
/**
 * Defines web application firewall policy.
 */
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
@Http.Private.includeInapplicableMetadataInPayload(false)
model WebApplicationFirewallPolicy extends Resource {
  properties?: WebApplicationFirewallPolicyPropertiesFormat;

  @visibility(Lifecycle.Read)
  @path
  @key("policyName")
  @segment("ApplicationGatewayWebApplicationFirewallPolicies")
  name: string;

  /**
   * A unique read-only string that changes whenever the resource is updated.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;
}

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
@armResourceOperations
interface WebApplicationFirewallPolicies {
  /**
   * Retrieve protection policy with specified name within a resource group.
   */
  get is ArmResourceRead<WebApplicationFirewallPolicy, Error = CloudError>;

  /**
   * Creates or update policy with specified rule set name within a resource group.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    WebApplicationFirewallPolicy,
    Error = CloudError
  >;

  /**
   * Deletes Policy.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    WebApplicationFirewallPolicy,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Lists all of the protection policies within a resource group.
   */
  list is ArmResourceListByParent<
    WebApplicationFirewallPolicy,
    Response = WebApplicationFirewallPolicyListResult,
    Error = CloudError
  >;

  /**
   * Gets all the WAF policies in a subscription.
   */
  listAll is ArmListBySubscription<
    WebApplicationFirewallPolicy,
    Response = WebApplicationFirewallPolicyListResult,
    Error = CloudError
  >;
}

@@maxLength(WebApplicationFirewallPolicy.name, 128);
@@doc(WebApplicationFirewallPolicy.name, "The name of the policy.");
@@doc(WebApplicationFirewallPolicy.properties,
  "Properties of the web application firewall policy."
);
@@doc(WebApplicationFirewallPolicies.createOrUpdate::parameters.resource,
  "Policy to be created."
);
