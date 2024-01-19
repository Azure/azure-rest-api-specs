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
@doc("Storage resource payload.")
@parentResource(ServiceResource)
model StorageResource is ProxyResource<StorageProperties> {
  @doc("The name of the storage resource.")
  @path
  @key("storageName")
  @segment("storages")
  name: string;
}

@armResourceOperations
interface StorageResources {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get the storage resource.")
  @operationId("Storages_Get")
  get is ArmResourceRead<StorageResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create or update storage resource.")
  @operationId("Storages_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<StorageResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Delete the storage resource.")
  @operationId("Storages_Delete")
  delete is ArmResourceDeleteAsync<StorageResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List all the storages of one Azure Spring Apps resource.")
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
