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
interface ManagedEnvironmentsStorages {
  /**
   * Get storage for a managedEnvironment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ManagedEnvironmentsStorages_Get")
  @summary("Get storage for a managedEnvironment.")
  get is ArmResourceRead<
    ManagedEnvironmentStorage,
    Error = DefaultErrorResponse
  >;

  /**
   * Create or update storage for a managedEnvironment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ManagedEnvironmentsStorages_CreateOrUpdate")
  @summary("Create or update storage for a managedEnvironment.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    ManagedEnvironmentStorage,
    Error = DefaultErrorResponse
  >;

  /**
   * Delete storage for a managedEnvironment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ManagedEnvironmentsStorages_Delete")
  @summary("Delete storage for a managedEnvironment.")
  delete is ArmResourceDeleteSync<
    ManagedEnvironmentStorage,
    Error = DefaultErrorResponse
  >;

  /**
   * Get all storages for a managedEnvironment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ManagedEnvironmentsStorages_List")
  @summary("Get all storages for a managedEnvironment.")
  list is ArmResourceListByParent<
    ManagedEnvironmentStorage,
    Response = ArmResponse<ManagedEnvironmentStoragesCollection>,
    Error = DefaultErrorResponse
  >;
}

@@doc(ManagedEnvironmentStorage.name, "Name of the storage.");
@@doc(ManagedEnvironmentStorage.properties, "Storage properties");
@@doc(ManagedEnvironmentsStorages.createOrUpdate::parameters.resource,
  "Configuration details of storage."
);
