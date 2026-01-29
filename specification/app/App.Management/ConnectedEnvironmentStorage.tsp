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
interface ConnectedEnvironmentStorages {
  /**
   * Get storage for a connectedEnvironment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ConnectedEnvironmentsStorages_Get")
  get is ArmResourceRead<ConnectedEnvironmentStorage>;

  /**
   * Create or update storage for a connectedEnvironment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ConnectedEnvironmentsStorages_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ConnectedEnvironmentStorage>;

  /**
   * Delete storage for a connectedEnvironment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ConnectedEnvironmentsStorages_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<ConnectedEnvironmentStorage>;

  /**
   * Get all storages for a connectedEnvironment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ConnectedEnvironmentsStorages_List")
  list is ArmResourceListByParent<
    ConnectedEnvironmentStorage,
    Response = ArmResponse<ConnectedEnvironmentStoragesCollection>
  >;
}

@@doc(ConnectedEnvironmentStorage.name, "Name of the storage.");
@@doc(ConnectedEnvironmentStorage.properties, "Storage properties");
@@doc(ConnectedEnvironmentStorages.createOrUpdate::parameters.resource,
  "Configuration details of storage."
);
