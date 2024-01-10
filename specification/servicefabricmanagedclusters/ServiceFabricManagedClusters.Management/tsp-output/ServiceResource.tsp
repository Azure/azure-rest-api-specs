import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ApplicationResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.ServiceFabric;
@doc("The service resource.")
@parentResource(ApplicationResource)
model ServiceResource is TrackedResource<ServiceResourceProperties> {
  @doc("The name of the service resource in the format of {applicationName}~{serviceName}.")
  @key("serviceName")
  @segment("services")
  name: string;
}

@armResourceOperations
@projectedName("client", "Services")
interface ServiceResources_Services {
  @doc("Get a Service Fabric service resource created or in the process of being created in the Service Fabric managed application resource.")
  get is ArmResourceRead<ServiceResource>;

  @doc("Create or update a Service Fabric managed service resource with the specified name.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ServiceResource>;

  @doc("Updates the tags of a service resource of a given managed cluster.")
  update is ArmCustomPatchSync<ServiceResource, ServiceUpdateParameters>;

  @doc("Delete a Service Fabric managed service resource with the specified name.")
  delete is ArmResourceDeleteAsync<ServiceResource>;

  @doc("Gets all service resources created or in the process of being created in the Service Fabric managed application resource.")
  listByApplications is ArmResourceListByParent<ServiceResource>;
}
