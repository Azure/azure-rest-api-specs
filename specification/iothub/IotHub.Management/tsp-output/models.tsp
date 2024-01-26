import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using TypeSpec.OpenAPI;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Devices;

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * Whether requests from Public Network are allowed
 */
enum PublicNetworkAccess {
  Enabled,
  Disabled,
}

/**
 * Default Action for Network Rule Set
 */
enum DefaultAction {
  Deny,
  Allow,
}

/**
 * IP Filter Action
 */
enum NetworkRuleIPAction {
  Allow,
}

/**
 * The status of a private endpoint connection
 */
enum PrivateLinkServiceConnectionStatus {
  Pending,
  Approved,
  Rejected,
  Disconnected,
}

/**
 * Specifies authentication type being used for connecting to the storage account.
 */
enum AuthenticationType {
  keyBased,
  identityBased,
}

/**
 * Encoding that is used to serialize messages to blobs. Supported values are 'avro', 'avrodeflate', and 'JSON'. Default value is 'avro'.
 */
enum RoutingStorageContainerPropertiesEncoding {
  Avro,
  AvroDeflate,
  JSON,
}

/**
 * The source that the routing rule is to be applied to, such as DeviceMessages.
 */
enum RoutingSource {
  Invalid,
  DeviceMessages,
  TwinChangeEvents,
  DeviceLifecycleEvents,
  DeviceJobLifecycleEvents,
  DeviceConnectionStateEvents,
}

/**
 * The capabilities and features enabled for the IoT hub.
 */
enum Capabilities {
  None,
  DeviceManagement,
}

/**
 * The role of the region, can be either primary or secondary. The primary region is where the IoT hub is currently provisioned. The secondary region is the Azure disaster recovery (DR) paired region and also the region where the IoT hub can failover to.
 */
enum IotHubReplicaRoleType {
  primary,
  secondary,
}

/**
 * The name of the SKU.
 */
enum IotHubSku {
  F1,
  S1,
  S2,
  S3,
  B1,
  B2,
  B3,
}

/**
 * The type of the job.
 */
enum JobType {
  `unknown`,
  export,
  `import`,
  backup,
  readDeviceProperties,
  writeDeviceProperties,
  updateDeviceConfiguration,
  rebootDevice,
  factoryResetDevice,
  firmwareUpdate,
}

/**
 * Health statuses have following meanings. The 'healthy' status shows that the endpoint is accepting messages as expected. The 'unhealthy' status shows that the endpoint is not accepting messages as expected and IoT Hub is retrying to send data to this endpoint. The status of an unhealthy endpoint will be updated to healthy when IoT Hub has established an eventually consistent state of health. The 'dead' status shows that the endpoint is not accepting messages, after IoT Hub retried sending messages for the retrial period. See IoT Hub metrics to identify errors and monitor issues with endpoints. The 'unknown' status shows that the IoT Hub has not established a connection with the endpoint. No messages have been delivered to or rejected from this endpoint
 */
enum EndpointHealthStatus {
  `unknown`,
  healthy,
  degraded,
  unhealthy,
  dead,
}

/**
 * Result of testing route
 */
enum TestResultStatus {
  undefined,
  `false`,
  `true`,
}

/**
 * Severity of the route error
 */
enum RouteErrorSeverity {
  error,
  warning,
}

/**
 * The permissions assigned to the shared access policy.
 */
@fixed
enum AccessRights {
  RegistryRead,
  RegistryWrite,
  ServiceConnect,
  DeviceConnect,
  `RegistryRead, RegistryWrite`,
  `RegistryRead, ServiceConnect`,
  `RegistryRead, DeviceConnect`,
  `RegistryWrite, ServiceConnect`,
  `RegistryWrite, DeviceConnect`,
  `ServiceConnect, DeviceConnect`,
  `RegistryRead, RegistryWrite, ServiceConnect`,
  `RegistryRead, RegistryWrite, DeviceConnect`,
  `RegistryRead, ServiceConnect, DeviceConnect`,
  `RegistryWrite, ServiceConnect, DeviceConnect`,
  `RegistryRead, RegistryWrite, ServiceConnect, DeviceConnect`,
}

/**
 * The desired action for requests captured by this rule.
 */
@fixed
enum IpFilterActionType {
  Accept,
  Reject,
}

/**
 * The billing tier for the IoT hub.
 */
@fixed
enum IotHubSkuTier {
  Free,
  Standard,
  Basic,
}

/**
 * The type of identity used for the resource. The type 'SystemAssigned, UserAssigned' includes both an implicitly created identity and a set of user assigned identities. The type 'None' will remove any identities from the service.
 */
@fixed
enum ResourceIdentityType {
  SystemAssigned,
  UserAssigned,
  `SystemAssigned, UserAssigned`,
  None,
}

/**
 * The type of the scaling enabled.
 */
@fixed
enum IotHubScaleType {
  Automatic,
  Manual,
  None,
}

/**
 * The status of the job.
 */
@fixed
enum JobStatus {
  `unknown`,
  enqueued,
  running,
  completed,
  failed,
  cancelled,
}

/**
 * The reason for unavailability.
 */
@fixed
enum IotHubNameUnavailabilityReason {
  Invalid,
  AlreadyExists,
}

/**
 * Error details.
 */
@error
model ErrorDetails {
  /**
   * The error code.
   */
  @visibility("read")
  code?: string;

  /**
   * The HTTP status code.
   */
  @visibility("read")
  httpStatusCode?: string;

  /**
   * The error message.
   */
  @visibility("read")
  message?: string;

  /**
   * The error details.
   */
  @visibility("read")
  details?: string;
}

/**
 * The properties of an IoT hub.
 */
