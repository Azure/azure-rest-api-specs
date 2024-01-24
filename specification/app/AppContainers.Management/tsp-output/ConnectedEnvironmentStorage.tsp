import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ConnectedEnvironment.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.App;
/**
 * Storage resource for connectedEnvironment.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(ConnectedEnvironment)
@Azure.ResourceManager.Private.armResourceInternal(
  ConnectedEnvironmentStorageProperties
)
@includeInapplicableMetadataInPayload(false)
model ConnectedEnvironmentStorage extends ProxyResourceBase {
  /**
   * Name of the storage.
   */
  @path
  @key("storageName")
  @segment("storages")
  name: string;

  /**
   * Storage properties
   */
  @extension("x-ms-client-flatten", true)
  properties?: ConnectedEnvironmentStorageProperties;
}

@armResourceOperations
interface ConnectedEnvironmentStorages {
  /**
   * Get storage for a connectedEnvironment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ConnectedEnvironmentsStorages_Get")
  get is ArmResourceRead<ConnectedEnvironmentStorage>;

  /**
   * Create or update storage for a connectedEnvironment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ConnectedEnvironmentsStorages_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<ConnectedEnvironmentStorage>;

  /**
   * Delete storage for a connectedEnvironment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ConnectedEnvironmentsStorages_Delete")
  delete is ArmResourceDeleteSync<ConnectedEnvironmentStorage>;

  /**
   * Get all storages for a connectedEnvironment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ConnectedEnvironmentsStorages_List")
  list is ArmResourceListByParent<ConnectedEnvironmentStorage>;
}

@@projectedName(ConnectedEnvironmentStorages.createOrUpdate::parameters.resource,
  "json",
  "storageEnvelope"
);
@@extension(ConnectedEnvironmentStorages.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "storageEnvelope"
);
@@doc(ConnectedEnvironmentStorages.createOrUpdate::parameters.resource,
  "Configuration details of storage."
);
