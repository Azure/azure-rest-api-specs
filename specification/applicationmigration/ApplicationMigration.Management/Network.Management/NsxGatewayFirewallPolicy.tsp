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
 * A gateway firewall policy resource.
 */
@parentResource(NetworkSite)
model NsxGatewayFirewallPolicy
  is Azure.ResourceManager.ProxyResource<NsxGatewayFirewallPolicyProperties, false> {
  ...ResourceNameParameter<
    Resource = NsxGatewayFirewallPolicy,
    KeyName = "policyName",
    SegmentName = "gatewayFirewallPolicies",
    NamePattern = "^[a-zA-Z0-9-]*$"
  >;
}

/**
 * Properties of a gateway firewall policy.
 */
model NsxGatewayFirewallPolicyProperties is AzureResourceProperties {
  /** The policy category. */
  category?: GatewayPolicyCategory;

  /** The sequence number determining policy evaluation order. */
  sequenceNumber?: int32;

  /** Whether this is a default policy. */
  isDefault?: boolean;

  /** The federation scope of the policy. */
  federationScope?: FederationScope;

  /** ARM resource IDs of scopes this policy is applied to. */
  appliedScopes?: Azure.Core.armResourceIdentifier[];

  /** ARM resource IDs of effective scopes. */
  effectiveScopes?: Azure.Core.armResourceIdentifier[];

  /** Original NSX resource metadata. */
  nsxOriginal?: NsxOriginal;
}

@armResourceOperations
interface GatewayFirewallPolicies {
  /**
   * Gets the NsxGatewayFirewallPolicy resource.
   */
  get is ArmResourceRead<NsxGatewayFirewallPolicy>;

  /**
   * Creates or updates the NsxGatewayFirewallPolicy resource.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<NsxGatewayFirewallPolicy>;

  /**
   * Patches the NsxGatewayFirewallPolicy resource.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    NsxGatewayFirewallPolicy,
    NsxGatewayFirewallPolicyPatchProperties
  >;

  /**
   * Deletes the NsxGatewayFirewallPolicy resource.
   */
  delete is ArmResourceDeleteSync<NsxGatewayFirewallPolicy>;

  /**
   * Lists NsxGatewayFirewallPolicy resources within a network site.
   */
  listByNetworkSite is ArmResourceListByParent<
    NsxGatewayFirewallPolicy,
    Response = ArmResponse<NsxGatewayFirewallPolicyList>
  >;
}

model NsxGatewayFirewallPolicyList is Azure.Core.Page<NsxGatewayFirewallPolicy>;

@@maxLength(NsxGatewayFirewallPolicy.name, 63);
@@minLength(NsxGatewayFirewallPolicy.name, 3);
@@doc(NsxGatewayFirewallPolicy.name, "The name of the gateway firewall policy.");
