import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.DigitalTwins;

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * The provisioning state.
 */
enum ProvisioningState {
  Provisioning,
  Deleting,
  Updating,
  Succeeded,
  Failed,
  Canceled,
  Deleted,
  Warning,
  Suspending,
  Restoring,
  Moving,
}

/**
 * The provisioning state.
 */
enum ConnectionPropertiesProvisioningState {
  Pending,
  Approved,
  Rejected,
  Disconnected,
}

/**
 * The status of a private endpoint connection.
 */
enum PrivateLinkServiceConnectionStatus {
  Pending,
  Approved,
  Rejected,
  Disconnected,
}

/**
 * Public network access for the DigitalTwinsInstance.
 */
enum PublicNetworkAccess {
  Enabled,
  Disabled,
}

/**
 * The type of Managed Identity used by the DigitalTwinsInstance.
 */
enum DigitalTwinsIdentityType {
  None,
  SystemAssigned,
  UserAssigned,
  `SystemAssigned,UserAssigned`,
}

/**
 * The type of Digital Twins endpoint
 */
enum EndpointType {
  EventHub,
  EventGrid,
  ServiceBus,
}

/**
 * The provisioning state.
 */
enum EndpointProvisioningState {
  Provisioning,
  Deleting,
  Updating,
  Succeeded,
  Failed,
  Canceled,
  Deleted,
  Warning,
  Suspending,
  Restoring,
  Moving,
  Disabled,
}

/**
 * Specifies the authentication type being used for connecting to the endpoint. Defaults to 'KeyBased'. If 'KeyBased' is selected, a connection string must be specified (at least the primary connection string). If 'IdentityBased' is select, the endpointUri and entityPath properties must be specified.
 */
enum AuthenticationType {
  KeyBased,
  IdentityBased,
}

/**
 * The type of managed identity used.
 */
enum IdentityType {
  SystemAssigned,
  UserAssigned,
}

/**
 * Message providing the reason why the given name is invalid.
 */
enum Reason {
  Invalid,
  AlreadyExists,
}

/**
 * The type of time series connection resource.
 */
enum ConnectionType {
  AzureDataExplorer,
}

/**
 * The provisioning state.
 */
enum TimeSeriesDatabaseConnectionState {
  Provisioning,
  Deleting,
  Updating,
  Succeeded,
  Failed,
  Canceled,
  Deleted,
  Warning,
  Suspending,
  Restoring,
  Moving,
  Disabled,
}

enum CleanupConnectionArtifacts {
  `true`,
  `false`,
}

/**
 * Specifies whether or not to record twin / relationship property and item removals, including removals of indexed or keyed values (such as map entries, array elements, etc.). This feature is de-activated unless explicitly set to 'true'. Setting this property to 'true' will generate an additional column in the property events table in ADX.
 */
enum RecordPropertyAndItemRemovals {
  `true`,
  `false`,
}

/**
 * The properties of a DigitalTwinsInstance.
 */
model DigitalTwinsProperties {
  /**
   * Time when DigitalTwinsInstance was created.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdTime?: utcDateTime;

  /**
   * Time when DigitalTwinsInstance was updated.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdatedTime?: utcDateTime;

  /**
   * The provisioning state.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * Api endpoint to work with DigitalTwinsInstance.
   */
  @visibility("read")
  hostName?: string;

  /**
   * The private endpoint connections.
   */
  privateEndpointConnections?: PrivateEndpointConnection[];

  /**
   * Public network access for the DigitalTwinsInstance.
   */
  publicNetworkAccess?: PublicNetworkAccess;
}

/**
 * The properties of a private endpoint connection.
 */
model ConnectionProperties {
  /**
   * The provisioning state.
   */
  @visibility("read")
  provisioningState?: ConnectionPropertiesProvisioningState;

  /**
   * The private endpoint.
   */
  privateEndpoint?: PrivateEndpoint;

  /**
   * The list of group ids for the private endpoint connection.
   */
  groupIds?: string[];

  /**
   * The connection state.
   */
  privateLinkServiceConnectionState?: ConnectionState;
}

/**
 * The private endpoint property of a private endpoint connection.
 */
model PrivateEndpoint {
  /**
   * The resource identifier.
   */
  @visibility("read")
  id?: string;
}

/**
 * The current state of a private endpoint connection.
 */
model ConnectionState {
  /**
   * The status of a private endpoint connection.
   */
  status: PrivateLinkServiceConnectionStatus;

  /**
   * The description for the current state of a private endpoint connection.
   */
  description: string;

  /**
   * Actions required for a private endpoint connection.
   */
  actionsRequired?: string;
}

/**
 * The common properties of a DigitalTwinsInstance.
 */
