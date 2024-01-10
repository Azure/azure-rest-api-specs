import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.SignalRService;

interface Operations extends Azure.ResourceManager.Operations {}

enum WebPubSubSkuTier {
  Free,
  Basic,
  Standard,
  Premium,
}

enum WebPubSubProvisioningState {
  Unknown,
  Succeeded,
  Failed,
  Canceled,
  Running,
  Creating,
  Updating,
  Deleting,
  Moving,
}

enum CreatedByType {
  User,
  Application,
  ManagedIdentity,
  Key,
}

enum WebPubSubPrivateLinkServiceConnectionStatus {
  Pending,
  Approved,
  Rejected,
  Disconnected,
}

enum WebPubSubSharedPrivateLinkStatus {
  Pending,
  Approved,
  Rejected,
  Disconnected,
  Timeout,
}

enum ACLAction {
  Allow,
  Deny,
}

enum WebPubSubRequestType {
  ClientConnection,
  ServerConnection,
  RESTAPI,
  Trace,
}

enum ManagedIdentityType {
  None,
  SystemAssigned,
  UserAssigned,
}

enum UpstreamAuthType {
  None,
  ManagedIdentity,
}

enum WebPubSubKeyType {
  Primary,
  Secondary,
  Salt,
}

enum WebPubSubScaleType {
  None,
  Manual,
  Automatic,
}

@doc("Extra Operation properties.")
model OperationProperties {
  @doc("An object that describes a specification.")
  serviceSpecification?: ServiceSpecification;
}

@doc("An object that describes a specification.")
model ServiceSpecification {
  @doc("Specifications of the Metrics for Azure Monitoring.")
  metricSpecifications?: MetricSpecification[];

  @doc("Specifications of the Logs for Azure Monitoring.")
  logSpecifications?: LogSpecification[];
}

@doc("Specifications of the Metrics for Azure Monitoring.")
model MetricSpecification {
  @doc("Name of the metric.")
  name?: string;

  @doc("Localized friendly display name of the metric.")
  displayName?: string;

  @doc("Localized friendly description of the metric.")
  displayDescription?: string;

  @doc("The unit that makes sense for the metric.")
  unit?: string;

  @doc("Only provide one value for this field. Valid values: Average, Minimum, Maximum, Total, Count.")
  aggregationType?: string;

  @doc("""
Optional. If set to true, then zero will be returned for time duration where no metric is emitted/published. 
Ex. a metric that returns the number of times a particular error code was emitted. The error code may not appear 
often, instead of the RP publishing 0, Shoebox can auto fill in 0s for time periods where nothing was emitted.
""")
  fillGapWithZero?: string;

  @doc("The name of the metric category that the metric belongs to. A metric can only belong to a single category.")
  category?: string;

  @doc("The dimensions of the metrics.")
  dimensions?: Dimension[];
}

@doc("Specifications of the Dimension of metrics.")
model Dimension {
  @doc("The public facing name of the dimension.")
  name?: string;

  @doc("Localized friendly display name of the dimension.")
  displayName?: string;

  @doc("Name of the dimension as it appears in MDM.")
  internalName?: string;

  @doc("A Boolean flag indicating whether this dimension should be included for the shoebox export scenario.")
  toBeExportedForShoebox?: boolean;
}

@doc("Specifications of the Logs for Azure Monitoring.")
model LogSpecification {
  @doc("Name of the log.")
  name?: string;

  @doc("Localized friendly display name of the log.")
  displayName?: string;
}

@doc("Data POST-ed to the nameAvailability action")
model WebPubSubNameAvailabilityParameters {
  @doc("The resource type. Can be \"Microsoft.SignalRService/SignalR\" or \"Microsoft.SignalRService/webPubSub\"")
  type: string;

  @doc("The resource name to validate. e.g.\"my-resource-name\"")
  name: string;
}

@doc("Result of the request to check name availability. It contains a flag and possible reason of failure.")
model WebPubSubNameAvailability {
  @doc("Indicates whether the name is available or not.")
  nameAvailable?: boolean;

  @doc("The reason of the availability. Required if name is not available.")
  reason?: string;

  @doc("The message of the operation.")
  message?: string;
}

@doc("Object that includes an array of the resource usages and a possible link for next set.")
model SignalRServiceUsageList is Azure.Core.Page<SignalRServiceUsage>;

@doc("Object that describes a specific usage of the resources.")
model SignalRServiceUsage {
  @doc("Fully qualified ARM resource id")
  id?: string;

  @doc("Current value for the usage quota.")
  currentValue?: int32;

  @doc("The maximum permitted value for the usage quota. If there is no limit, this value will be -1.")
  limit?: int32;

  @doc("Localizable String object containing the name and a localized value.")
  name?: SignalRServiceUsageName;

  @doc("Representing the units of the usage quota. Possible values are: Count, Bytes, Seconds, Percent, CountPerSecond, BytesPerSecond.")
  unit?: string;
}

