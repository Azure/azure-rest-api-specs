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
 * SmartGroup resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "New resource type for grouping multiple source selectors (KubeSelector, GeoLocation, etc.)"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Inheriting from Resource for consistency with existing Network top-level resources"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "Using custom resource model for consistency with existing Network resources"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Using Legacy.feature for consistency with existing Network resources"
@Azure.ResourceManager.Legacy.feature(Features.smartGroup)
@Http.Private.includeInapplicableMetadataInPayload(false)
@added(Versions.v2025_07_01)
model SmartGroup extends Common.Resource {
  properties?: SmartGroupProperties;

  @visibility(Lifecycle.Read)
  @path
  @key("smartGroupName")
  @segment("smartGroups")
  name: string;

  /** A unique read-only string that changes whenever the resource is updated. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Standard etag pattern for Network resources"
  @visibility(Lifecycle.Read)
  etag?: string;
}

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Using Legacy.feature for consistency with existing Network resources"
@Azure.ResourceManager.Legacy.feature(Features.smartGroup)
@added(Versions.v2025_07_01)
@armResourceOperations
interface SmartGroups {
  /**
   * Gets the specified SmartGroup.
   */
  get is ArmResourceRead<SmartGroup, Error = CloudError>;

  /**
   * Creates or updates a SmartGroup.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    SmartGroup,
    Error = CloudError
  >;

  /**
   * Updates tags of a SmartGroup resource.
   */
  @patch(#{ implicitOptionality: false })
  updateTags is ArmCustomPatchSync<
    SmartGroup,
    PatchModel = TagsObject,
    Error = CloudError
  >;

  /**
   * Deletes the specified SmartGroup.
   */
  delete is ArmResourceDeleteWithoutOkAsync<SmartGroup, Error = CloudError>;

  /**
   * Gets all the SmartGroups in a resource group.
   */
  list is ArmResourceListByParent<SmartGroup, Error = CloudError>;

  /**
   * Gets all the SmartGroups in a subscription.
   */
  listAll is ArmListBySubscription<SmartGroup, Error = CloudError>;
}

@@doc(SmartGroup.name, "The name of the SmartGroup.");
@@doc(SmartGroup.properties, "Properties of the SmartGroup resource.");
@@doc(SmartGroups.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update SmartGroup operation."
);
@@doc(SmartGroups.updateTags::parameters.properties,
  "Parameters supplied to update SmartGroup tags."
);
