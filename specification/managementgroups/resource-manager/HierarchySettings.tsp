import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ManagementGroup.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Management;
/**
 * Settings defined at the Management Group scope.
 */
@singleton("default")
@parentResource(ManagementGroup)
model HierarchySettings
  is Azure.ResourceManager.ProxyResource<HierarchySettingsProperties> {
  ...ResourceNameParameter<
    Resource = HierarchySettings,
    KeyName = "setting",
    SegmentName = "settings",
    NamePattern = ""
  >;

  /**
   * The fully qualified ID for the settings object.  For example, /providers/Microsoft.Management/managementGroups/0000000-0000-0000-0000-000000000000/settings/default.
   */
  @visibility("read")
  id?: string;

  /**
   * The type of the resource.  For example, Microsoft.Management/managementGroups/settings.
   */
  @visibility("read")
  type?: string;
}

@armResourceOperations
interface HierarchySettingsOperationGroup {
  /**
   * Gets the hierarchy settings defined at the Management Group level. Settings can only be set on the root Management Group of the hierarchy.
   *
   */
  get is ArmResourceRead<HierarchySettings>;

  /**
   * Creates or updates the hierarchy settings defined at the Management Group level.
   *
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<HierarchySettings>;

  /**
   * Updates the hierarchy settings defined at the Management Group level.
   *
   */
  @parameterVisibility
  update is ArmCustomPatchSync<
    HierarchySettings,
    CreateOrUpdateSettingsRequest
  >;

  /**
   * Deletes the hierarchy settings defined at the Management Group level.
   *
   */
  delete is ArmResourceDeleteSync<HierarchySettings>;

  /**
   * Gets all the hierarchy settings defined at the Management Group level. Settings can only be set on the root Management Group of the hierarchy.
   *
   */
  list is ArmResourceListByParent<HierarchySettings>;
}

@@doc(HierarchySettings.name, "");
@@doc(HierarchySettingsOperationGroup.createOrUpdate::parameters.resource,
  "Tenant level settings request parameter."
);
@@doc(HierarchySettingsOperationGroup.update::parameters.properties,
  "Tenant level settings request parameter."
);