model IotHubProperties {
  /**
   * The shared access policies you can use to secure a connection to the IoT hub.
   */
  authorizationPolicies?: SharedAccessSignatureAuthorizationRule[];

  /**
   * If true, SAS tokens with Iot hub scoped SAS keys cannot be used for authentication.
   */
  disableLocalAuth?: boolean;

  /**
   * If true, all device(including Edge devices but excluding modules) scoped SAS keys cannot be used for authentication.
   */
  disableDeviceSAS?: boolean;

  /**
   * If true, all module scoped SAS keys cannot be used for authentication.
   */
  disableModuleSAS?: boolean;

  /**
   * If true, egress from IotHub will be restricted to only the allowed FQDNs that are configured via allowedFqdnList.
   */
  restrictOutboundNetworkAccess?: boolean;

  /**
   * List of allowed FQDNs(Fully Qualified Domain Name) for egress from Iot Hub.
   */
  allowedFqdnList?: string[];

  /**
   * Whether requests from Public Network are allowed
   */
  publicNetworkAccess?: PublicNetworkAccess;

  /**
   * The IP filter rules.
   */
  ipFilterRules?: IpFilterRule[];

  /**
   * Network Rule Set Properties of IotHub
   */
  networkRuleSets?: NetworkRuleSetProperties;

  /**
   * Specifies the minimum TLS version to support for this hub. Can be set to "1.2" to have clients that use a TLS version below 1.2 to be rejected.
   */
  minTlsVersion?: string;

  /**
   * Private endpoint connections created on this IotHub
   */
  privateEndpointConnections?: PrivateEndpointConnection[];

  /**
   * The provisioning state.
   */
  @visibility("read")
  provisioningState?: string;

  /**
   * The hub state.
   */
  @visibility("read")
  state?: string;

  /**
   * The name of the host.
   */
  @visibility("read")
  hostName?: string;

  /**
   * The Event Hub-compatible endpoint properties. The only possible keys to this dictionary is events. This key has to be present in the dictionary while making create or update calls for the IoT hub.
   */
  eventHubEndpoints?: Record<EventHubProperties>;

  /**
   * The routing related properties of the IoT hub. See: https://docs.microsoft.com/azure/iot-hub/iot-hub-devguide-messaging
   */
  routing?: RoutingProperties;

  /**
   * The list of Azure Storage endpoints where you can upload files. Currently you can configure only one Azure Storage account and that MUST have its key as $default. Specifying more than one storage account causes an error to be thrown. Not specifying a value for this property when the enableFileUploadNotifications property is set to True, causes an error to be thrown.
   */
  storageEndpoints?: Record<StorageEndpointProperties>;

  /**
   * The messaging endpoint properties for the file upload notification queue.
   */
  messagingEndpoints?: Record<MessagingEndpointProperties>;

  /**
   * If True, file upload notifications are enabled.
   */
  enableFileUploadNotifications?: boolean;

  /**
   * The IoT hub cloud-to-device messaging properties.
   */
  cloudToDevice?: CloudToDeviceProperties;

  /**
   * IoT hub comments.
   */
  comments?: string;

  /**
   * The capabilities and features enabled for the IoT hub.
   */
  features?: Capabilities;

  /**
   * Primary and secondary location for iot hub
   */
  @visibility("read")
  locations?: IotHubLocationDescription[];

  /**
   * This property when set to true, will enable data residency, thus, disabling disaster recovery.
   */
  enableDataResidency?: boolean;
}

/**
 * The properties of an IoT hub shared access policy.
 */
model SharedAccessSignatureAuthorizationRule {
  /**
   * The name of the shared access policy.
   */
  keyName: string;

  /**
   * The primary key.
   */
  primaryKey?: string;

  /**
   * The secondary key.
   */
  secondaryKey?: string;

  /**
   * The permissions assigned to the shared access policy.
   */
  rights: AccessRights;
}

/**
 * The IP filter rules for the IoT hub.
 */
model IpFilterRule {
  /**
   * The name of the IP filter rule.
   */
  filterName: string;

  /**
   * The desired action for requests captured by this rule.
   */
  action: IpFilterActionType;

  /**
   * A string that contains the IP address range in CIDR notation for the rule.
   */
  ipMask: string;
}

/**
 * Network Rule Set Properties of IotHub
 */
model NetworkRuleSetProperties {
  /**
   * Default Action for Network Rule Set
   */
  defaultAction?: DefaultAction = DefaultAction.Deny;

  /**
   * If True, then Network Rule Set is also applied to BuiltIn EventHub EndPoint of IotHub
   */
  applyToBuiltInEventHubEndpoint: boolean;

  /**
   * List of IP Rules
   */
  ipRules: NetworkRuleSetIpRule[];
}

/**
 * IP Rule to be applied as part of Network Rule Set
 */
model NetworkRuleSetIpRule {
  /**
   * Name of the IP filter rule.
   */
  filterName: string;

  /**
   * IP Filter Action
   */
  action?: NetworkRuleIPAction = NetworkRuleIPAction.Allow;

  /**
   * A string that contains the IP address range in CIDR notation for the rule.
   */
  ipMask: string;
}

/**
 * The properties of a private endpoint connection
 */
model PrivateEndpointConnectionProperties {
  /**
   * The private endpoint property of a private endpoint connection
   */
  privateEndpoint?: PrivateEndpoint;

  /**
   * The current state of a private endpoint connection
   */
  privateLinkServiceConnectionState: PrivateLinkServiceConnectionState;
}

/**
 * The private endpoint property of a private endpoint connection
 */
model PrivateEndpoint {
  /**
   * The resource identifier.
   */
  @visibility("read")
  id?: string;
}

