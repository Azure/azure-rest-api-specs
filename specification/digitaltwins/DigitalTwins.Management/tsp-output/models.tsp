import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.DigitalTwins;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("The provisioning state.")
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

@doc("The provisioning state.")
enum ConnectionPropertiesProvisioningState {
  Pending,
  Approved,
  Rejected,
  Disconnected,
}

@doc("The status of a private endpoint connection.")
enum PrivateLinkServiceConnectionStatus {
  Pending,
  Approved,
  Rejected,
  Disconnected,
}

@doc("Public network access for the DigitalTwinsInstance.")
enum PublicNetworkAccess {
  Enabled,
  Disabled,
}

@doc("The type of Managed Identity used by the DigitalTwinsInstance.")
enum DigitalTwinsIdentityType {
  None,
  SystemAssigned,
  UserAssigned,
  `SystemAssigned,UserAssigned`,
}

@doc("The type of Digital Twins endpoint")
enum EndpointType {
  EventHub,
  EventGrid,
  ServiceBus,
}

@doc("The provisioning state.")
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

@doc("Specifies the authentication type being used for connecting to the endpoint. Defaults to 'KeyBased'. If 'KeyBased' is selected, a connection string must be specified (at least the primary connection string). If 'IdentityBased' is select, the endpointUri and entityPath properties must be specified.")
enum AuthenticationType {
  KeyBased,
  IdentityBased,
}

@doc("The type of managed identity used.")
enum IdentityType {
  SystemAssigned,
  UserAssigned,
}

@doc("Message providing the reason why the given name is invalid.")
enum Reason {
  Invalid,
  AlreadyExists,
}

@doc("The type of time series connection resource.")
enum ConnectionType {
  AzureDataExplorer,
}

@doc("The provisioning state.")
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

@doc("Specifies whether or not to record twin / relationship property and item removals, including removals of indexed or keyed values (such as map entries, array elements, etc.). This feature is de-activated unless explicitly set to 'true'. Setting this property to 'true' will generate an additional column in the property events table in ADX.")
enum RecordPropertyAndItemRemovals {
  `true`,
  `false`,
}

