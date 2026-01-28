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

  /**
   * Resource Location
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  location?: string;
}

@armResourceOperations
interface StorageClassificationMappings {
  /**
   * Gets the details of the specified storage classification mapping.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Gets the details of a storage classification mapping.")
  get is ArmResourceRead<StorageClassificationMapping, Error = never>;

  /**
   * The operation to create a storage classification mapping.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Create storage classification mapping.")
  create is Azure.ResourceManager.Legacy.CreateOrUpdateAsync<
    StorageClassificationMapping,
    Request = StorageClassificationMappingInput,
    Response = ArmResourceUpdatedResponse<StorageClassificationMapping> | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = StorageClassificationMapping> &
      Azure.Core.Foundations.RetryAfterHeader>,
    Error = never
  >;

  /**
   * The operation to delete a storage classification mapping.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Delete a storage classification mapping.")
  delete is ArmResourceDeleteWithoutOkAsync<
    StorageClassificationMapping,
    Error = never
  >;

  /**
   * Lists the storage classification mappings for the fabric.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Gets the list of storage classification mappings objects under a storage.")
  listByReplicationStorageClassifications is ArmResourceListByParent<
    StorageClassificationMapping,
    Response = ArmResponse<StorageClassificationMappingCollection>,
    Error = never
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
