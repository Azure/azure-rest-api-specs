import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Devices;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("Whether requests from Public Network are allowed")
enum PublicNetworkAccess {
  Enabled,
  Disabled,
}

@doc("Default Action for Network Rule Set")
enum DefaultAction {
  Deny,
  Allow,
}

@doc("IP Filter Action")
enum NetworkRuleIPAction {
  Allow,
}

@doc("The status of a private endpoint connection")
enum PrivateLinkServiceConnectionStatus {
  Pending,
  Approved,
  Rejected,
  Disconnected,
}

@doc("Specifies authentication type being used for connecting to the storage account.")
enum AuthenticationType {
  keyBased,
  identityBased,
}

@doc("Encoding that is used to serialize messages to blobs. Supported values are 'avro', 'avrodeflate', and 'JSON'. Default value is 'avro'.")
enum RoutingStorageContainerPropertiesEncoding {
  Avro,
  AvroDeflate,
  JSON,
}

@doc("The source that the routing rule is to be applied to, such as DeviceMessages.")
enum RoutingSource {
  Invalid,
  DeviceMessages,
  TwinChangeEvents,
  DeviceLifecycleEvents,
  DeviceJobLifecycleEvents,
  DeviceConnectionStateEvents,
}

@doc("The capabilities and features enabled for the IoT hub.")
enum Capabilities {
  None,
  DeviceManagement,
}

@doc("The role of the region, can be either primary or secondary. The primary region is where the IoT hub is currently provisioned. The secondary region is the Azure disaster recovery (DR) paired region and also the region where the IoT hub can failover to.")
enum IotHubReplicaRoleType {
  primary,
  secondary,
}

@doc("The name of the SKU.")
enum IotHubSku {
  F1,
  S1,
  S2,
  S3,
  B1,
  B2,
  B3,
}

@doc("The type of the job.")
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

@doc("Health statuses have following meanings. The 'healthy' status shows that the endpoint is accepting messages as expected. The 'unhealthy' status shows that the endpoint is not accepting messages as expected and IoT Hub is retrying to send data to this endpoint. The status of an unhealthy endpoint will be updated to healthy when IoT Hub has established an eventually consistent state of health. The 'dead' status shows that the endpoint is not accepting messages, after IoT Hub retried sending messages for the retrial period. See IoT Hub metrics to identify errors and monitor issues with endpoints. The 'unknown' status shows that the IoT Hub has not established a connection with the endpoint. No messages have been delivered to or rejected from this endpoint")
enum EndpointHealthStatus {
  `unknown`,
  healthy,
  degraded,
  unhealthy,
  dead,
}

@doc("Result of testing route")
enum TestResultStatus {
  undefined,
  `false`,
  `true`,
}

@doc("Severity of the route error")
enum RouteErrorSeverity {
  error,
  warning,
}

@doc("The permissions assigned to the shared access policy.")
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

@doc("The desired action for requests captured by this rule.")
@fixed
enum IpFilterActionType {
  Accept,
  Reject,
}

@doc("The billing tier for the IoT hub.")
@fixed
enum IotHubSkuTier {
  Free,
  Standard,
  Basic,
}

@doc("The type of identity used for the resource. The type 'SystemAssigned, UserAssigned' includes both an implicitly created identity and a set of user assigned identities. The type 'None' will remove any identities from the service.")
@fixed
enum ResourceIdentityType {
  SystemAssigned,
  UserAssigned,
  `SystemAssigned, UserAssigned`,
  None,
}

@doc("The type of the scaling enabled.")
@fixed
enum IotHubScaleType {
  Automatic,
  Manual,
  None,
}

@doc("The status of the job.")
@fixed
enum JobStatus {
  `unknown`,
  enqueued,
  running,
  completed,
  failed,
  cancelled,
}

@doc("The reason for unavailability.")
@fixed
enum IotHubNameUnavailabilityReason {
  Invalid,
  AlreadyExists,
}

@doc("Error details.")
@error
model ErrorDetails {
  @doc("The error code.")
  @visibility("read")
  code?: string;

  @doc("The HTTP status code.")
  @visibility("read")
  httpStatusCode?: string;

  @doc("The error message.")
  @visibility("read")
  message?: string;

  @doc("The error details.")
  @visibility("read")
  details?: string;
}