/**
 * The current state of a private endpoint connection
 */
model PrivateLinkServiceConnectionState {
  /**
   * The status of a private endpoint connection
   */
  status: PrivateLinkServiceConnectionStatus;

  /**
   * The description for the current state of a private endpoint connection
   */
  description: string;

  /**
   * Actions required for a private endpoint connection
   */
  actionsRequired?: string;
}

/**
 * The properties of the provisioned Event Hub-compatible endpoint used by the IoT hub.
 */
model EventHubProperties {
  /**
   * The retention time for device-to-cloud messages in days. See: https://docs.microsoft.com/azure/iot-hub/iot-hub-devguide-messaging#device-to-cloud-messages
   */
  retentionTimeInDays?: int64;

  /**
   * The number of partitions for receiving device-to-cloud messages in the Event Hub-compatible endpoint. See: https://docs.microsoft.com/azure/iot-hub/iot-hub-devguide-messaging#device-to-cloud-messages.
   */
  partitionCount?: int32;

  /**
   * The partition ids in the Event Hub-compatible endpoint.
   */
  @visibility("read")
  partitionIds?: string[];

  /**
   * The Event Hub-compatible name.
   */
  @visibility("read")
  path?: string;

  /**
   * The Event Hub-compatible endpoint.
   */
  @visibility("read")
  endpoint?: string;
}

/**
 * The routing related properties of the IoT hub. See: https://docs.microsoft.com/azure/iot-hub/iot-hub-devguide-messaging
 */
model RoutingProperties {
  /**
   * The properties related to the custom endpoints to which your IoT hub routes messages based on the routing rules. A maximum of 10 custom endpoints are allowed across all endpoint types for paid hubs and only 1 custom endpoint is allowed across all endpoint types for free hubs.
   */
  endpoints?: RoutingEndpoints;

  /**
   * The list of user-provided routing rules that the IoT hub uses to route messages to built-in and custom endpoints. A maximum of 100 routing rules are allowed for paid hubs and a maximum of 5 routing rules are allowed for free hubs.
   */
  routes?: RouteProperties[];

  /**
   * The properties of the route that is used as a fall-back route when none of the conditions specified in the 'routes' section are met. This is an optional parameter. When this property is not present in the template, the fallback route is disabled by default.
   */
  fallbackRoute?: FallbackRouteProperties;

  /**
   * The list of user-provided enrichments that the IoT hub applies to messages to be delivered to built-in and custom endpoints. See: https://aka.ms/telemetryoneventgrid
   */
  enrichments?: EnrichmentProperties[];
}

/**
 * The properties related to the custom endpoints to which your IoT hub routes messages based on the routing rules. A maximum of 10 custom endpoints are allowed across all endpoint types for paid hubs and only 1 custom endpoint is allowed across all endpoint types for free hubs.
 */
model RoutingEndpoints {
  /**
   * The list of Service Bus queue endpoints that IoT hub routes the messages to, based on the routing rules.
   */
  serviceBusQueues?: RoutingServiceBusQueueEndpointProperties[];

  /**
   * The list of Service Bus topic endpoints that the IoT hub routes the messages to, based on the routing rules.
   */
  serviceBusTopics?: RoutingServiceBusTopicEndpointProperties[];

  /**
   * The list of Event Hubs endpoints that IoT hub routes messages to, based on the routing rules. This list does not include the built-in Event Hubs endpoint.
   */
  eventHubs?: RoutingEventHubProperties[];

  /**
   * The list of storage container endpoints that IoT hub routes messages to, based on the routing rules.
   */
  storageContainers?: RoutingStorageContainerProperties[];

  /**
   * The list of Cosmos DB container endpoints that IoT hub routes messages to, based on the routing rules.
   */
  cosmosDBSqlContainers?: RoutingCosmosDBSqlApiProperties[];
}

/**
 * The properties related to service bus queue endpoint types.
 */
model RoutingServiceBusQueueEndpointProperties {
  /**
   * Id of the service bus queue endpoint
   */
  id?: string;

  /**
   * The connection string of the service bus queue endpoint.
   */
  connectionString?: string;

  /**
   * The url of the service bus queue endpoint. It must include the protocol sb://
   */
  endpointUri?: string;

  /**
   * Queue name on the service bus namespace
   */
  entityPath?: string;

  /**
   * Method used to authenticate against the service bus queue endpoint
   */
  authenticationType?: AuthenticationType;

  /**
   * Managed identity properties of routing service bus queue endpoint.
   */
  identity?: ManagedIdentity;

  /**
   * The name that identifies this endpoint. The name can only include alphanumeric characters, periods, underscores, hyphens and has a maximum length of 64 characters. The following names are reserved:  events, fileNotifications, $default. Endpoint names must be unique across endpoint types. The name need not be the same as the actual queue name.
   */
  @pattern("^[A-Za-z0-9-._]{1,64}$")
  name: string;

  /**
   * The subscription identifier of the service bus queue endpoint.
   */
  subscriptionId?: string;

  /**
   * The name of the resource group of the service bus queue endpoint.
   */
  resourceGroup?: string;
}

/**
 * The properties of the Managed identity.
 */
model ManagedIdentity {
  /**
   * The user assigned identity.
   */
  userAssignedIdentity?: string;
}

/**
 * The properties related to service bus topic endpoint types.
 */
