import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./DataBoxEdgeStorageAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.DataBoxEdge;
@doc("Represents a container on the  Data Box Edge/Gateway device.")
@parentResource(DataBoxEdgeStorageAccount)
model DataBoxEdgeStorageContainer is ProxyResource<ContainerProperties> {
  @doc("The container Name")
  @path
  @key("containerName")
  @segment("containers")
  name: string;
}

@armResourceOperations
interface DataBoxEdgeStorageContainers {
  @doc("Gets a container by name.")
  get is ArmResourceRead<DataBoxEdgeStorageContainer>;
  @doc("Creates a new container or updates an existing container on the device.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<DataBoxEdgeStorageContainer>;
  @doc("Deletes the container on the Data Box Edge/Data Box Gateway device.")
  delete is ArmResourceDeleteWithoutOkAsync<DataBoxEdgeStorageContainer>;
  @doc("Lists all the containers of a storage Account in a Data Box Edge/Data Box Gateway device.")
  listByStorageAccount is ArmResourceListByParent<DataBoxEdgeStorageContainer>;
  @doc("Refreshes the container metadata with the data from the cloud.")
  refresh is ArmResourceActionAsync<DataBoxEdgeStorageContainer, {}, {}>;
}
