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
}

@armResourceOperations
interface HierarchySettingsOperationGroup {
  /**
   * Gets the hierarchy settings defined at the Management Group level. Settings can only be set on the root Management Group of the hierarchy.
   *
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("HierarchySettings_Get")
  get is Extension.Read<Extension.Tenant, HierarchySettings>;

  /**
   * Creates or updates the hierarchy settings defined at the Management Group level.
   *
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("HierarchySettings_CreateOrUpdate")
  createOrUpdate is Azure.ResourceManager.Legacy.Extension.CreateOrReplaceSync<
    Extension.Tenant,
    HierarchySettings,
    Request = CreateOrUpdateSettingsRequest,
    Response = ArmResourceUpdatedResponse<HierarchySettings>
  >;

  /**
   * Updates the hierarchy settings defined at the Management Group level.
   *
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("HierarchySettings_Update")
  @patch(#{ implicitOptionality: false })
  update is Extension.CustomPatchSync<
    Extension.Tenant,
    HierarchySettings,
    PatchModel = CreateOrUpdateSettingsRequest
  >;

  /**
   * Deletes the hierarchy settings defined at the Management Group level.
   *
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("HierarchySettings_Delete")
  delete is Extension.DeleteSync<
    Extension.Tenant,
    HierarchySettings,
    Response = ArmDeletedResponse
  >;
}

@@doc(HierarchySettings.name, "");
@@doc(HierarchySettings.properties,
  "The generic properties of hierarchy settings."
);
@@doc(HierarchySettingsOperationGroup.createOrUpdate::parameters.resource,
  "Tenant level settings request parameter."
);
@@doc(HierarchySettingsOperationGroup.update::parameters.properties,
  "Tenant level settings request parameter."
);