@doc("Localizable String object containing the name and a localized value.")
model SignalRServiceUsageName {
  @doc("The identifier of the usage.")
  value?: string;

  @doc("Localized name of the usage.")
  localizedValue?: string;
}

@doc("The billing information of the resource.")
model BillingInfoSku {
  @doc("""
The name of the SKU. Required.

Allowed values: Standard_S1, Free_F1
""")
  name: string;

  @doc("""
Optional tier of this particular SKU. 'Standard' or 'Free'. 

`Basic` is deprecated, use `Standard` instead.
""")
  tier?: WebPubSubSkuTier;

  @doc("Not used. Retained for future use.")
  @visibility("read")
  size?: string;

  @doc("Not used. Retained for future use.")
  @visibility("read")
  family?: string;

  @doc("""
Optional, integer. The unit count of the resource. 1 by default.

If present, following values are allowed:
    Free: 1
    Standard: 1,2,5,10,20,50,100
""")
  capacity?: int32;
}

@doc("A class that describes the properties of the resource")
model WebPubSubProperties {
  @doc("Provisioning state of the resource.")
  @visibility("read")
  provisioningState?: WebPubSubProvisioningState;

  @doc("The publicly accessible IP of the resource.")
  @visibility("read")
  externalIP?: string;

  @doc("FQDN of the service instance.")
  @visibility("read")
  hostName?: string;

  @doc("The publicly accessible port of the resource which is designed for browser/client side usage.")
  @visibility("read")
  publicPort?: int32;

  @doc("The publicly accessible port of the resource which is designed for customer server side usage.")
  @visibility("read")
  serverPort?: int32;

  @doc("Version of the resource. Probably you need the same or higher version of client SDKs.")
  @visibility("read")
  version?: string;

  @doc("Private endpoint connections to the resource.")
  @visibility("read")
  privateEndpointConnections?: PrivateEndpointConnection[];

  @doc("The list of shared private link resources.")
  @visibility("read")
  sharedPrivateLinkResources?: WebPubSubSharedPrivateLink[];

  @doc("TLS settings for the resource")
  tls?: WebPubSubTlsSettings;

  @doc("Deprecated.")
  @visibility("read")
  hostNamePrefix?: string;

  @doc("Live trace configuration of a Microsoft.SignalRService resource.")
  liveTraceConfiguration?: LiveTraceConfiguration;

  @doc("Resource log configuration of a Microsoft.SignalRService resource.")
  resourceLogConfiguration?: ResourceLogConfiguration;

  @doc("Network ACLs for the resource")
  networkACLs?: WebPubSubNetworkACLs;

  @doc("""
Enable or disable public network access. Default to \"Enabled\".
When it's Enabled, network ACLs still apply.
When it's Disabled, public network access is always disabled no matter what you set in network ACLs.
""")
  publicNetworkAccess?: string;

  @doc("""
DisableLocalAuth
Enable or disable local auth with AccessKey
When set as true, connection with AccessKey=xxx won't work.
""")
  @projectedName("json", "disableLocalAuth")
  isLocalAuthDisabled?: boolean;

  @doc("""
DisableLocalAuth
Enable or disable aad auth
When set as true, connection with AuthType=aad won't work.
""")
  @projectedName("json", "disableAadAuth")
  isAadAuthDisabled?: boolean;
}

@doc("Private endpoint connection properties")
model PrivateEndpointConnectionProperties {
  @doc("Provisioning state of the resource.")
  @visibility("read")
  provisioningState?: WebPubSubProvisioningState;

  @doc("Private endpoint")
  privateEndpoint?: PrivateEndpoint;

  @doc("Group IDs")
  @visibility("read")
  groupIds?: string[];

  @doc("Connection state of the private endpoint connection")
  privateLinkServiceConnectionState?: PrivateLinkServiceConnectionState;
}

@doc("Private endpoint")
model PrivateEndpoint {
  @doc("Full qualified Id of the private endpoint")
  id?: string;
}

@doc("Connection state of the private endpoint connection")
model PrivateLinkServiceConnectionState {
  @doc("Indicates whether the connection has been Approved/Rejected/Removed by the owner of the service.")
  status?: WebPubSubPrivateLinkServiceConnectionStatus;

  @doc("The reason for approval/rejection of the connection.")
  description?: string;

  @doc("A message indicating if changes on the service provider require any updates on the consumer.")
  actionsRequired?: string;
}

@doc("The core properties of ARM resources.")
model Resource {
  @doc("Fully qualified resource Id for the resource.")
  @visibility("read")
  id?: string;

  @doc("The name of the resource.")
  @visibility("read")
  name?: string;

  @doc("The type of the resource - e.g. \"Microsoft.SignalRService/SignalR\"")
  @visibility("read")
  type?: string;
}