model DigitalTwinsResource {
  /**
   * The resource identifier.
   */
  @visibility("read")
  id?: string;

  /**
   * The resource name.
   */
  @visibility("read")
  @pattern("^(?!-)[A-Za-z0-9-]{3,63}(?<!-)$")
  name?: string;

  /**
   * The resource type.
   */
  @visibility("read")
  type?: string;

  /**
   * The resource location.
   */
  @visibility("read", "create")
  location: string;

  /**
   * The resource tags.
   */
  tags?: Record<string>;

  /**
   * The managed identity for the DigitalTwinsInstance.
   */
  identity?: DigitalTwinsIdentity;

  /**
   * Metadata pertaining to creation and last modification of the DigitalTwinsInstance.
   */
  @visibility("read")
  systemData?: SystemData;
}

/**
 * The managed identity for the DigitalTwinsInstance.
 */
model DigitalTwinsIdentity {
  /**
   * The type of Managed Identity used by the DigitalTwinsInstance.
   */
  type?: DigitalTwinsIdentityType;

  /**
   * The object id of the Managed Identity Resource. This will be sent to the RP from ARM via the x-ms-identity-principal-id header in the PUT request if the resource has a systemAssigned(implicit) identity
   */
  @visibility("read")
  principalId?: string;

  /**
   * The tenant id of the Managed Identity Resource. This will be sent to the RP from ARM via the x-ms-client-tenant-id header in the PUT request if the resource has a systemAssigned(implicit) identity
   */
  @visibility("read")
  tenantId?: string;

  /**
   * The list of user identities associated with the resource. The user identity dictionary key references will be ARM resource ids in the form:
   * '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{identityName}'.
   * .
   */
  userAssignedIdentities?: Record<UserAssignedIdentity>;
}

/**
 * The information about the user assigned identity.
 */
model UserAssignedIdentity {
  /**
   * The client id of the User Assigned Identity Resource.
   */
  @visibility("read")
  clientId?: string;

  /**
   * The object id of the User Assigned Identity Resource.
   */
  @visibility("read")
  principalId?: string;
}

/**
 * Error definition.
 */
model ErrorDefinition {
  /**
   * Service specific error code which serves as the substatus for the HTTP error code.
   */
  @visibility("read")
  code?: string;

  /**
   * Description of the error.
   */
  @visibility("read")
  message?: string;

  /**
   * Internal error details.
   */
  @visibility("read")
  details?: ErrorDefinition[];
}

/**
 * The description of the DigitalTwins service.
 */
model DigitalTwinsPatchDescription {
  /**
   * Instance patch properties
   */
  tags?: Record<string>;

  /**
   * The managed identity for the DigitalTwinsInstance.
   */
  identity?: DigitalTwinsIdentity;

  /**
   * Properties for the DigitalTwinsInstance.
   */
  properties?: DigitalTwinsPatchProperties;
}

/**
 * The properties of a DigitalTwinsInstance.
 */
model DigitalTwinsPatchProperties {
  /**
   * Public network access for the DigitalTwinsInstance.
   */
  publicNetworkAccess?: PublicNetworkAccess;
}

/**
 * Properties related to Digital Twins Endpoint
 */
@discriminator("endpointType")
model DigitalTwinsEndpointResourceProperties {
  /**
   * The provisioning state.
   */
  @visibility("read")
  provisioningState?: EndpointProvisioningState;

  /**
   * Time when the Endpoint was added to DigitalTwinsInstance.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdTime?: utcDateTime;

  /**
   * Specifies the authentication type being used for connecting to the endpoint. Defaults to 'KeyBased'. If 'KeyBased' is selected, a connection string must be specified (at least the primary connection string). If 'IdentityBased' is select, the endpointUri and entityPath properties must be specified.
   */
  authenticationType?: AuthenticationType;

  /**
   * Dead letter storage secret for key-based authentication. Will be obfuscated during read.
   */
  deadLetterSecret?: string;

  /**
   * Dead letter storage URL for identity-based authentication.
   */
  deadLetterUri?: string;

  /**
   * Managed identity properties for the endpoint.
   */
  identity?: ManagedIdentityReference;
}

/**
 * The properties of the Managed Identity.
 */
model ManagedIdentityReference {
  /**
   * The type of managed identity used.
   */
  type?: IdentityType;

  /**
   * The user identity ARM resource id if the managed identity type is 'UserAssigned'.
   */
  userAssignedIdentity?: string;
}

/**
 * Definition of a resource.
 */
model ExternalResource {
  /**
   * The resource identifier.
   */
  @visibility("read")
  id?: string;

  /**
   * Extension resource name.
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
   * Metadata pertaining to creation and last modification of the resource.
   */
  @visibility("read")
  systemData?: SystemData;
}

/**
 * The result returned from a database check name availability request.
 */
model CheckNameRequest {
  /**
   * Resource name.
   */
  name: string;

  /**
   * The type of resource, for instance Microsoft.DigitalTwins/digitalTwinsInstances.
   */
  type: "Microsoft.DigitalTwins/digitalTwinsInstances";
}

/**
 * The result returned from a check name availability request.
 */
model CheckNameResult {
  /**
   * Specifies a Boolean value that indicates if the name is available.
   */
  nameAvailable?: boolean;

  /**
   * Message indicating an unavailable name due to a conflict, or a description of the naming rules that are violated.
   */
  message?: string;

  /**
   * Message providing the reason why the given name is invalid.
   */
  reason?: Reason;
}

