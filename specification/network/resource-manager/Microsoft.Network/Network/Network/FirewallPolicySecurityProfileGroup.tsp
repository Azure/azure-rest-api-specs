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
 * Firewall Policy Security Profile Group resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "@Http.Private.includeInapplicableMetadataInPayload is required to preserve the existing firewall policy sub-resource payload shape produced by the original Swagger."
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "SecurityProfileGroup extends SubResourceModel to preserve the existing id-only firewall policy sub-resource envelope from the original Swagger; inheritance is required for wire-format compatibility."
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "firewallPolicy child resources use the ARM Legacy custom-resource pattern; @parentResource(FirewallPolicy) with Legacy.feature is required to match the existing firewall policy resource hierarchy."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "firewallPolicy uses the ARM Legacy resource pattern; @Azure.ResourceManager.Legacy.feature(Features.firewallPolicy) is required to keep SecurityProfileGroup consistent with the parent firewall policy resource tree."
@Azure.ResourceManager.Legacy.feature(Features.firewallPolicy)
@parentResource(FirewallPolicy)
@Http.Private.includeInapplicableMetadataInPayload(false)
@added(Versions.v2026_01_01)
model FirewallPolicySecurityProfileGroup extends SubResourceModel {
  properties?: FirewallPolicySecurityProfileGroupProperties;

  /**
   * The name of the resource that is unique within a resource group. This name can be used to access the resource.
   */
  @visibility(Lifecycle.Read)
  @path
  @key("securityProfileGroupName")
  @segment("securityProfileGroups")
  @pattern("^[a-zA-Z0-9]([a-zA-Z0-9-._]{0,78}[a-zA-Z0-9_])?$")
  name: string;

  /** A unique read-only string that changes whenever the resource is updated. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "etag is an existing firewall policy sub-resource envelope property carried over from the original Swagger for optimistic concurrency; it must remain on the resource model."
  @visibility(Lifecycle.Read)
  etag?: string;
}

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "These operations target the SecurityProfileGroup child of firewallPolicy, which uses the ARM Legacy resource pattern; @Azure.ResourceManager.Legacy.feature(Features.firewallPolicy) is required for consistency with the parent firewall policy resource tree."
@Azure.ResourceManager.Legacy.feature(Features.firewallPolicy)
@added(Versions.v2026_01_01)
@armResourceOperations
interface FirewallPolicySecurityProfileGroups {
  /**
   * Gets the specified FirewallPolicySecurityProfileGroup.
   */
  get is ArmResourceRead<
    FirewallPolicySecurityProfileGroup,
    Error = CloudError
  >;

  /**
   * Creates or updates the specified FirewallPolicySecurityProfileGroup.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    FirewallPolicySecurityProfileGroup,
    Error = CloudError
  >;

  /**
   * Deletes the specified FirewallPolicySecurityProfileGroup.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    FirewallPolicySecurityProfileGroup,
    Error = CloudError
  >;

  /**
   * Lists all FirewallPolicySecurityProfileGroups in a FirewallPolicy resource.
   */
  list is ArmResourceListByParent<
    FirewallPolicySecurityProfileGroup,
    Error = CloudError
  >;
}

@@doc(
  FirewallPolicySecurityProfileGroup.name,
  "The name of the resource that is unique within a resource group. This name can be used to access the resource."
);
@@doc(
  FirewallPolicySecurityProfileGroup.properties,
  "The properties of the firewall policy security profile group."
);
@@doc(
  FirewallPolicySecurityProfileGroups.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update FirewallPolicySecurityProfileGroup operation."
);
