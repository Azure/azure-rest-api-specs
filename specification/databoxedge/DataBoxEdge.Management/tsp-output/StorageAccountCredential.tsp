import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./DataBoxEdgeDevice.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataBoxEdge;
/**
 * The storage account credential.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(DataBoxEdgeDevice)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(
  StorageAccountCredentialProperties
)
model StorageAccountCredential extends ProxyResourceBase {
  /**
   * The storage account credential name.
   */
  @path
  @key("name")
  @segment("storageAccountCredentials")
  @visibility("read")
  name: string;

  /**
   * The storage account credential properties.
   */
  @extension("x-ms-client-flatten", true)
  properties: StorageAccountCredentialProperties;
}

@armResourceOperations
interface StorageAccountCredentials {
  /**
   * Gets the properties of the specified storage account credential.
   */
  get is ArmResourceRead<StorageAccountCredential>;

  /**
   * Creates or updates the storage account credential.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<StorageAccountCredential>;

  /**
   * Deletes the storage account credential.
   */
  delete is ArmResourceDeleteAsync<StorageAccountCredential>;

  /**
   * Gets all the storage account credentials in a Data Box Edge/Data Box Gateway device.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("StorageAccountCredentials_ListByDataBoxEdgeDevice")
  listByDataBoxEdgeDevice is ArmResourceListByParent<StorageAccountCredential>;
}

@@projectedName(StorageAccountCredentials.createOrUpdate::parameters.resource,
  "json",
  "storageAccountCredential"
);
@@extension(StorageAccountCredentials.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "storageAccountCredential"
);
@@doc(StorageAccountCredentials.createOrUpdate::parameters.resource,
  "The storage account credential."
);
