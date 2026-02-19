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
 * An NSX Tier-0 gateway resource.
 */
@parentResource(NetworkSite)
model NsxTier0Gateway
  is Azure.ResourceManager.ProxyResource<NsxTier0GatewayProperties, false> {
  ...ResourceNameParameter<
    Resource = NsxTier0Gateway,
    KeyName = "gatewayName",
    SegmentName = "tier0Gateways",
    NamePattern = "^[a-zA-Z0-9-]*$"
  >;
}

/**
 * Properties of an NSX Tier-0 gateway.
 */
model NsxTier0GatewayProperties is AzureResourceProperties {
  /** The high-availability mode. */
  haMode?: HaMode;

  /** Whether the firewall is enabled on this gateway. */
  firewallEnabled?: boolean;

  /** Whether this is a VRF gateway. */
  isVrf?: boolean;

  /** ARM resource IDs of associated Tier-1 gateways. */
  associatedTier1Gateways?: Azure.Core.armResourceIdentifier[];

  /** ARM resource IDs of associated segments. */
  associatedSegments?: Azure.Core.armResourceIdentifier[];

  /** ARM resource IDs of associated NAT rules. */
  associatedNatRules?: Azure.Core.armResourceIdentifier[];

  /** ARM resource IDs of associated gateway firewall policies. */
  associatedGfwPolicies?: Azure.Core.armResourceIdentifier[];
}

@armResourceOperations
interface NsxTier0Gateways {
  /**
   * Gets the NsxTier0Gateway resource.
   */
  get is ArmResourceRead<NsxTier0Gateway>;

  /**
   * Creates or updates the NsxTier0Gateway resource.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<NsxTier0Gateway>;

  /**
   * Patches the NsxTier0Gateway resource.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<NsxTier0Gateway, NsxTier0GatewayPatchProperties>;

  /**
   * Deletes the NsxTier0Gateway resource.
   */
  delete is ArmResourceDeleteSync<NsxTier0Gateway>;

  /**
   * Lists NsxTier0Gateway resources within a network site.
   */
  listByNetworkSite is ArmResourceListByParent<
    NsxTier0Gateway,
    Response = ArmResponse<NsxTier0GatewayList>
  >;

  /**
   * Lists NAT rules associated with this Tier-0 gateway.
   */
  @action("listNatRules")
  listNatRules is ArmResourceActionSync<NsxTier0Gateway, void, NsxNatRuleList>;
}

model NsxTier0GatewayList is Azure.Core.Page<NsxTier0Gateway>;

@@maxLength(NsxTier0Gateway.name, 63);
@@minLength(NsxTier0Gateway.name, 3);
@@doc(NsxTier0Gateway.name, "The name of the Tier-0 gateway.");
