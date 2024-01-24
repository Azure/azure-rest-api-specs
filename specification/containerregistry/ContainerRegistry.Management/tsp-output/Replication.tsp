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
/**
 * An object that represents a replication for a container registry.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Registry)
@Azure.ResourceManager.Private.armResourceInternal(ReplicationProperties)
@includeInapplicableMetadataInPayload(false)
model Replication extends TrackedResourceBase {
  /**
   * The name of the replication.
   */
  @maxLength(50)
  @minLength(5)
  @pattern("^[a-zA-Z0-9]*$")
  @path
  @key("replicationName")
  @segment("replications")
  name: string;

  /**
   * The properties of the replication.
   */
  @extension("x-ms-client-flatten", true)
  properties?: ReplicationProperties;
}

@armResourceOperations
interface Replications {
  /**
   * Gets the properties of the specified replication.
   */
  get is ArmResourceRead<Replication>;

  /**
   * Creates a replication for a container registry with the specified parameters.
   */
  create is ArmResourceCreateOrReplaceAsync<
    Replication,
    BaseParameters<Replication>,
    ArmAsyncOperationHeader
  >;

  /**
   * Updates a replication for a container registry with the specified parameters.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<
    Replication,
    ReplicationUpdateParameters,
    BaseParameters<Replication>,
    ArmAsyncOperationHeader
  >;

  /**
   * Deletes a replication from a container registry.
   */
  delete is ArmResourceDeleteAsync<
    Replication,
    BaseParameters<Replication>,
    ArmLroLocationHeader
  >;

  /**
   * Lists all the replications for the specified container registry.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Replications_List")
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