model RoutingServiceBusTopicEndpointProperties {
  /**
   * Id of the service bus topic endpoint
   */
  id?: string;

  /**
   * The connection string of the service bus topic endpoint.
   */
  connectionString?: string;

  /**
   * The url of the service bus topic endpoint. It must include the protocol sb://
   */
  endpointUri?: string;

  /**
   * Queue name on the service bus topic
   */
  entityPath?: string;

  /**
   * Method used to authenticate against the service bus topic endpoint
   */
  authenticationType?: AuthenticationType;

  /**
   * Managed identity properties of routing service bus topic endpoint.
   */
  identity?: ManagedIdentity;

  /**
   * The name that identifies this endpoint. The name can only include alphanumeric characters, periods, underscores, hyphens and has a maximum length of 64 characters. The following names are reserved:  events, fileNotifications, $default. Endpoint names must be unique across endpoint types.  The name need not be the same as the actual topic name.
   */
  @pattern("^[A-Za-z0-9-._]{1,64}$")
  name: string;

  /**
   * The subscription identifier of the service bus topic endpoint.
   */
  subscriptionId?: string;

  /**
   * The name of the resource group of the service bus topic endpoint.
   */
  resourceGroup?: string;
}

/**
 * The properties related to an event hub endpoint.
 */
model RoutingEventHubProperties {
  /**
   * Id of the event hub endpoint
   */
  id?: string;

  /**
   * The connection string of the event hub endpoint.
   */
  connectionString?: string;

  /**
   * The url of the event hub endpoint. It must include the protocol sb://
   */
  endpointUri?: string;

  /**
   * Event hub name on the event hub namespace
   */
  entityPath?: string;

  /**
   * Method used to authenticate against the event hub endpoint
   */
  authenticationType?: AuthenticationType;

  /**
   * Managed identity properties of routing event hub endpoint.
   */
  identity?: ManagedIdentity;

  /**
   * The name that identifies this endpoint. The name can only include alphanumeric characters, periods, underscores, hyphens and has a maximum length of 64 characters. The following names are reserved:  events, fileNotifications, $default. Endpoint names must be unique across endpoint types.
   */
  @pattern("^[A-Za-z0-9-._]{1,64}$")
  name: string;

  /**
   * The subscription identifier of the event hub endpoint.
   */
  subscriptionId?: string;

  /**
   * The name of the resource group of the event hub endpoint.
   */
  resourceGroup?: string;
}

/**
 * The properties related to a storage container endpoint.
 */
model RoutingStorageContainerProperties {
  /**
   * Id of the storage container endpoint
   */
  id?: string;

  /**
   * The connection string of the storage account.
   */
  connectionString?: string;

  /**
   * The url of the storage endpoint. It must include the protocol https://
   */
  endpointUri?: string;

  /**
   * Method used to authenticate against the storage endpoint
   */
  authenticationType?: AuthenticationType;

  /**
   * Managed identity properties of routing storage endpoint.
   */
  identity?: ManagedIdentity;

  /**
   * The name that identifies this endpoint. The name can only include alphanumeric characters, periods, underscores, hyphens and has a maximum length of 64 characters. The following names are reserved:  events, fileNotifications, $default. Endpoint names must be unique across endpoint types.
   */
  @pattern("^[A-Za-z0-9-._]{1,64}$")
  name: string;

  /**
   * The subscription identifier of the storage account.
   */
  subscriptionId?: string;

  /**
   * The name of the resource group of the storage account.
   */
  resourceGroup?: string;

  /**
   * The name of storage container in the storage account.
   */
  containerName: string;

  /**
   * File name format for the blob. Default format is {iothub}/{partition}/{YYYY}/{MM}/{DD}/{HH}/{mm}. All parameters are mandatory but can be reordered.
   */
  fileNameFormat?: string;

  /**
   * Time interval at which blobs are written to storage. Value should be between 60 and 720 seconds. Default value is 300 seconds.
   */
  @maxValue(720)
  @minValue(60)
  batchFrequencyInSeconds?: int32;

  /**
   * Maximum number of bytes for each blob written to storage. Value should be between 10485760(10MB) and 524288000(500MB). Default value is 314572800(300MB).
   */
  @maxValue(524288000)
  @minValue(10485760)
  maxChunkSizeInBytes?: int32;

  /**
   * Encoding that is used to serialize messages to blobs. Supported values are 'avro', 'avrodeflate', and 'JSON'. Default value is 'avro'.
   */
  encoding?: RoutingStorageContainerPropertiesEncoding;
}

/**
 * The properties related to a cosmos DB sql container endpoint.
 */
model RoutingCosmosDBSqlApiProperties {
  /**
   * The name that identifies this endpoint. The name can only include alphanumeric characters, periods, underscores, hyphens and has a maximum length of 64 characters. The following names are reserved:  events, fileNotifications, $default. Endpoint names must be unique across endpoint types.
   */
  @pattern("^[A-Za-z0-9-._]{1,64}$")
  name: string;

  /**
   * Id of the cosmos DB sql container endpoint
   */
  @visibility("read")
  id?: string;

  /**
   * The subscription identifier of the cosmos DB account.
   */
  subscriptionId?: string;

  /**
   * The name of the resource group of the cosmos DB account.
   */
  resourceGroup?: string;

  /**
   * The url of the cosmos DB account. It must include the protocol https://
   */
  endpointUri: url;

  /**
   * Method used to authenticate against the cosmos DB sql container endpoint
   */
  authenticationType?: AuthenticationType;

  /**
   * Managed identity properties of routing cosmos DB container endpoint.
   */
  identity?: ManagedIdentity;

  /**
   * The primary key of the cosmos DB account.
   */
  primaryKey?: string;

  /**
   * The secondary key of the cosmos DB account.
   */
  secondaryKey?: string;

  /**
   * The name of the cosmos DB database in the cosmos DB account.
   */
  databaseName: string;

  /**
   * The name of the cosmos DB sql container in the cosmos DB database.
   */
  containerName: string;

  /**
   * The name of the partition key associated with this cosmos DB sql container if one exists. This is an optional parameter.
   */
  partitionKeyName?: string;

  /**
   * The template for generating a synthetic partition key value for use with this cosmos DB sql container. The template must include at least one of the following placeholders: {iothub}, {deviceid}, {DD}, {MM}, and {YYYY}. Any one placeholder may be specified at most once, but order and non-placeholder components are arbitrary. This parameter is only required if PartitionKeyName is specified.
   */
  partitionKeyTemplate?: string;
}

