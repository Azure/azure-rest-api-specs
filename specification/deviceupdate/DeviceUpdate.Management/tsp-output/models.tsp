import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.DeviceUpdate;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("Provisioning state.")
enum ProvisioningState {
  Succeeded,
  Deleted,
  Failed,
  Canceled,
  Accepted,
  Creating,
}

@doc("Whether or not public network access is allowed for the account.")
enum PublicNetworkAccess {
  Enabled,
  Disabled,
}

@doc("The private endpoint connection status.")
enum PrivateEndpointServiceConnectionStatus {
  Pending,
  Approved,
  Rejected,
}

@doc("The current provisioning state.")
enum PrivateEndpointConnectionProvisioningState {
  Succeeded,
  Creating,
  Deleting,
  Failed,
}

@doc("Device Update Sku")
enum SKU {
  Free,
  Standard,
}

@doc("Whether the location is primary or failover")
enum Role {
  Primary,
  Failover,
}

@doc("Type of managed service identity (where both SystemAssigned and UserAssigned types are allowed).")
enum ManagedServiceIdentityType {
  None,
  SystemAssigned,
  UserAssigned,
  `SystemAssigned,UserAssigned`,
}

@doc("Authentication Type")
enum AuthenticationType {
  KeyBased,
}

@doc("The provisioning state of private link group ID.")
enum GroupIdProvisioningState {
  Succeeded,
  Failed,
  Canceled,
}

@doc("The current provisioning state.")
enum PrivateEndpointConnectionProxyProvisioningState {
  Succeeded,
  Creating,
  Deleting,
  Failed,
}

@doc("The check availability request body.")
model CheckNameAvailabilityRequest {
  @doc("The name of the resource for which availability needs to be checked.")
  name?: string;

  @doc("The resource type.")
  type?: string;
}

@doc("The check availability result.")
model CheckNameAvailabilityResponse {
  @doc("Indicates if the resource name is available.")
  nameAvailable?: boolean;

  @doc("The reason why the given name is not available.")
  reason?: CheckNameAvailabilityReason;

  @doc("Detailed reason why the given name is available.")
  message?: string;
}

