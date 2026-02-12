import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./Replication.models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ContainerRegistry;
/**
 * An object that represents a replication for a container registry.
 */
@parentResource(Registry)
model Replication
  is Azure.ResourceManager.TrackedResource<ReplicationProperties> {
  ...ResourceNameParameter<
    Resource = Replication,
    KeyName = "replicationName",
    SegmentName = "replications",
    NamePattern = "^[a-zA-Z0-9]*$"
  >;
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
  create is ArmResourceCreateOrReplaceAsync<Replication>;

  /**
   * Updates a replication for a container registry with the specified parameters.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    Replication,
    PatchModel = ReplicationUpdateParameters,
    Response = ArmResponse<Replication> | ArmResourceCreatedResponse<
      Replication,
      LroHeaders = ArmAsyncOperationHeader<FinalResult = Replication> &
        Azure.Core.Foundations.RetryAfterHeader
    >
  >;

  /**
   * Deletes a replication from a container registry.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    Replication,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Lists all the replications for the specified container registry.
   */
  @list
  list is ArmResourceListByParent<
    Replication,
    Response = ArmResponse<ReplicationListResult>
  >;
}

@@maxLength(Replication.name, 50);
@@minLength(Replication.name, 5);
@@doc(Replication.name, "The name of the replication.");
@@doc(Replication.properties, "The properties of the replication.");
@@doc(Replications.create::parameters.resource,
  "The parameters for creating a replication."
);
@@doc(Replications.update::parameters.properties,
  "The parameters for updating a replication."
);
