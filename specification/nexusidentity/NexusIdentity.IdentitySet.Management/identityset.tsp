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
@doc("The provisioning state of Identity Set resource.")
enum ProvisioningState {
  ...ResourceProvisioningState,

  @doc("The operation is accepted and in progress.")
  Updating,

  @doc("The resource is being deleted.")
  Deleting,

  @doc("The operation is accepted.")
  Accepted,
}

@doc("Identity Set Properties defines the properties of the Identity Set.")
model IdentitySetResourceProperties {
  @doc("Tenant id in which scopes are present. Identity service should have the User.Read.All permission on this tenant.")
  scopesTenantId: string;

  @doc("List of scopes to be watched")
  eventSubscriptions: Array<EventSubscription>;

  @doc("The URL to which the Nexus Identity Service will send notifications.")
  defaultNotificationUrl: string;

  @doc("The application Id of Identity Set resource")
  @visibility("read")
  appId?: string;

  @doc("The application name of Identity Set resource")
  @visibility("read")
  appName?: string;

  @doc("The status of the last operation.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("""
Event Subscriptions defines the properties needed to create an event subscription. 
Users should create EventSubscription for each distinct combination of Roles to be watched
""")
model EventSubscription {
  @doc("The name of the event subscription. Event subscription names must be unique in a Identity Set.")
  eventSubscriptionId?: string;

  @doc("""
  Scopes on which roles are to be watched. Valid scope are: subscription (format: '/subscriptions/{subscriptionId}'), resource group (format: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}', or resource (format: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/[{parentResourcePath}/]{resourceType}/{resourceName}'
  """)
  scopes: Array<string>;

  @doc("Roles to be watched.")
  roles: Array<string>;

  @doc("The type of access needed for the Roles. Only the specified access types data will be sent.")
  accessTypes: Array<AccessType>;

  @doc("The URL to which the Nexus Identity Service will send notifications for this Event subscription.")
  notificationUrl?: string;
}

@doc("Access Type defines the type of access needed for the Roles.")
enum AccessType {
  @doc("SSH access")
  Ssh,

  @doc("Web access")
  Web,
}

@doc("Identity Set resource definition")
model IdentitySetResource is TrackedResource<IdentitySetResourceProperties> {
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