@doc("The properties of an IoT hub.")
model IotHubProperties {
  @doc("The shared access policies you can use to secure a connection to the IoT hub.")
  authorizationPolicies?: SharedAccessSignatureAuthorizationRule[];

  @doc("If true, SAS tokens with Iot hub scoped SAS keys cannot be used for authentication.")
  disableLocalAuth?: boolean;

  @doc("If true, all device(including Edge devices but excluding modules) scoped SAS keys cannot be used for authentication.")
  disableDeviceSAS?: boolean;

  @doc("If true, all module scoped SAS keys cannot be used for authentication.")
  disableModuleSAS?: boolean;

  @doc("If true, egress from IotHub will be restricted to only the allowed FQDNs that are configured via allowedFqdnList.")
  restrictOutboundNetworkAccess?: boolean;

  @doc("List of allowed FQDNs(Fully Qualified Domain Name) for egress from Iot Hub.")
  allowedFqdnList?: string[];

  @doc("Whether requests from Public Network are allowed")
  publicNetworkAccess?: PublicNetworkAccess;

  @doc("The IP filter rules.")
  ipFilterRules?: IpFilterRule[];

  @doc("Network Rule Set Properties of IotHub")
  networkRuleSets?: NetworkRuleSetProperties;

  @doc("Specifies the minimum TLS version to support for this hub. Can be set to \"1.2\" to have clients that use a TLS version below 1.2 to be rejected.")
  minTlsVersion?: string;

  @doc("Private endpoint connections created on this IotHub")
  privateEndpointConnections?: PrivateEndpointConnection[];

  @doc("The provisioning state.")
  @visibility("read")
  provisioningState?: string;

  @doc("The hub state.")
  @visibility("read")
  state?: string;

  @doc("The name of the host.")
  @visibility("read")
  hostName?: string;

  @doc("The Event Hub-compatible endpoint properties. The only possible keys to this dictionary is events. This key has to be present in the dictionary while making create or update calls for the IoT hub.")
  eventHubEndpoints?: Record<EventHubProperties>;

  @doc("The routing related properties of the IoT hub. See: https://docs.microsoft.com/azure/iot-hub/iot-hub-devguide-messaging")
  routing?: RoutingProperties;

  @doc("The list of Azure Storage endpoints where you can upload files. Currently you can configure only one Azure Storage account and that MUST have its key as $default. Specifying more than one storage account causes an error to be thrown. Not specifying a value for this property when the enableFileUploadNotifications property is set to True, causes an error to be thrown.")
  storageEndpoints?: Record<StorageEndpointProperties>;

  @doc("The messaging endpoint properties for the file upload notification queue.")
  messagingEndpoints?: Record<MessagingEndpointProperties>;

  @doc("If True, file upload notifications are enabled.")
  enableFileUploadNotifications?: boolean;

  @doc("The IoT hub cloud-to-device messaging properties.")
  cloudToDevice?: CloudToDeviceProperties;

  @doc("IoT hub comments.")
  comments?: string;

  @doc("The capabilities and features enabled for the IoT hub.")
  features?: Capabilities;

  @doc("Primary and secondary location for iot hub")
  @visibility("read")
  locations?: IotHubLocationDescription[];

  @doc("This property when set to true, will enable data residency, thus, disabling disaster recovery.")
  enableDataResidency?: boolean;
}

@doc("The properties of an IoT hub shared access policy.")
model SharedAccessSignatureAuthorizationRule {
  @doc("The name of the shared access policy.")
  keyName: string;

  @doc("The primary key.")
  primaryKey?: string;

  @doc("The secondary key.")
  secondaryKey?: string;

  @doc("The permissions assigned to the shared access policy.")
  rights: AccessRights;
}

@doc("The IP filter rules for the IoT hub.")
model IpFilterRule {
  @doc("The name of the IP filter rule.")
  filterName: string;

  @doc("The desired action for requests captured by this rule.")
  action: IpFilterActionType;

  @doc("A string that contains the IP address range in CIDR notation for the rule.")
  ipMask: string;
}

@doc("Network Rule Set Properties of IotHub")
model NetworkRuleSetProperties {
  @doc("Default Action for Network Rule Set")
  defaultAction?: DefaultAction;

  @doc("If True, then Network Rule Set is also applied to BuiltIn EventHub EndPoint of IotHub")
  applyToBuiltInEventHubEndpoint: boolean;

  @doc("List of IP Rules")
  ipRules: NetworkRuleSetIpRule[];
}

@doc("IP Rule to be applied as part of Network Rule Set")
model NetworkRuleSetIpRule {
  @doc("Name of the IP filter rule.")
  filterName: string;

  @doc("IP Filter Action")
  action?: NetworkRuleIPAction;

  @doc("A string that contains the IP address range in CIDR notation for the rule.")
  ipMask: string;
}

@doc("The properties of a private endpoint connection")
model PrivateEndpointConnectionProperties {
  @doc("The private endpoint property of a private endpoint connection")
  privateEndpoint?: PrivateEndpoint;

  @doc("The current state of a private endpoint connection")
  privateLinkServiceConnectionState: PrivateLinkServiceConnectionState;
}

@doc("The private endpoint property of a private endpoint connection")
model PrivateEndpoint {
  @doc("The resource identifier.")
  @visibility("read")
  id?: string;
}

@doc("The current state of a private endpoint connection")
model PrivateLinkServiceConnectionState {
  @doc("The status of a private endpoint connection")
  status: PrivateLinkServiceConnectionStatus;

  @doc("The description for the current state of a private endpoint connection")
  description: string;

  @doc("Actions required for a private endpoint connection")
  actionsRequired?: string;
}

@doc("The properties of the provisioned Event Hub-compatible endpoint used by the IoT hub.")
model EventHubProperties {
  @doc("The retention time for device-to-cloud messages in days. See: https://docs.microsoft.com/azure/iot-hub/iot-hub-devguide-messaging#device-to-cloud-messages")
  retentionTimeInDays?: int32;

  @doc("The number of partitions for receiving device-to-cloud messages in the Event Hub-compatible endpoint. See: https://docs.microsoft.com/azure/iot-hub/iot-hub-devguide-messaging#device-to-cloud-messages.")
  partitionCount?: int32;

  @doc("The partition ids in the Event Hub-compatible endpoint.")
  @visibility("read")
  partitionIds?: string[];

  @doc("The Event Hub-compatible name.")
  @visibility("read")
  path?: string;

  @doc("The Event Hub-compatible endpoint.")
  @visibility("read")
  endpoint?: string;
}

