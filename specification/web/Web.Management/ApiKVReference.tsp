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
 * Description of site key vault references.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" ""
@parentResource(Site)
model ApiKVReference
  is Azure.ResourceManager.ProxyResource<ApiKVReferenceProperties> {
  ...ResourceNameParameter<
    Resource = ApiKVReference,
    KeyName = "appSettingKey",
    SegmentName = "appsettings",
    NamePattern = ""
  >;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" ""
@armResourceOperations
interface ApiKVReferenceOps
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

        /** undefined */
        @path
        @segment("config")
        @key
        configreferences: "configreferences",
      },
      {
        /** App Setting key name. */
        @path
        @segment("appsettings")
        @key
        appSettingKey: string,
      }
    > {}

@armResourceOperations
interface AppSettingKeyVaultReference {
  /**
   * Description for Gets the config reference and status of an app
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_GetAppSettingKeyVaultReference")
  getAppSettingKeyVaultReference is ApiKVReferenceOps.Read<ApiKVReference, OverrideErrorType = DefaultErrorResponse>;

  /**
   * Description for Gets the config reference app settings and status of an app
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_GetAppSettingsKeyVaultReferences")
  getAppSettingsKeyVaultReferences is ApiKVReferenceOps.List<
    ApiKVReference,
    Response = ArmResponse<ApiKVReferenceCollection>,
    OverrideErrorType = DefaultErrorResponse
  >;
}
#suppress "@azure-tools/typespec-azure-core/casing-style" ""
@armResourceOperations
interface ApiKVReferenceOperationGroupOps
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

        /** undefined */
        @path
        @segment("config")
        @key
        configreferences: "configreferences",
      },
      {
        /**  */
        #suppress "@azure-tools/typespec-azure-core/documentation-required" ""
        @path
        @segment("connectionstrings")
        @key
        connectionStringKey: string,
      }
    > {}

@armResourceOperations
interface SiteConnectionStringKeyVaultReference {
  /**
   * Description for Gets the config reference and status of an app
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_GetSiteConnectionStringKeyVaultReference")
  getSiteConnectionStringKeyVaultReference is ApiKVReferenceOperationGroupOps.Read<ApiKVReference, OverrideErrorType = DefaultErrorResponse>;

  /**
   * Description for Gets the config reference app settings and status of an app
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_GetSiteConnectionStringKeyVaultReferences")
  @segment("connectionstrings")
  getSiteConnectionStringKeyVaultReferences is ApiKVReferenceOperationGroupOps.List<
    ApiKVReference,
    Response = ArmResponse<ApiKVReferenceCollection>,
    OverrideErrorType = DefaultErrorResponse
  >;
}
@armResourceOperations
interface AppSettingKeyVaultReferenceSlotOps
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

        #suppress "@azure-tools/typespec-azure-core/documentation-required" ""
        @path
        @segment("slots")
        @key
        slot: string,

        /** undefined */
        @path
        @segment("config")
        @key
        configreferences: "configreferences",
      },
      {
        /** App Setting key name. */
        @path
        @segment("appsettings")
        @key
        appSettingKey: string,
      }
    > {}

@armResourceOperations
interface AppSettingKeyVaultReferenceSlot {
  /**
   * Description for Gets the config reference and status of an app
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_GetAppSettingKeyVaultReferenceSlot")
  getAppSettingKeyVaultReferenceSlot is AppSettingKeyVaultReferenceSlotOps.Read<ApiKVReference, OverrideErrorType = DefaultErrorResponse>;

  /**
   * Description for Gets the config reference app settings and status of an app
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_GetAppSettingsKeyVaultReferencesSlot")
  getAppSettingsKeyVaultReferencesSlot is AppSettingKeyVaultReferenceSlotOps.List<
    ApiKVReference,
    Response = ArmResponse<ApiKVReferenceCollection>,
    OverrideErrorType = DefaultErrorResponse
  >;
}
@armResourceOperations
interface SiteConnectionStringKeyVaultReferenceSlotOps
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

        #suppress "@azure-tools/typespec-azure-core/documentation-required" ""
        @path
        @segment("slots")
        @key
        slot: string,

        #suppress "@azure-tools/typespec-azure-core/documentation-required" ""
        @path
        @segment("config")
        @key
        configreferences: "configreferences",
      },
      {
        /**  */
        #suppress "@azure-tools/typespec-azure-core/documentation-required" ""
        @path
        @segment("connectionstrings")
        @key
        connectionStringKey: string,
      }
    > {}

@armResourceOperations
interface SiteConnectionStringKeyVaultReferenceSlot {
  /**
   * Description for Gets the config reference and status of an app
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_GetSiteConnectionStringKeyVaultReferenceSlot")
  getSiteConnectionStringKeyVaultReferenceSlot is SiteConnectionStringKeyVaultReferenceSlotOps.Read<ApiKVReference>;

  /**
   * Description for Gets the config reference app settings and status of an app
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_GetSiteConnectionStringKeyVaultReferencesSlot")
  @segment("connectionstrings")
  getSiteConnectionStringKeyVaultReferencesSlot is SiteConnectionStringKeyVaultReferenceSlotOps.List<
    ApiKVReference,
    Response = ArmResponse<ApiKVReferenceCollection>,
    OverrideErrorType = DefaultErrorResponse
  >;
}

@@doc(ApiKVReference.name, "App Setting key name.");
@@doc(ApiKVReference.properties, "ApiKVReference resource specific properties");
