import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.KubernetesConfiguration;
/**
 * An Azure Arc PrivateLinkScope definition.
 */
model KubernetesConfigurationPrivateLinkScope
  is Azure.ResourceManager.TrackedResource<KubernetesConfigurationPrivateLinkScopeProperties> {
  ...ResourceNameParameter<
    Resource = KubernetesConfigurationPrivateLinkScope,
    KeyName = "scopeName",
    SegmentName = "privateLinkScopes",
    NamePattern = ""
  >;
}

@armResourceOperations
interface KubernetesConfigurationPrivateLinkScopes {
  /**
   * Returns a Azure Arc PrivateLinkScope.
   */
  get is ArmResourceRead<KubernetesConfigurationPrivateLinkScope>;

  /**
   * Creates (or updates) a Azure Arc PrivateLinkScope. Note: You cannot specify a different value for InstrumentationKey nor AppId in the Put operation.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<KubernetesConfigurationPrivateLinkScope>;

  /**
   * Updates an existing PrivateLinkScope's tags. To update other fields use the CreateOrUpdate method.
   */
  @patch(#{ implicitOptionality: false })
  updateTags is ArmCustomPatchSync<
    KubernetesConfigurationPrivateLinkScope,
    PatchModel = TagsResource
  >;

  /**
   * Deletes a Azure Arc PrivateLinkScope.
   */
  delete is ArmResourceDeleteSync<KubernetesConfigurationPrivateLinkScope>;

  /**
   * Gets a list of Azure Arc PrivateLinkScopes within a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<KubernetesConfigurationPrivateLinkScope>;

  /**
   * Gets a list of all Azure Arc PrivateLinkScopes within a subscription.
   */
  list is ArmListBySubscription<KubernetesConfigurationPrivateLinkScope>;
}

@@doc(KubernetesConfigurationPrivateLinkScope.name,
  "The name of the Azure Arc PrivateLinkScope resource."
);
@@doc(KubernetesConfigurationPrivateLinkScope.properties,
  "Properties that define a Azure Arc PrivateLinkScope resource."
);
@@doc(KubernetesConfigurationPrivateLinkScopes.createOrUpdate::parameters.resource,
  "Properties that need to be specified to create or update a Azure Arc for Servers and Clusters PrivateLinkScope."
);
@@doc(KubernetesConfigurationPrivateLinkScopes.updateTags::parameters.properties,
  "Updated tag information to set into the PrivateLinkScope instance."
);
