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
 * A gateway firewall rule resource.
 */
@parentResource(NetworkSite)
model NsxGatewayFirewallRule
  is Azure.ResourceManager.ProxyResource<
    NsxGatewayFirewallRuleProperties,
    false
  > {
  ...ResourceNameParameter<
    Resource = NsxGatewayFirewallRule,
    KeyName = "ruleName",
    SegmentName = "nsxGatewayFirewallRules",
    NamePattern = "^[a-zA-Z0-9-]*$"
  >;
}

/**
 * Properties of a gateway firewall rule.
 */
model NsxGatewayFirewallRuleProperties is AzureResourceProperties {
  /** ARM resource ID of the associated NSX Manager. */
  nsxManagerArmId: Azure.Core.armResourceIdentifier;

  /** ARM resource ID of the parent gateway firewall policy. */
  parentGatewayFirewallPolicyArmId?: Azure.Core.armResourceIdentifier;

  /** The action to take when the rule matches. */
  action?: FirewallAction;

  /** The traffic direction the rule applies to. */
  direction?: FirewallDirection;

  /** Whether the rule is disabled. */
  disabled?: boolean;

  /** The sequence number determining rule evaluation order. */
  sequenceNumber?: int32;

  /** The global priority of the rule. */
  globalPriority?: string;

  /** ARM resource IDs of source IP groups. */
  sourceIpGroupArmIds?: Azure.Core.armResourceIdentifier[];

  /** Source IP addresses. */
  sourceAddresses?: string[];

  /** ARM resource IDs of destination IP groups. */
  destinationIpGroupArmIds?: Azure.Core.armResourceIdentifier[];

  /** Destination IP addresses. */
  destinationAddresses?: string[];

  /** The services this rule applies to. */
  @identifiers(#[])
  services?: FirewallService[];

  /** ARM resource IDs of scopes this rule is applied to. */
  appliedScopeArmIds?: Azure.Core.armResourceIdentifier[];

  /** ARM resource IDs of effective scopes. */
  effectiveScopeArmIds?: Azure.Core.armResourceIdentifier[];
}

@armResourceOperations
interface NsxGatewayFirewallRules {
  /**
   * Gets the NsxGatewayFirewallRule resource.
   */
  get is ArmResourceRead<NsxGatewayFirewallRule>;

  /**
   * Creates or updates the NsxGatewayFirewallRule resource.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<NsxGatewayFirewallRule>;

  /**
   * Patches the NsxGatewayFirewallRule resource.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    NsxGatewayFirewallRule,
    NsxGatewayFirewallRulePatchProperties
  >;

  /**
   * Deletes the NsxGatewayFirewallRule resource.
   */
  delete is ArmResourceDeleteSync<NsxGatewayFirewallRule>;

  /**
   * Lists NsxGatewayFirewallRule resources within a network site.
   */
  listByNetworkSite is ArmResourceListByParent<
    NsxGatewayFirewallRule,
    Response = ArmResponse<NsxGatewayFirewallRuleList>
  >;
}

model NsxGatewayFirewallRuleList is Azure.Core.Page<NsxGatewayFirewallRule>;

@@maxLength(NsxGatewayFirewallRule.name, 63);
@@minLength(NsxGatewayFirewallRule.name, 3);
@@doc(NsxGatewayFirewallRule.name, "The name of the gateway firewall rule.");
