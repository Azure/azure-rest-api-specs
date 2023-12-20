import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ContainerAppConnectedEnvironment.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.AppContainers;
@doc("Storage resource for connectedEnvironment.")
@parentResource(ContainerAppConnectedEnvironment)
model ContainerAppConnectedEnvironmentStorage
  is ProxyResource<ConnectedEnvironmentStorageProperties> {
  @doc("Name of the storage.")
  @path
  @key("storageName")
  @segment("storages")
  name: string;
}

@armResourceOperations
interface ContainerAppConnectedEnvironmentStorages {
  @doc("Get storage for a connectedEnvironment.")
  get is ArmResourceRead<ContainerAppConnectedEnvironmentStorage>;
  @doc("Create or update storage for a connectedEnvironment.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<ContainerAppConnectedEnvironmentStorage>;
  @doc("Delete storage for a connectedEnvironment.")
  delete is ArmResourceDeleteSync<ContainerAppConnectedEnvironmentStorage>;
  @doc("Get all storages for a connectedEnvironment.")
  list is ArmResourceListByParent<ContainerAppConnectedEnvironmentStorage>;
}
