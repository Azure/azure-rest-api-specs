import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;

namespace DeviceUpdate;

enum CheckNameAvailabilityReason {
  Invalid,
  AlreadyExists,
}

enum ProvisioningState {
  Succeeded,
  Deleted,
  Failed,
  Canceled,
  Accepted,
  Creating,
}

enum PublicNetworkAccess {
  Enabled,
  Disabled,
}

enum PrivateEndpointServiceConnectionStatus {
  Pending,
  Approved,
  Rejected,
}

enum PrivateEndpointConnectionProvisioningState {
  Succeeded,
  Creating,
  Deleting,
  Failed,
}

enum CreatedByType {
  User,
  Application,
  ManagedIdentity,
  Key,
}

enum SKU {
  Free,
  Standard,
}

enum Role {
  Primary,
  Failover,
}

enum ManagedServiceIdentityType {
  None,
  SystemAssigned,
  UserAssigned,
  `SystemAssigned,UserAssigned`,
}

enum AuthenticationType {
  KeyBased,
}

enum GroupIdProvisioningState {
  Succeeded,
  Failed,
  Canceled,
}

enum PrivateEndpointConnectionProxyProvisioningState {
  Succeeded,
  Creating,
  Deleting,
  Failed,
}

enum Origin {
  user,
  system,
  `user,system`,
}

