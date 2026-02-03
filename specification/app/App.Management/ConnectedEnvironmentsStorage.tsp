import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ConnectedEnvironment.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.App;
/**
 * Storage resource for connectedEnvironment.
 */
@parentResource(ConnectedEnvironment)
model ConnectedEnvironmentStorage
  is Azure.ResourceManager.ProxyResource<ConnectedEnvironmentStorageProperties> {
  ...ResourceNameParameter<
    Resource = ConnectedEnvironmentStorage,
    KeyName = "storageName",
    SegmentName = "storages",
    NamePattern = ""
  >;
}

@armResourceOperations
interface ConnectedEnvironmentsStorages {
  /**
   * Get storage for a connectedEnvironment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ConnectedEnvironmentsStorages_Get")
  @summary("Get storage for a connectedEnvironment.")
  get is ArmResourceRead<
    ConnectedEnvironmentStorage,
    Error = DefaultErrorResponse
  >;

  /**
   * Create or update storage for a connectedEnvironment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ConnectedEnvironmentsStorages_CreateOrUpdate")
  @summary("Create or update storage for a connectedEnvironment.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ConnectedEnvironmentStorage>;

  /**
   * Delete storage for a connectedEnvironment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ConnectedEnvironmentsStorages_Delete")
  @summary("Delete storage for a connectedEnvironment.")
  delete is ArmResourceDeleteWithoutOkAsync<ConnectedEnvironmentStorage>;

  /**
   * Get all storages for a connectedEnvironment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ConnectedEnvironmentsStorages_List")
  @summary("Get all storages for a connectedEnvironment.")
  list is ArmResourceListByParent<
    ConnectedEnvironmentStorage,
    Response = ArmResponse<ConnectedEnvironmentStoragesCollection>,
    Error = DefaultErrorResponse
  >;
}

@@doc(ConnectedEnvironmentStorage.name, "Name of the storage.");
@@doc(ConnectedEnvironmentStorage.properties, "Storage properties");
@@doc(ConnectedEnvironmentsStorages.createOrUpdate::parameters.resource,
  "Configuration details of storage."
);
