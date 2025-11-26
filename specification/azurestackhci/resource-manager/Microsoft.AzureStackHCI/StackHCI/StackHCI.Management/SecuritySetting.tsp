import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Cluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AzureStackHCI;
/**
 * Security settings proxy resource
 */
@parentResource(Cluster)
model SecuritySetting
  is Azure.ResourceManager.ProxyResource<SecurityProperties> {
  ...ResourceNameParameter<
    Resource = SecuritySetting,
    KeyName = "securitySettingsName",
    SegmentName = "securitySettings"
  >;
}

@armResourceOperations
interface SecuritySettings {
  /**
   * Get a SecuritySetting
   */
  get is ArmResourceRead<SecuritySetting>;

  /**
   * Create a security setting
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<SecuritySetting>;

  /**
   * Delete a SecuritySetting
   */
  delete is ArmResourceDeleteWithoutOkAsync<SecuritySetting>;

  /**
   * List SecuritySetting resources by Clusters
   */
  listByClusters is ArmResourceListByParent<SecuritySetting>;
}

@@doc(SecuritySetting.name, "Name of security setting");
@@doc(SecuritySetting.properties,
  "The resource-specific properties for this resource."
);
