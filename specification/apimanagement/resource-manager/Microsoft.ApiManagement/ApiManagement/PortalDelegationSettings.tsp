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

// ResourceName = "ApiManagementPortalDelegationSetting" makes the C# emitter
// produce ApiManagementPortalDelegationSettingResource.cs / Collection.cs
// (matching the GA contract).
@armResourceOperations
interface PortalDelegationSettingsOps
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
        portalsetting: "delegation",
      },
      ResourceName = "ApiManagementPortalDelegationSetting"
    > {}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface DelegationSettings {
  /**
   * Get Delegation Settings for the Portal.
   */
  #deprecated "deprecated"
  get is PortalDelegationSettingsOps.Read<
    PortalDelegationSettings,
    Response = ArmResponse<PortalDelegationSettings> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      eTag: string;
    }
  >;

  /**
   * Gets the entity state (Etag) version of the DelegationSettings.
   */
  #deprecated "deprecated"
  getEntityTag is PortalDelegationSettingsOps.CheckExistence<
    PortalDelegationSettings,
    Response = OkResponse & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      eTag: string;
    }
  >;

  /**
   * Create or Update Delegation settings.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #deprecated "deprecated"
  createOrUpdate is PortalDelegationSettingsOps.CreateOrUpdateSync<
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
  update is PortalDelegationSettingsOps.CustomPatchSync<
    PortalDelegationSettings,
    PatchModel = PortalDelegationSettings,
    Parameters = IfMatchHeaderParameter,
    Response = ArmNoContentResponse
  >;

  /**
   * Gets the secret validation key of the DelegationSettings.
   */
  #deprecated "deprecated"
  listSecrets is PortalDelegationSettingsOps.ActionSync<
    PortalDelegationSettings,
    void,
    ArmResponse<PortalSettingValidationKeyContract>
  >;
}

@@doc(PortalDelegationSettings.name, "");
@@doc(
  PortalDelegationSettings.properties,
  "Delegation settings contract properties."
);
@@doc(
  DelegationSettings.createOrUpdate::parameters.resource,
  "Create or update parameters."
);
@@doc(
  DelegationSettings.update::parameters.properties,
  "Update Delegation settings."
);