@doc("The routing related properties of the IoT hub. See: https://docs.microsoft.com/azure/iot-hub/iot-hub-devguide-messaging")
model RoutingProperties {
  @doc("The properties related to the custom endpoints to which your IoT hub routes messages based on the routing rules. A maximum of 10 custom endpoints are allowed across all endpoint types for paid hubs and only 1 custom endpoint is allowed across all endpoint types for free hubs.")
  endpoints?: RoutingEndpoints;

  @doc("The list of user-provided routing rules that the IoT hub uses to route messages to built-in and custom endpoints. A maximum of 100 routing rules are allowed for paid hubs and a maximum of 5 routing rules are allowed for free hubs.")
  routes?: RouteProperties[];

  @doc("The properties of the route that is used as a fall-back route when none of the conditions specified in the 'routes' section are met. This is an optional parameter. When this property is not present in the template, the fallback route is disabled by default.")
  fallbackRoute?: FallbackRouteProperties;

  @doc("The list of user-provided enrichments that the IoT hub applies to messages to be delivered to built-in and custom endpoints. See: https://aka.ms/telemetryoneventgrid")
  enrichments?: EnrichmentProperties[];
}

@doc("The properties related to the custom endpoints to which your IoT hub routes messages based on the routing rules. A maximum of 10 custom endpoints are allowed across all endpoint types for paid hubs and only 1 custom endpoint is allowed across all endpoint types for free hubs.")
model RoutingEndpoints {
  @doc("The list of Service Bus queue endpoints that IoT hub routes the messages to, based on the routing rules.")
  serviceBusQueues?: RoutingServiceBusQueueEndpointProperties[];

  @doc("The list of Service Bus topic endpoints that the IoT hub routes the messages to, based on the routing rules.")
  serviceBusTopics?: RoutingServiceBusTopicEndpointProperties[];

  @doc("The list of Event Hubs endpoints that IoT hub routes messages to, based on the routing rules. This list does not include the built-in Event Hubs endpoint.")
  eventHubs?: RoutingEventHubProperties[];

  @doc("The list of storage container endpoints that IoT hub routes messages to, based on the routing rules.")
  storageContainers?: RoutingStorageContainerProperties[];

  @doc("The list of Cosmos DB container endpoints that IoT hub routes messages to, based on the routing rules.")
  cosmosDBSqlContainers?: RoutingCosmosDBSqlApiProperties[];
}

@doc("The properties related to service bus queue endpoint types.")
model RoutingServiceBusQueueEndpointProperties {
  @doc("Id of the service bus queue endpoint")
  id?: string;

  @doc("The connection string of the service bus queue endpoint.")
  connectionString?: string;

  @doc("The url of the service bus queue endpoint. It must include the protocol sb://")
  endpointUri?: string;

  @doc("Queue name on the service bus namespace")
  entityPath?: string;

  @doc("Method used to authenticate against the service bus queue endpoint")
  authenticationType?: AuthenticationType;

  @doc("Managed identity properties of routing service bus queue endpoint.")
  identity?: ManagedIdentity;

  @doc("The name that identifies this endpoint. The name can only include alphanumeric characters, periods, underscores, hyphens and has a maximum length of 64 characters. The following names are reserved:  events, fileNotifications, $default. Endpoint names must be unique across endpoint types. The name need not be the same as the actual queue name.")
  @pattern("^[A-Za-z0-9-._]{1,64}$")
  name: string;

  @doc("The subscription identifier of the service bus queue endpoint.")
  subscriptionId?: string;

  @doc("The name of the resource group of the service bus queue endpoint.")
  resourceGroup?: string;
}

@doc("The properties of the Managed identity.")
model ManagedIdentity {
  @doc("The user assigned identity.")
  userAssignedIdentity?: string;
}

@doc("The properties related to service bus topic endpoint types.")
model RoutingServiceBusTopicEndpointProperties {
  @doc("Id of the service bus topic endpoint")
  id?: string;

  @doc("The connection string of the service bus topic endpoint.")
  connectionString?: string;

  @doc("The url of the service bus topic endpoint. It must include the protocol sb://")
  endpointUri?: string;

  @doc("Queue name on the service bus topic")
  entityPath?: string;

  @doc("Method used to authenticate against the service bus topic endpoint")
  authenticationType?: AuthenticationType;

  @doc("Managed identity properties of routing service bus topic endpoint.")
  identity?: ManagedIdentity;

  @doc("The name that identifies this endpoint. The name can only include alphanumeric characters, periods, underscores, hyphens and has a maximum length of 64 characters. The following names are reserved:  events, fileNotifications, $default. Endpoint names must be unique across endpoint types.  The name need not be the same as the actual topic name.")
  @pattern("^[A-Za-z0-9-._]{1,64}$")
  name: string;

  @doc("The subscription identifier of the service bus topic endpoint.")
  subscriptionId?: string;

  @doc("The name of the resource group of the service bus topic endpoint.")
  resourceGroup?: string;
}

