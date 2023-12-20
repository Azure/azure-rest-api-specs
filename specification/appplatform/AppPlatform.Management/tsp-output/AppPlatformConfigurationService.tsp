import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./AppPlatformService.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.AppPlatform;
@doc("Application Configuration Service resource")
@parentResource(AppPlatformService)
model AppPlatformConfigurationService
  is ProxyResource<ConfigurationServiceProperties> {
  @doc("The name of Application Configuration Service.")
  @path
  @key("configurationServiceName")
  @segment("configurationServices")
  name: string;
}

@armResourceOperations
interface AppPlatformConfigurationServices {
  @doc("Get the Application Configuration Service and its properties.")
  get is ArmResourceRead<AppPlatformConfigurationService>;
  @doc("Create the default Application Configuration Service or update the existing Application Configuration Service.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<AppPlatformConfigurationService>;
  @doc("Disable the default Application Configuration Service.")
  delete is ArmResourceDeleteAsync<AppPlatformConfigurationService>;
  @doc("Handles requests to list all resources in a Service.")
  list is ArmResourceListByParent<AppPlatformConfigurationService>;
  @doc("Check if the Application Configuration Service settings are valid.")
  validate is ArmResourceActionAsync<
    AppPlatformConfigurationService,
    ConfigurationServiceSettings,
    ConfigurationServiceSettingsValidateResult
  >;
}
