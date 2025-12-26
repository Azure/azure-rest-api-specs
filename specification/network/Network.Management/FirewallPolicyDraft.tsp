import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./FirewallPolicy.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
/**
 * FirewallPolicy Resource.
 */
@singleton("default")
@parentResource(FirewallPolicy)
@Http.Private.includeInapplicableMetadataInPayload(false)
model FirewallPolicyDraft extends Resource {
  properties?: FirewallPolicyDraftProperties;

  @visibility(Lifecycle.Read)
  @path
  @key("firewallPolicyDraft")
  @segment("firewallPolicyDrafts")
  name: string;  /** Resource tags. *//**
   * Resource location.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  location: string;
}

@armResourceOperations
interface FirewallPolicyDrafts {
  /**
   * Get a draft Firewall Policy.
   */
  get is ArmResourceRead<FirewallPolicyDraft, Error = CloudError>;

  /**
   * Create or update a draft Firewall Policy.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    FirewallPolicyDraft,
    Error = CloudError
  >;

  /**
   * Delete a draft policy.
   */
  delete is ArmResourceDeleteSync<FirewallPolicyDraft, Error = CloudError>;
}

@@doc(FirewallPolicyDraft.name, "");
@@doc(FirewallPolicyDraft.properties, "Properties of the firewall policy.");
@@doc(FirewallPolicyDrafts.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update Firewall Policy Draft operation."
);
