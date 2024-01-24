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

namespace Microsoft.StorageSync;
/**
 * Storage Sync Service object.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@Azure.ResourceManager.Private.armResourceInternal(StorageSyncServiceProperties)
@includeInapplicableMetadataInPayload(false)
model StorageSyncService extends TrackedResourceBase {
  /**
   * Name of Storage Sync Service resource.
   */
  @path
  @key("storageSyncServiceName")
  @segment("storageSyncServices")
  name: string;

  /**
   * Storage Sync Service properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: StorageSyncServiceProperties;
}

@armResourceOperations
interface StorageSyncServices {
  /**
   * Get a given StorageSyncService.
   */
  get is ArmResourceRead<StorageSyncService>;

  /**
   * Create a new StorageSyncService.
   */
  create is ArmResourceCreateOrReplaceAsync<StorageSyncService>;

  /**
   * Patch a given StorageSyncService.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<
    StorageSyncService,
    StorageSyncServiceUpdateParameters
  >;

  /**
   * Delete a given StorageSyncService.
   */
  delete is ArmResourceDeleteAsync<StorageSyncService>;

  /**
   * Get a StorageSyncService list by Resource group name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("StorageSyncServices_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<StorageSyncService>;

  /**
   * Get a StorageSyncService list by subscription.
   */
  listBySubscription is ArmListBySubscription<StorageSyncService>;

  /**
   * Check the give namespace name availability.
   */
  checkNameAvailability is checkLocalNameAvailability<
    CheckNameAvailabilityParameters,
    CheckNameAvailabilityResult
  >;

  /**
   * Gets the private link resources that need to be created for a storage sync service.
   */
  // FIXME: PrivateLinkResources_ListByStorageSyncService could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PrivateLinkResources_ListByStorageSyncService")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/storageSyncServices/{storageSyncServiceName}/privateLinkResources")
  @get
  listByStorageSyncService is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the resource group. The name is case insensitive.
       */
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      /**
       * The name of the storage sync service name within the specified resource group.
       */
      @path
      storageSyncServiceName: string;

      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;
    },
    PrivateLinkResourceListResult
  >;
}

@@projectedName(StorageSyncServices.create::parameters.resource,
  "json",
  "parameters"
);
@@extension(StorageSyncServices.create::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(StorageSyncServices.create::parameters.resource,
  "Storage Sync Service resource name."
);
@@projectedName(StorageSyncServices.update::parameters.properties,
  "json",
  "parameters"
);
@@extension(StorageSyncServices.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(StorageSyncServices.update::parameters.properties,
  "Storage Sync Service resource."
);
