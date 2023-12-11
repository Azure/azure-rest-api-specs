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
@doc("The application type name resource")
@parentResource(ServiceFabricCluster)
model ServiceFabricApplicationType
  is TrackedResource<ApplicationTypeResourceProperties> {
  @doc("The name of the application type name resource.")
  @path
  @key("applicationTypeName")
  @segment("applicationTypes")
  name: string;
}

@armResourceOperations
interface ServiceFabricApplicationTypes {
  @doc("Get a Service Fabric application type name resource created or in the process of being created in the Service Fabric cluster resource.")
  get is ArmResourceRead<ServiceFabricApplicationType>;
  @doc("Create or update a Service Fabric application type name resource with the specified name.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<ServiceFabricApplicationType>;
  @doc("Delete a Service Fabric application type name resource with the specified name.")
  delete is ArmResourceDeleteWithoutOkAsync<ServiceFabricApplicationType>;
  @doc("Gets all application type name resources created or in the process of being created in the Service Fabric cluster resource.")
  list is ArmResourceListByParent<ServiceFabricApplicationType>;
}
