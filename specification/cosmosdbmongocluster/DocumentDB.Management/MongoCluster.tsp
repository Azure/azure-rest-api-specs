import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.DocumentDB;
@doc("Represents a mongo cluster resource.")
model MongoCluster is TrackedResource<MongoClusterProperties> {
  @doc("The name of the mongo cluster.")
  @maxLength(40)
  @minLength(3)
  @pattern("^[a-z0-9]+(-[a-z0-9]+)*")
  @path
  @key("mongoClusterName")
  @segment("mongoClusters")
  name: string;
}

@armResourceOperations
interface MongoClusters {
  @doc("Gets information about a mongo cluster.")
  get is ArmResourceRead<MongoCluster>;
  @doc("Create or update a mongo cluster. Update overwrites all properties for the resource. To only modify some of the properties, use PATCH.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<MongoCluster>;
  @doc("Updates an existing mongo cluster. The request body can contain one to many of the properties present in the normal mongo cluster definition.")
  update is ArmResourcePatchAsync<MongoCluster, MongoClusterProperties>;
  @doc("Deletes a mongo cluster.")
  delete is ArmResourceDeleteWithoutOkAsync<MongoCluster>;
  @doc("List all the mongo clusters in a given resource group.")
  listByResourceGroup is ArmResourceListByParent<MongoCluster>;
  @doc("List all the mongo clusters in a given subscription.")
  list is ArmListBySubscription<MongoCluster>;
  @doc("List mongo cluster connection strings. This includes the default connection string using SCRAM-SHA-256, as well as other connection strings supported by the cluster.")
  listConnectionStrings is ArmResourceActionSync<
    MongoCluster,
    {},
    ListConnectionStringsResult
  >;
}
