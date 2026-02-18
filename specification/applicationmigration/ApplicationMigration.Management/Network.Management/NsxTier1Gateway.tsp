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
 * An NSX Tier-1 gateway resource.
 */
@parentResource(NetworkSite)
model NsxTier1Gateway
  is Azure.ResourceManager.ProxyResource<NsxTier1GatewayProperties, false> {
  ...ResourceNameParameter<
    Resource = NsxTier1Gateway,
    KeyName = "gatewayName",
    SegmentName = "tier1Gateways",
    NamePattern = "^[a-zA-Z0-9-]*$"
  >;
}

/**
 * Properties of an NSX Tier-1 gateway.
 */
model NsxTier1GatewayProperties is AzureResourceProperties {
  /** The high-availability mode. */
  haMode?: HaMode;

  /** Whether the firewall is enabled on this gateway. */
  firewallEnabled?: boolean;

  /** ARM resource ID of the parent Tier-0 gateway. */
  parentTier0Gateway?: Azure.Core.armResourceIdentifier;

  /** ARM resource IDs of associated segments. */
  associatedSegments?: Azure.Core.armResourceIdentifier[];

  /** ARM resource IDs of associated DNS services. */
  associatedDnsServices?: Azure.Core.armResourceIdentifier[];

  /** ARM resource IDs of associated NAT rules. */
  associatedNatRules?: Azure.Core.armResourceIdentifier[];

  /** ARM resource IDs of associated gateway firewall policies. */
  associatedGfwPolicies?: Azure.Core.armResourceIdentifier[];

  /** ARM resource IDs of associated load balancers. */
  associatedLoadBalancers?: Azure.Core.armResourceIdentifier[];
}

@armResourceOperations
interface NsxTier1Gateways {
  /**
   * Gets the NsxTier1Gateway resource.
   */
  get is ArmResourceRead<NsxTier1Gateway>;

  /**
   * Creates or updates the NsxTier1Gateway resource.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<NsxTier1Gateway>;

  /**
   * Patches the NsxTier1Gateway resource.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<NsxTier1Gateway, NsxTier1GatewayPatchProperties>;

  /**
   * Deletes the NsxTier1Gateway resource.
   */
  delete is ArmResourceDeleteSync<NsxTier1Gateway>;

  /**
   * Lists NsxTier1Gateway resources within a network site.
   */
  listByNetworkSite is ArmResourceListByParent<
    NsxTier1Gateway,
    Response = ArmResponse<NsxTier1GatewayList>
  >;
}

model NsxTier1GatewayList is Azure.Core.Page<NsxTier1Gateway>;

@@maxLength(NsxTier1Gateway.name, 63);
@@minLength(NsxTier1Gateway.name, 3);
@@doc(NsxTier1Gateway.name, "The name of the Tier-1 gateway.");
