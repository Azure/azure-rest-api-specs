import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.SignalRService;

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * Optional tier of this particular SKU. 'Standard' or 'Free'.
 *
 * `Basic` is deprecated, use `Standard` instead.
 */
enum SignalRSkuTier {
  Free,
  Basic,
  Standard,
  Premium,
}

/**
 * Provisioning state of the resource.
 */
enum ProvisioningState {
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
enum PrivateLinkServiceConnectionStatus {
  Pending,
  Approved,
  Rejected,
  Disconnected,
}

/**
 * Status of the shared private link resource
 */
enum SharedPrivateLinkResourceStatus {
  Pending,
  Approved,
  Rejected,
  Disconnected,
  Timeout,
}

/**
 * FeatureFlags is the supported features of Azure SignalR service.
 * - ServiceMode: Flag for backend server for SignalR service. Values allowed: "Default": have your own backend server; "Serverless": your application doesn't have a backend server; "Classic": for backward compatibility. Support both Default and Serverless mode but not recommended; "PredefinedOnly": for future use.
 * - EnableConnectivityLogs: "true"/"false", to enable/disable the connectivity log category respectively.
 * - EnableMessagingLogs: "true"/"false", to enable/disable the connectivity log category respectively.
 * - EnableLiveTrace: Live Trace allows you to know what's happening inside Azure SignalR service, it will give you live traces in real time, it will be helpful when you developing your own Azure SignalR based web application or self-troubleshooting some issues. Please note that live traces are counted as outbound messages that will be charged. Values allowed: "true"/"false", to enable/disable live trace feature.
 */
enum FeatureFlags {
  ServiceMode,
  EnableConnectivityLogs,
  EnableMessagingLogs,
  EnableLiveTrace,
}

/**
 * Upstream auth type enum.
 */
enum UpstreamAuthType {
  None,
  ManagedIdentity,
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
enum SignalRRequestType {
  ClientConnection,
  ServerConnection,
  RESTAPI,
  Trace,
}

/**
 * The kind of the service, it can be SignalR or RawWebSockets
 */
enum ServiceKind {
  SignalR,
  RawWebSockets,
}

/**
 * The type of access key.
 */
enum KeyType {
  Primary,
  Secondary,
  Salt,
}

/**
 * The scale type applicable to the sku.
 */
enum ScaleType {
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
   * Ex. a metric that returns the number of times a particular error code was emitted. The error code may not appear
   * often, instead of the RP publishing 0, Shoebox can auto fill in 0s for time periods where nothing was emitted.
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
model NameAvailabilityParameters {
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
model NameAvailability {
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
model SignalRUsageList is Azure.Core.Page<SignalRUsage>;

/**
 * Object that describes a specific usage of the resources.
 */
model SignalRUsage {
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
  name?: SignalRUsageName;

  /**
   * Representing the units of the usage quota. Possible values are: Count, Bytes, Seconds, Percent, CountPerSecond, BytesPerSecond.
   */
  unit?: string;
}

/**
 * Localizable String object containing the name and a localized value.
 */
model SignalRUsageName {
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
 * A class that describes the properties of the resource
 */
model SignalRProperties {
  /**
   * Provisioning state of the resource.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

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
  sharedPrivateLinkResources?: SharedPrivateLinkResource[];

  /**
   * TLS settings for the resource
   */
  tls?: SignalRTlsSettings;

  /**
   * Deprecated.
   */
  @visibility("read")
  hostNamePrefix?: string;

  /**
   * List of the featureFlags.
   *
   * FeatureFlags that are not included in the parameters for the update operation will not be modified.
   * And the response will only include featureFlags that are explicitly set.
   * When a featureFlag is not explicitly set, its globally default value will be used
   * But keep in mind, the default value doesn't mean "false". It varies in terms of different FeatureFlags.
   */
  features?: SignalRFeature[];

  /**
   * Live trace configuration of a Microsoft.SignalRService resource.
   */
  liveTraceConfiguration?: LiveTraceConfiguration;

  /**
   * Resource log configuration of a Microsoft.SignalRService resource.
   */
  resourceLogConfiguration?: ResourceLogConfiguration;

  /**
   * Cross-Origin Resource Sharing (CORS) settings.
   */
  cors?: SignalRCorsSettings;

  /**
   * The settings for the Upstream when the service is in server-less mode.
   */
  upstream?: ServerlessUpstreamSettings;

  /**
   * Network ACLs for the resource
   */
  networkACLs?: SignalRNetworkACLs;

  /**
   * Enable or disable public network access. Default to "Enabled".
   * When it's Enabled, network ACLs still apply.
   * When it's Disabled, public network access is always disabled no matter what you set in network ACLs.
   */
  publicNetworkAccess?: string = "Enabled";

  /**
   * DisableLocalAuth
   * Enable or disable local auth with AccessKey
   * When set as true, connection with AccessKey=xxx won't work.
   */
  disableLocalAuth?: boolean;

  /**
   * DisableLocalAuth
   * Enable or disable aad auth
   * When set as true, connection with AuthType=aad won't work.
   */
  disableAadAuth?: boolean;
}

/**
 * Private endpoint connection properties
 */
model PrivateEndpointConnectionProperties {
  /**
   * Provisioning state of the resource.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

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
  status?: PrivateLinkServiceConnectionStatus;

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
  provisioningState?: ProvisioningState;

  /**
   * The request message for requesting approval of the shared private link resource
   */
  requestMessage?: string;

  /**
   * Status of the shared private link resource
   */
  @visibility("read")
  status?: SharedPrivateLinkResourceStatus;
}

/**
 * TLS settings for the resource
 */
model SignalRTlsSettings {
  /**
   * Request client certificate during TLS handshake if enabled
   */
  clientCertEnabled?: boolean = true;
}

/**
 * Feature of a resource, which controls the runtime behavior.
 */
model SignalRFeature {
  /**
   * FeatureFlags is the supported features of Azure SignalR service.
   * - ServiceMode: Flag for backend server for SignalR service. Values allowed: "Default": have your own backend server; "Serverless": your application doesn't have a backend server; "Classic": for backward compatibility. Support both Default and Serverless mode but not recommended; "PredefinedOnly": for future use.
   * - EnableConnectivityLogs: "true"/"false", to enable/disable the connectivity log category respectively.
   * - EnableMessagingLogs: "true"/"false", to enable/disable the connectivity log category respectively.
   * - EnableLiveTrace: Live Trace allows you to know what's happening inside Azure SignalR service, it will give you live traces in real time, it will be helpful when you developing your own Azure SignalR based web application or self-troubleshooting some issues. Please note that live traces are counted as outbound messages that will be charged. Values allowed: "true"/"false", to enable/disable live trace feature.
   */
  flag: FeatureFlags;

  /**
   * Value of the feature flag. See Azure SignalR service document https://docs.microsoft.com/azure/azure-signalr/ for allowed values.
   */
  @maxLength(128)
  @minLength(1)
  value: string;

  /**
   * Optional properties related to this feature.
   */
  properties?: Record<string>;
}

/**
 * Live trace configuration of a Microsoft.SignalRService resource.
 */
model LiveTraceConfiguration {
  /**
   * Indicates whether or not enable live trace.
   * When it's set to true, live trace client can connect to the service.
   * Otherwise, live trace client can't connect to the service, so that you are unable to receive any log, no matter what you configure in "categories".
   * Available values: true, false.
   * Case insensitive.
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
   * Available values: ConnectivityLogs, MessagingLogs.
   * Case insensitive.
   */
  name?: string;

  /**
   * Indicates whether or the live trace category is enabled.
   * Available values: true, false.
   * Case insensitive.
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
   * Available values: ConnectivityLogs, MessagingLogs.
   * Case insensitive.
   */
  name?: string;

  /**
   * Indicates whether or the resource log category is enabled.
   * Available values: true, false.
   * Case insensitive.
   */
  enabled?: string;
}

/**
 * Cross-Origin Resource Sharing (CORS) settings.
 */
model SignalRCorsSettings {
  /**
   * Gets or sets the list of origins that should be allowed to make cross-origin calls (for example: http://example.com:12345). Use "*" to allow all. If omitted, allow all by default.
   */
  allowedOrigins?: string[];
}

/**
 * The settings for the Upstream when the service is in server-less mode.
 */
model ServerlessUpstreamSettings {
  /**
   * Gets or sets the list of Upstream URL templates. Order matters, and the first matching template takes effects.
   */
  templates?: UpstreamTemplate[];
}

/**
 * Upstream template item settings. It defines the Upstream URL of the incoming requests.
 * The template defines the pattern of the event, the hub or the category of the incoming request that matches current URL template.
 */
model UpstreamTemplate {
  /**
   * Gets or sets the matching pattern for hub names. If not set, it matches any hub.
   * There are 3 kind of patterns supported:
   *     1. "*", it to matches any hub name.
   *     2. Combine multiple hubs with ",", for example "hub1,hub2", it matches "hub1" and "hub2".
   *     3. The single hub name, for example, "hub1", it matches "hub1".
   */
  hubPattern?: string;

  /**
   * Gets or sets the matching pattern for event names. If not set, it matches any event.
   * There are 3 kind of patterns supported:
   *     1. "*", it to matches any event name.
   *     2. Combine multiple events with ",", for example "connect,disconnect", it matches event "connect" and "disconnect".
   *     3. The single event name, for example, "connect", it matches "connect".
   */
  eventPattern?: string;

  /**
   * Gets or sets the matching pattern for category names. If not set, it matches any category.
   * There are 3 kind of patterns supported:
   *     1. "*", it to matches any category name.
   *     2. Combine multiple categories with ",", for example "connections,messages", it matches category "connections" and "messages".
   *     3. The single category name, for example, "connections", it matches the category "connections".
   */
  categoryPattern?: string;

  /**
   * Gets or sets the Upstream URL template. You can use 3 predefined parameters {hub}, {category} {event} inside the template, the value of the Upstream URL is dynamically calculated when the client request comes in.
   * For example, if the urlTemplate is `http://example.com/{hub}/api/{event}`, with a client request from hub `chat` connects, it will first POST to this URL: `http://example.com/chat/api/connect`.
   */
  urlTemplate: string;

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
   * It also appears in the aud (audience) claim of the issued token.
   */
  resource?: string;
}

/**
 * Network ACLs for the resource
 */
model SignalRNetworkACLs {
  /**
   * Azure Networking ACL Action.
   */
  defaultAction?: ACLAction;

  /**
   * Network ACL
   */
  publicNetwork?: NetworkACL;

  /**
   * ACLs for requests from private endpoints
   */
  privateEndpoints?: PrivateEndpointACL[];
}

/**
 * Network ACL
 */
model NetworkACL {
  /**
   * Allowed request types. The value can be one or more of: ClientConnection, ServerConnection, RESTAPI.
   */
  allow?: SignalRRequestType[];

  /**
   * Denied request types. The value can be one or more of: ClientConnection, ServerConnection, RESTAPI.
   */
  deny?: SignalRRequestType[];
}

/**
 * ACL for a private endpoint
 */
model PrivateEndpointACL extends NetworkACL {
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
   * Only be used in response.
   */
  @visibility("read")
  principalId?: string;

  /**
   * Get the tenant id for the system assigned identity.
   * Only be used in response
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
 * Custom certificate properties.
 */
model CustomCertificateProperties {
  /**
   * Provisioning state of the resource.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * Base uri of the KeyVault that stores certificate.
   */
  @visibility("read", "create")
  keyVaultBaseUri: string;

  /**
   * Certificate secret name.
   */
  @visibility("read", "create")
  keyVaultSecretName: string;

  /**
   * Certificate secret version.
   */
  @visibility("read", "create")
  keyVaultSecretVersion?: string;
}

/**
 * Properties of a custom domain.
 */
model CustomDomainProperties {
  /**
   * Provisioning state of the resource.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * The custom domain name.
   */
  domainName: string;

  /**
   * Reference to a resource.
   */
  customCertificate: ResourceReference;
}

/**
 * Reference to a resource.
 */
model ResourceReference {
  /**
   * Resource ID.
   */
  id?: string;
}

/**
 * A class represents the access keys of the resource.
 */
model SignalRKeys {
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
model PrivateLinkResourceList is Azure.Core.Page<PrivateLinkResource>;

/**
 * Private link resource
 */
model PrivateLinkResource extends ProxyResource {
  /**
   * Private link resource properties
   */
  @extension("x-ms-client-flatten", true)
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
  shareablePrivateLinkResourceTypes?: ShareablePrivateLinkResourceType[];
}

/**
 * Describes a  resource type that has been onboarded to private link service
 */
model ShareablePrivateLinkResourceType {
  /**
   * The name of the resource type that has been onboarded to private link service
   */
  name?: string;

  /**
   * Describes the properties of a resource type that has been onboarded to private link service
   */
  properties?: ShareablePrivateLinkResourceProperties;
}

/**
 * Describes the properties of a resource type that has been onboarded to private link service
 */
model ShareablePrivateLinkResourceProperties {
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
  keyType?: KeyType;
}

/**
 * The list skus operation response
 */
model SkuList {
  /**
   * The list of skus available for the resource.
   */
  @visibility("read")
  value?: Sku[];

  /**
   * The URL the client should use to fetch the next page (per server side paging).
   * It's null for now, added for future use.
   */
  @visibility("read")
  nextLink?: string;
}

/**
 * Describes an available sku."
 */
model Sku {
  /**
   * The resource type that this object applies to
   */
  @visibility("read")
  resourceType?: string;

  /**
   * The billing information of the resource.
   */
  @visibility("read")
  sku?: ResourceSku;

  /**
   * Describes scaling information of a sku.
   */
  @visibility("read")
  capacity?: SkuCapacity;
}

/**
 * Describes scaling information of a sku.
 */
model SkuCapacity {
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
  scaleType?: ScaleType;
}