@doc("Describes the properties of an existing Shared Private Link Resource")
model SharedPrivateLinkResourceProperties {
  @doc("The group id from the provider of resource the shared private link resource is for")
  groupId: string;

  @doc("The resource id of the resource the shared private link resource is for")
  privateLinkResourceId: string;

  @doc("Provisioning state of the resource.")
  @visibility("read")
  provisioningState?: WebPubSubProvisioningState;

  @doc("The request message for requesting approval of the shared private link resource")
  requestMessage?: string;

  @doc("Status of the shared private link resource")
  @visibility("read")
  status?: WebPubSubSharedPrivateLinkStatus;
}

@doc("TLS settings for the resource")
model WebPubSubTlsSettings {
  @doc("Request client certificate during TLS handshake if enabled")
  @projectedName("json", "clientCertEnabled")
  isClientCertEnabled?: boolean;
}

@doc("Live trace configuration of a Microsoft.SignalRService resource.")
model LiveTraceConfiguration {
  @doc("""
Indicates whether or not enable live trace.
When it's set to true, live trace client can connect to the service.
Otherwise, live trace client can't connect to the service, so that you are unable to receive any log, no matter what you configure in \"categories\".
Available values: true, false.
Case insensitive.
""")
  enabled?: string;

  @doc("Gets or sets the list of category configurations.")
  categories?: LiveTraceCategory[];
}

@doc("Live trace category configuration of a Microsoft.SignalRService resource.")
model LiveTraceCategory {
  @doc("""
Gets or sets the live trace category's name.
Available values: ConnectivityLogs, MessagingLogs.
Case insensitive.
""")
  name?: string;

  @doc("""
Indicates whether or the live trace category is enabled.
Available values: true, false.
Case insensitive.
""")
  enabled?: string;
}

@doc("Resource log configuration of a Microsoft.SignalRService resource.")
model ResourceLogConfiguration {
  @doc("Gets or sets the list of category configurations.")
  categories?: ResourceLogCategory[];
}

@doc("Resource log category configuration of a Microsoft.SignalRService resource.")
model ResourceLogCategory {
  @doc("""
Gets or sets the resource log category's name.
Available values: ConnectivityLogs, MessagingLogs.
Case insensitive.
""")
  name?: string;

  @doc("""
Indicates whether or the resource log category is enabled.
Available values: true, false.
Case insensitive.
""")
  enabled?: string;
}

@doc("Network ACLs for the resource")
model WebPubSubNetworkACLs {
  @doc("Azure Networking ACL Action.")
  defaultAction?: ACLAction;

  @doc("Network ACL")
  publicNetwork?: PublicNetworkAcls;

  @doc("ACLs for requests from private endpoints")
  privateEndpoints?: PrivateEndpointACL[];
}

@doc("Network ACL")
model PublicNetworkAcls {
  @doc("Allowed request types. The value can be one or more of: ClientConnection, ServerConnection, RESTAPI.")
  allow?: WebPubSubRequestType[];

  @doc("Denied request types. The value can be one or more of: ClientConnection, ServerConnection, RESTAPI.")
  deny?: WebPubSubRequestType[];
}

@doc("ACL for a private endpoint")
model PrivateEndpointACL extends PublicNetworkAcls {
  @doc("Name of the private endpoint connection")
  name: string;
}

@doc("A class represent managed identities used for request and response")
model ManagedIdentity {
  @doc("Represents the identity type: systemAssigned, userAssigned, None")
  type?: ManagedIdentityType;

  @doc("Get or set the user assigned identities")
  userAssignedIdentities?: Record<UserAssignedIdentityProperty>;

  @doc("""
Get the principal id for the system assigned identity.
Only be used in response.
""")
  @visibility("read")
  principalId?: string;

  @doc("""
Get the tenant id for the system assigned identity.
Only be used in response
""")
  @visibility("read")
  tenantId?: string;
}

@doc("Properties of user assigned identity.")
model UserAssignedIdentityProperty {
  @doc("Get the principal id for the user assigned identity")
  @visibility("read")
  principalId?: string;

  @doc("Get the client id for the user assigned identity")
  @visibility("read")
  clientId?: string;
}

@doc("Properties of a hub.")
model WebPubSubHubProperties {
  @doc("Event handler of a hub.")
  eventHandlers?: WebPubSubEventHandler[];

  @doc("The settings for configuring if anonymous connections are allowed for this hub: \"allow\" or \"deny\". Default to \"deny\".")
  anonymousConnectPolicy?: string;
}

