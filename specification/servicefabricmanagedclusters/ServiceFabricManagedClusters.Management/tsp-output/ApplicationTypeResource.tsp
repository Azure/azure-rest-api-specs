import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedCluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.ServiceFabricManagedClusters;
@doc("The application type name resource")
@parentResource(ManagedCluster)
model ApplicationTypeResource
  is TrackedResource<ApplicationTypeResourceProperties> {
  @doc("The name of the application type name resource.")
  @key("applicationTypeName")
  @segment("applicationTypes")
  name: string;
}

@armResourceOperations
interface ApplicationTypes {
  @doc("Get a Service Fabric application type name resource created or in the process of being created in the Service Fabric managed cluster resource.")
  get is ArmResourceRead<ApplicationTypeResource>;
  @doc("Create or update a Service Fabric managed application type name resource with the specified name.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<ApplicationTypeResource>;
  @doc("Updates the tags of an application type resource of a given managed cluster.")
  update is ArmCustomPatchSync<
    ApplicationTypeResource,
    ApplicationTypeUpdateParameters
  >;
  @doc("Delete a Service Fabric managed application type name resource with the specified name.")
  delete is ArmResourceDeleteAsync<ApplicationTypeResource>;
  @doc("Gets all application type name resources created or in the process of being created in the Service Fabric managed cluster resource.")
  list is ArmResourceListByParent<ApplicationTypeResource>;
}
