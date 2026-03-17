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
 * A distributed firewall policy resource.
 */
@parentResource(NetworkSite)
model NsxDistributedFirewallPolicy
  is Azure.ResourceManager.ProxyResource<
    NsxDistributedFirewallPolicyProperties,
    false
  > {
  ...ResourceNameParameter<
    Resource = NsxDistributedFirewallPolicy,
    KeyName = "policyName",
    SegmentName = "nsxDistributedFirewallPolicies",
    NamePattern = "^[a-zA-Z0-9-]*$"
  >;
}

/**
 * Properties of a distributed firewall policy.
 */
model NsxDistributedFirewallPolicyProperties is AzureResourceProperties {
  /** ARM resource ID of the associated NSX Manager. */
  nsxManagerArmId: Azure.Core.armResourceIdentifier;

  /** The policy category. */
  category?: DistributedFirewallPolicyCategory;

  /** The sequence number determining policy evaluation order. */
  sequenceNumber?: int32;

  /** Whether this is a default policy. */
  isDefault?: boolean;

  /** The federation scope of the policy. */
  federationScope?: FederationScope;

  /** Whether scope is applied. */
  scope?: boolean;

  /** ARM resource IDs of scope groups this policy applies to. */
  scopeGroupArmIds?: string[];
}

@armResourceOperations
interface NsxDistributedFirewallPolicies {
  /**
   * Gets the NsxDistributedFirewallPolicy resource.
   */
  get is ArmResourceRead<NsxDistributedFirewallPolicy>;

  /**
   * Creates or updates the NsxDistributedFirewallPolicy resource.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<NsxDistributedFirewallPolicy>;

  /**
   * Patches the NsxDistributedFirewallPolicy resource.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    NsxDistributedFirewallPolicy,
    NsxDistributedFirewallPolicyPatchProperties
  >;

  /**
   * Deletes the NsxDistributedFirewallPolicy resource.
   */
  delete is ArmResourceDeleteSync<NsxDistributedFirewallPolicy>;

  /**
   * Lists NsxDistributedFirewallPolicy resources within a network site.
   */
  listByNetworkSite is ArmResourceListByParent<
    NsxDistributedFirewallPolicy,
    Response = ArmResponse<NsxDistributedFirewallPolicyList>
  >;
}

model NsxDistributedFirewallPolicyList
  is Azure.Core.Page<NsxDistributedFirewallPolicy>;

@@maxLength(NsxDistributedFirewallPolicy.name, 63);
@@minLength(NsxDistributedFirewallPolicy.name, 3);
@@doc(NsxDistributedFirewallPolicy.name,
  "The name of the distributed firewall policy."
);