@doc("The properties related to an event hub endpoint.")
model RoutingEventHubProperties {
  @doc("Id of the event hub endpoint")
  id?: string;

  @doc("The connection string of the event hub endpoint. ")
  connectionString?: string;

  @doc("The url of the event hub endpoint. It must include the protocol sb://")
  endpointUri?: string;

  @doc("Event hub name on the event hub namespace")
  entityPath?: string;

  @doc("Method used to authenticate against the event hub endpoint")
  authenticationType?: AuthenticationType;

  @doc("Managed identity properties of routing event hub endpoint.")
  identity?: ManagedIdentity;

  @doc("The name that identifies this endpoint. The name can only include alphanumeric characters, periods, underscores, hyphens and has a maximum length of 64 characters. The following names are reserved:  events, fileNotifications, $default. Endpoint names must be unique across endpoint types.")
  @pattern("^[A-Za-z0-9-._]{1,64}$")
  name: string;

  @doc("The subscription identifier of the event hub endpoint.")
  subscriptionId?: string;

  @doc("The name of the resource group of the event hub endpoint.")
  resourceGroup?: string;
}

@doc("The properties related to a storage container endpoint.")
model RoutingStorageContainerProperties {
  @doc("Id of the storage container endpoint")
  id?: string;

  @doc("The connection string of the storage account.")
  connectionString?: string;

  @doc("The url of the storage endpoint. It must include the protocol https://")
  endpointUri?: string;

  @doc("Method used to authenticate against the storage endpoint")
  authenticationType?: AuthenticationType;

  @doc("Managed identity properties of routing storage endpoint.")
  identity?: ManagedIdentity;

  @doc("The name that identifies this endpoint. The name can only include alphanumeric characters, periods, underscores, hyphens and has a maximum length of 64 characters. The following names are reserved:  events, fileNotifications, $default. Endpoint names must be unique across endpoint types.")
  @pattern("^[A-Za-z0-9-._]{1,64}$")
  name: string;

  @doc("The subscription identifier of the storage account.")
  subscriptionId?: string;

  @doc("The name of the resource group of the storage account.")
  resourceGroup?: string;

  @doc("The name of storage container in the storage account.")
  containerName: string;

  @doc("File name format for the blob. Default format is {iothub}/{partition}/{YYYY}/{MM}/{DD}/{HH}/{mm}. All parameters are mandatory but can be reordered.")
  fileNameFormat?: string;

  @doc("Time interval at which blobs are written to storage. Value should be between 60 and 720 seconds. Default value is 300 seconds.")
  @maxValue(720)
  @minValue(60)
  batchFrequencyInSeconds?: int32;

  @doc("Maximum number of bytes for each blob written to storage. Value should be between 10485760(10MB) and 524288000(500MB). Default value is 314572800(300MB).")
  @maxValue(524288000)
  @minValue(10485760)
  maxChunkSizeInBytes?: int32;

  @doc("Encoding that is used to serialize messages to blobs. Supported values are 'avro', 'avrodeflate', and 'JSON'. Default value is 'avro'.")
  encoding?: RoutingStorageContainerPropertiesEncoding;
}

@doc("The properties related to a cosmos DB sql container endpoint.")
model RoutingCosmosDBSqlApiProperties {
  @doc("The name that identifies this endpoint. The name can only include alphanumeric characters, periods, underscores, hyphens and has a maximum length of 64 characters. The following names are reserved:  events, fileNotifications, $default. Endpoint names must be unique across endpoint types.")
  @pattern("^[A-Za-z0-9-._]{1,64}$")
  name: string;

  @doc("Id of the cosmos DB sql container endpoint")
  @visibility("read")
  id?: string;

  @doc("The subscription identifier of the cosmos DB account.")
  subscriptionId?: string;

  @doc("The name of the resource group of the cosmos DB account.")
  resourceGroup?: string;

  @doc("The url of the cosmos DB account. It must include the protocol https://")
  endpointUri: string;

  @doc("Method used to authenticate against the cosmos DB sql container endpoint")
  authenticationType?: AuthenticationType;

  @doc("Managed identity properties of routing cosmos DB container endpoint.")
  identity?: ManagedIdentity;

  @doc("The primary key of the cosmos DB account.")
  primaryKey?: string;

  @doc("The secondary key of the cosmos DB account.")
  secondaryKey?: string;

  @doc("The name of the cosmos DB database in the cosmos DB account.")
  databaseName: string;

  @doc("The name of the cosmos DB sql container in the cosmos DB database.")
  containerName: string;

  @doc("The name of the partition key associated with this cosmos DB sql container if one exists. This is an optional parameter.")
  partitionKeyName?: string;

  @doc("The template for generating a synthetic partition key value for use with this cosmos DB sql container. The template must include at least one of the following placeholders: {iothub}, {deviceid}, {DD}, {MM}, and {YYYY}. Any one placeholder may be specified at most once, but order and non-placeholder components are arbitrary. This parameter is only required if PartitionKeyName is specified.")
  partitionKeyTemplate?: string;
}

