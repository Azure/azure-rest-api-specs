import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ServiceResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.AppPlatform;
@doc("Application Configuration Service resource")
@parentResource(ServiceResource)
model ConfigurationServiceResource
  is ProxyResource<ConfigurationServiceProperties> {
  @doc("The name of Application Configuration Service.")
  @key("configurationServiceName")
  @segment("configurationServices")
  name: string;
}

@armResourceOperations
@projectedName("client", "ConfigurationServices")
interface ConfigurationServiceResources_ConfigurationServices {
  @doc("Get the Application Configuration Service and its properties.")
  get is ArmResourceRead<ConfigurationServiceResource>;

  @doc("Create the default Application Configuration Service or update the existing Application Configuration Service.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ConfigurationServiceResource>;

  @doc("Disable the default Application Configuration Service.")
  delete is ArmResourceDeleteAsync<ConfigurationServiceResource>;

  @doc("Handles requests to list all resources in a Service.")
  list is ArmResourceListByParent<ConfigurationServiceResource>;

  @doc("Check if the Application Configuration Service settings are valid.")
  validate is ArmResourceActionAsync<
    ConfigurationServiceResource,
    ConfigurationServiceSettings,
    ConfigurationServiceSettingsValidateResult
  >;
}
