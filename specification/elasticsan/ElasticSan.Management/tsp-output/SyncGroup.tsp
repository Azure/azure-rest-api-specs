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
@doc("Sync Group object.")
@parentResource(StorageSyncService)
model SyncGroup is ProxyResource<SyncGroupProperties> {
  @doc("Name of Sync Group resource.")
  @path
  @key("syncGroupName")
  @segment("syncGroups")
  name: string;
}

@armResourceOperations
interface SyncGroups {
  @doc("Get a given SyncGroup.")
  get is ArmResourceRead<SyncGroup>;

  @doc("Create a new SyncGroup.")
  create is ArmResourceCreateOrReplaceSync<SyncGroup>;

  @doc("Delete a given SyncGroup.")
  delete is ArmResourceDeleteSync<SyncGroup>;

  @doc("Get a SyncGroup List.")
  listByStorageSyncService is ArmResourceListByParent<SyncGroup>;
}

@@projectedName(SyncGroups.create::parameters.resource, "json", "parameters");
@@extension(SyncGroups.create::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(SyncGroups.create::parameters.resource, "Sync Group Body");
