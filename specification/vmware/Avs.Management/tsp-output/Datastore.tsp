import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Cluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AVS;
@doc("A datastore resource")
@parentResource(Cluster)
model Datastore is ProxyResource<DatastoreProperties> {
  @doc("Name of the datastore in the private cloud cluster")
  @path
  @key("datastoreName")
  @segment("datastores")
  name: string;
}

@armResourceOperations
interface Datastores {
  @doc("Get a datastore in a private cloud cluster")
  get is ArmResourceRead<Datastore>;

  @doc("Create or update a datastore in a private cloud cluster")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<Datastore>;

  @doc("Delete a datastore in a private cloud cluster")
  delete is ArmResourceDeleteAsync<Datastore>;

  @doc("List datastores in a private cloud cluster")
  list is ArmResourceListByParent<Datastore>;
}

@@projectedName(Datastores.createOrUpdate::parameters.resource,
  "json",
  "datastore"
);
@@extension(Datastores.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "datastore"
);
@@doc(Datastores.createOrUpdate::parameters.resource,
  "A datastore in a private cloud cluster"
);
