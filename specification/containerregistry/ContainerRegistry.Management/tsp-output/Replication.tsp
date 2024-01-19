import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Registry.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ContainerRegistry;
@doc("An object that represents a replication for a container registry.")
@parentResource(Registry)
model Replication is TrackedResource<ReplicationProperties> {
  @doc("The name of the replication.")
  @maxLength(50)
  @minLength(5)
  @pattern("^[a-zA-Z0-9]*$")
  @path
  @key("replicationName")
  @segment("replications")
  name: string;
}

@armResourceOperations
interface Replications {
  @doc("Gets the properties of the specified replication.")
  get is ArmResourceRead<Replication>;

  @doc("Creates a replication for a container registry with the specified parameters.")
  create is ArmResourceCreateOrUpdateAsync<
    Replication,
    BaseParameters<Replication>,
    ArmAsyncOperationHeader
  >;

  @doc("Updates a replication for a container registry with the specified parameters.")
  update is ArmCustomPatchAsync<
    Replication,
    ReplicationUpdateParameters,
    BaseParameters<Replication>,
    ArmAsyncOperationHeader
  >;

  @doc("Deletes a replication from a container registry.")
  delete is ArmResourceDeleteAsync<
    Replication,
    BaseParameters<Replication>,
    ArmLroLocationHeader
  >;

  @doc("Lists all the replications for the specified container registry.")
  list is ArmResourceListByParent<Replication>;
}

@@projectedName(Replications.create::parameters.resource,
  "json",
  "replication"
);
@@extension(Replications.create::parameters.resource,
  "x-ms-client-name",
  "replication"
);
@@doc(Replications.create::parameters.resource,
  "The parameters for creating a replication."
);
@@projectedName(Replications.update::parameters.properties,
  "json",
  "replicationUpdateParameters"
);
@@extension(Replications.update::parameters.properties,
  "x-ms-client-name",
  "replicationUpdateParameters"
);
@@doc(Replications.update::parameters.properties,
  "The parameters for updating a replication."
);
