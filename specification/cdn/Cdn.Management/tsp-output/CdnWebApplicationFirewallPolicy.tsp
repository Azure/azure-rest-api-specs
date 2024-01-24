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

namespace Microsoft.Cdn;
/**
 * Defines web application firewall policy for Azure CDN.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@Azure.ResourceManager.Private.armResourceInternal(
  CdnWebApplicationFirewallPolicyProperties
)
@includeInapplicableMetadataInPayload(false)
model CdnWebApplicationFirewallPolicy extends TrackedResource {
  /**
   * The name of the CdnWebApplicationFirewallPolicy.
   */
  @maxLength(128)
  @path
  @key("policyName")
  @segment("cdnWebApplicationFirewallPolicies")
  name: string;

  /**
   * Gets a unique read-only string that changes whenever the resource is updated.
   */
  etag?: string;

  /**
   * The pricing tier (defines a CDN provider, feature list and rate) of the CdnWebApplicationFirewallPolicy.
   */
  sku: Sku;

  /**
   * Properties of the web application firewall policy.
   */
  @extension("x-ms-client-flatten", true)
  properties?: CdnWebApplicationFirewallPolicyProperties;
}

@armResourceOperations
interface CdnWebApplicationFirewallPolicies {
  /**
   * Retrieve protection policy with specified name within a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Policies_Get")
  get is ArmResourceRead<CdnWebApplicationFirewallPolicy>;

  /**
   * Create or update policy with specified rule set name within a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Policies_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<CdnWebApplicationFirewallPolicy>;

  /**
   * Update an existing CdnWebApplicationFirewallPolicy with the specified policy name under the specified subscription and resource group
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("Policies_Update")
  update is ArmCustomPatchAsync<
    CdnWebApplicationFirewallPolicy,
    CdnWebApplicationFirewallPolicyPatchParameters
  >;

  /**
   * Deletes Policy
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Policies_Delete")
  delete is ArmResourceDeleteSync<CdnWebApplicationFirewallPolicy>;

  /**
   * Lists all of the protection policies within a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Policies_List")
  list is ArmResourceListByParent<CdnWebApplicationFirewallPolicy>;
}

@@projectedName(CdnWebApplicationFirewallPolicies.createOrUpdate::parameters.resource,
  "json",
  "cdnWebApplicationFirewallPolicy"
);
@@extension(CdnWebApplicationFirewallPolicies.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "cdnWebApplicationFirewallPolicy"
);
@@doc(CdnWebApplicationFirewallPolicies.createOrUpdate::parameters.resource,
  "Policy to be created."
);
@@projectedName(CdnWebApplicationFirewallPolicies.update::parameters.properties,
  "json",
  "cdnWebApplicationFirewallPolicyPatchParameters"
);
@@extension(CdnWebApplicationFirewallPolicies.update::parameters.properties,
  "x-ms-client-name",
  "cdnWebApplicationFirewallPolicyPatchParameters"
);
@@doc(CdnWebApplicationFirewallPolicies.update::parameters.properties,
  "CdnWebApplicationFirewallPolicy parameters to be patched."
);
