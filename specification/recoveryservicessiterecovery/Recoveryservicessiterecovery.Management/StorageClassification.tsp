import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Fabric.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.RecoveryServices;
/**
 * Storage object definition.
 */
@parentResource(Fabric)
model StorageClassification
  is Azure.ResourceManager.ProxyResource<StorageClassificationProperties> {
  ...ResourceNameParameter<
    Resource = StorageClassification,
    KeyName = "storageClassificationName",
    SegmentName = "replicationStorageClassifications",
    NamePattern = ""
  >;
}

@armResourceOperations
interface StorageClassifications {
  /**
   * Gets the details of the specified storage classification.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ReplicationStorageClassifications_Get")
  get is ArmResourceRead<StorageClassification>;

  /**
   * Lists the storage classifications available in the specified fabric.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ReplicationStorageClassifications_ListByReplicationFabrics")
  listByReplicationFabrics is ArmResourceListByParent<
    StorageClassification,
    Response = ArmResponse<StorageClassificationCollection>
  >;
}

@@doc(StorageClassification.name, "Storage classification name.");
@@doc(StorageClassification.properties, "Properties of the storage object.");
