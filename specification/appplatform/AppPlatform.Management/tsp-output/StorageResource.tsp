import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ServiceResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AppPlatform;
/**
 * Storage resource payload.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(ServiceResource)
@Azure.ResourceManager.Private.armResourceInternal(StorageProperties)
@includeInapplicableMetadataInPayload(false)
model StorageResource extends ProxyResource {
  /**
   * The name of the storage resource.
   */
  @path
  @key("storageName")
  @segment("storages")
  name: string;

  /**
   * Properties of the storage resource payload.
   */
  @extension("x-ms-client-flatten", true)
  properties?: StorageProperties;
}

@armResourceOperations
interface StorageResources {
  /**
   * Get the storage resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Storages_Get")
  get is ArmResourceRead<StorageResource>;

  /**
   * Create or update storage resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Storages_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<StorageResource>;

  /**
   * Delete the storage resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Storages_Delete")
  delete is ArmResourceDeleteAsync<StorageResource>;

  /**
   * List all the storages of one Azure Spring Apps resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Storages_List")
  list is ArmResourceListByParent<StorageResource>;
}

@@projectedName(StorageResources.createOrUpdate::parameters.resource,
  "json",
  "storageResource"
);
@@extension(StorageResources.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "storageResource"
);
@@doc(StorageResources.createOrUpdate::parameters.resource,
  "Parameters for the create or update operation"
);
