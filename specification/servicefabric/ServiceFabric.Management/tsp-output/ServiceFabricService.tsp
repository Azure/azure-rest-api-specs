import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ServiceFabricApplication.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.ServiceFabric;
@doc("The service resource.")
@parentResource(ServiceFabricApplication)
model ServiceFabricService is TrackedResource<ServiceResourceProperties> {
  @doc("The name of the service resource in the format of {applicationName}~{serviceName}.")
  @path
  @key("serviceName")
  @segment("services")
  name: string;
}

@armResourceOperations
interface ServiceFabricServices {
  @doc("Get a Service Fabric service resource created or in the process of being created in the Service Fabric application resource.")
  get is ArmResourceRead<ServiceFabricService>;
  @doc("Create or update a Service Fabric service resource with the specified name.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ServiceFabricService>;
  @doc("Update a Service Fabric service resource with the specified name.")
  update is ArmResourcePatchAsync<
    ServiceFabricService,
    ServiceResourceProperties
  >;
  @doc("Delete a Service Fabric service resource with the specified name.")
  delete is ArmResourceDeleteWithoutOkAsync<ServiceFabricService>;
  @doc("Gets all service resources created or in the process of being created in the Service Fabric application resource.")
  list is ArmResourceListByParent<ServiceFabricService>;
}
