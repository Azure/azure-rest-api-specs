import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ApplicationResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.ServiceFabric;
@doc("The service resource.")
@parentResource(ApplicationResource)
model ServiceResource is TrackedResource<ServiceResourceProperties> {
  @doc("The name of the service resource in the format of {applicationName}~{serviceName}.")
  @path
  @key("serviceName")
  @segment("services")
  name: string;
}

@armResourceOperations
interface Services {
  @doc("Get a Service Fabric service resource created or in the process of being created in the Service Fabric application resource.")
  get is ArmResourceRead<ServiceResource>;
  @doc("Create or update a Service Fabric service resource with the specified name.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ServiceResource>;
  @doc("Update a Service Fabric service resource with the specified name.")
  update is ArmResourcePatchAsync<ServiceResource, ServiceResourceProperties>;
  @doc("Delete a Service Fabric service resource with the specified name.")
  delete is ArmResourceDeleteWithoutOkAsync<ServiceResource>;
  @doc("Gets all service resources created or in the process of being created in the Service Fabric application resource.")
  list is ArmResourceListByParent<ServiceResource>;
}
