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
@doc("The application resource.")
@parentResource(ManagedCluster)
model ApplicationResource is TrackedResource<ApplicationResourceProperties> {
  @doc("The name of the application resource.")
  @path
  @key("applicationName")
  @segment("applications")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface Applications {
  @doc("Get a Service Fabric managed application resource created or in the process of being created in the Service Fabric cluster resource.")
  get is ArmResourceRead<ApplicationResource>;
  @doc("Create or update a Service Fabric managed application resource with the specified name.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ApplicationResource>;
  @doc("Updates the tags of an application resource of a given managed cluster.")
  update is ArmTagsPatchSync<ApplicationResource>;
  @doc("Delete a Service Fabric managed application resource with the specified name.")
  delete is ArmResourceDeleteAsync<ApplicationResource>;
  @doc("Gets all managed application resources created or in the process of being created in the Service Fabric cluster resource.")
  list is ArmResourceListByParent<ApplicationResource>;
}
