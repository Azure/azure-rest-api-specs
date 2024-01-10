import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ConnectedEnvironment.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.App;
@doc("Storage resource for connectedEnvironment.")
@parentResource(ConnectedEnvironment)
model ConnectedEnvironmentStorage
  is ProxyResource<ConnectedEnvironmentStorageProperties> {
  @doc("Name of the storage.")
  @key("storageName")
  @segment("storages")
  name: string;
}

@armResourceOperations
@projectedName("client", "ConnectedEnvironmentsStorages")
interface ConnectedEnvironmentStorages_ConnectedEnvironmentsStorages {
  @doc("Get storage for a connectedEnvironment.")
  get is ArmResourceRead<ConnectedEnvironmentStorage>;

  @doc("Create or update storage for a connectedEnvironment.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<ConnectedEnvironmentStorage>;

  @doc("Delete storage for a connectedEnvironment.")
  delete is ArmResourceDeleteSync<ConnectedEnvironmentStorage>;

  @doc("Get all storages for a connectedEnvironment.")
  list is ArmResourceListByParent<ConnectedEnvironmentStorage>;
}
