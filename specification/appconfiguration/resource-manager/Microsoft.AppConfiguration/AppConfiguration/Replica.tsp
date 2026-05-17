import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ConfigurationStore.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AppConfiguration;
/**
 * The replica resource.
 */
@parentResource(ConfigurationStore)
model Replica is Azure.ResourceManager.ProxyResource<ReplicaProperties> {
  ...ResourceNameParameter<
    Resource = Replica,
    KeyName = "replicaName",
    SegmentName = "replicas",
    NamePattern = "^[a-zA-Z0-9]*$"
  >;

  /**
   * The location of the replica.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location?: string;
}

@armResourceOperations
interface Replicas {
  /**
   * Gets the properties of the specified replica.
   */
  get is ArmResourceRead<Replica>;

  /**
   * Creates a replica with the specified parameters.
   */
  create is ArmResourceCreateOrReplaceAsync<Replica>;

  /**
   * Deletes a replica.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    Replica,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse<ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader> | ArmDeletedNoContentResponse
  >;

  /**
   * Lists the replicas for a given configuration store.
   */
  listByConfigurationStore is ArmResourceListByParent<
    Replica,
    Parameters = {
      /**
       * A skip token is used to continue retrieving items after an operation returns a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skipToken parameter that specifies a starting point to use for subsequent calls.
       */
      @query("$skipToken")
      $skipToken?: string;
    }
  >;
}

@@doc(Replica.name, "The name of the replica.");
@@doc(Replica.properties, "All replica properties.");
@@doc(Replicas.create::parameters.resource,
  "The parameters for creating a replica."
);
