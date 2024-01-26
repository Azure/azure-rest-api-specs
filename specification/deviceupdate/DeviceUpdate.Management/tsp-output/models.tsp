import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.DeviceUpdate;

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * Provisioning state.
 */
enum ProvisioningState {
  Succeeded,
  Deleted,
  Failed,
  Canceled,
  Accepted,
  Creating,
}

/**
 * Whether or not public network access is allowed for the account.
 */
enum PublicNetworkAccess {
  Enabled,
  Disabled,
}

/**
 * The private endpoint connection status.
 */
enum PrivateEndpointServiceConnectionStatus {
  Pending,
  Approved,
  Rejected,
}

/**
 * The current provisioning state.
 */
enum PrivateEndpointConnectionProvisioningState {
  Succeeded,
  Creating,
  Deleting,
  Failed,
}

/**
 * Device Update Sku
 */
enum SKU {
  Free,
  Standard,
}

/**
 * Whether the location is primary or failover
 */
enum Role {
  Primary,
  Failover,
}

/**
 * Type of managed service identity (where both SystemAssigned and UserAssigned types are allowed).
 */
enum ManagedServiceIdentityType {
  None,
  SystemAssigned,
  UserAssigned,
  `SystemAssigned,UserAssigned`,
}

/**
 * Authentication Type
 */
enum AuthenticationType {
  KeyBased,
}

/**
 * The provisioning state of private link group ID.
 */
enum GroupIdProvisioningState {
  Succeeded,
  Failed,
  Canceled,
}

/**
 * The current provisioning state.
 */
enum PrivateEndpointConnectionProxyProvisioningState {
  Succeeded,
  Creating,
  Deleting,
  Failed,
}

/**
 * The check availability request body.
 */
model CheckNameAvailabilityRequest {
  /**
   * The name of the resource for which availability needs to be checked.
   */
  name?: string;

  /**
   * The resource type.
   */
  type?: string;
}

/**
 * The check availability result.
 */
model CheckNameAvailabilityResponse {
  /**
   * Indicates if the resource name is available.
   */
  nameAvailable?: boolean;

  /**
   * The reason why the given name is not available.
   */
  reason?: CheckNameAvailabilityReason;

  /**
   * Detailed reason why the given name is available.
   */
  message?: string;
}

/**
 * Device Update account properties.
 */
model AccountProperties {
  /**
   * Provisioning state.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * API host name.
   */
  @visibility("read")
  hostName?: string;

  /**
   * Whether or not public network access is allowed for the account.
   */
  publicNetworkAccess?: PublicNetworkAccess = PublicNetworkAccess.Enabled;

  /**
   * List of private endpoint connections associated with the account.
   */
  privateEndpointConnections?: PrivateEndpointConnection[];

  /**
   * Device Update Sku
   */
  sku?: SKU = SKU.Standard;

  /**
   * CMK encryption at rest properties
   */
  encryption?: Encryption;

  /**
   * Device Update account primary and failover location details
   */
  @visibility("read")
  locations?: Location[];
}

/**
 * Properties of the PrivateEndpointConnectProperties.
 */
model PrivateEndpointConnectionProperties {
  /**
   * The resource of private end point.
   */
  privateEndpoint?: PrivateEndpoint;

  /**
   * A collection of information about the state of the connection between service consumer and provider.
   */
  privateLinkServiceConnectionState: PrivateLinkServiceConnectionState;

  /**
   * Array of group IDs.
   */
  groupIds?: string[];

  /**
   * The provisioning state of the private endpoint connection resource.
   */
  @visibility("read")
  provisioningState?: PrivateEndpointConnectionProvisioningState;
}

/**
 * The Private Endpoint resource.
 */
model PrivateEndpoint {
  /**
   * The ARM identifier for Private Endpoint
   */
  @visibility("read")
  id?: string;
}

/**
 * A collection of information about the state of the connection between service consumer and provider.
 */
model PrivateLinkServiceConnectionState {
  /**
   * Indicates whether the connection has been Approved/Rejected/Removed by the owner of the service.
   */
  status?: PrivateEndpointServiceConnectionStatus;

  /**
   * The reason for approval/rejection of the connection.
   */
  description?: string;

  /**
   * A message indicating if changes on the service provider require any updates on the consumer.
   */
  actionsRequired?: string;
}

