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
model WebApplicationFirewallPolicy
  is Azure.ResourceManager.Legacy.TrackedResourceWithOptionalLocation<WebApplicationFirewallPolicyPropertiesFormat> {
  ...ResourceNameParameter<
    Resource = WebApplicationFirewallPolicy,
    KeyName = "policyName",
    SegmentName = "ApplicationGatewayWebApplicationFirewallPolicies",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
}

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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
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
    Error = CloudError
  >;

  /**
   * Gets all the WAF policies in a subscription.
   */
  listAll is ArmListBySubscription<
    WebApplicationFirewallPolicy,
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
