import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./NetworkSite.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ApplicationMigration;

/**
 * A distributed firewall rule resource.
 */
@parentResource(NetworkSite)
model NsxDistributedFirewallRule
  is Azure.ResourceManager.ProxyResource<
    NsxDistributedFirewallRuleProperties,
    false
  > {
  ...ResourceNameParameter<
    Resource = NsxDistributedFirewallRule,
    KeyName = "ruleName",
    SegmentName = "nsxDistributedFirewallRules",
    NamePattern = "^[a-zA-Z0-9-]*$"
  >;
}

/**
 * Properties of a distributed firewall rule.
 */
model NsxDistributedFirewallRuleProperties is AzureResourceProperties {
  /** ARM resource ID of the associated NSX Manager. */
  nsxManagerArmId: Azure.Core.armResourceIdentifier;

  /** ARM resource ID of the parent distributed firewall policy. */
  parentDistributedFirewallPolicyArmId: Azure.Core.armResourceIdentifier;

  /** The action to take when the rule matches. */
  action?: FirewallAction;

  /** The traffic direction the rule applies to. */
  direction?: FirewallDirection;

  /** Whether scope is ANY. */
  anyScope?: boolean;

  /** ARM resource IDs of scope groups. */
  scopeGroupArmIds?: Azure.Core.armResourceIdentifier[];

  /** Whether source groups are excluded. */
  sourceExcluded?: boolean;

  /** Whether source is ANY. */
  sourceAny?: boolean;

  /** ARM resource IDs of source groups. */
  sourceGroupArmIds?: Azure.Core.armResourceIdentifier[];

  /** Source IP addresses. */
  sourceAddresses?: string[];

  /** Whether destination groups are excluded. */
  destinationsExcluded?: boolean;

  /** Whether destination is ANY. */
  destinationAny?: boolean;

  /** ARM resource IDs of destination groups. */
  destinationGroupsArmIds?: Azure.Core.armResourceIdentifier[];

  /** Destination IP addresses. */
  destinationAddresses?: string[];

  /** The services this rule applies to. */
  @identifiers(#[])
  services?: FirewallService[];
}

@armResourceOperations
interface NsxDistributedFirewallRules {
  /**
   * Gets the NsxDistributedFirewallRule resource.
   */
  get is ArmResourceRead<NsxDistributedFirewallRule>;

  /**
   * Creates or updates the NsxDistributedFirewallRule resource.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<NsxDistributedFirewallRule>;

  /**
   * Patches the NsxDistributedFirewallRule resource.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    NsxDistributedFirewallRule,
    NsxDistributedFirewallRulePatchProperties
  >;

  /**
   * Deletes the NsxDistributedFirewallRule resource.
   */
  delete is ArmResourceDeleteSync<NsxDistributedFirewallRule>;

  /**
   * Lists NsxDistributedFirewallRule resources within a network site.
   */
  listByNetworkSite is ArmResourceListByParent<
    NsxDistributedFirewallRule,
    Response = ArmResponse<NsxDistributedFirewallRuleList>
  >;
}

model NsxDistributedFirewallRuleList
  is Azure.Core.Page<NsxDistributedFirewallRule>;

@@maxLength(NsxDistributedFirewallRule.name, 63);
@@minLength(NsxDistributedFirewallRule.name, 3);
@@doc(NsxDistributedFirewallRule.name,
  "The name of the distributed firewall rule."
);