enum ActionType {
  Internal,
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

@doc("""
Common error response for all Azure Resource Manager APIs to return error
details for failed operations. (This also follows the OData error response
format.).
""")
@error
model ErrorResponse {
  @doc("The error object.")
  error?: ErrorDetail;
}

@doc("The error detail.")
model ErrorDetail {
  @doc("The error code.")
  @visibility("read")
  code?: string;

  @doc("The error message.")
  @visibility("read")
  message?: string;

  @doc("The error target.")
  @visibility("read")
  target?: string;

  @doc("The error details.")
  @visibility("read")
  details?: ErrorDetail[];

  @doc("The error additional info.")
  @visibility("read")
  additionalInfo?: ErrorAdditionalInfo[];
}

@doc("The resource management error additional info.")
model ErrorAdditionalInfo {
  @doc("The additional info type.")
  @visibility("read")
  type?: string;

  @doc("The additional info.")
  @visibility("read")
  info?: unknown;
}

@doc("List of Accounts.")
model AccountList is Azure.Core.Page<Account>;

@doc("Device Update account details.")
model Account {
  ...TrackedResource;

  @doc("Device Update account properties.")
  properties?: AccountProperties;

  @doc("The type of identity used for the resource.")
  identity?: ManagedServiceIdentity;
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

  @doc("Device Update account primary and failover location details")
  @visibility("read")
  locations?: Location[];
}

@doc("The Private Endpoint Connection resource.")
model PrivateEndpointConnection {
  ...Resource;

  @doc("Resource properties.")
  properties: PrivateEndpointConnectionProperties;
}

@doc("Properties of the PrivateEndpointConnectProperties.")
model PrivateEndpointConnectionProperties {
  @doc("The resource of private end point.")
  privateEndpoint?: PrivateEndpoint;

  @doc("""
A collection of information about the state of the connection between service
consumer and provider.
""")
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

@doc("""
A collection of information about the state of the connection between service
consumer and provider.
""")
model PrivateLinkServiceConnectionState {
  @doc("""
Indicates whether the connection has been Approved/Rejected/Removed by the
owner of the service.
""")
  status?: PrivateEndpointServiceConnectionStatus;

  @doc("The reason for approval/rejection of the connection.")
  description?: string;

  @doc("""
A message indicating if changes on the service provider require any updates on
the consumer.
""")
  actionsRequired?: string;
}

@doc("""
Common fields that are returned in the response for all Azure Resource Manager
resources
""")
model Resource {
  @doc("""
Fully qualified resource ID for the resource. Ex -
/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}
""")
  @visibility("read")
  id?: string;

  @doc("The name of the resource")
  @visibility("read")
  name?: string;

  @doc("""
The type of the resource. E.g. \"Microsoft.Compute/virtualMachines\" or
\"Microsoft.Storage/storageAccounts\"
""")
  @visibility("read")
  type?: string;

  @doc("Azure Resource Manager metadata containing createdBy and modifiedBy information.")
  @visibility("read")
  systemData?: SystemData;
}

@doc("Metadata pertaining to creation and last modification of the resource.")
model SystemData {
  @doc("The identity that created the resource.")
  createdBy?: string;

  @doc("The type of identity that created the resource.")
  createdByType?: CreatedByType;

  @doc("The timestamp of resource creation (UTC).")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdAt?: utcDateTime;

  @doc("The identity that last modified the resource.")
  lastModifiedBy?: string;

  @doc("The type of identity that last modified the resource.")
  lastModifiedByType?: CreatedByType;

  @doc("The timestamp of resource last modification (UTC)")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedAt?: utcDateTime;
}

model Location {
  name?: string;

  @doc("Whether the location is primary or failover")
  role?: Role;
}

@doc("Managed service identity (system assigned and/or user assigned identities)")
model ManagedServiceIdentity {
  @doc("""
The service principal ID of the system assigned identity. This property will
only be provided for a system assigned identity.
""")
  @visibility("read")
  principalId?: string;

  @doc("""
The tenant ID of the system assigned identity. This property will only be
provided for a system assigned identity.
""")
  @visibility("read")
  tenantId?: string;

  @doc("""
Type of managed service identity (where both SystemAssigned and UserAssigned
types are allowed).
""")
  type: ManagedServiceIdentityType;

  @doc("""
The set of user assigned identities associated with the resource. The
userAssignedIdentities dictionary keys will be ARM resource ids in the form:
'/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{identityName}.
The dictionary values can be empty objects ({}) in requests.
""")
  userAssignedIdentities?: Record<UserAssignedIdentity>;
}

@doc("User assigned identity properties")
model UserAssignedIdentity {
  @doc("The principal ID of the assigned identity.")
  @visibility("read")
  principalId?: string;

  @doc("The client ID of the assigned identity.")
  @visibility("read")
  clientId?: string;
}

@doc("""
The resource model definition for an Azure Resource Manager tracked top level
resource which has 'tags' and a 'location'
""")
model TrackedResource {
  ...Resource;

  @doc("Resource tags.")
  tags?: Record<string>;

  @doc("The geo-location where the resource lives")
  location: string;
}

@doc("Request payload used to update and existing Accounts.")
model AccountUpdate {
  ...TagUpdate;

  @doc("The type of identity used for the resource.")
  identity?: ManagedServiceIdentity;

  @doc("The geo-location where the resource lives")
  location?: string;
}

@doc("Request payload used to update an existing resource's tags.")
model TagUpdate {
  @doc("""
List of key value pairs that describe the resource. This will overwrite the
existing tags.
""")
  tags?: Record<string>;
}

@doc("List of Instances.")
model InstanceList is Azure.Core.Page<Instance>;

@doc("Device Update instance details.")
model Instance {
  ...TrackedResource;

  @doc("Device Update instance properties.")
  properties: InstanceProperties;
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

@doc("""
List of private endpoint connection associated with the specified storage
account
""")
@pagedResult
model PrivateEndpointConnectionListResult {
  @doc("Array of private endpoint connections")
  @items
  value?: PrivateEndpointConnection[];
}

@doc("The available private link resources for an Account")
model PrivateLinkResourceListResult is Azure.Core.Page<GroupInformation>;

@doc("The group information for creating a private endpoint on an Account")
model GroupInformation {
  ...ProxyResource;

  @doc("The properties for a group information object")
  properties: GroupInformationProperties;
}

@doc("The properties for a group information object")
model GroupInformationProperties {
  ...PrivateLinkResourceProperties;

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

@doc("""
The resource model definition for a Azure Resource Manager proxy resource. It
will not have tags and a location
""")
model ProxyResource {
  ...Resource;
}

@doc("""
The available private endpoint connection proxies for an Account (not to be
used by anyone, here because of ARM requirements)
""")
model PrivateEndpointConnectionProxyListResult
  is Azure.Core.Page<PrivateEndpointConnectionProxy>;

@doc("Private endpoint connection proxy details.")
model PrivateEndpointConnectionProxy {
  ...ProxyResource;
  ...PrivateEndpointConnectionProxyProperties;

  @doc("Private endpoint connection proxy object property bag.")
  properties?: PrivateEndpointConnectionProxyProperties;
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
model PrivateLinkServiceProxyRemotePrivateEndpointConnection {
  ...RemotePrivateEndpointConnection;
}

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

@doc("""
A list of REST API operations supported by an Azure Resource Provider. It
contains an URL link to get the next set of results.
""")
model OperationListResult is Azure.Core.Page<Operation>;

@doc("""
Details of a REST API operation, returned from the Resource Provider Operations
API
""")
model Operation {
  @doc("""
The name of the operation, as per Resource-Based Access Control (RBAC).
Examples: \"Microsoft.Compute/virtualMachines/write\",
\"Microsoft.Compute/virtualMachines/capture/action\"
""")
  @visibility("read")
  name?: string;

  @doc("""
Whether the operation applies to data-plane. This is \"true\" for data-plane
operations and \"false\" for ARM/control-plane operations.
""")
  @visibility("read")
  isDataAction?: boolean;

  @doc("Localized display information for this particular operation.")
  display?: OperationDisplay;

  @doc("""
The intended executor of the operation; as in Resource Based Access Control
(RBAC) and audit logs UX. Default value is \"user,system\"
""")
  @visibility("read")
  origin?: Origin;

  @doc("""
Enum. Indicates the action type. \"Internal\" refers to actions that are for
internal only APIs.
""")
  @visibility("read")
  actionType?: ActionType;
}

@doc("Localized display information for this particular operation.")
model OperationDisplay {
  @doc("""
The localized friendly form of the resource provider name, e.g. \"Microsoft
Monitoring Insights\" or \"Microsoft Compute\".
""")
  @visibility("read")
  provider?: string;

  @doc("""
The localized friendly name of the resource type related to this operation.
E.g. \"Virtual Machines\" or \"Job Schedule Collections\".
""")
  @visibility("read")
  resource?: string;

  @doc("""
The concise, localized friendly name for the operation; suitable for dropdowns.
E.g. \"Create or Update Virtual Machine\", \"Restart Virtual Machine\".
""")
  @visibility("read")
  operation?: string;

  @doc("""
The short, localized friendly description of the operation; suitable for tool
tips and detailed views.
""")
  @visibility("read")
  description?: string;
}
