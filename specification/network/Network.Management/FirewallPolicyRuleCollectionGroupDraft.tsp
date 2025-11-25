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
@singleton("default")
@parentResource(FirewallPolicyRuleCollectionGroup)
model FirewallPolicyRuleCollectionGroupDraft
  is Azure.ResourceManager.ProxyResource<FirewallPolicyRuleCollectionGroupDraftProperties> {
  ...ResourceNameParameter<
    Resource = FirewallPolicyRuleCollectionGroupDraft,
    KeyName = "ruleCollectionGroupDraft",
    SegmentName = "ruleCollectionGroupDrafts",
    NamePattern = ""
  >;
}

@armResourceOperations
interface FirewallPolicyRuleCollectionGroupDrafts {
  /**
   * Get Rule Collection Group Draft.
   */
  get is ArmResourceRead<FirewallPolicyRuleCollectionGroupDraft, Error = CloudError>;

  /**
   * Create or Update Rule Collection Group Draft.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<FirewallPolicyRuleCollectionGroupDraft, Error = CloudError>;

  /**
   * Delete Rule Collection Group Draft.
   */
  delete is ArmResourceDeleteSync<FirewallPolicyRuleCollectionGroupDraft, Error = CloudError>;
}

@@doc(FirewallPolicyRuleCollectionGroupDraft.name, "");
@@doc(FirewallPolicyRuleCollectionGroupDraft.properties,
  "The properties of the firewall policy rule collection group."
);
@@doc(FirewallPolicyRuleCollectionGroupDrafts.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update FirewallPolicyRuleCollectionGroup operation."
);
