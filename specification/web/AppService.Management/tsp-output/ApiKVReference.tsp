import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Site.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CertificateRegistration;
/**
 * Description of site key vault references.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Site)
@Azure.ResourceManager.Private.armResourceInternal(ApiKVReferenceProperties)
@includeInapplicableMetadataInPayload(false)
model ApiKVReference extends ProxyOnlyResource {
  /**
   * App Setting key name.
   */
  @path
  @key("appSettingKey")
  @segment("appsettings")
  name: string;

  /**
   * ApiKVReference resource specific properties
   */
  @extension("x-ms-client-flatten", true)
  properties?: ApiKVReferenceProperties;
}

@armResourceOperations
interface ApiKVReferences {
  /**
   * Description for Gets the config reference and status of an app
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_GetAppSettingKeyVaultReference")
  getAppSettingKeyVaultReference is ArmResourceRead<ApiKVReference>;

  /**
   * Description for Gets the config reference app settings and status of an app
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_GetAppSettingsKeyVaultReferences")
  getAppSettingsKeyVaultReferences is ArmResourceListByParent<ApiKVReference>;
}
