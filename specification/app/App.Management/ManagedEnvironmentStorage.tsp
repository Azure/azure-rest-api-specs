import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedEnvironment.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.App;
/**
 * Storage resource for managedEnvironment.
 */
@parentResource(ManagedEnvironment)
model ManagedEnvironmentStorage
  is Azure.ResourceManager.ProxyResource<ManagedEnvironmentStorageProperties> {
  ...ResourceNameParameter<
    Resource = ManagedEnvironmentStorage,
    KeyName = "storageName",
    SegmentName = "storages",
    NamePattern = ""
  >;
}

@armResourceOperations
interface ManagedEnvironmentStorages {
  /**
   * Get storage for a managedEnvironment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ManagedEnvironmentsStorages_Get")
  get is ArmResourceRead<ManagedEnvironmentStorage>;

  /**
   * Create or update storage for a managedEnvironment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ManagedEnvironmentsStorages_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<ManagedEnvironmentStorage>;

  /**
   * Delete storage for a managedEnvironment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ManagedEnvironmentsStorages_Delete")
  delete is ArmResourceDeleteSync<ManagedEnvironmentStorage>;

  /**
   * Get all storages for a managedEnvironment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ManagedEnvironmentsStorages_List")
  list is ArmResourceListByParent<
    ManagedEnvironmentStorage,
    Response = ArmResponse<ManagedEnvironmentStoragesCollection>
  >;
}

@@doc(ManagedEnvironmentStorage.name, "Name of the storage.");
@@doc(ManagedEnvironmentStorage.properties, "Storage properties");
@@doc(ManagedEnvironmentStorages.createOrUpdate::parameters.resource,
  "Configuration details of storage."
);