/**
 * Common fields that are returned in the response for all Azure Resource Manager resources
 */
model Resource {
  /**
   * Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}
   */
  @visibility("read")
  id?: string;

  /**
   * The name of the resource
   */
  @visibility("read")
  name?: string;

  /**
   * The type of the resource. E.g. "Microsoft.Compute/virtualMachines" or "Microsoft.Storage/storageAccounts"
   */
  @visibility("read")
  type?: string;

  /**
   * Azure Resource Manager metadata containing createdBy and modifiedBy information.
   */
  @visibility("read")
  systemData?: SystemData;
}

/**
 * The CMK encryption settings on the Device Update account.
 */
model Encryption {
  /**
   * The URI of the key vault
   */
  keyVaultKeyUri?: string;

  /**
   * The full resourceId of the user assigned identity to be used for key vault access. Identity has to be also assigned to the Account
   */
  userAssignedIdentity?: string;
}

model Location {
  name?: string;

  /**
   * Whether the location is primary or failover
   */
  role?: Role = Role.Primary;
}

/**
 * Request payload used to update and existing Accounts.
 */
model AccountUpdate {
  /**
   * The type of identity used for the resource.
   */
  identity?: ManagedServiceIdentity;

  /**
   * The geo-location where the resource lives
   */
  location?: string;

  /**
   * List of key value pairs that describe the resource. This will overwrite the existing tags.
   */
  tags?: Record<string>;
}

/**
 * Device Update instance properties.
 */
model InstanceProperties {
  /**
   * Provisioning state.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * Parent Device Update Account name which Instance belongs to.
   */
  @visibility("read")
  accountName?: string;

  /**
   * List of IoT Hubs associated with the account.
   */
  iotHubs?: IotHubSettings[];

  /**
   * Enables or Disables the diagnostic logs collection
   */
  enableDiagnostics?: boolean;

  /**
   * Customer-initiated diagnostic log collection storage properties
   */
  diagnosticStorageProperties?: DiagnosticStorageProperties;
}

/**
 * Device Update account integration with IoT Hub settings.
 */
model IotHubSettings {
  /**
   * IoTHub resource ID
   */
  @maxLength(244)
  @minLength(108)
  resourceId: string;
}

/**
 * Customer-initiated diagnostic log collection storage properties
 */
model DiagnosticStorageProperties {
  /**
   * Authentication Type
   */
  authenticationType: AuthenticationType;

  /**
   * ConnectionString of the diagnostic storage account
   */
  connectionString?: string;

  /**
   * ResourceId of the diagnostic storage account
   */
  resourceId: string;
}

/**
 * Request payload used to update an existing resource's tags.
 */
model TagUpdate {
  /**
   * List of key value pairs that describe the resource. This will overwrite the existing tags.
   */
  tags?: Record<string>;
}

/**
 * The properties for a group information object
 */
model GroupInformationProperties extends PrivateLinkResourceProperties {
  /**
   * The provisioning state of private link group ID.
   */
  @visibility("read")
  provisioningState?: GroupIdProvisioningState;
}

/**
 * Properties of a private link resource.
 */
model PrivateLinkResourceProperties {
  /**
   * The private link resource group id.
   */
  @visibility("read")
  groupId?: string;

  /**
   * The private link resource required member names.
   */
  @visibility("read")
  requiredMembers?: string[];

  /**
   * The private link resource Private link DNS zone name.
   */
  requiredZoneNames?: string[];
}

/**
 * Private endpoint connection proxy object property bag.
 */
model PrivateEndpointConnectionProxyProperties {
  /**
   * The provisioning state of the private endpoint connection proxy resource.
   */
  @visibility("read")
  provisioningState?: PrivateEndpointConnectionProxyProvisioningState;
}

/**
 * Private endpoint connection proxy object properties.
 */
model PrivateEndpointConnectionProxyProperties {
  /**
   * ETag from NRP.
   */
  @visibility("read")
  eTag?: string;

  /**
   * Remote private endpoint details.
   */
  remotePrivateEndpoint?: RemotePrivateEndpoint;

  /**
   * Operation status.
   */
  status?: string;
}