@doc("The properties of a routing rule that your IoT hub uses to route messages to endpoints.")
model RouteProperties {
  @doc("The name of the route. The name can only include alphanumeric characters, periods, underscores, hyphens, has a maximum length of 64 characters, and must be unique.")
  @pattern("^[A-Za-z0-9-._]{1,64}$")
  name: string;

  @doc("The source that the routing rule is to be applied to, such as DeviceMessages.")
  source: RoutingSource;

  @doc("The condition that is evaluated to apply the routing rule. If no condition is provided, it evaluates to true by default. For grammar, see: https://docs.microsoft.com/azure/iot-hub/iot-hub-devguide-query-language")
  condition?: string;

  @doc("The list of endpoints to which messages that satisfy the condition are routed. Currently only one endpoint is allowed.")
  endpointNames: string[];

  @doc("Used to specify whether a route is enabled.")
  isEnabled: boolean;
}

@doc("The properties of the fallback route. IoT Hub uses these properties when it routes messages to the fallback endpoint.")
model FallbackRouteProperties {
  @doc("The name of the route. The name can only include alphanumeric characters, periods, underscores, hyphens, has a maximum length of 64 characters, and must be unique.")
  name?: string;

  @doc("The source to which the routing rule is to be applied to. For example, DeviceMessages")
  source: RoutingSource;

  @doc("The condition which is evaluated in order to apply the fallback route. If the condition is not provided it will evaluate to true by default. For grammar, See: https://docs.microsoft.com/azure/iot-hub/iot-hub-devguide-query-language")
  condition?: string;

  @doc("The list of endpoints to which the messages that satisfy the condition are routed to. Currently only 1 endpoint is allowed.")
  endpointNames: string[];

  @doc("Used to specify whether the fallback route is enabled.")
  isEnabled: boolean;
}

@doc("The properties of an enrichment that your IoT hub applies to messages delivered to endpoints.")
model EnrichmentProperties {
  @doc("The key or name for the enrichment property.")
  key: string;

  @doc("The value for the enrichment property.")
  value: string;

  @doc("The list of endpoints for which the enrichment is applied to the message.")
  endpointNames: string[];
}

@doc("The properties of the Azure Storage endpoint for file upload.")
model StorageEndpointProperties {
  @doc("The period of time for which the SAS URI generated by IoT Hub for file upload is valid. See: https://docs.microsoft.com/azure/iot-hub/iot-hub-devguide-file-upload#file-upload-notification-configuration-options.")
  sasTtlAsIso8601?: duration;

  @doc("The connection string for the Azure Storage account to which files are uploaded.")
  connectionString: string;

  @doc("The name of the root container where you upload files. The container need not exist but should be creatable using the connectionString specified.")
  containerName: string;

  @doc("Specifies authentication type being used for connecting to the storage account.")
  authenticationType?: AuthenticationType;

  @doc("Managed identity properties of storage endpoint for file upload.")
  identity?: ManagedIdentity;
}

@doc("The properties of the messaging endpoints used by this IoT hub.")
model MessagingEndpointProperties {
  @doc("The lock duration. See: https://docs.microsoft.com/azure/iot-hub/iot-hub-devguide-file-upload.")
  lockDurationAsIso8601?: duration;

  @doc("The period of time for which a message is available to consume before it is expired by the IoT hub. See: https://docs.microsoft.com/azure/iot-hub/iot-hub-devguide-file-upload.")
  ttlAsIso8601?: duration;

  @doc("The number of times the IoT hub attempts to deliver a message. See: https://docs.microsoft.com/azure/iot-hub/iot-hub-devguide-file-upload.")
  @maxValue(100)
  @minValue(1)
  maxDeliveryCount?: int32;
}

@doc("The IoT hub cloud-to-device messaging properties.")
model CloudToDeviceProperties {
  @doc("The max delivery count for cloud-to-device messages in the device queue. See: https://docs.microsoft.com/azure/iot-hub/iot-hub-devguide-messaging#cloud-to-device-messages.")
  @maxValue(100)
  @minValue(1)
  maxDeliveryCount?: int32;

  @doc("The default time to live for cloud-to-device messages in the device queue. See: https://docs.microsoft.com/azure/iot-hub/iot-hub-devguide-messaging#cloud-to-device-messages.")
  defaultTtlAsIso8601?: duration;

  @doc("The properties of the feedback queue for cloud-to-device messages.")
  feedback?: FeedbackProperties;
}

@doc("The properties of the feedback queue for cloud-to-device messages.")
model FeedbackProperties {
  @doc("The lock duration for the feedback queue. See: https://docs.microsoft.com/azure/iot-hub/iot-hub-devguide-messaging#cloud-to-device-messages.")
  lockDurationAsIso8601?: duration;

  @doc("The period of time for which a message is available to consume before it is expired by the IoT hub. See: https://docs.microsoft.com/azure/iot-hub/iot-hub-devguide-messaging#cloud-to-device-messages.")
  ttlAsIso8601?: duration;

  @doc("The number of times the IoT hub attempts to deliver a message on the feedback queue. See: https://docs.microsoft.com/azure/iot-hub/iot-hub-devguide-messaging#cloud-to-device-messages.")
  @maxValue(100)
  @minValue(1)
  maxDeliveryCount?: int32;
}

