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

namespace Microsoft.StorageMover;
/**
 * The Storage Mover resource, which is a container for a group of Agents, Projects, and Endpoints.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(StorageMoverProperties)
model StorageMover extends TrackedResourceBase {
  /**
   * The name of the Storage Mover resource.
   */
  @path
  @key("storageMoverName")
  @segment("storageMovers")
  @visibility("read")
  name: string;

  /**
   * The resource specific properties for the Storage Mover resource.
   */
  @extension("x-ms-client-flatten", true)
  properties?: StorageMoverProperties;
}

@armResourceOperations
interface StorageMovers {
  /**
   * Gets a Storage Mover resource.
   */
  get is ArmResourceRead<StorageMover>;

  /**
   * Creates or updates a top-level Storage Mover resource.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<StorageMover>;

  /**
   * Updates properties for a Storage Mover resource. Properties not specified in the request body will be unchanged.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchSync<StorageMover, StorageMoverUpdateParameters>;

  /**
   * Deletes a Storage Mover resource.
   */
  delete is ArmResourceDeleteAsync<
    StorageMover,
    BaseParameters<StorageMover>,
    ArmLroLocationHeader
  >;

  /**
   * Lists all Storage Movers in a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("StorageMovers_List")
  list is ArmResourceListByParent<StorageMover>;

  /**
   * Lists all Storage Movers in a subscription.
   */
  listBySubscription is ArmListBySubscription<StorageMover>;
}

@@projectedName(StorageMovers.createOrUpdate::parameters.resource,
  "json",
  "storageMover"
);
@@extension(StorageMovers.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "storageMover"
);
@@doc(StorageMovers.createOrUpdate::parameters.resource, "");
@@projectedName(StorageMovers.update::parameters.properties,
  "json",
  "storageMover"
);
@@extension(StorageMovers.update::parameters.properties,
  "x-ms-client-name",
  "storageMover"
);
@@doc(StorageMovers.update::parameters.properties, "");
