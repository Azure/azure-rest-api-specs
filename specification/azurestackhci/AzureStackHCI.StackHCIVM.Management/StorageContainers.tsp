import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AzureStackHCI;
/**
 * The storage container resource definition.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(StorageContainerProperties)
model StorageContainers extends TrackedResourceBase {
  /**
   * Name of the storage container
   */
  @maxLength(80)
  @minLength(1)
  @pattern("^[a-zA-Z0-9]$|^[a-zA-Z0-9][-._a-zA-Z0-9]{0,78}[_a-zA-Z0-9]$")
  @path
  @key("storageContainerName")
  @segment("storageContainers")
  @visibility("read")
  name: string;

  /**
   * The extendedLocation of the resource.
   */
  extendedLocation?: ExtendedLocation;

  /**
   * Properties under the storage container resource
   */
  @extension("x-ms-client-flatten", true)
  properties?: StorageContainerProperties;
}

@armResourceOperations
@projectedName("client", "StorageContainers")
interface StorageContainersOperationGroup {
  /**
   * Gets a storage container
   */
  get is ArmResourceRead<StorageContainers>;

  /**
   * The operation to create or update a storage container. Please note some properties can be set only during storage container creation.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    StorageContainers,
    BaseParameters<StorageContainers>,
    ArmAsyncOperationHeader
  >;

  /**
   * The operation to update a storage container.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<
    StorageContainers,
    StorageContainersUpdateRequest,
    BaseParameters<StorageContainers>,
    ArmAsyncOperationHeader
  >;

  /**
   * The operation to delete a storage container.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    StorageContainers,
    BaseParameters<StorageContainers>,
    ArmAsyncOperationHeader
  >;

  /**
   * Lists all of the storage containers in the specified resource group. Use the nextLink property in the response to get the next page of storage containers.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("StorageContainers_List")
  list is ArmResourceListByParent<StorageContainers>;

  /**
   * Lists all of the storage containers in the specified subscription. Use the nextLink property in the response to get the next page of storage containers.
   */
  listAll is ArmListBySubscription<StorageContainers>;
}

@@projectedName(StorageContainersOperationGroup.createOrUpdate::parameters.resource,
  "json",
  "storageContainers"
);
@@extension(StorageContainersOperationGroup.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "storageContainers"
);
@@doc(StorageContainersOperationGroup.createOrUpdate::parameters.resource, "");
@@projectedName(StorageContainersOperationGroup.update::parameters.properties,
  "json",
  "storageContainers"
);
@@extension(StorageContainersOperationGroup.update::parameters.properties,
  "x-ms-client-name",
  "storageContainers"
);
@@doc(StorageContainersOperationGroup.update::parameters.properties, "");