@doc("Public representation of one of the locations where a resource is provisioned.")
model IotHubLocationDescription {
  @doc("The name of the Azure region")
  location?: string;

  @doc("The role of the region, can be either primary or secondary. The primary region is where the IoT hub is currently provisioned. The secondary region is the Azure disaster recovery (DR) paired region and also the region where the IoT hub can failover to.")
  role?: IotHubReplicaRoleType;
}

@doc("Information about the SKU of the IoT hub.")
model IotHubSkuInfo {
  @doc("The name of the SKU.")
  name: IotHubSku;

  @doc("The billing tier for the IoT hub.")
  @visibility("read")
  tier?: IotHubSkuTier;

  @doc("The number of provisioned IoT Hub units. See: https://docs.microsoft.com/azure/azure-subscription-service-limits#iot-hub-limits.")
  capacity?: int32;
}

model ArmIdentity {
  @doc("Principal Id")
  @visibility("read")
  principalId?: string;

  @doc("Tenant Id")
  @visibility("read")
  tenantId?: string;

  @doc("The type of identity used for the resource. The type 'SystemAssigned, UserAssigned' includes both an implicitly created identity and a set of user assigned identities. The type 'None' will remove any identities from the service.")
  type?: ResourceIdentityType;

  @doc("Dictionary of <ArmUserIdentity>")
  userAssignedIdentities?: Record<ArmUserIdentity>;
}

model ArmUserIdentity {
  @visibility("read")
  principalId?: string;

  @visibility("read")
  clientId?: string;
}

@doc("The common properties of an Azure resource.")
model Resource {
  @doc("The resource identifier.")
  @visibility("read")
  id?: string;

  @doc("The resource name.")
  @visibility("read")
  @pattern("^(?![0-9]+$)(?!-)[a-zA-Z0-9-]{2,49}[a-zA-Z0-9]$")
  name?: string;

  @doc("The resource type.")
  @visibility("read")
  type?: string;

  @doc("The resource location.")
  location: string;

  @doc("The resource tags.")
  tags?: Record<string>;
}

@doc("A container holding only the Tags for a resource, allowing the user to update the tags on an IoT Hub instance.")
model TagsResource {
  @doc("Resource tags")
  tags?: Record<string>;
}

@doc("Identity registry statistics.")
model RegistryStatistics {
  @doc("The total count of devices in the identity registry.")
  @visibility("read")
  totalDeviceCount?: int32;

  @doc("The count of enabled devices in the identity registry.")
  @visibility("read")
  enabledDeviceCount?: int32;

  @doc("The count of disabled devices in the identity registry.")
  @visibility("read")
  disabledDeviceCount?: int32;
}

@doc("The JSON-serialized array of IotHubSkuDescription objects with a next link.")
model IotHubSkuDescriptionListResult is Azure.Core.Page<IotHubSkuDescription>;

@doc("SKU properties.")
model IotHubSkuDescription {
  @doc("The type of the resource.")
  @visibility("read")
  resourceType?: string;

  @doc("The type of the resource.")
  sku: IotHubSkuInfo;

  @doc("IotHub capacity")
  capacity: IotHubCapacity;
}

@doc("IoT Hub capacity information.")
model IotHubCapacity {
  @doc("The minimum number of units.")
  @visibility("read")
  @maxValue(1)
  @minValue(1)
  minimum?: int32;

  @doc("The maximum number of units.")
  @visibility("read")
  maximum?: int32;

  @doc("The default number of units.")
  @visibility("read")
  default?: int32;

  @doc("The type of the scaling enabled.")
  @visibility("read")
  scaleType?: IotHubScaleType;
}

@doc("The EventHub consumer group.")
model ConsumerGroupEventHubContent {
  @doc("The EventHub consumer group name.")
  properties: EventHubConsumerGroupName;
}

@doc("The EventHub consumer group name.")
model EventHubConsumerGroupName {
  @doc("EventHub consumer group name")
  name: string;
}

@doc("The JSON-serialized array of JobResponse objects with a next link.")
model JobResponseListResult is Azure.Core.Page<JobResponse>;

