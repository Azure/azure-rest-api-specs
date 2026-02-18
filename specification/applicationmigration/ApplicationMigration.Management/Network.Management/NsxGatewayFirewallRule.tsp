import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./NsxGatewayFirewallPolicy.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ApplicationMigration;

/**
 * A gateway firewall rule resource (child of NsxGatewayFirewallPolicy).
 */
@parentResource(NsxGatewayFirewallPolicy)
model NsxGatewayFirewallRule
  is Azure.ResourceManager.ProxyResource<NsxGatewayFirewallRuleProperties, false> {
  ...ResourceNameParameter<
    Resource = NsxGatewayFirewallRule,
    KeyName = "ruleName",
    SegmentName = "rules",
    NamePattern = "^[a-zA-Z0-9-]*$"
  >;
}

/**
 * Properties of a gateway firewall rule.
 */
model NsxGatewayFirewallRuleProperties is AzureResourceProperties {
  /** The action to take when the rule matches. */
  action?: FirewallAction;

  /** The traffic direction the rule applies to. */
  direction?: FirewallDirection;

  /** Whether the rule is disabled. */
  disabled?: boolean;

  /** The sequence number determining rule evaluation order. */
  sequenceNumber?: int32;

  /** ARM resource IDs of source IP groups. */
  sourceIpGroups?: Azure.Core.armResourceIdentifier[];

  /** Source IP addresses. */
  sourceAddresses?: string[];

  /** ARM resource IDs of destination IP groups. */
  destinationIpGroups?: Azure.Core.armResourceIdentifier[];

  /** Destination IP addresses. */
  destinationAddresses?: string[];

  /** ARM resource IDs of services this rule applies to. */
  services?: Azure.Core.armResourceIdentifier[];

  /** ARM resource IDs of scopes this rule is applied to. */
  appliedScopes?: Azure.Core.armResourceIdentifier[];

  /** ARM resource IDs of effective scopes. */
  effectiveScopes?: Azure.Core.armResourceIdentifier[];

  /** Original NSX resource metadata. */
  nsxOriginal?: NsxOriginal;
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
   * Lists NsxGatewayFirewallRule resources within a gateway firewall policy.
   */
  listByNsxGatewayFirewallPolicy is ArmResourceListByParent<
    NsxGatewayFirewallRule,
    Response = ArmResponse<NsxGatewayFirewallRuleList>
  >;
}

/**
 * A list of NsxGatewayFirewallRule resources.
 */
model NsxGatewayFirewallRuleList is Azure.Core.Page<NsxGatewayFirewallRule>;

@@maxLength(NsxGatewayFirewallRule.name, 63);
@@minLength(NsxGatewayFirewallRule.name, 3);
@@doc(NsxGatewayFirewallRule.name, "The name of the gateway firewall rule.");
@@doc(NsxGatewayFirewallRule.properties, "Resource properties.");
@@doc(NsxGatewayFirewallRules.createOrUpdate::parameters.resource,
  "The request body for creating or updating a NsxGatewayFirewallRule resource."
);
@@doc(NsxGatewayFirewallRules.update::parameters.properties,
  "The request body for patching a NsxGatewayFirewallRule resource."
);
