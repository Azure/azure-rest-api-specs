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
 * Tenant Settings.
 */
@parentResource(ApiManagementServiceResource)
model TenantSettingsContract
  is Azure.ResourceManager.ProxyResource<TenantSettingsContractProperties> {
  ...ResourceNameParameter<
    Resource = TenantSettingsContract,
    KeyName = "settingsType",
    SegmentName = "settings",
    NamePattern = "",
    Type = SettingsTypeName
  >;
}

@armResourceOperations
interface TenantSettingsContracts {
  /**
   * Get tenant settings.
   */
  #deprecated "deprecated"
  get is ArmResourceRead<
    TenantSettingsContract,
    Response = ArmResponse<TenantSettingsContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Public settings.
   */
  #deprecated "deprecated"
  listByService is ArmResourceListByParent<
    TenantSettingsContract,
    Parameters = {
      /**
       * Not used
       */
      @query("$filter")
      $filter?: string;
    },
    Response = ArmResponse<TenantSettingsCollection>
  >;
}

@@doc(TenantSettingsContract.name, "The identifier of the settings.");
@@doc(TenantSettingsContract.properties,
  "TenantSettings entity contract properties."
);
