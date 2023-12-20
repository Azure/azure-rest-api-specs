import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ServiceFabricCluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.ServiceFabric;
@doc("The application resource.")
@parentResource(ServiceFabricCluster)
model ServiceFabricApplication
  is TrackedResource<ApplicationResourceProperties> {
  @doc("The name of the application resource.")
  @path
  @key("applicationName")
  @segment("applications")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface ServiceFabricApplications {
  @doc("Get a Service Fabric application resource created or in the process of being created in the Service Fabric cluster resource.")
  get is ArmResourceRead<ServiceFabricApplication>;
  @doc("Create or update a Service Fabric application resource with the specified name.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ServiceFabricApplication>;
  @doc("Update a Service Fabric application resource with the specified name.")
  update is ArmResourcePatchAsync<
    ServiceFabricApplication,
    ApplicationResourceProperties
  >;
  @doc("Delete a Service Fabric application resource with the specified name.")
  delete is ArmResourceDeleteWithoutOkAsync<ServiceFabricApplication>;
  @doc("Gets all application resources created or in the process of being created in the Service Fabric cluster resource.")
  list is ArmResourceListByParent<ServiceFabricApplication>;
}
