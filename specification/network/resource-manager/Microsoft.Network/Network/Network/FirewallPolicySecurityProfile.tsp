import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./FirewallPolicy.tsp";
import "../Common/main.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;
using Common;

namespace Microsoft.Network;
/**
 * Firewall Policy Security Profile resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "The converted firewallPolicy family places path metadata on its resource models. includeInapplicableMetadataInPayload(false) prevents metadata that is not applicable to an operation from being duplicated into that operation's payload, preserving the established request schemas."
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "The converted firewallPolicy family represents child resources as subclasses of Common.SubResourceModel. Retaining extends preserves the generated allOf and SDK inheritance for the id, name, and type envelope; model is or spread would flatten that established model hierarchy."
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "Common.SubResourceModel is the established custom Azure resource base for the brownfield firewallPolicy family. A standard ARM resource template would change its id, name, and type envelope and generated SDK hierarchy, so this child must retain the custom resource classification."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "firewallPolicy uses the ARM Legacy resource pattern; @Azure.ResourceManager.Legacy.feature(Features.firewallPolicy) is required to keep SecurityProfile consistent with the parent firewall policy resource tree."
@Azure.ResourceManager.Legacy.feature(Features.firewallPolicy)
@parentResource(FirewallPolicy)
@Http.Private.includeInapplicableMetadataInPayload(false)
@added(Versions.v2026_01_01)
model FirewallPolicySecurityProfile extends SubResourceModel {
  properties?: FirewallPolicySecurityProfileProperties;

  /**
   * The name of the resource that is unique within a resource group. This name can be used to access the resource.
   */
  @visibility(Lifecycle.Read)
  @path
  @key("securityProfileName")
  @segment("securityProfiles")
  @pattern("^[a-zA-Z0-9]([a-zA-Z0-9-._]{0,78}[a-zA-Z0-9_])?$")
  name: string;

  ...Azure.ResourceManager.Legacy.EntityTagProperty;

  /** The system metadata related to this resource. */
  @visibility(Lifecycle.Read)
  systemData?: Azure.ResourceManager.Foundations.SystemData;
}

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "These operations target the SecurityProfile child of firewallPolicy, which uses the ARM Legacy resource pattern; @Azure.ResourceManager.Legacy.feature(Features.firewallPolicy) is required for consistency with the parent firewall policy resource tree."
@Azure.ResourceManager.Legacy.feature(Features.firewallPolicy)
@added(Versions.v2026_01_01)
@armResourceOperations
interface FirewallPolicySecurityProfiles {
  /**
   * Gets the specified FirewallPolicySecurityProfile.
   */
  get is ArmResourceRead<FirewallPolicySecurityProfile, Error = CloudError>;

  /**
   * Creates or updates the specified FirewallPolicySecurityProfile.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    FirewallPolicySecurityProfile,
    Error = CloudError
  >;

  /**
   * Deletes the specified FirewallPolicySecurityProfile.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    FirewallPolicySecurityProfile,
    Error = CloudError
  >;

  /**
   * Lists all FirewallPolicySecurityProfiles in a FirewallPolicy resource.
   */
  list is ArmResourceListByParent<
    FirewallPolicySecurityProfile,
    Error = CloudError
  >;
}

@@doc(
  FirewallPolicySecurityProfile.name,
  "The name of the resource that is unique within a resource group. This name can be used to access the resource."
);
@@doc(
  FirewallPolicySecurityProfile.properties,
  "The properties of the firewall policy security profile."
);
@@doc(
  FirewallPolicySecurityProfiles.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update FirewallPolicySecurityProfile operation."
);
