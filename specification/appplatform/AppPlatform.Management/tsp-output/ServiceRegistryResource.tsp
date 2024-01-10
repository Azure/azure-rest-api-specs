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
@doc("Service Registry resource")
@parentResource(ServiceResource)
model ServiceRegistryResource is ProxyResource<ServiceRegistryProperties> {
  @doc("The name of Service Registry.")
  @key("serviceRegistryName")
  @segment("serviceRegistries")
  name: string;
}

@armResourceOperations
@projectedName("client", "ServiceRegistries")
interface ServiceRegistryResources_ServiceRegistries {
  @doc("Get the Service Registry and its properties.")
  get is ArmResourceRead<ServiceRegistryResource>;

  @doc("Create the default Service Registry or update the existing Service Registry.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ServiceRegistryResource>;

  @doc("Disable the default Service Registry.")
  delete is ArmResourceDeleteAsync<ServiceRegistryResource>;

  @doc("Handles requests to list all resources in a Service.")
  list is ArmResourceListByParent<ServiceRegistryResource>;
}
