import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ServiceFabricManagedApplication.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.ServiceFabricManagedClusters;
@doc("The service resource.")
@parentResource(ServiceFabricManagedApplication)
model ServiceFabricManagedService
  is TrackedResource<ServiceResourceProperties> {
  @doc("The name of the service resource in the format of {applicationName}~{serviceName}.")
  @path
  @key("serviceName")
  @segment("services")
  name: string;
}

@armResourceOperations
interface ServiceFabricManagedServices {
  @doc("Get a Service Fabric service resource created or in the process of being created in the Service Fabric managed application resource.")
  get is ArmResourceRead<ServiceFabricManagedService>;
  @doc("Create or update a Service Fabric managed service resource with the specified name.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ServiceFabricManagedService>;
  @doc("Updates the tags of a service resource of a given managed cluster.")
  update is ArmTagsPatchSync<ServiceFabricManagedService>;
  @doc("Delete a Service Fabric managed service resource with the specified name.")
  delete is ArmResourceDeleteAsync<ServiceFabricManagedService>;
  @doc("Gets all service resources created or in the process of being created in the Service Fabric managed application resource.")
  listByApplications is ArmResourceListByParent<ServiceFabricManagedService>;
}
