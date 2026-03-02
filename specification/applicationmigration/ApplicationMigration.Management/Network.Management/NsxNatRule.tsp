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
    SegmentName = "nsxNatRules",
    NamePattern = "^[a-zA-Z0-9-]*$"
  >;
}

/**
 * Properties of an NSX NAT rule.
 */
model NsxNatRuleProperties is AzureResourceProperties {
  /** ARM resource ID of the associated NSX Manager. */
  nsxManagerRef?: Azure.Core.armResourceIdentifier;

  /** The NAT type (SNAT or DNAT). */
  natType?: NatType;

  /** The administrative state. */
  adminState?: AdminState;

  /** ARM resource ID of the parent gateway. */
  parentGateway?: Azure.Core.armResourceIdentifier;

  /** The match criteria. */
  match?: NatMatch;

  /** The translation target. */
  translate?: NatTranslate;
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

model NsxNatRuleList is Azure.Core.Page<NsxNatRule>;

@@maxLength(NsxNatRule.name, 63);
@@minLength(NsxNatRule.name, 3);
@@doc(NsxNatRule.name, "The name of the NAT rule.");
