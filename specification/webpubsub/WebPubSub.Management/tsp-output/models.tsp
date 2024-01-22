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

/**
* Optional tier of this particular SKU. 'Standard' or 'Free'. 

`Basic` is deprecated, use `Standard` instead.
*/
enum WebPubSubSkuTier {
  Free,
  Basic,
  Standard,
  Premium,
}

/**
 * Provisioning state of the resource.
 */
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

/**
 * Indicates whether the connection has been Approved/Rejected/Removed by the owner of the service.
 */
enum WebPubSubPrivateLinkServiceConnectionStatus {
  Pending,
  Approved,
  Rejected,
  Disconnected,
}

/**
 * Status of the shared private link resource
 */
enum WebPubSubSharedPrivateLinkStatus {
  Pending,
  Approved,
  Rejected,
  Disconnected,
  Timeout,
}

/**
 * Azure Networking ACL Action.
 */
enum ACLAction {
  Allow,
  Deny,
}

/**
 * The incoming request type to the service
 */
enum WebPubSubRequestType {
  ClientConnection,
  ServerConnection,
  RESTAPI,
  Trace,
}

/**
 * Upstream auth type enum.
 */
enum UpstreamAuthType {
  None,
  ManagedIdentity,
}

/**
 * The type of access key.
 */
enum WebPubSubKeyType {
  Primary,
  Secondary,
  Salt,
}

/**
 * The scale type applicable to the sku.
 */
enum WebPubSubScaleType {
  None,
  Manual,
  Automatic,
}

/**
 * Extra Operation properties.
 */
model OperationProperties {
  /**
   * An object that describes a specification.
   */
  serviceSpecification?: ServiceSpecification;
}

/**
 * An object that describes a specification.
 */
model ServiceSpecification {
  /**
   * Specifications of the Metrics for Azure Monitoring.
   */
  metricSpecifications?: MetricSpecification[];

  /**
   * Specifications of the Logs for Azure Monitoring.
   */
  logSpecifications?: LogSpecification[];
}

/**
 * Specifications of the Metrics for Azure Monitoring.
 */
model MetricSpecification {
  /**
   * Name of the metric.
   */
  name?: string;

  /**
   * Localized friendly display name of the metric.
   */
  displayName?: string;

  /**
   * Localized friendly description of the metric.
   */
  displayDescription?: string;

  /**
   * The unit that makes sense for the metric.
   */
  unit?: string;

  /**
   * Only provide one value for this field. Valid values: Average, Minimum, Maximum, Total, Count.
   */
  aggregationType?: string;

  /**
* Optional. If set to true, then zero will be returned for time duration where no metric is emitted/published. 
Ex. a metric that returns the number of times a particular error code was emitted. The error code may not appear 
often, instead of the RP publishing 0, Shoebox can auto fill in 0s for time periods where nothing was emitted.
*/
  fillGapWithZero?: string;

  /**
   * The name of the metric category that the metric belongs to. A metric can only belong to a single category.
   */
  category?: string;

  /**
   * The dimensions of the metrics.
   */
  dimensions?: Dimension[];
}

/**
 * Specifications of the Dimension of metrics.
 */
model Dimension {
  /**
   * The public facing name of the dimension.
   */
  name?: string;

  /**
   * Localized friendly display name of the dimension.
   */
  displayName?: string;

  /**
   * Name of the dimension as it appears in MDM.
   */
  internalName?: string;

  /**
   * A Boolean flag indicating whether this dimension should be included for the shoebox export scenario.
   */
  toBeExportedForShoebox?: boolean;
}

/**
 * Specifications of the Logs for Azure Monitoring.
 */
model LogSpecification {
  /**
   * Name of the log.
   */
  name?: string;

  /**
   * Localized friendly display name of the log.
   */
  displayName?: string;
}

/**
 * Data POST-ed to the nameAvailability action
 */
