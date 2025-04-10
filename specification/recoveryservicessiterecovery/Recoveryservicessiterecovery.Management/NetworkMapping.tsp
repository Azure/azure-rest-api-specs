import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Network.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.RecoveryServices;
/**
 * Network Mapping model. Ideally it should have been possible to inherit this class from prev version in InheritedModels as long as there is no difference in structure or method signature. Since there were no base Models for certain fields and methods viz NetworkMappingProperties and Load with required return type, the class has been introduced in its entirety with references to base models to facilitate extensions in subsequent versions.
 */
@parentResource(Network)
model NetworkMapping
  is Azure.ResourceManager.ProxyResource<NetworkMappingProperties> {
  ...ResourceNameParameter<
    Resource = NetworkMapping,
    KeyName = "networkMappingName",
    SegmentName = "replicationNetworkMappings",
    NamePattern = ""
  >;
}

@armResourceOperations
interface NetworkMappings {
  /**
   * Gets the details of an ASR network mapping.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ReplicationNetworkMappings_Get")
  get is ArmResourceRead<NetworkMapping>;

  /**
   * The operation to create an ASR network mapping.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("ReplicationNetworkMappings_Create")
  create is ArmResourceCreateOrReplaceAsync<
    NetworkMapping,
    Response = ArmResourceUpdatedResponse<NetworkMapping> | ArmAcceptedLroResponse,
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * The operation to update an ASR network mapping.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @patch(#{ implicitOptionality: false })
  @operationId("ReplicationNetworkMappings_Update")
  update is ArmCustomPatchAsync<
    NetworkMapping,
    PatchModel = UpdateNetworkMappingInput
  >;

  /**
   * The operation to delete a network mapping.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ReplicationNetworkMappings_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<NetworkMapping>;

  /**
   * Lists all ASR network mappings for the specified network.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ReplicationNetworkMappings_ListByReplicationNetworks")
  listByReplicationNetworks is ArmResourceListByParent<
    NetworkMapping,
    Response = ArmResponse<NetworkMappingCollection>
  >;
}

@@doc(NetworkMapping.name, "Network mapping name.");
@@doc(NetworkMapping.properties, "The Network Mapping Properties.");
@@doc(NetworkMappings.create::parameters.resource,
  "Create network mapping input."
);
@@doc(NetworkMappings.update::parameters.properties,
  "Update network mapping input."
);