@doc("Properties of event handler.")
model WebPubSubEventHandler {
  @doc("""
Gets or sets the EventHandler URL template. You can use a predefined parameter {hub} and {event} inside the template, the value of the EventHandler URL is dynamically calculated when the client request comes in.
For example, UrlTemplate can be `http://example.com/api/{hub}/{event}`. The host part can't contains parameters.
""")
  urlTemplate: string;

  @doc("""
Gets or sets the matching pattern for event names.
There are 3 kind of patterns supported:
    1. \"*\", it to matches any event name
    2. Combine multiple events with \",\", for example \"event1,event2\", it matches event \"event1\" and \"event2\"
    3. The single event name, for example, \"event1\", it matches \"event1\"
""")
  userEventPattern?: string;

  @doc("Gets ot sets the list of system events.")
  systemEvents?: string[];

  @doc("Upstream auth settings. If not set, no auth is used for upstream messages.")
  auth?: UpstreamAuthSettings;
}

@doc("Upstream auth settings. If not set, no auth is used for upstream messages.")
model UpstreamAuthSettings {
  @doc("Upstream auth type enum.")
  type?: UpstreamAuthType;

  @doc("Managed identity settings for upstream.")
  managedIdentity?: ManagedIdentitySettings;
}

@doc("Managed identity settings for upstream.")
model ManagedIdentitySettings {
  @doc("""
The Resource indicating the App ID URI of the target resource.
It also appears in the aud (audience) claim of the issued token.
""")
  resource?: string;
}

@doc("A class represents the access keys of the resource.")
model WebPubSubKeys {
  @doc("The primary access key.")
  primaryKey?: string;

  @doc("The secondary access key.")
  secondaryKey?: string;

  @doc("Connection string constructed via the primaryKey")
  primaryConnectionString?: string;

  @doc("Connection string constructed via the secondaryKey")
  secondaryConnectionString?: string;
}

@doc("Contains a list of PrivateLinkResource and a possible link to query more results")
model PrivateLinkResourceList is Azure.Core.Page<WebPubSubPrivateLink>;

@doc("Private link resource")
model WebPubSubPrivateLink extends ProxyResource {
  @doc("Private link resource properties")
  properties?: PrivateLinkResourceProperties;
}

@doc("Private link resource properties")
model PrivateLinkResourceProperties {
  @doc("Group Id of the private link resource")
  groupId?: string;

  @doc("Required members of the private link resource")
  requiredMembers?: string[];

  @doc("Required private DNS zone names")
  requiredZoneNames?: string[];

  @doc("The list of resources that are onboarded to private link service")
  @projectedName("json", "shareablePrivateLinkResourceTypes")
  shareablePrivateLinkTypes?: ShareablePrivateLinkType[];
}

@doc("Describes a  resource type that has been onboarded to private link service")
model ShareablePrivateLinkType {
  @doc("The name of the resource type that has been onboarded to private link service")
  name?: string;

  @doc("Describes the properties of a resource type that has been onboarded to private link service")
  properties?: ShareablePrivateLinkProperties;
}

@doc("Describes the properties of a resource type that has been onboarded to private link service")
model ShareablePrivateLinkProperties {
  @doc("The description of the resource type that has been onboarded to private link service")
  description?: string;

  @doc("The resource provider group id for the resource that has been onboarded to private link service")
  groupId?: string;

  @doc("The resource provider type for the resource that has been onboarded to private link service")
  type?: string;
}

@doc("Parameters describes the request to regenerate access keys")
model RegenerateKeyParameters {
  @doc("The type of access key.")
  keyType?: WebPubSubKeyType;
}

@doc("The list skus operation response")
model SkuList {
  @doc("The list of skus available for the resource.")
  @visibility("read")
  value?: WebPubSubSku[];

  @doc("""
The URL the client should use to fetch the next page (per server side paging).
It's null for now, added for future use.
""")
  @visibility("read")
  nextLink?: string;
}

@doc("Describes an available sku.\"")
model WebPubSubSku {
  @doc("The resource type that this object applies to")
  @visibility("read")
  resourceType?: string;

  @doc("The billing information of the resource.")
  @visibility("read")
  sku?: BillingInfoSku;

  @doc("Describes scaling information of a sku.")
  @visibility("read")
  capacity?: WebPubSubSkuCapacity;
}

@doc("Describes scaling information of a sku.")
model WebPubSubSkuCapacity {
  @doc("The lowest permitted capacity for this resource")
  @visibility("read")
  minimum?: int32;

  @doc("The highest permitted capacity for this resource")
  @visibility("read")
  maximum?: int32;

  @doc("The default capacity.")
  @visibility("read")
  default?: int32;

  @doc("Allows capacity value list.")
  @visibility("read")
  allowedValues?: int32[];

  @doc("The scale type applicable to the sku.")
  @visibility("read")
  scaleType?: WebPubSubScaleType;
}
