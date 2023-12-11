import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./WebSite.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.AppService;
@doc("Description of site key vault references.")
@parentResource(WebSite)
model SiteConfigAppsetting is ProxyResource<ApiKVReferenceProperties> {
  @doc("App Setting key name.")
  @path
  @key("appSettingKey")
  @segment("appsettings")
  name: string;
}

@armResourceOperations
interface SiteConfigAppsettings {
  @doc("Description for Gets the config reference and status of an app")
  getAppSettingKeyVaultReference is ArmResourceRead<SiteConfigAppsetting>;
  @doc("Description for Gets the config reference app settings and status of an app")
  getAppSettingsKeyVaultReferences is ArmResourceListByParent<SiteConfigAppsetting>;
}
