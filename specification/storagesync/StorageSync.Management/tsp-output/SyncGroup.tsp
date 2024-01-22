import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./StorageSyncService.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.StorageSync;
/**
 * Sync Group object.
 */
@parentResource(StorageSyncService)
model SyncGroup is ProxyResource<SyncGroupProperties> {
  /**
   * Name of Sync Group resource.
   */
  @path
  @key("syncGroupName")
  @segment("syncGroups")
  name: string;
}

@armResourceOperations
interface SyncGroups {
  /**
   * Get a given SyncGroup.
   */
  get is ArmResourceRead<SyncGroup>;

  /**
   * Create a new SyncGroup.
   */
  create is ArmResourceCreateOrReplaceSync<SyncGroup>;

  /**
   * Delete a given SyncGroup.
   */
  delete is ArmResourceDeleteSync<SyncGroup>;

  /**
   * Get a SyncGroup List.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SyncGroups_ListByStorageSyncService")
  listByStorageSyncService is ArmResourceListByParent<SyncGroup>;
}

@@projectedName(SyncGroups.create::parameters.resource, "json", "parameters");
@@extension(SyncGroups.create::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(SyncGroups.create::parameters.resource, "Sync Group Body");
