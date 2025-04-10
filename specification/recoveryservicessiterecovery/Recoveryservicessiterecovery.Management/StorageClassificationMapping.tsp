import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./StorageClassification.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.RecoveryServices;
/**
 * Storage mapping object.
 */
@parentResource(StorageClassification)
model StorageClassificationMapping
  is Azure.ResourceManager.ProxyResource<StorageClassificationMappingProperties> {
  ...ResourceNameParameter<
    Resource = StorageClassificationMapping,
    KeyName = "storageClassificationMappingName",
    SegmentName = "replicationStorageClassificationMappings",
    NamePattern = ""
  >;
}

@armResourceOperations
interface StorageClassificationMappings {
  /**
   * Gets the details of the specified storage classification mapping.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ReplicationStorageClassificationMappings_Get")
  get is ArmResourceRead<StorageClassificationMapping>;

  /**
   * The operation to create a storage classification mapping.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("ReplicationStorageClassificationMappings_Create")
  create is ArmResourceCreateOrReplaceAsync<
    StorageClassificationMapping,
    Response = ArmResourceUpdatedResponse<StorageClassificationMapping> | ArmAcceptedLroResponse,
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * The operation to delete a storage classification mapping.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ReplicationStorageClassificationMappings_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<StorageClassificationMapping>;

  /**
   * Lists the storage classification mappings for the fabric.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ReplicationStorageClassificationMappings_ListByReplicationStorageClassifications")
  listByReplicationStorageClassifications is ArmResourceListByParent<
    StorageClassificationMapping,
    Response = ArmResponse<StorageClassificationMappingCollection>
  >;
}

@@doc(StorageClassificationMapping.name,
  "Storage classification mapping name."
);
@@doc(StorageClassificationMapping.properties,
  "Properties of the storage mapping object."
);
@@doc(StorageClassificationMappings.create::parameters.resource,
  "Pairing input."
);
