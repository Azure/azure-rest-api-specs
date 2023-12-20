import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./AvsPrivateCloudCluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Avs;
@doc("A datastore resource")
@parentResource(AvsPrivateCloudCluster)
model AvsPrivateCloudDatastore is ProxyResource<DatastoreProperties> {
  @doc("Name of the datastore in the private cloud cluster")
  @path
  @key("datastoreName")
  @segment("datastores")
  name: string;
}

@armResourceOperations
interface AvsPrivateCloudDatastores {
  @doc("Get a datastore in a private cloud cluster")
  get is ArmResourceRead<AvsPrivateCloudDatastore>;
  @doc("Create or update a datastore in a private cloud cluster")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<AvsPrivateCloudDatastore>;
  @doc("Delete a datastore in a private cloud cluster")
  delete is ArmResourceDeleteAsync<AvsPrivateCloudDatastore>;
  @doc("List datastores in a private cloud cluster")
  list is ArmResourceListByParent<AvsPrivateCloudDatastore>;
}
