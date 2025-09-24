import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Cdn;
/**
 * Defines web application firewall policy for Azure CDN.
 */
model CdnWebApplicationFirewallPolicy
  is Azure.ResourceManager.TrackedResource<CdnWebApplicationFirewallPolicyProperties> {
  ...ResourceNameParameter<
    Resource = CdnWebApplicationFirewallPolicy,
    KeyName = "policyName",
    SegmentName = "cdnWebApplicationFirewallPolicies",
    NamePattern = ""
  >;

  /**
   * Gets a unique read-only string that changes whenever the resource is updated.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  etag?: string;

  /**
   * The pricing tier (defines a CDN provider, feature list and rate) of the CdnWebApplicationFirewallPolicy.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sku: Sku;
}

@armResourceOperations
interface CdnWebApplicationFirewallPolicies {
  /**
   * Retrieve protection policy with specified name within a resource group.
   */
  get is ArmResourceRead<CdnWebApplicationFirewallPolicy>;

  /**
   * Create or update policy with specified rule set name within a resource group.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    CdnWebApplicationFirewallPolicy,
    Response = ArmResourceUpdatedResponse<CdnWebApplicationFirewallPolicy> | ArmResourceCreatedResponse<CdnWebApplicationFirewallPolicy> | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = CdnWebApplicationFirewallPolicy>> & {
      @bodyRoot
      _: CdnWebApplicationFirewallPolicy;
    })
  >;

  /**
   * Update an existing CdnWebApplicationFirewallPolicy with the specified policy name under the specified subscription and resource group
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    CdnWebApplicationFirewallPolicy,
    PatchModel = CdnWebApplicationFirewallPolicyPatchParameters,
    Response = ArmResponse<CdnWebApplicationFirewallPolicy> | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = CdnWebApplicationFirewallPolicy>> & {
      @bodyRoot
      _: CdnWebApplicationFirewallPolicy;
    })
  >;

  /**
   * Deletes Policy
   */
  delete is ArmResourceDeleteSync<CdnWebApplicationFirewallPolicy>;

  /**
   * Lists all of the protection policies within a resource group.
   */
  @list
  list is ArmResourceListByParent<
    CdnWebApplicationFirewallPolicy,
    Response = ArmResponse<CdnWebApplicationFirewallPolicyList>
  >;
}

@@maxLength(CdnWebApplicationFirewallPolicy.name, 128);
@@doc(CdnWebApplicationFirewallPolicy.name,
  "The name of the CdnWebApplicationFirewallPolicy."
);
@@doc(CdnWebApplicationFirewallPolicy.properties,
  "Properties of the web application firewall policy."
);
@@doc(CdnWebApplicationFirewallPolicies.createOrUpdate::parameters.resource,
  "Policy to be created."
);
@@doc(CdnWebApplicationFirewallPolicies.update::parameters.properties,
  "CdnWebApplicationFirewallPolicy parameters to be patched."
);
