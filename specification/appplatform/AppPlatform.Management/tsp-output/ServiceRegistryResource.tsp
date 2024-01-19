import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ServiceResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AppPlatform;
@doc("Service Registry resource")
@parentResource(ServiceResource)
model ServiceRegistryResource is ProxyResource<ServiceRegistryProperties> {
  @doc("The name of Service Registry.")
  @path
  @key("serviceRegistryName")
  @segment("serviceRegistries")
  name: string;
}

@armResourceOperations
interface ServiceRegistryResources {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get the Service Registry and its properties.")
  @operationId("ServiceRegistries_Get")
  get is ArmResourceRead<ServiceRegistryResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create the default Service Registry or update the existing Service Registry.")
  @operationId("ServiceRegistries_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ServiceRegistryResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Disable the default Service Registry.")
  @operationId("ServiceRegistries_Delete")
  delete is ArmResourceDeleteAsync<ServiceRegistryResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Handles requests to list all resources in a Service.")
  @operationId("ServiceRegistries_List")
  list is ArmResourceListByParent<ServiceRegistryResource>;
}
