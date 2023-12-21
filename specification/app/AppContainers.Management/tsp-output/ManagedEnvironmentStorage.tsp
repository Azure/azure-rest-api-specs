import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.AppContainers;
@doc("Storage resource for managedEnvironment.")
model ManagedEnvironmentStorage
  is ProxyResource<ManagedEnvironmentStorageProperties> {
  @doc("Name of the storage.")
  @path
  @key("storageName")
  @segment("storages")
  name: string;
}

@armResourceOperations
interface ManagedEnvironmentsStorages {
  @doc("Get storage for a managedEnvironment.")
  get is ArmResourceRead<ManagedEnvironmentStorage>;
  @doc("Create or update storage for a managedEnvironment.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<ManagedEnvironmentStorage>;
  @doc("Delete storage for a managedEnvironment.")
  delete is ArmResourceDeleteSync<ManagedEnvironmentStorage>;
  @doc("Get all storages for a managedEnvironment.")
  list is ArmResourceListByParent<ManagedEnvironmentStorage>;
}
