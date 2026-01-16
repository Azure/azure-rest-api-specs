import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./FirewallPolicyRuleCollectionGroup.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
/**
 * Rule Collection Group resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@singleton("default")
@parentResource(FirewallPolicyRuleCollectionGroup)
@Http.Private.includeInapplicableMetadataInPayload(false)
model FirewallPolicyRuleCollectionGroupDraft extends SubResourceModel {
  properties?: FirewallPolicyRuleCollectionGroupDraftProperties;

  /**
   * The name of the resource that is unique within a resource group. This name can be used to access the resource.
   */
  @visibility(Lifecycle.Read)
  @path
  @key("ruleCollectionGroupDraft")
  @segment("ruleCollectionGroupDrafts")
  name: string;
}

@armResourceOperations
interface FirewallPolicyRuleCollectionGroupDrafts {
  /**
   * Get Rule Collection Group Draft.
   */
  get is ArmResourceRead<
    FirewallPolicyRuleCollectionGroupDraft,
    Error = CloudError
  >;

  /**
   * Create or Update Rule Collection Group Draft.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    FirewallPolicyRuleCollectionGroupDraft,
    Error = CloudError
  >;

  /**
   * Delete Rule Collection Group Draft.
   */
  delete is ArmResourceDeleteSync<
    FirewallPolicyRuleCollectionGroupDraft,
    Error = CloudError
  >;
}

@@doc(FirewallPolicyRuleCollectionGroupDraft.name,
  "The name of the resource that is unique within a resource group. This name can be used to access the resource."
);
@@doc(FirewallPolicyRuleCollectionGroupDraft.properties,
  "The properties of the firewall policy rule collection group."
);
@@doc(FirewallPolicyRuleCollectionGroupDrafts.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update FirewallPolicyRuleCollectionGroup operation."
);