@doc("The properties of a DigitalTwinsInstance.")
model DigitalTwinsProperties {
  @doc("Time when DigitalTwinsInstance was created.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdTime?: utcDateTime;

  @doc("Time when DigitalTwinsInstance was updated.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdatedTime?: utcDateTime;

  @doc("The provisioning state.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Api endpoint to work with DigitalTwinsInstance.")
  @visibility("read")
  hostName?: string;

  @doc("The private endpoint connections.")
  privateEndpointConnections?: PrivateEndpointConnection[];

  @doc("Public network access for the DigitalTwinsInstance.")
  publicNetworkAccess?: PublicNetworkAccess;
}

@doc("The properties of a private endpoint connection.")
model ConnectionProperties {
  @doc("The provisioning state.")
  @visibility("read")
  provisioningState?: ConnectionPropertiesProvisioningState;

  @doc("The private endpoint.")
  privateEndpoint?: PrivateEndpoint;

  @doc("The list of group ids for the private endpoint connection.")
  groupIds?: string[];

  @doc("The connection state.")
  privateLinkServiceConnectionState?: ConnectionState;
}

@doc("The private endpoint property of a private endpoint connection.")
model PrivateEndpoint {
  @doc("The resource identifier.")
  @visibility("read")
  id?: string;
}

@doc("The current state of a private endpoint connection.")
model ConnectionState {
  @doc("The status of a private endpoint connection.")
  status: PrivateLinkServiceConnectionStatus;

  @doc("The description for the current state of a private endpoint connection.")
  description: string;

  @doc("Actions required for a private endpoint connection.")
  actionsRequired?: string;
}

@doc("The common properties of a DigitalTwinsInstance.")
model DigitalTwinsResource {
  @doc("The resource identifier.")
  @visibility("read")
  id?: string;

  @doc("The resource name.")
  @visibility("read")
  @pattern("^(?!-)[A-Za-z0-9-]{3,63}(?<!-)$")
  name?: string;

  @doc("The resource type.")
  @visibility("read")
  type?: string;

  @doc("The resource location.")
  @visibility("read", "create")
  location: string;

  @doc("The resource tags.")
  tags?: Record<string>;

  @doc("The managed identity for the DigitalTwinsInstance.")
  identity?: DigitalTwinsIdentity;

  @doc("Metadata pertaining to creation and last modification of the DigitalTwinsInstance.")
  @visibility("read")
  systemData?: SystemData;
}

@doc("The managed identity for the DigitalTwinsInstance.")
model DigitalTwinsIdentity {
  @doc("The type of Managed Identity used by the DigitalTwinsInstance.")
  type?: DigitalTwinsIdentityType;

  @doc("The object id of the Managed Identity Resource. This will be sent to the RP from ARM via the x-ms-identity-principal-id header in the PUT request if the resource has a systemAssigned(implicit) identity")
  @visibility("read")
  principalId?: string;

  @doc("The tenant id of the Managed Identity Resource. This will be sent to the RP from ARM via the x-ms-client-tenant-id header in the PUT request if the resource has a systemAssigned(implicit) identity")
  @visibility("read")
  tenantId?: string;

  @doc("""
The list of user identities associated with the resource. The user identity dictionary key references will be ARM resource ids in the form:
'/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{identityName}'.
.
""")
  userAssignedIdentities?: Record<UserAssignedIdentity>;
}

@doc("Error definition.")
model ErrorDefinition {
  @doc("Service specific error code which serves as the substatus for the HTTP error code.")
  @visibility("read")
  code?: string;

  @doc("Description of the error.")
  @visibility("read")
  message?: string;

  @doc("Internal error details.")
  @visibility("read")
  details?: ErrorDefinition[];
}

@doc("The description of the DigitalTwins service.")
model DigitalTwinsPatchDescription {
  @doc("Instance patch properties")
  tags?: Record<string>;

  @doc("The managed identity for the DigitalTwinsInstance.")
  identity?: DigitalTwinsIdentity;

  @doc("Properties for the DigitalTwinsInstance.")
  properties?: DigitalTwinsPatchProperties;
}

@doc("The properties of a DigitalTwinsInstance.")
model DigitalTwinsPatchProperties {
  @doc("Public network access for the DigitalTwinsInstance.")
  publicNetworkAccess?: PublicNetworkAccess;
}

@doc("Properties related to Digital Twins Endpoint")
@discriminator("endpointType")
model DigitalTwinsEndpointResourceProperties {
  @doc("The provisioning state.")
  @visibility("read")
  provisioningState?: EndpointProvisioningState;

  @doc("Time when the Endpoint was added to DigitalTwinsInstance.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdTime?: utcDateTime;

  @doc("Specifies the authentication type being used for connecting to the endpoint. Defaults to 'KeyBased'. If 'KeyBased' is selected, a connection string must be specified (at least the primary connection string). If 'IdentityBased' is select, the endpointUri and entityPath properties must be specified.")
  authenticationType?: AuthenticationType;

  @doc("Dead letter storage secret for key-based authentication. Will be obfuscated during read.")
  deadLetterSecret?: string;

  @doc("Dead letter storage URL for identity-based authentication.")
  deadLetterUri?: string;

  @doc("Managed identity properties for the endpoint.")
  identity?: ManagedIdentityReference;
}

@doc("The properties of the Managed Identity.")
model ManagedIdentityReference {
  @doc("The type of managed identity used.")
  type?: IdentityType;

  @doc("The user identity ARM resource id if the managed identity type is 'UserAssigned'.")
  userAssignedIdentity?: string;
}

@doc("Definition of a resource.")
model ExternalResource {
  @doc("The resource identifier.")
  @visibility("read")
  id?: string;

  @doc("Extension resource name.")
  @visibility("read")
  @pattern("^(?![0-9]+$)(?!-)[a-zA-Z0-9-]{2,49}[a-zA-Z0-9]$")
  name?: string;

  @doc("The resource type.")
  @visibility("read")
  type?: string;

  @doc("Metadata pertaining to creation and last modification of the resource.")
  @visibility("read")
  systemData?: SystemData;
}

@doc("The result returned from a database check name availability request.")
model CheckNameRequest {
  @doc("Resource name.")
  name: string;

  @doc("The type of resource, for instance Microsoft.DigitalTwins/digitalTwinsInstances.")
  type: "Microsoft.DigitalTwins/digitalTwinsInstances";
}

@doc("The result returned from a check name availability request.")
model CheckNameResult {
  @doc("Specifies a Boolean value that indicates if the name is available.")
  nameAvailable?: boolean;

  @doc("Message indicating an unavailable name due to a conflict, or a description of the naming rules that are violated.")
  message?: string;

  @doc("Message providing the reason why the given name is invalid.")
  reason?: Reason;
}

@doc("The properties for a group information object.")
model GroupIdInformationProperties {
  @doc("The group id.")
  groupId?: string;

  @doc("The required members for a specific group id.")
  requiredMembers?: string[];

  @doc("The required DNS zones for a specific group id.")
  requiredZoneNames?: string[];
}

@doc("Properties of a time series database connection resource.")
@discriminator("connectionType")
model TimeSeriesDatabaseConnectionProperties {
  @doc("The provisioning state.")
  @visibility("read")
  provisioningState?: TimeSeriesDatabaseConnectionState;

  @doc("Managed identity properties for the time series database connection resource.")
  identity?: ManagedIdentityReference;
}

@doc("Properties related to ServiceBus.")
model ServiceBus extends DigitalTwinsEndpointResourceProperties {
  @doc("PrimaryConnectionString of the endpoint for key-based authentication. Will be obfuscated during read.")
  primaryConnectionString?: string;

  @doc("SecondaryConnectionString of the endpoint for key-based authentication. Will be obfuscated during read.")
  secondaryConnectionString?: string;

  @doc("The URL of the ServiceBus namespace for identity-based authentication. It must include the protocol 'sb://'.")
  endpointUri?: string;

  @doc("The ServiceBus Topic name for identity-based authentication.")
  entityPath?: string;

  @doc("The type of Digital Twins endpoint")
  endpointType: "ServiceBus";
}

@doc("Properties related to EventHub.")
model EventHub extends DigitalTwinsEndpointResourceProperties {
  @doc("PrimaryConnectionString of the endpoint for key-based authentication. Will be obfuscated during read.")
  connectionStringPrimaryKey?: string;

  @doc("SecondaryConnectionString of the endpoint for key-based authentication. Will be obfuscated during read.")
  connectionStringSecondaryKey?: string;

  @doc("The URL of the EventHub namespace for identity-based authentication. It must include the protocol 'sb://'.")
  endpointUri?: string;

  @doc("The EventHub name in the EventHub namespace for identity-based authentication.")
  entityPath?: string;

  @doc("The type of Digital Twins endpoint")
  endpointType: "EventHub";
}

@doc("Properties related to EventGrid.")
model EventGrid extends DigitalTwinsEndpointResourceProperties {
  @doc("EventGrid Topic Endpoint.")
  @projectedName("json", "TopicEndpoint")
  topicEndpoint: string;

  @doc("EventGrid secondary accesskey. Will be obfuscated during read.")
  accessKey1: string;

  @doc("EventGrid secondary accesskey. Will be obfuscated during read.")
  accessKey2?: string;

  @doc("The type of Digital Twins endpoint")
  endpointType: "EventGrid";
}

@doc("Properties of a time series database connection to Azure Data Explorer with data being sent via an EventHub.")
model AzureDataExplorerConnectionProperties
  extends TimeSeriesDatabaseConnectionProperties {
  @doc("The resource ID of the Azure Data Explorer cluster.")
  adxResourceId: string;

  @doc("The URI of the Azure Data Explorer endpoint.")
  adxEndpointUri: string;

  @doc("The name of the Azure Data Explorer database.")
  adxDatabaseName: string;

  @doc("The name of the Azure Data Explorer table used for storing updates to properties of twins and relationships. Defaults to AdtPropertyEvents.")
  adxTableName?: string;

  @doc("The name of the Azure Data Explorer table used for recording twin lifecycle events. The table will not be created if this property is left unspecified.")
  adxTwinLifecycleEventsTableName?: string;

  @doc("The name of the Azure Data Explorer table used for recording relationship lifecycle events. The table will not be created if this property is left unspecified.")
  adxRelationshipLifecycleEventsTableName?: string;

  @doc("The URL of the EventHub namespace for identity-based authentication. It must include the protocol sb://")
  eventHubEndpointUri: string;

  @doc("The EventHub name in the EventHub namespace for identity-based authentication.")
  eventHubEntityPath: string;

  @doc("The resource ID of the EventHub namespace.")
  eventHubNamespaceResourceId: string;

  @doc("The EventHub consumer group to use when ADX reads from EventHub. Defaults to $Default.")
  eventHubConsumerGroup?: string;

  @doc("Specifies whether or not to record twin / relationship property and item removals, including removals of indexed or keyed values (such as map entries, array elements, etc.). This feature is de-activated unless explicitly set to 'true'. Setting this property to 'true' will generate an additional column in the property events table in ADX.")
  recordPropertyAndItemRemovals?: RecordPropertyAndItemRemovals;

  @doc("The type of time series connection resource.")
  connectionType: "AzureDataExplorer";
}
