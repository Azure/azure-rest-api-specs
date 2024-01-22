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

namespace Microsoft.App;
/**
 * Storage resource for managedEnvironment.
 */
model ManagedEnvironmentStorage
  is ProxyResource<ManagedEnvironmentStorageProperties> {
  /**
   * Name of the storage.
   */
  @path
  @key("storageName")
  @segment("storages")
  name: string;
}

@armResourceOperations
interface ManagedEnvironmentStorages {
  /**
   * Get storage for a managedEnvironment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ManagedEnvironmentsStorages_Get")
  get is ArmResourceRead<ManagedEnvironmentStorage>;

  /**
   * Create or update storage for a managedEnvironment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ManagedEnvironmentsStorages_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<ManagedEnvironmentStorage>;

  /**
   * Delete storage for a managedEnvironment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ManagedEnvironmentsStorages_Delete")
  delete is ArmResourceDeleteSync<ManagedEnvironmentStorage>;

  /**
   * Get all storages for a managedEnvironment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ManagedEnvironmentsStorages_List")
  list is ArmResourceListByParent<ManagedEnvironmentStorage>;
}

@@projectedName(ManagedEnvironmentStorages.createOrUpdate::parameters.resource,
  "json",
  "storageEnvelope"
);
@@extension(ManagedEnvironmentStorages.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "storageEnvelope"
);
@@doc(ManagedEnvironmentStorages.createOrUpdate::parameters.resource,
  "Configuration details of storage."
);