/**
 * Remote private endpoint details.
 */
model RemotePrivateEndpoint {
  /**
   * Remote endpoint resource ID.
   */
  id?: string;

  /**
   * ARM location of the remote private endpoint.
   */
  location?: string;

  /**
   * Original subscription ID needed by Microsoft.Network.
   */
  immutableSubscriptionId?: string;

  /**
   * Original resource ID needed by Microsoft.Network.
   */
  immutableResourceId?: string;

  /**
   * Virtual network traffic tag.
   */
  vnetTrafficTag?: string;

  /**
   * List of private link service connections that need manual approval.
   */
  manualPrivateLinkServiceConnections?: PrivateLinkServiceConnection[];

  /**
   * List of automatically approved private link service connections.
   */
  privateLinkServiceConnections?: PrivateLinkServiceConnection[];

  /**
   * List of private link service proxies.
   */
  privateLinkServiceProxies?: PrivateLinkServiceProxy[];

  /**
   * List of connection details.
   */
  connectionDetails?: ConnectionDetails[];
}

/**
 * Private link service connection details.
 */
model PrivateLinkServiceConnection {
  /**
   * Private link service connection name.
   */
  name?: string;

  /**
   * List of group IDs.
   */
  groupIds?: string[];

  /**
   * Request message.
   */
  requestMessage?: string;
}

/**
 * Private link service proxy details.
 */
model PrivateLinkServiceProxy {
  /**
   * NRP resource ID.
   */
  id?: string;

  /**
   * Remote private link service connection state
   */
  remotePrivateLinkServiceConnectionState?: PrivateLinkServiceConnectionState;

  /**
   * Remote private endpoint connection details.
   */
  remotePrivateEndpointConnection?: PrivateLinkServiceProxyRemotePrivateEndpointConnection;

  /**
   * Group connectivity information.
   */
  groupConnectivityInformation?: GroupConnectivityInformation[];
}

/**
 * Remote private endpoint connection details.
 */
model PrivateLinkServiceProxyRemotePrivateEndpointConnection
  extends RemotePrivateEndpointConnection {}

/**
 * Remote private endpoint connection details.
 */
model RemotePrivateEndpointConnection {
  /**
   * Remote private endpoint connection ID.
   */
  @visibility("read")
  id?: string;
}

/**
 * Group connectivity details.
 */
model GroupConnectivityInformation {
  /**
   * Group ID.
   */
  @visibility("read")
  groupId?: string;

  /**
   * Member name.
   */
  @visibility("read")
  memberName?: string;

  /**
   * List of customer visible FQDNs.
   */
  customerVisibleFqdns?: string[];

  /**
   * Internal FQDN.
   */
  @visibility("read")
  internalFqdn?: string;

  /**
   * Redirect map ID.
   */
  redirectMapId?: string;

  /**
   * PrivateLinkService ARM region.
   */
  privateLinkServiceArmRegion?: string;
}

/**
 * Private endpoint connection proxy object properties.
 */
model ConnectionDetails {
  /**
   * Connection details ID.
   */
  @visibility("read")
  id?: string;

  /**
   * Private IP address.
   */
  @visibility("read")
  privateIpAddress?: string;

  /**
   * Link ID.
   */
  @visibility("read")
  linkIdentifier?: string;

  /**
   * Group ID.
   */
  @visibility("read")
  groupId?: string;

  /**
   * Member name.
   */
  @visibility("read")
  memberName?: string;
}

/**
 * Private endpoint update details.
 */
model PrivateEndpointUpdate {
  /**
   * Remote endpoint resource ID.
   */
  id?: string;

  /**
   * ARM location of the remote private endpoint.
   */
  location?: string;

  /**
   * Original subscription ID needed by Microsoft.Network.
   */
  immutableSubscriptionId?: string;

  /**
   * Original resource ID needed by Microsoft.Network.
   */
  immutableResourceId?: string;

  /**
   * Virtual network traffic tag.
   */
  vnetTrafficTag?: string;
}