/**
 * The properties of a routing rule that your IoT hub uses to route messages to endpoints.
 */
model RouteProperties {
  /**
   * The name of the route. The name can only include alphanumeric characters, periods, underscores, hyphens, has a maximum length of 64 characters, and must be unique.
   */
  @pattern("^[A-Za-z0-9-._]{1,64}$")
  name: string;

  /**
   * The source that the routing rule is to be applied to, such as DeviceMessages.
   */
  source: RoutingSource;

  /**
   * The condition that is evaluated to apply the routing rule. If no condition is provided, it evaluates to true by default. For grammar, see: https://docs.microsoft.com/azure/iot-hub/iot-hub-devguide-query-language
   */
  condition?: string;

  /**
   * The list of endpoints to which messages that satisfy the condition are routed. Currently only one endpoint is allowed.
   */
  endpointNames: string[];

  /**
   * Used to specify whether a route is enabled.
   */
  isEnabled: boolean;
}

/**
 * The properties of the fallback route. IoT Hub uses these properties when it routes messages to the fallback endpoint.
 */
model FallbackRouteProperties {
  /**
   * The name of the route. The name can only include alphanumeric characters, periods, underscores, hyphens, has a maximum length of 64 characters, and must be unique.
   */
  name?: string;

  /**
   * The source to which the routing rule is to be applied to. For example, DeviceMessages
   */
  source: RoutingSource;

  /**
   * The condition which is evaluated in order to apply the fallback route. If the condition is not provided it will evaluate to true by default. For grammar, See: https://docs.microsoft.com/azure/iot-hub/iot-hub-devguide-query-language
   */
  condition?: string;

  /**
   * The list of endpoints to which the messages that satisfy the condition are routed to. Currently only 1 endpoint is allowed.
   */
  endpointNames: string[];

  /**
   * Used to specify whether the fallback route is enabled.
   */
  isEnabled: boolean;
}

/**
 * The properties of an enrichment that your IoT hub applies to messages delivered to endpoints.
 */
model EnrichmentProperties {
  /**
   * The key or name for the enrichment property.
   */
  key: string;

  /**
   * The value for the enrichment property.
   */
  value: string;

  /**
   * The list of endpoints for which the enrichment is applied to the message.
   */
  endpointNames: string[];
}

/**
 * The properties of the Azure Storage endpoint for file upload.
 */
model StorageEndpointProperties {
  /**
   * The period of time for which the SAS URI generated by IoT Hub for file upload is valid. See: https://docs.microsoft.com/azure/iot-hub/iot-hub-devguide-file-upload#file-upload-notification-configuration-options.
   */
  sasTtlAsIso8601?: duration;

  /**
   * The connection string for the Azure Storage account to which files are uploaded.
   */
  connectionString: string;

  /**
   * The name of the root container where you upload files. The container need not exist but should be creatable using the connectionString specified.
   */
  containerName: string;

  /**
   * Specifies authentication type being used for connecting to the storage account.
   */
  authenticationType?: AuthenticationType;

  /**
   * Managed identity properties of storage endpoint for file upload.
   */
  identity?: ManagedIdentity;
}

/**
 * The properties of the messaging endpoints used by this IoT hub.
 */
model MessagingEndpointProperties {
  /**
   * The lock duration. See: https://docs.microsoft.com/azure/iot-hub/iot-hub-devguide-file-upload.
   */
  lockDurationAsIso8601?: duration;

  /**
   * The period of time for which a message is available to consume before it is expired by the IoT hub. See: https://docs.microsoft.com/azure/iot-hub/iot-hub-devguide-file-upload.
   */
  ttlAsIso8601?: duration;

  /**
   * The number of times the IoT hub attempts to deliver a message. See: https://docs.microsoft.com/azure/iot-hub/iot-hub-devguide-file-upload.
   */
  @maxValue(100)
  @minValue(1)
  maxDeliveryCount?: int32;
}

/**
 * The IoT hub cloud-to-device messaging properties.
 */
model CloudToDeviceProperties {
  /**
   * The max delivery count for cloud-to-device messages in the device queue. See: https://docs.microsoft.com/azure/iot-hub/iot-hub-devguide-messaging#cloud-to-device-messages.
   */
  @maxValue(100)
  @minValue(1)
  maxDeliveryCount?: int32;

  /**
   * The default time to live for cloud-to-device messages in the device queue. See: https://docs.microsoft.com/azure/iot-hub/iot-hub-devguide-messaging#cloud-to-device-messages.
   */
  defaultTtlAsIso8601?: duration;

  /**
   * The properties of the feedback queue for cloud-to-device messages.
   */
  feedback?: FeedbackProperties;
}

/**
 * The properties of the feedback queue for cloud-to-device messages.
 */
model FeedbackProperties {
  /**
   * The lock duration for the feedback queue. See: https://docs.microsoft.com/azure/iot-hub/iot-hub-devguide-messaging#cloud-to-device-messages.
   */
  lockDurationAsIso8601?: duration;

  /**
   * The period of time for which a message is available to consume before it is expired by the IoT hub. See: https://docs.microsoft.com/azure/iot-hub/iot-hub-devguide-messaging#cloud-to-device-messages.
   */
  ttlAsIso8601?: duration;

  /**
   * The number of times the IoT hub attempts to deliver a message on the feedback queue. See: https://docs.microsoft.com/azure/iot-hub/iot-hub-devguide-messaging#cloud-to-device-messages.
   */
  @maxValue(100)
  @minValue(1)
  maxDeliveryCount?: int32;
}

