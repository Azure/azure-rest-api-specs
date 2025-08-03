import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./common/provisioningState.tsp";
import "./common/resourceIds.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.CommonTypes;

namespace Microsoft.HealthcareInterop;

@doc("The healthcare interop hub resource to centrally manage configuration across a collection of associated healthcare interop resources such as connectors and channels.")
@resource("hubs")
model Hub is Azure.ResourceManager.TrackedResource<HubProperties> {
  @doc("The name of the hub resource.")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("hubName")
  @segment("hubs")
  @path
  name: string;

  ...ManagedServiceIdentityProperty;
}

@doc("The properties to configure the healthcare interop hub.")
model HubProperties {
  @doc("The configuration for the managed infra resources associated with this hub resource.")
  @visibility(Lifecycle.Read)
  managedInfraConfiguration?: ManagedInfraConfiguration;

  @doc("The managed-on-behalf-of configuration for the resource provider to be able to manage resources on behalf of the resource owner.")
  @visibility(Lifecycle.Read)
  managedOnBehalfOfConfiguration?: ManagedOnBehalfOfConfiguration;

  @doc("Environments hosted on remote locations where Connectors can be deployed.")
  @identifiers(#[])
  remoteConnectorEnvironments?: Array<RemoteConnectorEnvironment>;

  @doc("The status of the last provisioning operation.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningLROState;
}

@doc("The configuration for the managed infra resources.")
model ManagedInfraConfiguration {
  @doc("The name of the managed resource group.")
  @visibility(Lifecycle.Read)
  resourceGroupName?: string;

  @doc("The configuration of the managed-on-behalf-of storage account.")
  @visibility(Lifecycle.Read)
  storageAccount?: StorageAccountConfiguration;

  @doc("The configuration of the managed-on-behalf-of key vault.")
  @visibility(Lifecycle.Read)
  keyVault?: KeyVaultConfiguration;
}

@doc("Storage account configuration.")
model StorageAccountConfiguration {
  @doc("The resource ID of the storage account.")
  @visibility(Lifecycle.Read)
  storageAccountResourceId: StorageAccountResourceId;

  @doc("The storage account blob service endpoint.")
  @visibility(Lifecycle.Read)
  @pattern(".+\\.core\\.windows\\.net\\/")
  storageAccountBlobEndpoint: url;
}

@doc("Key Vault configuration.")
model KeyVaultConfiguration {
  @doc("The resource ID of the key vault.")
  @visibility(Lifecycle.Read)
  keyVaultResourceId: KeyVaultResourceId;

  @doc("The URI of the key vault.")
  @visibility(Lifecycle.Read)
  @pattern(".+\\.vault\\.azure\\.net\\/")
  keyVaultUri: url;
}

@doc("An Environment hosted on a remote location where Connectors can be deployed.")
model RemoteConnectorEnvironment {
  @doc("The name of the remote connector environment connected cluster.")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  name: string;

  @doc("The resource ID of the remote connector environment connected cluster.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  connectedClusterId: ConnectedClusterResourceId;

  @doc("The geo-location where the connected cluster is provisioned.")
  @visibility(Lifecycle.Create, Lifecycle.Read, Lifecycle.Update)
  location: string;

  @doc("The resource ID of the healthcare extension.")
  @visibility(Lifecycle.Create, Lifecycle.Read, Lifecycle.Update)
  healthcareExtensionId: HealthcareExtensionResourceId;

  @doc("The custom location associated with the healthcare extension.")
  @visibility(Lifecycle.Create, Lifecycle.Read, Lifecycle.Update)
  customLocation: CustomLocation;

  @doc("The managed identity used by the storage extension.")
  @visibility(Lifecycle.Create, Lifecycle.Read, Lifecycle.Update)
  storageExtensionManagedIdentity: ExtensionManagedIdentity;
}

@doc("The custom location.")
model CustomLocation {
  @doc("The name of the custom location resource.")
  @visibility(Lifecycle.Create, Lifecycle.Read, Lifecycle.Update)
  name: string;

  @doc("The resource ID of the custom location resource.")
  @visibility(Lifecycle.Create, Lifecycle.Read, Lifecycle.Update)
  id: CustomLocationResourceId;
}

@doc("The managed identity used for extensions.")
model ExtensionManagedIdentity {
  @doc("The principal ID of the managed identity.")
  @visibility(Lifecycle.Create, Lifecycle.Read, Lifecycle.Update)
  principalId: string;

  @doc("The managed identity type.")
  @visibility(Lifecycle.Create, Lifecycle.Read, Lifecycle.Update)
  type: Azure.ResourceManager.Foundations.ManagedServiceIdentityType;
}

@armResourceOperations
interface Hubs {
  get is ArmResourceRead<Hub>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Hub>;
  update is ArmResourcePatchAsync<Hub, HubProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<Hub>;
  listByResourceGroup is ArmResourceListByParent<Hub>;
  listBySubscription is ArmListBySubscription<Hub>;
}
