import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "../Common/main.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;
using Common;

namespace Microsoft.Network;

/**
 * KubeSelectorGroup resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "New resource type for grouping Kubernetes pod selectors with AKS clusters"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Inheriting from Resource for consistency with existing Network top-level resources"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "Using custom resource model for consistency with existing Network resources"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Using Legacy.feature for consistency with existing Network resources"
@Azure.ResourceManager.Legacy.feature(Features.kubeSelectorGroup)
@Http.Private.includeInapplicableMetadataInPayload(false)
@added(Versions.v2025_07_01)
model KubeSelectorGroup extends Common.Resource {
  properties?: KubeSelectorGroupProperties;

  @visibility(Lifecycle.Read)
  @path
  @key("kubeSelectorGroupName")
  @segment("kubeSelectorGroups")
  name: string;

  /** A unique read-only string that changes whenever the resource is updated. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Standard etag pattern for Network resources"
  @visibility(Lifecycle.Read)
  etag?: string;
}

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Using Legacy.feature for consistency with existing Network resources"
@Azure.ResourceManager.Legacy.feature(Features.kubeSelectorGroup)
@added(Versions.v2025_07_01)
@armResourceOperations
interface KubeSelectorGroups {
  /**
   * Gets the specified KubeSelectorGroup.
   */
  get is ArmResourceRead<KubeSelectorGroup, Error = CloudError>;

  /**
   * Creates or updates a KubeSelectorGroup.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    KubeSelectorGroup,
    Error = CloudError
  >;

  /**
   * Updates tags of a KubeSelectorGroup resource.
   */
  @patch(#{ implicitOptionality: false })
  updateTags is ArmCustomPatchSync<
    KubeSelectorGroup,
    PatchModel = TagsObject,
    Error = CloudError
  >;

  /**
   * Deletes the specified KubeSelectorGroup.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    KubeSelectorGroup,
    Error = CloudError
  >;

  /**
   * Gets all the KubeSelectorGroups in a resource group.
   */
  list is ArmResourceListByParent<KubeSelectorGroup, Error = CloudError>;

  /**
   * Gets all the KubeSelectorGroups in a subscription.
   */
  listAll is ArmListBySubscription<KubeSelectorGroup, Error = CloudError>;
}

@@doc(KubeSelectorGroup.name, "The name of the KubeSelectorGroup.");
@@doc(KubeSelectorGroup.properties,
  "Properties of the KubeSelectorGroup resource."
);
@@doc(KubeSelectorGroups.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update KubeSelectorGroup operation."
);
@@doc(KubeSelectorGroups.updateTags::parameters.properties,
  "Parameters supplied to update KubeSelectorGroup tags."
);
