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
@doc("Service Registry resource")
@parentResource(AppPlatformService)
model AppPlatformServiceRegistry is ProxyResource<ServiceRegistryProperties> {
  @doc("The name of Service Registry.")
  @path
  @key("serviceRegistryName")
  @segment("serviceRegistries")
  name: string;
}

@armResourceOperations
interface AppPlatformServiceRegistries {
  @doc("Get the Service Registry and its properties.")
  get is ArmResourceRead<AppPlatformServiceRegistry>;
  @doc("Create the default Service Registry or update the existing Service Registry.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<AppPlatformServiceRegistry>;
  @doc("Disable the default Service Registry.")
  delete is ArmResourceDeleteAsync<AppPlatformServiceRegistry>;
  @doc("Handles requests to list all resources in a Service.")
  list is ArmResourceListByParent<AppPlatformServiceRegistry>;
}
