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
 * An NSX NAT rule resource.
 */
@parentResource(NetworkSite)
model NsxNatRule
  is Azure.ResourceManager.ProxyResource<NsxNatRuleProperties, false> {
  ...ResourceNameParameter<
    Resource = NsxNatRule,
    KeyName = "natRuleName",
    SegmentName = "natRules",
    NamePattern = "^[a-zA-Z0-9-]*$"
  >;
}

/**
 * Properties of an NSX NAT rule.
 */
model NsxNatRuleProperties is AzureResourceProperties {
  /** The NAT type (SNAT or DNAT). */
  natType?: NatType;

  /** The administrative state. */
  adminState?: AdminState;

  /** The routing context referencing a Tier-1 gateway. */
  routingContext?: RoutingContext;

  /** The match criteria. */
  match?: NatMatch;

  /** The translation target. */
  translate?: NatTranslate;

  /** A content hash for change detection. */
  contentHash?: string;

  /** NSX tags applied to this NAT rule. */
  @identifiers(#[])
  tags?: NsxTag[];
}

@armResourceOperations
interface NsxNatRules {
  /**
   * Gets the NsxNatRule resource.
   */
  get is ArmResourceRead<NsxNatRule>;

  /**
   * Creates or updates the NsxNatRule resource.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<NsxNatRule>;

  /**
   * Patches the NsxNatRule resource.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<NsxNatRule, NsxNatRulePatchProperties>;

  /**
   * Deletes the NsxNatRule resource.
   */
  delete is ArmResourceDeleteSync<NsxNatRule>;

  /**
   * Lists NsxNatRule resources within a network site.
   */
  listByNetworkSite is ArmResourceListByParent<
    NsxNatRule,
    Response = ArmResponse<NsxNatRuleList>
  >;
}

/**
 * A list of NsxNatRule resources.
 */
model NsxNatRuleList is Azure.Core.Page<NsxNatRule>;

@@maxLength(NsxNatRule.name, 63);
@@minLength(NsxNatRule.name, 3);
@@doc(NsxNatRule.name, "The name of the NAT rule.");
@@doc(NsxNatRule.properties, "Resource properties.");
@@doc(NsxNatRules.createOrUpdate::parameters.resource,
  "The request body for creating or updating an NsxNatRule resource."
);
@@doc(NsxNatRules.update::parameters.properties,
  "The request body for patching an NsxNatRule resource."
);
