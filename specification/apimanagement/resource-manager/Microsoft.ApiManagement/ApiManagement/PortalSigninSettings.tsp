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
 * Sign-In settings for the Developer Portal.
 */
@singleton("signin")
@parentResource(ApiManagementServiceResource)
model PortalSigninSettings
  is Azure.ResourceManager.ProxyResource<PortalSigninSettingProperties> {
  ...ResourceNameParameter<
    Resource = PortalSigninSettings,
    KeyName = "portalsetting",
    SegmentName = "portalsettings",
    NamePattern = ""
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface SignInSettings {
  /**
   * Get Sign In Settings for the Portal
   */
  #deprecated "deprecated"
  get is ArmResourceRead<
    PortalSigninSettings,
    Response = ArmResponse<PortalSigninSettings> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Gets the entity state (Etag) version of the SignInSettings.
   */
  #deprecated "deprecated"
  getEntityTag is ArmResourceCheckExistence<
    PortalSigninSettings,
    Response = OkResponse & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Create or Update Sign-In settings.
   */
  #deprecated "deprecated"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    PortalSigninSettings,
    Parameters = {
      /**
       * ETag of the Entity. Not required when creating an entity, but required when updating an entity.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`?: string;
    },
    Response = ArmResourceUpdatedResponse<PortalSigninSettings>
  >;

  /**
   * Update Sign-In settings.
   */
  #deprecated "deprecated"
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    PortalSigninSettings,
    PatchModel = PortalSigninSettings,
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
}

@@doc(PortalSigninSettings.name, "");
@@doc(PortalSigninSettings.properties, "Sign-in settings contract properties.");
@@doc(SignInSettings.createOrUpdate::parameters.resource,
  "Create or update parameters."
);
@@doc(SignInSettings.update::parameters.properties, "Update Sign-In settings.");
