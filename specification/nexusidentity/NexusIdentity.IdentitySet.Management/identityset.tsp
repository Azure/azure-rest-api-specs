import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.NexusIdentity;

@lroStatus
@doc("The current provisioning state.")
union ProvisioningState {
  @doc("Accepted Provisioning State")
  Accepted: "Accepted",

  @doc("Succeeded Provisioning State")
  Succeeded: "Succeeded",

  @doc("Updating Provisioning State")
  Updating: "Updating",

  @doc("Deleting Provisioning State")
  Deleting: "Deleting",

  @doc("Failed Provisioning State")
  Failed: "Failed",

  @doc("Canceled Provisioning State")
  Canceled: "Canceled",

  string,
}

@doc("Identity Set Properties defines the properties of the Identity Set.")
model IdentitySetResourceProperties {
  @doc("Tenant id in which scopes are present. Identity service should have the User.Read.All permission on this tenant.")
  scopesTenantId: string;

  @doc("""
    Scopes on which roles are to be watched. Valid scope are: subscription (format: '/subscriptions/{subscriptionId}'), resource group (format: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}', or resource (format: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/[{parentResourcePath}/]{resourceType}/{resourceName}'
    """)
  scopes: Array<string>;

  @doc("""
    Roles to be watched. Role Definition Ids to be passed here
    e.g /providers/Microsoft.Authorization/roleDefinitions/8e3af657-a8ff-443c-a75c-2fe8c4bcb635
    """)
  roleDefinitionIds: Array<string>;

  @doc("The type of access needed for the Roles. Only the specified access types data will be sent.")
  accessTypes: Array<AccessType>;

  @doc("The URL to which the Nexus Identity Service will send notifications.")
  notificationUrl: url;

  @doc("The application Id of Identity Set resource")
  @visibility(Lifecycle.Read)
  appId?: string;

  @doc("The application name of Identity Set resource")
  @visibility(Lifecycle.Read)
  appName?: string;

  @doc("The storage account to which data related to role assignments will be stored for notifications")
  storageAccountName?: string;

  @doc("The URI of the keyvault which stores the keys for encryption and decryption of the sensitive client data")
  keyVaultId?: string;

  @doc("The status of the last operation.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@doc("Access Type defines the type of access needed for the Roles.")
union AccessType {
  @doc("SSH access")
  Ssh: "Ssh",

  @doc("Web access")
  Web: "Web",

  string,
}

@doc("Identity Set resource definition")
model IdentitySetResource is TrackedResource<IdentitySetResourceProperties> {
  @pattern("^[a-zA-Z]{1}[a-zA-Z0-9-_]{2,127}$")
  @key
  @segment("identitySets")
  @doc("The name of the Identity Set resource.")
  @path
  name: string;
}

@armResourceOperations
interface IdentitySet {
  get is ArmResourceRead<IdentitySetResource>;
  create is ArmResourceCreateOrUpdateAsync<IdentitySetResource>;
  update is ArmResourcePatchAsync<
    IdentitySetResource,
    IdentitySetResourceProperties
  >;
  delete is ArmResourceDeleteWithoutOkAsync<IdentitySetResource>;
  listByResourceGroup is ArmResourceListByParent<IdentitySetResource>;
  listBySubscription is ArmListBySubscription<IdentitySetResource>;
}
