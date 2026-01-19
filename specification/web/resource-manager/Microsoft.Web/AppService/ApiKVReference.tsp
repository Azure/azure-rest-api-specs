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
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@parentResource(Site)
model ApiKVReference
  is Azure.ResourceManager.ProxyResource<ApiKVReferenceProperties> {
  ...ResourceNameParameter<
    Resource = ApiKVReference,
    KeyName = "appSettingKey",
    SegmentName = "appsettings",
    NamePattern = ""
  >;

  /**
   * Kind of resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  kind?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  @summary("Gets the config reference and status of an app")
  getAppSettingKeyVaultReference is ApiKVReferenceOps.Read<
    ApiKVReference,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Gets the config reference app settings and status of an app
   */
  @summary("Gets the config reference app settings and status of an app")
  getAppSettingsKeyVaultReferences is ApiKVReferenceOps.List<
    ApiKVReference,
    Response = ArmResponse<ApiKVReferenceCollection>,
    OverrideErrorType = DefaultErrorResponse
  >;
}
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
        #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  @summary("Gets the config reference and status of an app")
  getSiteConnectionStringKeyVaultReference is ApiKVReferenceOperationGroupOps.Read<
    ApiKVReference,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Gets the config reference app settings and status of an app
   */
  @summary("Gets the config reference app settings and status of an app")
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

        #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  @summary("Gets the config reference and status of an app")
  getAppSettingKeyVaultReferenceSlot is AppSettingKeyVaultReferenceSlotOps.Read<
    ApiKVReference,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Gets the config reference app settings and status of an app
   */
  @summary("Gets the config reference app settings and status of an app")
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

        #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
        @path
        @segment("slots")
        @key
        slot: string,

        #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
        @path
        @segment("config")
        @key
        configreferences: "configreferences",
      },
      {
        /**  */
        #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  @summary("Gets the config reference and status of an app")
  getSiteConnectionStringKeyVaultReferenceSlot is SiteConnectionStringKeyVaultReferenceSlotOps.Read<
    ApiKVReference,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Gets the config reference app settings and status of an app
   */
  @summary("Gets the config reference app settings and status of an app")
  @segment("connectionstrings")
  getSiteConnectionStringKeyVaultReferencesSlot is SiteConnectionStringKeyVaultReferenceSlotOps.List<
    ApiKVReference,
    Response = ArmResponse<ApiKVReferenceCollection>,
    OverrideErrorType = DefaultErrorResponse
  >;
}

@@doc(ApiKVReference.name, "App Setting key name.");
@@doc(ApiKVReference.properties, "ApiKVReference resource specific properties");
