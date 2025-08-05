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
        configreferences: string,
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
interface ApiKVReferences {
  /**
   * Description for Gets the config reference and status of an app
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_GetAppSettingKeyVaultReference")
  getAppSettingKeyVaultReference is ApiKVReferenceOps.Read<ApiKVReference>;

  /**
   * Description for Gets the config reference app settings and status of an app
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_GetAppSettingsKeyVaultReferences")
  getAppSettingsKeyVaultReferences is ApiKVReferenceOps.List<
    ApiKVReference,
    Response = ArmResponse<ApiKVReferenceCollection>
  >;
}
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
        configreferences: string,
      },
      {
        /**  */
        @path
        @segment("connectionstrings")
        @key
        connectionStringKey: string,
      }
    > {}

@armResourceOperations
interface ApiKVReferenceOperationGroup {
  /**
   * Description for Gets the config reference and status of an app
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_GetSiteConnectionStringKeyVaultReference")
  getSiteConnectionStringKeyVaultReference is ApiKVReferenceOperationGroupOps.Read<ApiKVReference>;

  /**
   * Description for Gets the config reference app settings and status of an app
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_GetSiteConnectionStringKeyVaultReferences")
  getSiteConnectionStringKeyVaultReferences is ApiKVReferenceOperationGroupOps.List<
    ApiKVReference,
    Response = ArmResponse<ApiKVReferenceCollection>
  >;
}
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

        /**  */
        @path
        @segment("slots")
        @key
        slot: string,

        /** undefined */
        @path
        @segment("config")
        @key
        configreferences: string,
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
interface ApiKVReferenceOperationGroup {
  /**
   * Description for Gets the config reference and status of an app
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_GetAppSettingKeyVaultReferenceSlot")
  getAppSettingKeyVaultReferenceSlot is ApiKVReferenceOperationGroupOps.Read<ApiKVReference>;

  /**
   * Description for Gets the config reference app settings and status of an app
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_GetAppSettingsKeyVaultReferencesSlot")
  getAppSettingsKeyVaultReferencesSlot is ApiKVReferenceOperationGroupOps.List<
    ApiKVReference,
    Response = ArmResponse<ApiKVReferenceCollection>
  >;
}
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

        /**  */
        @path
        @segment("slots")
        @key
        slot: string,

        /** undefined */
        @path
        @segment("config")
        @key
        configreferences: string,
      },
      {
        /**  */
        @path
        @segment("connectionstrings")
        @key
        connectionStringKey: string,
      }
    > {}

@armResourceOperations
interface ApiKVReferenceOperationGroup {
  /**
   * Description for Gets the config reference and status of an app
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_GetSiteConnectionStringKeyVaultReferenceSlot")
  getSiteConnectionStringKeyVaultReferenceSlot is ApiKVReferenceOperationGroupOps.Read<ApiKVReference>;

  /**
   * Description for Gets the config reference app settings and status of an app
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_GetSiteConnectionStringKeyVaultReferencesSlot")
  getSiteConnectionStringKeyVaultReferencesSlot is ApiKVReferenceOperationGroupOps.List<
    ApiKVReference,
    Response = ArmResponse<ApiKVReferenceCollection>
  >;
}

@@doc(ApiKVReference.name, "App Setting key name.");
@@doc(ApiKVReference.properties, "ApiKVReference resource specific properties");