@doc("The properties of the Job Response object.")
model JobResponse {
  @doc("The job identifier.")
  @visibility("read")
  jobId?: string;

  @doc("The start time of the job.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTimeUtc?: utcDateTime;

  @doc("The time the job stopped processing.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTimeUtc?: utcDateTime;

  @doc("The type of the job.")
  @visibility("read")
  type?: JobType;

  @doc("The status of the job.")
  @visibility("read")
  status?: JobStatus;

  @doc("If status == failed, this string containing the reason for the failure.")
  @visibility("read")
  failureReason?: string;

  @doc("The status message for the job.")
  @visibility("read")
  statusMessage?: string;

  @doc("The job identifier of the parent job, if any.")
  @visibility("read")
  parentJobId?: string;
}

@doc("The JSON-serialized array of IotHubQuotaMetricInfo objects with a next link.")
model IotHubQuotaMetricInfoListResult is Azure.Core.Page<IotHubQuotaMetricInfo>;

@doc("Quota metrics properties.")
model IotHubQuotaMetricInfo {
  @doc("The name of the quota metric.")
  @visibility("read")
  name?: string;

  @doc("The current value for the quota metric.")
  @visibility("read")
  currentValue?: int32;

  @doc("The maximum value of the quota metric.")
  @visibility("read")
  maxValue?: int32;
}

@doc("The JSON-serialized array of EndpointHealthData objects with a next link.")
model EndpointHealthDataListResult is Azure.Core.Page<EndpointHealthData>;

@doc("The health data for an endpoint")
model EndpointHealthData {
  @doc("Id of the endpoint")
  endpointId?: string;

  @doc("Health statuses have following meanings. The 'healthy' status shows that the endpoint is accepting messages as expected. The 'unhealthy' status shows that the endpoint is not accepting messages as expected and IoT Hub is retrying to send data to this endpoint. The status of an unhealthy endpoint will be updated to healthy when IoT Hub has established an eventually consistent state of health. The 'dead' status shows that the endpoint is not accepting messages, after IoT Hub retried sending messages for the retrial period. See IoT Hub metrics to identify errors and monitor issues with endpoints. The 'unknown' status shows that the IoT Hub has not established a connection with the endpoint. No messages have been delivered to or rejected from this endpoint")
  healthStatus?: EndpointHealthStatus;

  @doc("Last error obtained when a message failed to be delivered to iot hub")
  lastKnownError?: string;

  @doc("Time at which the last known error occurred")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastKnownErrorTime?: utcDateTime;

  @doc("Last time iot hub successfully sent a message to the endpoint")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastSuccessfulSendAttemptTime?: utcDateTime;

  @doc("Last time iot hub tried to send a message to the endpoint")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastSendAttemptTime?: utcDateTime;
}

@doc("Input values.")
model OperationInputs {
  @doc("The name of the IoT hub to check.")
  name: string;
}

@doc("The properties indicating whether a given IoT hub name is available.")
model IotHubNameAvailabilityInfo {
  @doc("The value which indicates whether the provided name is available.")
  @visibility("read")
  nameAvailable?: boolean;

  @doc("The reason for unavailability.")
  @visibility("read")
  reason?: IotHubNameUnavailabilityReason;

  @doc("The detailed reason message.")
  message?: string;
}

@doc("Json-serialized array of User subscription quota response")
model UserSubscriptionQuotaListResult {
  value?: UserSubscriptionQuota[];

  @visibility("read")
  nextLink?: string;
}

@doc("User subscription quota response")
model UserSubscriptionQuota {
  @doc("IotHub type id")
  id?: string;

  @doc("Response type")
  type?: string;

  @doc("Unit of IotHub type")
  unit?: string;

  @doc("Current number of IotHub type")
  currentValue?: int32;

  @doc("Numerical limit on IotHub type")
  limit?: int32;

  @doc("IotHub type")
  name?: Name;
}

@doc("Name of Iot Hub type")
model Name {
  @doc("IotHub type")
  value?: string;

  @doc("Localized value of name")
  localizedValue?: string;
}

@doc("Input for testing all routes")
model TestAllRoutesInput {
  @doc("Routing source")
  routingSource?: RoutingSource;

  @doc("Routing message")
  message?: RoutingMessage;

  @doc("Routing Twin Reference")
  twin?: RoutingTwin;
}

@doc("Routing message")
model RoutingMessage {
  @doc("Body of routing message")
  body?: string;

  @doc("App properties")
  appProperties?: Record<string>;

  @doc("System properties")
  systemProperties?: Record<string>;
}

@doc("Twin reference input parameter. This is an optional parameter")
model RoutingTwin {
  @doc("Twin Tags")
  tags?: Record<unknown>;

  properties?: RoutingTwinProperties;
}

model RoutingTwinProperties {
  @doc("Twin desired properties")
  desired?: Record<unknown>;

  @doc("Twin desired properties")
  reported?: Record<unknown>;
}

@doc("Result of testing all routes")
model TestAllRoutesResult {
  @doc("JSON-serialized array of matched routes")
  routes?: MatchedRoute[];
}

@doc("Routes that matched")
model MatchedRoute {
  @doc("Properties of routes that matched")
  properties?: RouteProperties;
}

@doc("Input for testing route")
model TestRouteInput {
  @doc("Routing message")
  message?: RoutingMessage;

  @doc("Route properties")
  route: RouteProperties;

  @doc("Routing Twin Reference")
  twin?: RoutingTwin;
}

@doc("Result of testing one route")
model TestRouteResult {
  @doc("Result of testing route")
  result?: TestResultStatus;

  @doc("Detailed result of testing route")
  details?: TestRouteResultDetails;
}

@doc("Detailed result of testing a route")
model TestRouteResultDetails {
  @doc("JSON-serialized list of route compilation errors")
  compilationErrors?: RouteCompilationError[];
}

@doc("Compilation error when evaluating route")
model RouteCompilationError {
  @doc("Route error message")
  message?: string;

  @doc("Severity of the route error")
  severity?: RouteErrorSeverity;

  @doc("Location where the route error happened")
  location?: RouteErrorRange;
}

@doc("Range of route errors")
model RouteErrorRange {
  @doc("Start where the route error happened")
  start?: RouteErrorPosition;

  @doc("End where the route error happened")
  end?: RouteErrorPosition;
}

@doc("Position where the route error happened")
model RouteErrorPosition {
  @doc("Line where the route error happened")
  line?: int32;

  @doc("Column where the route error happened")
  column?: int32;
}

@doc("The list of shared access policies with a next link.")
model SharedAccessSignatureAuthorizationRuleListResult
  is Azure.Core.Page<SharedAccessSignatureAuthorizationRule>;

@doc("Use to provide parameters when requesting an export of all devices in the IoT hub.")
model ExportDevicesRequest {
  @doc("The export blob container URI.")
  exportBlobContainerUri: string;

  @doc("The value indicating whether keys should be excluded during export.")
  excludeKeys: boolean;

  @doc("The name of the blob that will be created in the provided output blob container. This blob will contain the exported device registry information for the IoT Hub.")
  exportBlobName?: string;

  @doc("Specifies authentication type being used for connecting to the storage account.")
  authenticationType?: AuthenticationType;

  @doc("Managed identity properties of storage endpoint for export devices.")
  identity?: ManagedIdentity;

  @doc("The value indicating whether configurations should be exported.")
  includeConfigurations?: boolean;

  @doc("The name of the blob that will be created in the provided output blob container. This blob will contain the exported configurations for the Iot Hub.")
  configurationsBlobName?: string;
}

@doc("Use to provide parameters when requesting an import of all devices in the hub.")
model ImportDevicesRequest {
  @doc("The input blob container URI.")
  inputBlobContainerUri: string;

  @doc("The output blob container URI.")
  outputBlobContainerUri: string;

  @doc("The blob name to be used when importing from the provided input blob container.")
  inputBlobName?: string;

  @doc("The blob name to use for storing the status of the import job.")
  outputBlobName?: string;

  @doc("Specifies authentication type being used for connecting to the storage account.")
  authenticationType?: AuthenticationType;

  @doc("Managed identity properties of storage endpoint for import devices.")
  identity?: ManagedIdentity;

  @doc("The value indicating whether configurations should be imported.")
  includeConfigurations?: boolean;

  @doc("The blob name to be used when importing configurations from the provided input blob container.")
  configurationsBlobName?: string;
}

@doc("The description of an X509 CA Certificate.")
model CertificateProperties {
  @doc("The certificate's subject name.")
  @visibility("read")
  subject?: string;

  @doc("The certificate's expiration date and time.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expiry?: utcDateTime;

  @doc("The certificate's thumbprint.")
  @visibility("read")
  thumbprint?: string;

  @doc("Determines whether certificate has been verified.")
  isVerified?: boolean;

  @doc("The certificate's create date and time.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  created?: utcDateTime;

  @doc("The certificate's last update date and time.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  updated?: utcDateTime;

  @doc("The certificate content")
  certificate?: string;
}

@doc("The X509 Certificate.")
model CertificateWithNonceDescription {
  @doc("The description of an X509 CA Certificate including the challenge nonce issued for the Proof-Of-Possession flow.")
  properties?: CertificatePropertiesWithNonce;

  @doc("The resource identifier.")
  @visibility("read")
  id?: string;

  @doc("The name of the certificate.")
  @visibility("read")
  name?: string;

  @doc("The entity tag.")
  @visibility("read")
  etag?: string;

  @doc("The resource type.")
  @visibility("read")
  type?: string;
}

@doc("The description of an X509 CA Certificate including the challenge nonce issued for the Proof-Of-Possession flow.")
model CertificatePropertiesWithNonce {
  @doc("The certificate's subject name.")
  @visibility("read")
  subject?: string;

  @doc("The certificate's expiration date and time.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expiry?: utcDateTime;

  @doc("The certificate's thumbprint.")
  @visibility("read")
  thumbprint?: string;

  @doc("Determines whether certificate has been verified.")
  @visibility("read")
  isVerified?: boolean;

  @doc("The certificate's create date and time.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  created?: utcDateTime;

  @doc("The certificate's last update date and time.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  updated?: utcDateTime;

  @doc("The certificate's verification code that will be used for proof of possession.")
  @visibility("read")
  verificationCode?: string;

  @doc("The certificate content")
  @visibility("read")
  certificate?: string;
}

@doc("The JSON-serialized leaf certificate")
model CertificateVerificationDescription {
  @doc("base-64 representation of X509 certificate .cer file or just .pem file content.")
  certificate?: string;
}

@doc("Use to provide failover region when requesting manual Failover for a hub.")
model FailoverInput {
  @doc("Region the hub will be failed over to")
  failoverRegion: string;
}

@doc("The properties for a group information object")
model GroupIdInformationProperties {
  @doc("The group id")
  groupId?: string;

  @doc("The required members for a specific group id")
  requiredMembers?: string[];

  @doc("The required DNS zones for a specific group id")
  requiredZoneNames?: string[];
}

@doc("The JSON-serialized X509 Certificate.")
model CertificateBodyDescription {
  @doc("base-64 representation of the X509 leaf certificate .cer file or just .pem file content.")
  certificate?: string;

  @doc("True indicates that the certificate will be created in verified state and proof of possession will not be required.")
  isVerified?: boolean;
}
