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

  /**
   * Resource Location
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  location?: string;
}

@armResourceOperations
interface StorageClassifications {
  /**
   * Gets the details of the specified storage classification.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Gets the details of a storage classification.")
  get is ArmResourceRead<StorageClassification, Error = never>;

  /**
   * Lists the storage classifications available in the specified fabric.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Gets the list of storage classification objects under a fabric.")
  listByReplicationFabrics is ArmResourceListByParent<
    StorageClassification,
    Response = ArmResponse<StorageClassificationCollection>,
    Error = never
  >;
}

@@doc(StorageClassification.name, "Storage classification name.");
@@doc(StorageClassification.properties, "Properties of the storage object.");
