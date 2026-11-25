import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./FirewallPolicy.tsp";
import "./shared-models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.Network;
/**
 * Firewall Policy Kubernetes Selector Group resource.
 */
@featureFile(Features.firewallPolicy)
@parentResource(FirewallPolicy)
@added(Versions.v2025_09_01)
model FirewallPolicyKubeSelectorGroup
  is SubResourceInstance<FirewallPolicyKubeSelectorGroupProperties> {
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

@featureFile(Features.firewallPolicy)
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
  delete is ArmResourceDeleteWithoutOkAsync<
    FirewallPolicyKubeSelectorGroup,
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