/**
 * Public representation of one of the locations where a resource is provisioned.
 */
model IotHubLocationDescription {
  /**
   * The name of the Azure region
   */
  location?: string;

  /**
   * The role of the region, can be either primary or secondary. The primary region is where the IoT hub is currently provisioned. The secondary region is the Azure disaster recovery (DR) paired region and also the region where the IoT hub can failover to.
   */
  role?: IotHubReplicaRoleType;
}

/**
 * Information about the SKU of the IoT hub.
 */
model IotHubSkuInfo {
  /**
   * The name of the SKU.
   */
  name: IotHubSku;

  /**
   * The billing tier for the IoT hub.
   */
  @visibility("read")
  tier?: IotHubSkuTier;

  /**
   * The number of provisioned IoT Hub units. See: https://docs.microsoft.com/azure/azure-subscription-service-limits#iot-hub-limits.
   */
  capacity?: int64;
}

model ArmIdentity {
  /**
   * Principal Id
   */
  @visibility("read")
  principalId?: string;

  /**
   * Tenant Id
   */
  @visibility("read")
  tenantId?: string;

  /**
   * The type of identity used for the resource. The type 'SystemAssigned, UserAssigned' includes both an implicitly created identity and a set of user assigned identities. The type 'None' will remove any identities from the service.
   */
  type?: ResourceIdentityType;

  /**
   * Dictionary of <ArmUserIdentity>
   */
  userAssignedIdentities?: Record<ArmUserIdentity>;
}

model ArmUserIdentity {
  @visibility("read")
  principalId?: string;

  @visibility("read")
  clientId?: string;
}

/**
 * The common properties of an Azure resource.
 */
model Resource {
  /**
   * The resource identifier.
   */
  @visibility("read")
  id?: string;

  /**
   * The resource name.
   */
  @visibility("read")
  @pattern("^(?![0-9]+$)(?!-)[a-zA-Z0-9-]{2,49}[a-zA-Z0-9]$")
  name?: string;

  /**
   * The resource type.
   */
  @visibility("read")
  type?: string;

  /**
   * The resource location.
   */
  location: string;

  /**
   * The resource tags.
   */
  tags?: Record<string>;
}

/**
 * A container holding only the Tags for a resource, allowing the user to update the tags on an IoT Hub instance.
 */
model TagsResource {
  /**
   * Resource tags
   */
  tags?: Record<string>;
}

/**
 * Identity registry statistics.
 */
model RegistryStatistics {
  /**
   * The total count of devices in the identity registry.
   */
  @visibility("read")
  totalDeviceCount?: int64;

  /**
   * The count of enabled devices in the identity registry.
   */
  @visibility("read")
  enabledDeviceCount?: int64;

  /**
   * The count of disabled devices in the identity registry.
   */
  @visibility("read")
  disabledDeviceCount?: int64;
}

/**
 * The JSON-serialized array of IotHubSkuDescription objects with a next link.
 */
model IotHubSkuDescriptionListResult is Azure.Core.Page<IotHubSkuDescription>;

/**
 * SKU properties.
 */
model IotHubSkuDescription {
  /**
   * The type of the resource.
   */
  @visibility("read")
  resourceType?: string;

  /**
   * The type of the resource.
   */
  sku: IotHubSkuInfo;

  /**
   * IotHub capacity
   */
  capacity: IotHubCapacity;
}

/**
 * IoT Hub capacity information.
 */
model IotHubCapacity {
  /**
   * The minimum number of units.
   */
  @visibility("read")
  @maxValue(1)
  @minValue(1)
  minimum?: int64;

  /**
   * The maximum number of units.
   */
  @visibility("read")
  maximum?: int64;

  /**
   * The default number of units.
   */
  @visibility("read")
  default?: int64;

  /**
   * The type of the scaling enabled.
   */
  @visibility("read")
  scaleType?: IotHubScaleType;
}

/**
 * The EventHub consumer group.
 */
model ConsumerGroupEventHubContent {
  /**
   * The EventHub consumer group name.
   */
  @extension("x-ms-client-flatten", true)
  properties: EventHubConsumerGroupName;
}

/**
 * The EventHub consumer group name.
 */
model EventHubConsumerGroupName {
  /**
   * EventHub consumer group name
   */
  name: string;
}

/**
 * The JSON-serialized array of JobResponse objects with a next link.
 */
model JobResponseListResult is Azure.Core.Page<JobResponse>;

/**
 * The properties of the Job Response object.
 */
model JobResponse {
  /**
   * The job identifier.
   */
  @visibility("read")
  jobId?: string;

  /**
   * The start time of the job.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTimeUtc?: utcDateTime;

  /**
   * The time the job stopped processing.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTimeUtc?: utcDateTime;

  /**
   * The type of the job.
   */
  @visibility("read")
  type?: JobType;

  /**
   * The status of the job.
   */
  @visibility("read")
  status?: JobStatus;

  /**
   * If status == failed, this string containing the reason for the failure.
   */
  @visibility("read")
  failureReason?: string;

  /**
   * The status message for the job.
   */
  @visibility("read")
  statusMessage?: string;

  /**
   * The job identifier of the parent job, if any.
   */
  @visibility("read")
  parentJobId?: string;
}

/**
 * The JSON-serialized array of IotHubQuotaMetricInfo objects with a next link.
 */