/**
 * The properties for a group information object.
 */
model GroupIdInformationProperties {
  /**
   * The group id.
   */
  groupId?: string;

  /**
   * The required members for a specific group id.
   */
  requiredMembers?: string[];

  /**
   * The required DNS zones for a specific group id.
   */
  requiredZoneNames?: string[];
}

/**
 * Properties of a time series database connection resource.
 */
@discriminator("connectionType")
model TimeSeriesDatabaseConnectionProperties {
  /**
   * The provisioning state.
   */
  @visibility("read")
  provisioningState?: TimeSeriesDatabaseConnectionState;

  /**
   * Managed identity properties for the time series database connection resource.
   */
  identity?: ManagedIdentityReference;
}

/**
 * Properties related to ServiceBus.
 */
model ServiceBus extends DigitalTwinsEndpointResourceProperties {
  /**
   * PrimaryConnectionString of the endpoint for key-based authentication. Will be obfuscated during read.
   */
  primaryConnectionString?: string;

  /**
   * SecondaryConnectionString of the endpoint for key-based authentication. Will be obfuscated during read.
   */
  secondaryConnectionString?: string;

  /**
   * The URL of the ServiceBus namespace for identity-based authentication. It must include the protocol 'sb://'.
   */
  endpointUri?: string;

  /**
   * The ServiceBus Topic name for identity-based authentication.
   */
  entityPath?: string;

  /**
   * The type of Digital Twins endpoint
   */
  endpointType: "ServiceBus";
}

/**
 * Properties related to EventHub.
 */
model EventHub extends DigitalTwinsEndpointResourceProperties {
  /**
   * PrimaryConnectionString of the endpoint for key-based authentication. Will be obfuscated during read.
   */
  connectionStringPrimaryKey?: string;

  /**
   * SecondaryConnectionString of the endpoint for key-based authentication. Will be obfuscated during read.
   */
  connectionStringSecondaryKey?: string;

  /**
   * The URL of the EventHub namespace for identity-based authentication. It must include the protocol 'sb://'.
   */
  endpointUri?: string;

  /**
   * The EventHub name in the EventHub namespace for identity-based authentication.
   */
  entityPath?: string;

  /**
   * The type of Digital Twins endpoint
   */
  endpointType: "EventHub";
}

/**
 * Properties related to EventGrid.
 */
model EventGrid extends DigitalTwinsEndpointResourceProperties {
  /**
   * EventGrid Topic Endpoint.
   */
  @projectedName("json", "TopicEndpoint")
  topicEndpoint: string;

  /**
   * EventGrid secondary accesskey. Will be obfuscated during read.
   */
  accessKey1: string;

  /**
   * EventGrid secondary accesskey. Will be obfuscated during read.
   */
  accessKey2?: string;

  /**
   * The type of Digital Twins endpoint
   */
  endpointType: "EventGrid";
}

/**
 * Properties of a time series database connection to Azure Data Explorer with data being sent via an EventHub.
 */
model AzureDataExplorerConnectionProperties
  extends TimeSeriesDatabaseConnectionProperties {
  /**
   * The resource ID of the Azure Data Explorer cluster.
   */
  adxResourceId: string;

  /**
   * The URI of the Azure Data Explorer endpoint.
   */
  adxEndpointUri: string;

  /**
   * The name of the Azure Data Explorer database.
   */
  adxDatabaseName: string;

  /**
   * The name of the Azure Data Explorer table used for storing updates to properties of twins and relationships. Defaults to AdtPropertyEvents.
   */
  adxTableName?: string = "AdtPropertyEvents";

  /**
   * The name of the Azure Data Explorer table used for recording twin lifecycle events. The table will not be created if this property is left unspecified.
   */
  adxTwinLifecycleEventsTableName?: string;

  /**
   * The name of the Azure Data Explorer table used for recording relationship lifecycle events. The table will not be created if this property is left unspecified.
   */
  adxRelationshipLifecycleEventsTableName?: string;

  /**
   * The URL of the EventHub namespace for identity-based authentication. It must include the protocol sb://
   */
  eventHubEndpointUri: string;

  /**
   * The EventHub name in the EventHub namespace for identity-based authentication.
   */
  eventHubEntityPath: string;

  /**
   * The resource ID of the EventHub namespace.
   */
  eventHubNamespaceResourceId: string;

  /**
   * The EventHub consumer group to use when ADX reads from EventHub. Defaults to $Default.
   */
  eventHubConsumerGroup?: string = "$Default";

  /**
   * Specifies whether or not to record twin / relationship property and item removals, including removals of indexed or keyed values (such as map entries, array elements, etc.). This feature is de-activated unless explicitly set to 'true'. Setting this property to 'true' will generate an additional column in the property events table in ADX.
   */
  recordPropertyAndItemRemovals?: RecordPropertyAndItemRemovals = RecordPropertyAndItemRemovals.`false`;

  /**
   * The type of time series connection resource.
   */
  connectionType: "AzureDataExplorer";
}
