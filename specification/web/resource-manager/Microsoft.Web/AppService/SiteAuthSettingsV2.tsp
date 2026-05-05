import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Site.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Web;
/**
 * Configuration settings for the Azure App Service Authentication / Authorization V2 feature.
 */
@singleton("authsettingsV2")
@parentResource(Site)
model SiteAuthSettingsV2
  is Azure.ResourceManager.ProxyResource<SiteAuthSettingsV2Properties> {
  ...ResourceNameParameter<
    Resource = SiteAuthSettingsV2,
    KeyName = "config",
    SegmentName = "config",
    NamePattern = ""
  >;

  /** Kind of resource. If the resource is an app, you can refer to https://github.com/Azure/app-service-linux-docs/blob/master/Things_You_Should_Know/kind_property.md#app-service-resource-kind-reference for details supported values for kind. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  kind?: string;
}

@armResourceOperations
interface SiteAuthSettingsV2Ops
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** Name of the app. */
        @path
        @segment("sites")
        @key
        name: string,
      },
      {
        /** undefined */
        @path
        @segment("config")
        @key
        authsettingsV2: "authsettingsV2",
      }
    > {}

@armResourceOperations
interface SiteAuthSettingsV2s {
  /**
   * Description for Gets site's Authentication / Authorization settings for apps via the V2 format
   */
  @summary("Gets site's Authentication / Authorization settings for apps via the V2 format")
  getAuthSettingsV2WithoutSecrets is SiteAuthSettingsV2Ops.Read<
    SiteAuthSettingsV2,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Updates site's Authentication / Authorization settings for apps via the V2 format
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Updates site's Authentication / Authorization settings for apps via the V2 format")
  updateAuthSettingsV2 is SiteAuthSettingsV2Ops.CreateOrUpdateSync<
    SiteAuthSettingsV2,
    Response = ArmResourceUpdatedResponse<SiteAuthSettingsV2>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Gets site's Authentication / Authorization settings for apps via the V2 format
   */
  @summary("Gets site's Authentication / Authorization settings for apps via the V2 format")
  @get
  @action("list")
  getAuthSettingsV2 is SiteAuthSettingsV2Ops.ActionSync<
    SiteAuthSettingsV2,
    void,
    ArmResponse<SiteAuthSettingsV2>,
    OverrideErrorType = DefaultErrorResponse
  >;
}
@armResourceOperations
interface SiteAuthSettingsV2OperationGroupOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** Name of the app. */
        @path
        @segment("sites")
        @key
        name: string,

        /** Name of the deployment slot. If a slot is not specified, the API will get the settings for the production slot. */
        @path
        @segment("slots")
        @key
        slot: string,
      },
      {
        /** undefined */
        @path
        @segment("config")
        @key
        authsettingsV2: "authsettingsV2",
      }
    > {}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface SiteAuthSettingsV2OperationGroup {
  /**
   * Gets site's Authentication / Authorization settings for apps via the V2 format
   */
  @summary("Gets site's Authentication / Authorization settings for apps via the V2 format")
  getAuthSettingsV2WithoutSecretsSlot is SiteAuthSettingsV2OperationGroupOps.Read<
    SiteAuthSettingsV2,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Updates site's Authentication / Authorization settings for apps via the V2 format
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Updates site's Authentication / Authorization settings for apps via the V2 format")
  updateAuthSettingsV2Slot is SiteAuthSettingsV2OperationGroupOps.CreateOrUpdateSync<
    SiteAuthSettingsV2,
    Response = ArmResourceUpdatedResponse<SiteAuthSettingsV2>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Gets site's Authentication / Authorization settings for apps via the V2 format
   */
  @summary("Gets site's Authentication / Authorization settings for apps via the V2 format")
  @get
  @action("list")
  getAuthSettingsV2Slot is SiteAuthSettingsV2OperationGroupOps.ActionSync<
    SiteAuthSettingsV2,
    void,
    ArmResponse<SiteAuthSettingsV2>,
    OverrideErrorType = DefaultErrorResponse
  >;
}

@@doc(SiteAuthSettingsV2.name, "");
@@doc(SiteAuthSettingsV2.properties,
  "SiteAuthSettingsV2 resource specific properties"
);
@@doc(SiteAuthSettingsV2s.updateAuthSettingsV2::parameters.resource,
  "Auth settings associated with web app."
);
@@doc(SiteAuthSettingsV2OperationGroup.updateAuthSettingsV2Slot::parameters.resource,
  "Auth settings associated with web app."
);
