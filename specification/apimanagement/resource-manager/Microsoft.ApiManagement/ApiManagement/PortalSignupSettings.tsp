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

// ResourceName = "ApiManagementPortalSignUpSetting" makes the C# emitter
// produce ApiManagementPortalSignUpSettingResource.cs / Collection.cs
// (matching the GA contract).
@armResourceOperations
interface PortalSignupSettingsOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** The name of the API Management service. */
        @path
        @segment("service")
        @key
        @pattern("^[a-zA-Z](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?$")
        @minLength(1)
        @maxLength(50)
        serviceName: string,
      },
      {
        /** Portal setting singleton key. */
        @path
        @segment("portalsettings")
        @key
        portalsetting: "signup",
      },
      ResourceName = "ApiManagementPortalSignUpSetting"
    > {}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface SignUpSettings {
  /**
   * Get Sign Up Settings for the Portal
   */
  #deprecated "deprecated"
  get is PortalSignupSettingsOps.Read<
    PortalSignupSettings,
    Response = ArmResponse<PortalSignupSettings> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      eTag: string;
    }
  >;

  /**
   * Gets the entity state (Etag) version of the SignUpSettings.
   */
  #deprecated "deprecated"
  getEntityTag is PortalSignupSettingsOps.CheckExistence<
    PortalSignupSettings,
    Response = OkResponse & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      eTag: string;
    }
  >;

  /**
   * Create or Update Sign-Up settings.
   */
  #deprecated "deprecated"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is PortalSignupSettingsOps.CreateOrUpdateSync<
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
  update is PortalSignupSettingsOps.CustomPatchSync<
    PortalSignupSettings,
    PatchModel = PortalSignupSettings,
    Parameters = IfMatchHeaderParameter,
    Response = ArmNoContentResponse
  >;
}

@@doc(PortalSignupSettings.name, "");
@@doc(PortalSignupSettings.properties, "Sign-up settings contract properties.");
@@doc(
  SignUpSettings.createOrUpdate::parameters.resource,
  "Create or update parameters."
);
@@doc(SignUpSettings.update::parameters.properties, "Update Sign-Up settings.");
