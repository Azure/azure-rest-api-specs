import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ApiManagementServiceResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ApiManagement;
/**
 * Delegation settings for a developer portal.
 */
@singleton("delegation")
@parentResource(ApiManagementServiceResource)
model PortalDelegationSettings
  is Azure.ResourceManager.ProxyResource<PortalDelegationSettingsProperties> {
  ...ResourceNameParameter<
    Resource = PortalDelegationSettings,
    KeyName = "portalsetting",
    SegmentName = "portalsettings",
    NamePattern = ""
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface DelegationSettings {
  /**
   * Get Delegation Settings for the Portal.
   */
  #deprecated "deprecated"
  get is ArmResourceRead<
    PortalDelegationSettings,
    Response = ArmResponse<PortalDelegationSettings> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Gets the entity state (Etag) version of the DelegationSettings.
   */
  #deprecated "deprecated"
  getEntityTag is ArmResourceCheckExistence<
    PortalDelegationSettings,
    Response = OkResponse & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Create or Update Delegation settings.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #deprecated "deprecated"
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    PortalDelegationSettings,
    Parameters = {
      /**
       * ETag of the Entity. Not required when creating an entity, but required when updating an entity.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`?: string;
    },
    Response = ArmResourceUpdatedResponse<PortalDelegationSettings>
  >;

  /**
   * Update Delegation settings.
   */
  #deprecated "deprecated"
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    PortalDelegationSettings,
    PatchModel = PortalDelegationSettings,
    Parameters = {
      /**
       * ETag of the Entity. ETag should match the current entity state from the header response of the GET request or it should be * for unconditional update.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`: string;
    },
    Response = ArmNoContentResponse
  >;

  /**
   * Gets the secret validation key of the DelegationSettings.
   */
  #deprecated "deprecated"
  listSecrets is ArmResourceActionSync<
    PortalDelegationSettings,
    void,
    ArmResponse<PortalSettingValidationKeyContract>
  >;
}

@@doc(PortalDelegationSettings.name, "");
@@doc(PortalDelegationSettings.properties,
  "Delegation settings contract properties."
);
@@doc(DelegationSettings.createOrUpdate::parameters.resource,
  "Create or update parameters."
);
@@doc(DelegationSettings.update::parameters.properties,
  "Update Delegation settings."
);
