import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./StorageAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataBoxEdge;
@doc("Represents a container on the  Data Box Edge/Gateway device.")
@parentResource(StorageAccount)
model Container is ProxyResource<ContainerProperties> {
  @doc("The container Name")
  @path
  @key("containerName")
  @segment("containers")
  name: string;
}

@armResourceOperations
interface Containers {
  @doc("Gets a container by name.")
  get is ArmResourceRead<Container>;

  @doc("Creates a new container or updates an existing container on the device.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<Container>;

  @doc("Deletes the container on the Data Box Edge/Data Box Gateway device.")
  delete is ArmResourceDeleteWithoutOkAsync<Container>;

  @doc("Lists all the containers of a storage Account in a Data Box Edge/Data Box Gateway device.")
  listByStorageAccount is ArmResourceListByParent<Container>;

  @doc("Refreshes the container metadata with the data from the cloud.")
  refresh is ArmResourceActionAsync<Container, void, void>;
}

@@projectedName(Containers.createOrUpdate::parameters.resource,
  "json",
  "container"
);
@@extension(Containers.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "container"
);
@@doc(Containers.createOrUpdate::parameters.resource,
  "The container properties."
);