model WebPubSubNameAvailabilityParameters {
  /**
   * The resource type. Can be "Microsoft.SignalRService/SignalR" or "Microsoft.SignalRService/webPubSub"
   */
  type: string;

  /**
   * The resource name to validate. e.g."my-resource-name"
   */
  name: string;
}

/**
 * Result of the request to check name availability. It contains a flag and possible reason of failure.
 */
model WebPubSubNameAvailability {
  /**
   * Indicates whether the name is available or not.
   */
  nameAvailable?: boolean;

  /**
   * The reason of the availability. Required if name is not available.
   */
  reason?: string;

  /**
   * The message of the operation.
   */
  message?: string;
}

/**
 * Object that includes an array of the resource usages and a possible link for next set.
 */
model SignalRServiceUsageList is Azure.Core.Page<SignalRServiceUsage>;

/**
 * Object that describes a specific usage of the resources.
 */
model SignalRServiceUsage {
  /**
   * Fully qualified ARM resource id
   */
  id?: string;

  /**
   * Current value for the usage quota.
   */
  currentValue?: int64;

  /**
   * The maximum permitted value for the usage quota. If there is no limit, this value will be -1.
   */
  limit?: int64;

  /**
   * Localizable String object containing the name and a localized value.
   */
  name?: SignalRServiceUsageName;

  /**
   * Representing the units of the usage quota. Possible values are: Count, Bytes, Seconds, Percent, CountPerSecond, BytesPerSecond.
   */
  unit?: string;
}

/**
 * Localizable String object containing the name and a localized value.
 */
model SignalRServiceUsageName {
  /**
   * The identifier of the usage.
   */
  value?: string;

  /**
   * Localized name of the usage.
   */
  localizedValue?: string;
}

/**
 * The billing information of the resource.
 */
model BillingInfoSku {
  /**
* The name of the SKU. Required.

Allowed values: Standard_S1, Free_F1
*/
  name: string;

  /**
* Optional tier of this particular SKU. 'Standard' or 'Free'. 

`Basic` is deprecated, use `Standard` instead.
*/
  tier?: WebPubSubSkuTier;

  /**
   * Not used. Retained for future use.
   */
  @visibility("read")
  size?: string;

  /**
   * Not used. Retained for future use.
   */
  @visibility("read")
  family?: string;

  /**
* Optional, integer. The unit count of the resource. 1 by default.

If present, following values are allowed:
    Free: 1
    Standard: 1,2,5,10,20,50,100
*/
  capacity?: int32;
}

/**
 * A class that describes the properties of the resource
 */
model WebPubSubProperties {
  /**
   * Provisioning state of the resource.
   */
  @visibility("read")
  provisioningState?: WebPubSubProvisioningState;

  /**
   * The publicly accessible IP of the resource.
   */
  @visibility("read")
  externalIP?: string;

  /**
   * FQDN of the service instance.
   */
  @visibility("read")
  hostName?: string;

  /**
   * The publicly accessible port of the resource which is designed for browser/client side usage.
   */
  @visibility("read")
  publicPort?: int32;

  /**
   * The publicly accessible port of the resource which is designed for customer server side usage.
   */
  @visibility("read")
  serverPort?: int32;

  /**
   * Version of the resource. Probably you need the same or higher version of client SDKs.
   */
  @visibility("read")
  version?: string;

  /**
   * Private endpoint connections to the resource.
   */
  @visibility("read")
  privateEndpointConnections?: PrivateEndpointConnection[];

  /**
   * The list of shared private link resources.
   */
  @visibility("read")
  sharedPrivateLinkResources?: WebPubSubSharedPrivateLink[];

  /**
   * TLS settings for the resource
   */
  tls?: WebPubSubTlsSettings;

  /**
   * Deprecated.
   */
  @visibility("read")
  hostNamePrefix?: string;

  /**
   * Live trace configuration of a Microsoft.SignalRService resource.
   */
  liveTraceConfiguration?: LiveTraceConfiguration;

  /**
   * Resource log configuration of a Microsoft.SignalRService resource.
   */
  resourceLogConfiguration?: ResourceLogConfiguration;

  /**
   * Network ACLs for the resource
   */
  networkACLs?: WebPubSubNetworkACLs;

  /**
* Enable or disable public network access. Default to "Enabled".
When it's Enabled, network ACLs still apply.
When it's Disabled, public network access is always disabled no matter what you set in network ACLs.
*/
  publicNetworkAccess?: string = "Enabled";

  /**
* DisableLocalAuth
Enable or disable local auth with AccessKey
When set as true, connection with AccessKey=xxx won't work.
*/
  @projectedName("json", "disableLocalAuth")
  isLocalAuthDisabled?: boolean;

  /**
* DisableLocalAuth
Enable or disable aad auth
When set as true, connection with AuthType=aad won't work.
*/
  @projectedName("json", "disableAadAuth")
  isAadAuthDisabled?: boolean;
}

