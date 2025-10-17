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
 * Sign-Up settings for a developer portal.
 */
@singleton("signup")
@parentResource(ApiManagementServiceResource)
model PortalSignupSettings
  is Azure.ResourceManager.ProxyResource<PortalSignupSettingsProperties> {
  ...ResourceNameParameter<
    Resource = PortalSignupSettings,
    KeyName = "portalsetting",
    SegmentName = "portalsettings",
    NamePattern = ""
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface SignUpSettings {
  /**
   * Get Sign Up Settings for the Portal
   */
  #deprecated "deprecated"
  get is ArmResourceRead<
    PortalSignupSettings,
    Response = ArmResponse<PortalSignupSettings> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Gets the entity state (Etag) version of the SignUpSettings.
   */
  #deprecated "deprecated"
  getEntityTag is ArmResourceCheckExistence<
    PortalSignupSettings,
    Response = OkResponse & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Create or Update Sign-Up settings.
   */
  #deprecated "deprecated"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    PortalSignupSettings,
    Parameters = {
      /**
       * ETag of the Entity. Not required when creating an entity, but required when updating an entity.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`?: string;
    },
    Response = ArmResourceUpdatedResponse<PortalSignupSettings>
  >;

  /**
   * Update Sign-Up settings.
   */
  #deprecated "deprecated"
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    PortalSignupSettings,
    PatchModel = PortalSignupSettings,
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

@@doc(PortalSignupSettings.name, "");
@@doc(PortalSignupSettings.properties, "Sign-up settings contract properties.");
@@doc(SignUpSettings.createOrUpdate::parameters.resource,
  "Create or update parameters."
);
@@doc(SignUpSettings.update::parameters.properties, "Update Sign-Up settings.");
