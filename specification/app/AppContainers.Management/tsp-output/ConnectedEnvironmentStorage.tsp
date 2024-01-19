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
@doc("Storage resource for connectedEnvironment.")
@parentResource(ConnectedEnvironment)
model ConnectedEnvironmentStorage
  is ProxyResource<ConnectedEnvironmentStorageProperties> {
  @doc("Name of the storage.")
  @path
  @key("storageName")
  @segment("storages")
  name: string;
}

@armResourceOperations
interface ConnectedEnvironmentStorages {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get storage for a connectedEnvironment.")
  @operationId("ConnectedEnvironmentsStorages_Get")
  get is ArmResourceRead<ConnectedEnvironmentStorage>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create or update storage for a connectedEnvironment.")
  @operationId("ConnectedEnvironmentsStorages_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<ConnectedEnvironmentStorage>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Delete storage for a connectedEnvironment.")
  @operationId("ConnectedEnvironmentsStorages_Delete")
  delete is ArmResourceDeleteSync<ConnectedEnvironmentStorage>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get all storages for a connectedEnvironment.")
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