/**
 * Private endpoint connection properties
 */
model PrivateEndpointConnectionProperties {
  /**
   * Provisioning state of the resource.
   */
  @visibility("read")
  provisioningState?: WebPubSubProvisioningState;

  /**
   * Private endpoint
   */
  privateEndpoint?: PrivateEndpoint;

  /**
   * Group IDs
   */
  @visibility("read")
  groupIds?: string[];

  /**
   * Connection state of the private endpoint connection
   */
  privateLinkServiceConnectionState?: PrivateLinkServiceConnectionState;
}

/**
 * Private endpoint
 */
model PrivateEndpoint {
  /**
   * Full qualified Id of the private endpoint
   */
  id?: string;
}

/**
 * Connection state of the private endpoint connection
 */
model PrivateLinkServiceConnectionState {
  /**
   * Indicates whether the connection has been Approved/Rejected/Removed by the owner of the service.
   */
  status?: WebPubSubPrivateLinkServiceConnectionStatus;

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
 * The core properties of ARM resources.
 */
model Resource {
  /**
   * Fully qualified resource Id for the resource.
   */
  @visibility("read")
  id?: string;

  /**
   * The name of the resource.
   */
  @visibility("read")
  name?: string;

  /**
   * The type of the resource - e.g. "Microsoft.SignalRService/SignalR"
   */
  @visibility("read")
  type?: string;
}

/**
 * Describes the properties of an existing Shared Private Link Resource
 */
model SharedPrivateLinkResourceProperties {
  /**
   * The group id from the provider of resource the shared private link resource is for
   */
  groupId: string;

  /**
   * The resource id of the resource the shared private link resource is for
   */
  privateLinkResourceId: string;

  /**
   * Provisioning state of the resource.
   */
  @visibility("read")
  provisioningState?: WebPubSubProvisioningState;

  /**
   * The request message for requesting approval of the shared private link resource
   */
  requestMessage?: string;

  /**
   * Status of the shared private link resource
   */
  @visibility("read")
  status?: WebPubSubSharedPrivateLinkStatus;
}

/**
 * TLS settings for the resource
 */
model WebPubSubTlsSettings {
  /**
   * Request client certificate during TLS handshake if enabled
   */
  @projectedName("json", "clientCertEnabled")
  isClientCertEnabled?: boolean = true;
}

/**
 * Live trace configuration of a Microsoft.SignalRService resource.
 */
model LiveTraceConfiguration {
  /**
* Indicates whether or not enable live trace.
When it's set to true, live trace client can connect to the service.
Otherwise, live trace client can't connect to the service, so that you are unable to receive any log, no matter what you configure in "categories".
Available values: true, false.
Case insensitive.
*/
  enabled?: string = "false";

  /**
   * Gets or sets the list of category configurations.
   */
  categories?: LiveTraceCategory[];
}

/**
 * Live trace category configuration of a Microsoft.SignalRService resource.
 */
model LiveTraceCategory {
  /**
* Gets or sets the live trace category's name.
Available values: ConnectivityLogs, MessagingLogs.
Case insensitive.
*/
  name?: string;

  /**
* Indicates whether or the live trace category is enabled.
Available values: true, false.
Case insensitive.
*/
  enabled?: string;
}

/**
 * Resource log configuration of a Microsoft.SignalRService resource.
 */
model ResourceLogConfiguration {
  /**
   * Gets or sets the list of category configurations.
   */
  categories?: ResourceLogCategory[];
}

/**
 * Resource log category configuration of a Microsoft.SignalRService resource.
 */
model ResourceLogCategory {
  /**
* Gets or sets the resource log category's name.
Available values: ConnectivityLogs, MessagingLogs.
Case insensitive.
*/
  name?: string;

  /**
* Indicates whether or the resource log category is enabled.
Available values: true, false.
Case insensitive.
*/
  enabled?: string;
}

/**
 * Network ACLs for the resource
 */
model WebPubSubNetworkACLs {
  /**
   * Azure Networking ACL Action.
   */
  defaultAction?: ACLAction;

  /**
   * Network ACL
   */
  publicNetwork?: PublicNetworkAcls;

  /**
   * ACLs for requests from private endpoints
   */
  privateEndpoints?: PrivateEndpointACL[];
}

/**
 * Network ACL
 */
model PublicNetworkAcls {
  /**
   * Allowed request types. The value can be one or more of: ClientConnection, ServerConnection, RESTAPI.
   */
  allow?: WebPubSubRequestType[];

  /**
   * Denied request types. The value can be one or more of: ClientConnection, ServerConnection, RESTAPI.
   */
  deny?: WebPubSubRequestType[];
}

/**
 * ACL for a private endpoint
 */
model PrivateEndpointACL extends PublicNetworkAcls {
  /**
   * Name of the private endpoint connection
   */
  name: string;
}

/**
 * A class represent managed identities used for request and response
 */
model ManagedIdentity {
  /**
   * Represents the identity type: systemAssigned, userAssigned, None
   */
  type?: ManagedIdentityType;

  /**
   * Get or set the user assigned identities
   */
  userAssignedIdentities?: Record<UserAssignedIdentityProperty>;

  /**
* Get the principal id for the system assigned identity.
Only be used in response.
*/
  @visibility("read")
  principalId?: string;

  /**
* Get the tenant id for the system assigned identity.
Only be used in response
*/
  @visibility("read")
  tenantId?: string;
}

/**
 * Properties of user assigned identity.
 */
model UserAssignedIdentityProperty {
  /**
   * Get the principal id for the user assigned identity
   */
  @visibility("read")
  principalId?: string;

  /**
   * Get the client id for the user assigned identity
   */
  @visibility("read")
  clientId?: string;
}

/**
 * Properties of a hub.
 */
model WebPubSubHubProperties {
  /**
   * Event handler of a hub.
   */
  eventHandlers?: WebPubSubEventHandler[];

  /**
   * The settings for configuring if anonymous connections are allowed for this hub: "allow" or "deny". Default to "deny".
   */
  anonymousConnectPolicy?: string = "deny";
}

/**
 * Properties of event handler.
 */
model WebPubSubEventHandler {
  /**
* Gets or sets the EventHandler URL template. You can use a predefined parameter {hub} and {event} inside the template, the value of the EventHandler URL is dynamically calculated when the client request comes in.
For example, UrlTemplate can be `http://example.com/api/{hub}/{event}`. The host part can't contains parameters.
*/
  urlTemplate: string;

  /**
* Gets or sets the matching pattern for event names.
There are 3 kind of patterns supported:
    1. "*", it to matches any event name
    2. Combine multiple events with ",", for example "event1,event2", it matches event "event1" and "event2"
    3. The single event name, for example, "event1", it matches "event1"
*/
  userEventPattern?: string;

  /**
   * Gets ot sets the list of system events.
   */
  systemEvents?: string[];

  /**
   * Upstream auth settings. If not set, no auth is used for upstream messages.
   */
  auth?: UpstreamAuthSettings;
}

/**
 * Upstream auth settings. If not set, no auth is used for upstream messages.
 */
model UpstreamAuthSettings {
  /**
   * Upstream auth type enum.
   */
  type?: UpstreamAuthType;

  /**
   * Managed identity settings for upstream.
   */
  managedIdentity?: ManagedIdentitySettings;
}

/**
 * Managed identity settings for upstream.
 */
model ManagedIdentitySettings {
  /**
* The Resource indicating the App ID URI of the target resource.
It also appears in the aud (audience) claim of the issued token.
*/
  resource?: string;
}

/**
 * A class represents the access keys of the resource.
 */
model WebPubSubKeys {
  /**
   * The primary access key.
   */
  primaryKey?: string;

  /**
   * The secondary access key.
   */
  secondaryKey?: string;

  /**
   * Connection string constructed via the primaryKey
   */
  primaryConnectionString?: string;

  /**
   * Connection string constructed via the secondaryKey
   */
  secondaryConnectionString?: string;
}

/**
 * Contains a list of PrivateLinkResource and a possible link to query more results
 */
model PrivateLinkResourceList is Azure.Core.Page<WebPubSubPrivateLink>;

/**
 * Private link resource
 */
model WebPubSubPrivateLink{
  /**
   * Private link resource properties
   */
  properties?: PrivateLinkResourceProperties;
}

/**
 * Private link resource properties
 */
model PrivateLinkResourceProperties {
  /**
   * Group Id of the private link resource
   */
  groupId?: string;

  /**
   * Required members of the private link resource
   */
  requiredMembers?: string[];

  /**
   * Required private DNS zone names
   */
  requiredZoneNames?: string[];

  /**
   * The list of resources that are onboarded to private link service
   */
  @projectedName("json", "shareablePrivateLinkResourceTypes")
  shareablePrivateLinkTypes?: ShareablePrivateLinkType[];
}

/**
 * Describes a  resource type that has been onboarded to private link service
 */
model ShareablePrivateLinkType {
  /**
   * The name of the resource type that has been onboarded to private link service
   */
  name?: string;

  /**
   * Describes the properties of a resource type that has been onboarded to private link service
   */
  properties?: ShareablePrivateLinkProperties;
}

/**
 * Describes the properties of a resource type that has been onboarded to private link service
 */
model ShareablePrivateLinkProperties {
  /**
   * The description of the resource type that has been onboarded to private link service
   */
  description?: string;

  /**
   * The resource provider group id for the resource that has been onboarded to private link service
   */
  groupId?: string;

  /**
   * The resource provider type for the resource that has been onboarded to private link service
   */
  type?: string;
}

/**
 * Parameters describes the request to regenerate access keys
 */
model RegenerateKeyParameters {
  /**
   * The type of access key.
   */
  keyType?: WebPubSubKeyType;
}

/**
 * The list skus operation response
 */
model SkuList {
  /**
   * The list of skus available for the resource.
   */
  @visibility("read")
  value?: WebPubSubSku[];

  /**
* The URL the client should use to fetch the next page (per server side paging).
It's null for now, added for future use.
*/
  @visibility("read")
  nextLink?: string;
}

/**
 * Describes an available sku."
 */
model WebPubSubSku {
  /**
   * The resource type that this object applies to
   */
  @visibility("read")
  resourceType?: string;

  /**
   * The billing information of the resource.
   */
  @visibility("read")
  sku?: BillingInfoSku;

  /**
   * Describes scaling information of a sku.
   */
  @visibility("read")
  capacity?: WebPubSubSkuCapacity;
}

/**
 * Describes scaling information of a sku.
 */
model WebPubSubSkuCapacity {
  /**
   * The lowest permitted capacity for this resource
   */
  @visibility("read")
  minimum?: int32;

  /**
   * The highest permitted capacity for this resource
   */
  @visibility("read")
  maximum?: int32;

  /**
   * The default capacity.
   */
  @visibility("read")
  default?: int32;

  /**
   * Allows capacity value list.
   */
  @visibility("read")
  allowedValues?: int32[];

  /**
   * The scale type applicable to the sku.
   */
  @visibility("read")
  scaleType?: WebPubSubScaleType;
}