model IotHubQuotaMetricInfoListResult is Azure.Core.Page<IotHubQuotaMetricInfo>;

/**
 * Quota metrics properties.
 */
model IotHubQuotaMetricInfo {
  /**
   * The name of the quota metric.
   */
  @visibility("read")
  name?: string;

  /**
   * The current value for the quota metric.
   */
  @visibility("read")
  currentValue?: int64;

  /**
   * The maximum value of the quota metric.
   */
  @visibility("read")
  maxValue?: int64;
}

/**
 * The JSON-serialized array of EndpointHealthData objects with a next link.
 */
model EndpointHealthDataListResult is Azure.Core.Page<EndpointHealthData>;

/**
 * The health data for an endpoint
 */
model EndpointHealthData {
  /**
   * Id of the endpoint
   */
  endpointId?: string;

  /**
   * Health statuses have following meanings. The 'healthy' status shows that the endpoint is accepting messages as expected. The 'unhealthy' status shows that the endpoint is not accepting messages as expected and IoT Hub is retrying to send data to this endpoint. The status of an unhealthy endpoint will be updated to healthy when IoT Hub has established an eventually consistent state of health. The 'dead' status shows that the endpoint is not accepting messages, after IoT Hub retried sending messages for the retrial period. See IoT Hub metrics to identify errors and monitor issues with endpoints. The 'unknown' status shows that the IoT Hub has not established a connection with the endpoint. No messages have been delivered to or rejected from this endpoint
   */
  healthStatus?: EndpointHealthStatus;

  /**
   * Last error obtained when a message failed to be delivered to iot hub
   */
  lastKnownError?: string;

  /**
   * Time at which the last known error occurred
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastKnownErrorTime?: utcDateTime;

  /**
   * Last time iot hub successfully sent a message to the endpoint
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastSuccessfulSendAttemptTime?: utcDateTime;

  /**
   * Last time iot hub tried to send a message to the endpoint
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastSendAttemptTime?: utcDateTime;
}

/**
 * Input values.
 */
model OperationInputs {
  /**
   * The name of the IoT hub to check.
   */
  name: string;
}

/**
 * The properties indicating whether a given IoT hub name is available.
 */
model IotHubNameAvailabilityInfo {
  /**
   * The value which indicates whether the provided name is available.
   */
  @visibility("read")
  nameAvailable?: boolean;

  /**
   * The reason for unavailability.
   */
  @visibility("read")
  reason?: IotHubNameUnavailabilityReason;

  /**
   * The detailed reason message.
   */
  message?: string;
}

/**
 * Json-serialized array of User subscription quota response
 */
model UserSubscriptionQuotaListResult {
  value?: UserSubscriptionQuota[];

  @visibility("read")
  nextLink?: string;
}

/**
 * User subscription quota response
 */
model UserSubscriptionQuota {
  /**
   * IotHub type id
   */
  id?: string;

  /**
   * Response type
   */
  type?: string;

  /**
   * Unit of IotHub type
   */
  unit?: string;

  /**
   * Current number of IotHub type
   */
  currentValue?: int32;

  /**
   * Numerical limit on IotHub type
   */
  limit?: int32;

  /**
   * IotHub type
   */
  name?: Name;
}

/**
 * Name of Iot Hub type
 */
model Name {
  /**
   * IotHub type
   */
  value?: string;

  /**
   * Localized value of name
   */
  localizedValue?: string;
}

/**
 * Input for testing all routes
 */
model TestAllRoutesInput {
  /**
   * Routing source
   */
  routingSource?: RoutingSource;

  /**
   * Routing message
   */
  message?: RoutingMessage;

  /**
   * Routing Twin Reference
   */
  twin?: RoutingTwin;
}

/**
 * Routing message
 */
model RoutingMessage {
  /**
   * Body of routing message
   */
  body?: string;

  /**
   * App properties
   */
  appProperties?: Record<string>;

  /**
   * System properties
   */
  systemProperties?: Record<string>;
}

/**
 * Twin reference input parameter. This is an optional parameter
 */
model RoutingTwin {
  /**
   * Twin Tags
   */
  tags?: Record<unknown>;

  properties?: RoutingTwinProperties;
}

model RoutingTwinProperties {
  /**
   * Twin desired properties
   */
  desired?: Record<unknown>;

  /**
   * Twin desired properties
   */
  reported?: Record<unknown>;
}

/**
 * Result of testing all routes
 */
model TestAllRoutesResult {
  /**
   * JSON-serialized array of matched routes
   */
  routes?: MatchedRoute[];
}

/**
 * Routes that matched
 */
model MatchedRoute {
  /**
   * Properties of routes that matched
   */
  properties?: RouteProperties;
}

/**
 * Input for testing route
 */
model TestRouteInput {
  /**
   * Routing message
   */
  message?: RoutingMessage;

  /**
   * Route properties
   */
  route: RouteProperties;

  /**
   * Routing Twin Reference
   */
  twin?: RoutingTwin;
}

/**
 * Result of testing one route
 */
model TestRouteResult {
  /**
   * Result of testing route
   */
  result?: TestResultStatus;

  /**
   * Detailed result of testing route
   */
  details?: TestRouteResultDetails;
}

/**
 * Detailed result of testing a route
 */
model TestRouteResultDetails {
  /**
   * JSON-serialized list of route compilation errors
   */
  compilationErrors?: RouteCompilationError[];
}

/**
 * Compilation error when evaluating route
 */
model RouteCompilationError {
  /**
   * Route error message
   */
  message?: string;

  /**
   * Severity of the route error
   */
  severity?: RouteErrorSeverity;

  /**
   * Location where the route error happened
   */
  location?: RouteErrorRange;
}

/**
 * Range of route errors
 */
model RouteErrorRange {
  /**
   * Start where the route error happened
   */
  start?: RouteErrorPosition;

  /**
   * End where the route error happened
   */
  end?: RouteErrorPosition;
}

/**
 * Position where the route error happened
 */
model RouteErrorPosition {
  /**
   * Line where the route error happened
   */
  line?: int32;

  /**
   * Column where the route error happened
   */
  column?: int32;
}

/**
 * The list of shared access policies with a next link.
 */
model SharedAccessSignatureAuthorizationRuleListResult
  is Azure.Core.Page<SharedAccessSignatureAuthorizationRule>;

/**
 * Use to provide parameters when requesting an export of all devices in the IoT hub.
 */
model ExportDevicesRequest {
  /**
   * The export blob container URI.
   */
  exportBlobContainerUri: string;

  /**
   * The value indicating whether keys should be excluded during export.
   */
  excludeKeys: boolean;

  /**
   * The name of the blob that will be created in the provided output blob container. This blob will contain the exported device registry information for the IoT Hub.
   */
  exportBlobName?: string;

  /**
   * Specifies authentication type being used for connecting to the storage account.
   */
  authenticationType?: AuthenticationType;

  /**
   * Managed identity properties of storage endpoint for export devices.
   */
  identity?: ManagedIdentity;

  /**
   * The value indicating whether configurations should be exported.
   */
  includeConfigurations?: boolean;

  /**
   * The name of the blob that will be created in the provided output blob container. This blob will contain the exported configurations for the Iot Hub.
   */
  configurationsBlobName?: string;
}

/**
 * Use to provide parameters when requesting an import of all devices in the hub.
 */
model ImportDevicesRequest {
  /**
   * The input blob container URI.
   */
  inputBlobContainerUri: string;

  /**
   * The output blob container URI.
   */
  outputBlobContainerUri: string;

  /**
   * The blob name to be used when importing from the provided input blob container.
   */
  inputBlobName?: string;

  /**
   * The blob name to use for storing the status of the import job.
   */
  outputBlobName?: string;

  /**
   * Specifies authentication type being used for connecting to the storage account.
   */
  authenticationType?: AuthenticationType;

  /**
   * Managed identity properties of storage endpoint for import devices.
   */
  identity?: ManagedIdentity;

  /**
   * The value indicating whether configurations should be imported.
   */
  includeConfigurations?: boolean;

  /**
   * The blob name to be used when importing configurations from the provided input blob container.
   */
  configurationsBlobName?: string;
}

/**
 * The description of an X509 CA Certificate.
 */
model CertificateProperties {
  /**
   * The certificate's subject name.
   */
  @visibility("read")
  subject?: string;

  /**
   * The certificate's expiration date and time.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expiry?: utcDateTime;

  /**
   * The certificate's thumbprint.
   */
  @visibility("read")
  thumbprint?: string;

  /**
   * Determines whether certificate has been verified.
   */
  isVerified?: boolean;

  /**
   * The certificate's create date and time.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  created?: utcDateTime;

  /**
   * The certificate's last update date and time.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  updated?: utcDateTime;

  /**
   * The certificate content
   */
  certificate?: string;
}

/**
 * The X509 Certificate.
 */
model CertificateWithNonceDescription {
  /**
   * The description of an X509 CA Certificate including the challenge nonce issued for the Proof-Of-Possession flow.
   */
  properties?: CertificatePropertiesWithNonce;

  /**
   * The resource identifier.
   */
  @visibility("read")
  id?: string;

  /**
   * The name of the certificate.
   */
  @visibility("read")
  name?: string;

  /**
   * The entity tag.
   */
  @visibility("read")
  etag?: string;

  /**
   * The resource type.
   */
  @visibility("read")
  type?: string;
}

/**
 * The description of an X509 CA Certificate including the challenge nonce issued for the Proof-Of-Possession flow.
 */
model CertificatePropertiesWithNonce {
  /**
   * The certificate's subject name.
   */
  @visibility("read")
  subject?: string;

  /**
   * The certificate's expiration date and time.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expiry?: utcDateTime;

  /**
   * The certificate's thumbprint.
   */
  @visibility("read")
  thumbprint?: string;

  /**
   * Determines whether certificate has been verified.
   */
  @visibility("read")
  isVerified?: boolean;

  /**
   * The certificate's create date and time.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  created?: utcDateTime;

  /**
   * The certificate's last update date and time.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  updated?: utcDateTime;

  /**
   * The certificate's verification code that will be used for proof of possession.
   */
  @visibility("read")
  verificationCode?: string;

  /**
   * The certificate content
   */
  @visibility("read")
  certificate?: string;
}

/**
 * The JSON-serialized leaf certificate
 */
model CertificateVerificationDescription {
  /**
   * base-64 representation of X509 certificate .cer file or just .pem file content.
   */
  certificate?: string;
}

/**
 * Use to provide failover region when requesting manual Failover for a hub.
 */
model FailoverInput {
  /**
   * Region the hub will be failed over to
   */
  failoverRegion: string;
}

/**
 * The properties for a group information object
 */
model GroupIdInformationProperties {
  /**
   * The group id
   */
  groupId?: string;

  /**
   * The required members for a specific group id
   */
  requiredMembers?: string[];

  /**
   * The required DNS zones for a specific group id
   */
  requiredZoneNames?: string[];
}

/**
 * The JSON-serialized X509 Certificate.
 */
model CertificateBodyDescription {
  /**
   * base-64 representation of the X509 leaf certificate .cer file or just .pem file content.
   */
  certificate?: string;

  /**
   * True indicates that the certificate will be created in verified state and proof of possession will not be required.
   */
  isVerified?: boolean;
}