@doc("Device Update account properties.")
model AccountProperties {
  @doc("Provisioning state.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("API host name.")
  @visibility("read")
  hostName?: string;

  @doc("Whether or not public network access is allowed for the account.")
  publicNetworkAccess?: PublicNetworkAccess;

  @doc("List of private endpoint connections associated with the account.")
  privateEndpointConnections?: PrivateEndpointConnection[];

  @doc("Device Update Sku")
  sku?: SKU;

  @doc("CMK encryption at rest properties")
  encryption?: Encryption;

  @doc("Device Update account primary and failover location details")
  @visibility("read")
  locations?: Location[];
}

@doc("Properties of the PrivateEndpointConnectProperties.")
model PrivateEndpointConnectionProperties {
  @doc("The resource of private end point.")
  privateEndpoint?: PrivateEndpoint;

  @doc("A collection of information about the state of the connection between service consumer and provider.")
  privateLinkServiceConnectionState: PrivateLinkServiceConnectionState;

  @doc("Array of group IDs.")
  groupIds?: string[];

  @doc("The provisioning state of the private endpoint connection resource.")
  @visibility("read")
  provisioningState?: PrivateEndpointConnectionProvisioningState;
}

@doc("The Private Endpoint resource.")
model PrivateEndpoint {
  @doc("The ARM identifier for Private Endpoint")
  @visibility("read")
  id?: string;
}

@doc("A collection of information about the state of the connection between service consumer and provider.")
model PrivateLinkServiceConnectionState {
  @doc("Indicates whether the connection has been Approved/Rejected/Removed by the owner of the service.")
  status?: PrivateEndpointServiceConnectionStatus;

  @doc("The reason for approval/rejection of the connection.")
  description?: string;

  @doc("A message indicating if changes on the service provider require any updates on the consumer.")
  actionsRequired?: string;
}

@doc("Common fields that are returned in the response for all Azure Resource Manager resources")
model Resource {
  @doc("Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}")
  @visibility("read")
  id?: string;

  @doc("The name of the resource")
  @visibility("read")
  name?: string;

  @doc("The type of the resource. E.g. \"Microsoft.Compute/virtualMachines\" or \"Microsoft.Storage/storageAccounts\"")
  @visibility("read")
  type?: string;

  @doc("Azure Resource Manager metadata containing createdBy and modifiedBy information.")
  @visibility("read")
  systemData?: SystemData;
}

@doc("The CMK encryption settings on the Device Update account.")
model Encryption {
  @doc("The URI of the key vault")
  keyVaultKeyUri?: string;

  @doc("The full resourceId of the user assigned identity to be used for key vault access. Identity has to be also assigned to the Account")
  userAssignedIdentity?: string;
}

model Location {
  name?: string;

  @doc("Whether the location is primary or failover")
  role?: Role;
}

@doc("Request payload used to update and existing Accounts.")
model AccountUpdate {
  @doc("The type of identity used for the resource.")
  identity?: ManagedServiceIdentity;

  @doc("The geo-location where the resource lives")
  location?: string;

  @doc("List of key value pairs that describe the resource. This will overwrite the existing tags.")
  tags?: Record<string>;
}

@doc("Device Update instance properties.")
model InstanceProperties {
  @doc("Provisioning state.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Parent Device Update Account name which Instance belongs to.")
  @visibility("read")
  accountName?: string;

  @doc("List of IoT Hubs associated with the account.")
  iotHubs?: IotHubSettings[];

  @doc("Enables or Disables the diagnostic logs collection")
  enableDiagnostics?: boolean;

  @doc("Customer-initiated diagnostic log collection storage properties")
  diagnosticStorageProperties?: DiagnosticStorageProperties;
}

@doc("Device Update account integration with IoT Hub settings.")
model IotHubSettings {
  @doc("IoTHub resource ID")
  @maxLength(244)
  @minLength(108)
  resourceId: string;
}

@doc("Customer-initiated diagnostic log collection storage properties")
model DiagnosticStorageProperties {
  @doc("Authentication Type")
  authenticationType: AuthenticationType;

  @doc("ConnectionString of the diagnostic storage account")
  connectionString?: string;

  @doc("ResourceId of the diagnostic storage account")
  resourceId: string;
}

@doc("Request payload used to update an existing resource's tags.")
model TagUpdate {
  @doc("List of key value pairs that describe the resource. This will overwrite the existing tags.")
  tags?: Record<string>;
}

@doc("The properties for a group information object")
model GroupInformationProperties extends PrivateLinkResourceProperties {
  @doc("The provisioning state of private link group ID.")
  @visibility("read")
  provisioningState?: GroupIdProvisioningState;
}

@doc("Properties of a private link resource.")
model PrivateLinkResourceProperties {
  @doc("The private link resource group id.")
  @visibility("read")
  groupId?: string;

  @doc("The private link resource required member names.")
  @visibility("read")
  requiredMembers?: string[];

  @doc("The private link resource Private link DNS zone name.")
  requiredZoneNames?: string[];
}

@doc("Private endpoint connection proxy object property bag.")
model PrivateEndpointConnectionProxyProperties {
  @doc("The provisioning state of the private endpoint connection proxy resource.")
  @visibility("read")
  provisioningState?: PrivateEndpointConnectionProxyProvisioningState;
}

@doc("Private endpoint connection proxy object properties.")
model PrivateEndpointConnectionProxyProperties {
  @doc("ETag from NRP.")
  @visibility("read")
  eTag?: string;

  @doc("Remote private endpoint details.")
  remotePrivateEndpoint?: RemotePrivateEndpoint;

  @doc("Operation status.")
  status?: string;
}

@doc("Remote private endpoint details.")
model RemotePrivateEndpoint {
  @doc("Remote endpoint resource ID.")
  id?: string;

  @doc("ARM location of the remote private endpoint.")
  location?: string;

  @doc("Original subscription ID needed by Microsoft.Network.")
  immutableSubscriptionId?: string;

  @doc("Original resource ID needed by Microsoft.Network.")
  immutableResourceId?: string;

  @doc("Virtual network traffic tag.")
  vnetTrafficTag?: string;

  @doc("List of private link service connections that need manual approval.")
  manualPrivateLinkServiceConnections?: PrivateLinkServiceConnection[];

  @doc("List of automatically approved private link service connections.")
  privateLinkServiceConnections?: PrivateLinkServiceConnection[];

  @doc("List of private link service proxies.")
  privateLinkServiceProxies?: PrivateLinkServiceProxy[];

  @doc("List of connection details.")
  connectionDetails?: ConnectionDetails[];
}

@doc("Private link service connection details.")
model PrivateLinkServiceConnection {
  @doc("Private link service connection name.")
  name?: string;

  @doc("List of group IDs.")
  groupIds?: string[];

  @doc("Request message.")
  requestMessage?: string;
}

@doc("Private link service proxy details.")
model PrivateLinkServiceProxy {
  @doc("NRP resource ID.")
  id?: string;

  @doc("Remote private link service connection state")
  remotePrivateLinkServiceConnectionState?: PrivateLinkServiceConnectionState;

  @doc("Remote private endpoint connection details.")
  remotePrivateEndpointConnection?: PrivateLinkServiceProxyRemotePrivateEndpointConnection;

  @doc("Group connectivity information.")
  groupConnectivityInformation?: GroupConnectivityInformation[];
}

@doc("Remote private endpoint connection details.")
model PrivateLinkServiceProxyRemotePrivateEndpointConnection
  extends RemotePrivateEndpointConnection {}

@doc("Remote private endpoint connection details.")
model RemotePrivateEndpointConnection {
  @doc("Remote private endpoint connection ID.")
  @visibility("read")
  id?: string;
}

@doc("Group connectivity details.")
model GroupConnectivityInformation {
  @doc("Group ID.")
  @visibility("read")
  groupId?: string;

  @doc("Member name.")
  @visibility("read")
  memberName?: string;

  @doc("List of customer visible FQDNs.")
  customerVisibleFqdns?: string[];

  @doc("Internal FQDN.")
  @visibility("read")
  internalFqdn?: string;

  @doc("Redirect map ID.")
  redirectMapId?: string;

  @doc("PrivateLinkService ARM region.")
  privateLinkServiceArmRegion?: string;
}

@doc("Private endpoint connection proxy object properties.")
model ConnectionDetails {
  @doc("Connection details ID.")
  @visibility("read")
  id?: string;

  @doc("Private IP address.")
  @visibility("read")
  privateIpAddress?: string;

  @doc("Link ID.")
  @visibility("read")
  linkIdentifier?: string;

  @doc("Group ID.")
  @visibility("read")
  groupId?: string;

  @doc("Member name.")
  @visibility("read")
  memberName?: string;
}

@doc("Private endpoint update details.")
model PrivateEndpointUpdate {
  @doc("Remote endpoint resource ID.")
  id?: string;

  @doc("ARM location of the remote private endpoint.")
  location?: string;

  @doc("Original subscription ID needed by Microsoft.Network.")
  immutableSubscriptionId?: string;

  @doc("Original resource ID needed by Microsoft.Network.")
  immutableResourceId?: string;

  @doc("Virtual network traffic tag.")
  vnetTrafficTag?: string;
}
