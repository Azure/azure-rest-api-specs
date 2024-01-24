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

namespace Microsoft.Network;
/**
 * Defines web application firewall policy.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@Azure.ResourceManager.Private.armResourceInternal(
  WebApplicationFirewallPolicyProperties
)
@includeInapplicableMetadataInPayload(false)
model WebApplicationFirewallPolicy extends FrontDoorResourceModel {
  /**
   * The name of the Web Application Firewall Policy.
   */
  @maxLength(128)
  @path
  @key("policyName")
  @segment("FrontDoorWebApplicationFirewallPolicies")
  name: string;

  /**
   * Gets a unique read-only string that changes whenever the resource is updated.
   */
  etag?: string;

  /**
   * The pricing tier of web application firewall policy. Defaults to Classic_AzureFrontDoor if not specified.
   */
  sku?: Sku;

  /**
   * Properties of the web application firewall policy.
   */
  @extension("x-ms-client-flatten", true)
  properties?: WebApplicationFirewallPolicyProperties;
}

@armResourceOperations
interface WebApplicationFirewallPolicies {
  /**
   * Retrieve protection policy with specified name within a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Policies_Get")
  get is ArmResourceRead<WebApplicationFirewallPolicy>;

  /**
   * Create or update policy with specified rule set name within a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Policies_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<WebApplicationFirewallPolicy>;

  /**
   * Patch a specific frontdoor webApplicationFirewall policy for tags update under the specified subscription and resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("Policies_Update")
  update is ArmCustomPatchAsync<WebApplicationFirewallPolicy, TagsObject>;

  /**
   * Deletes Policy
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Policies_Delete")
  delete is ArmResourceDeleteAsync<WebApplicationFirewallPolicy>;

  /**
   * Lists all of the protection policies within a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Policies_List")
  list is ArmResourceListByParent<WebApplicationFirewallPolicy>;
}

@@projectedName(WebApplicationFirewallPolicies.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(WebApplicationFirewallPolicies.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(WebApplicationFirewallPolicies.createOrUpdate::parameters.resource,
  "Policy to be created."
);
@@projectedName(WebApplicationFirewallPolicies.update::parameters.properties,
  "json",
  "parameters"
);
@@extension(WebApplicationFirewallPolicies.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(WebApplicationFirewallPolicies.update::parameters.properties,
  "FrontdoorWebApplicationFirewallPolicy parameters to be patched."
);
