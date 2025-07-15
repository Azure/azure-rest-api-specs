import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";
import "./../common/provisioningState.tsp";
import "./../common/resourceIds.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.HealthcareInterop;

@doc("The healthcare interop storage account connector resource to capture the configuration pertaining to an existing Storage Account instance.")
@resource("storageAccountConnectors")
model StorageAccountConnector
  is TrackedResource<StorageAccountConnectorProperties> {
  @doc("The name of the storage account connector resource.")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("storageAccountConnectorName")
  @segment("storageAccountConnectors")
  @path
  name: string;
}

@doc("The properties to configure the StorageAccountConnector resource.")
model StorageAccountConnectorProperties {
  @doc("The status of the last provisioning operation.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningLROState;

  @doc("The resource ID of an existing hub resource to link/associate this storageAccountConnector resource to.")
  hubResourceId: HubResourceId;

  @doc("URL of the Azure storage account container to connect to.")
  @pattern(".+\\.core\\.windows\\.net\\/.+")
  storageAccountContainerUrl: url;

  @doc("Optional string to specify the blob prefix/path to use when reading/writing blobs from/to an Azure Storage container. If not specified, the root of the container will be used.")
  blobPrefix?: string;
}

@armResourceOperations
interface StorageAccountConnectors {
  get is ArmResourceRead<StorageAccountConnector>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<StorageAccountConnector>;
  update is ArmResourcePatchAsync<
    StorageAccountConnector,
    StorageAccountConnectorProperties
  >;
  delete is ArmResourceDeleteWithoutOkAsync<StorageAccountConnector>;
  listByResourceGroup is ArmResourceListByParent<StorageAccountConnector>;
  listBySubscription is ArmListBySubscription<StorageAccountConnector>;
}
