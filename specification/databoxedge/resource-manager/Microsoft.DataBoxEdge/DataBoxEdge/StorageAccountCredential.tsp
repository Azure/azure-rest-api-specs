import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./DataBoxEdgeDevice.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataBoxEdge;
/**
 * The storage account credential.
 */
@parentResource(DataBoxEdgeDevice)
model StorageAccountCredential
  is Azure.ResourceManager.ProxyResource<
    StorageAccountCredentialProperties,
    false
  > {
  ...ResourceNameParameter<
    Resource = StorageAccountCredential,
    KeyName = "name",
    SegmentName = "storageAccountCredentials",
    NamePattern = ""
  >;
}

@armResourceOperations
interface StorageAccountCredentials {
  /**
   * Gets the properties of the specified storage account credential.
   */
  get is ArmResourceRead<StorageAccountCredential, Error = CloudError>;

  /**
   * Creates or updates the storage account credential.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    StorageAccountCredential,
    Response = ArmResourceUpdatedResponse<StorageAccountCredential> | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = StorageAccountCredential> &
      Azure.Core.Foundations.RetryAfterHeader>,
    Error = CloudError
  >;

  /**
   * Deletes the storage account credential.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    StorageAccountCredential,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Gets all the storage account credentials in a Data Box Edge/Data Box Gateway device.
   */
  @summary("Gets all the storage account credentials in a Data Box Edge/Data Box Gateway device.")
  listByDataBoxEdgeDevice is ArmResourceListByParent<
    StorageAccountCredential,
    Response = ArmResponse<StorageAccountCredentialList>,
    Error = CloudError
  >;
}

@@doc(StorageAccountCredential.name, "The storage account credential name.");
@@doc(StorageAccountCredential.properties,
  "The storage account credential properties."
);
@@doc(StorageAccountCredentials.createOrUpdate::parameters.resource,
  "The storage account credential."
);
