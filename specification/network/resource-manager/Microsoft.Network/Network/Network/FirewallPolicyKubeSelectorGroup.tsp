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
 * Firewall Policy Kubernetes Selector Group resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "@Http.Private.includeInapplicableMetadataInPayload is required to preserve the existing firewall policy sub-resource payload shape produced by the original Swagger."
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "KubeSelectorGroup extends SubResourceModel to preserve the existing id-only firewall policy sub-resource envelope from the original Swagger; inheritance is required for wire-format compatibility."
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "firewallPolicy child resources use the ARM Legacy custom-resource pattern; @parentResource(FirewallPolicy) with Legacy.feature is required to match the existing firewall policy resource hierarchy."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "firewallPolicy uses the ARM Legacy resource pattern; @Azure.ResourceManager.Legacy.feature(Features.firewallPolicy) is required to keep KubeSelectorGroup consistent with the parent firewall policy resource tree."
@Azure.ResourceManager.Legacy.feature(Features.firewallPolicy)
@parentResource(FirewallPolicy)
@Http.Private.includeInapplicableMetadataInPayload(false)
@added(Versions.v2025_09_01)
model FirewallPolicyKubeSelectorGroup extends SubResourceModel {
  properties?: FirewallPolicyKubeSelectorGroupProperties;

  /**
   * The name of the resource that is unique within a resource group. This name can be used to access the resource.
   */
  @visibility(Lifecycle.Read)
  @path
  @key("kubeSelectorGroupName")
  @segment("kubeSelectorGroups")
  @pattern("^[a-zA-Z0-9]([a-zA-Z0-9-._]{0,78}[a-zA-Z0-9_])?$")
  name: string;

  /** A unique read-only string that changes whenever the resource is updated. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "etag is an existing firewall policy sub-resource envelope property carried over from the original Swagger for optimistic concurrency; it must remain on the resource model."
  @visibility(Lifecycle.Read)
  etag?: string;
}

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "These operations target the KubeSelectorGroup child of firewallPolicy, which uses the ARM Legacy resource pattern; @Azure.ResourceManager.Legacy.feature(Features.firewallPolicy) is required for consistency with the parent firewall policy resource tree."
@Azure.ResourceManager.Legacy.feature(Features.firewallPolicy)
@added(Versions.v2025_09_01)
@armResourceOperations
interface FirewallPolicyKubeSelectorGroups {
  /**
   * Gets the specified FirewallPolicyKubeSelectorGroup.
   */
  get is ArmResourceRead<FirewallPolicyKubeSelectorGroup, Error = CloudError>;

  /**
   * Creates or updates the specified FirewallPolicyKubeSelectorGroup.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    FirewallPolicyKubeSelectorGroup,
    Error = CloudError
  >;

  /**
   * Deletes the specified FirewallPolicyKubeSelectorGroup.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "KubeSelectorGroup delete is a long-running operation that returns 200, 202, and 204 to match the existing firewall policy delete behavior, which deviates from the default ARM delete response codes."
  delete is ArmResourceDeleteWithoutOkAsync<
    FirewallPolicyKubeSelectorGroup,
    Response =
      | ArmDeletedResponse
      | ArmDeleteAcceptedLroResponse
      | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Lists all FirewallPolicyKubeSelectorGroups in a FirewallPolicy resource.
   */
  list is ArmResourceListByParent<
    FirewallPolicyKubeSelectorGroup,
    Error = CloudError
  >;
}

@@doc(
  FirewallPolicyKubeSelectorGroup.name,
  "The name of the FirewallPolicyKubeSelectorGroup."
);
@@doc(
  FirewallPolicyKubeSelectorGroup.name,
  "The name of the resource that is unique within a resource group. This name can be used to access the resource."
);
@@doc(
  FirewallPolicyKubeSelectorGroup.properties,
  "The properties of the firewall policy Kubernetes selector group."
);
@@doc(
  FirewallPolicyKubeSelectorGroups.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update FirewallPolicyKubeSelectorGroup operation."
);
