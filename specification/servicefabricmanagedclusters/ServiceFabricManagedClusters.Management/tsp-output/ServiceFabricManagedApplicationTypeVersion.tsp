import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ServiceFabricManagedApplicationType.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.ServiceFabricManagedClusters;
@doc("An application type version resource for the specified application type name resource.")
@parentResource(ServiceFabricManagedApplicationType)
model ServiceFabricManagedApplicationTypeVersion
  is TrackedResource<ApplicationTypeVersionResourceProperties> {
  @doc("The application type version.")
  @path
  @key("version")
  @segment("versions")
  name: string;
}

@armResourceOperations
interface ServiceFabricManagedApplicationTypeVersions {
  @doc("Get a Service Fabric managed application type version resource created or in the process of being created in the Service Fabric managed application type name resource.")
  get is ArmResourceRead<ServiceFabricManagedApplicationTypeVersion>;
  @doc("Create or update a Service Fabric managed application type version resource with the specified name.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ServiceFabricManagedApplicationTypeVersion>;
  @doc("Updates the tags of an application type version resource of a given managed cluster.")
  update is ArmTagsPatchSync<ServiceFabricManagedApplicationTypeVersion>;
  @doc("Delete a Service Fabric managed application type version resource with the specified name.")
  delete is ArmResourceDeleteAsync<ServiceFabricManagedApplicationTypeVersion>;
  @doc("Gets all application type version resources created or in the process of being created in the Service Fabric managed application type name resource.")
  listByApplicationTypes is ArmResourceListByParent<ServiceFabricManagedApplicationTypeVersion>;
}
