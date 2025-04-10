import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.DigitalTwins;

/**
 * The provisioning state.
 */
union ProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Provisioning: "Provisioning",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Updating: "Updating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Canceled: "Canceled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deleted: "Deleted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Warning: "Warning",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Suspending: "Suspending",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Restoring: "Restoring",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Moving: "Moving",
}

/**
 * The provisioning state.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
union ConnectionPropertiesProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Pending: "Pending",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Approved: "Approved",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Rejected: "Rejected",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disconnected: "Disconnected",
}

/**
 * The status of a private endpoint connection.
 */
union PrivateLinkServiceConnectionStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Pending: "Pending",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Approved: "Approved",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Rejected: "Rejected",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disconnected: "Disconnected",
}

/**
 * Public network access for the DigitalTwinsInstance.
 */
union PublicNetworkAccess {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disabled: "Disabled",
}

/**
 * The type of Managed Identity used by the DigitalTwinsInstance.
 */
union DigitalTwinsIdentityType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  None: "None",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SystemAssigned: "SystemAssigned",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  UserAssigned: "UserAssigned",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `SystemAssigned,UserAssigned`: "SystemAssigned,UserAssigned",
}

/**
 * The type of Digital Twins endpoint
 */
union EndpointType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  EventHub: "EventHub",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  EventGrid: "EventGrid",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ServiceBus: "ServiceBus",
}

/**
 * The provisioning state.
 */
union EndpointProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Provisioning: "Provisioning",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Updating: "Updating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Canceled: "Canceled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deleted: "Deleted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Warning: "Warning",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Suspending: "Suspending",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Restoring: "Restoring",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Moving: "Moving",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disabled: "Disabled",
}

/**
 * Specifies the authentication type being used for connecting to the endpoint. Defaults to 'KeyBased'. If 'KeyBased' is selected, a connection string must be specified (at least the primary connection string). If 'IdentityBased' is select, the endpointUri and entityPath properties must be specified.
 */
union AuthenticationType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  KeyBased: "KeyBased",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  IdentityBased: "IdentityBased",
}

/**
 * The type of managed identity used.
 */
union IdentityType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SystemAssigned: "SystemAssigned",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  UserAssigned: "UserAssigned",
}

/**
 * Message providing the reason why the given name is invalid.
 */
union Reason {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Invalid: "Invalid",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AlreadyExists: "AlreadyExists",
}

/**
 * The type of time series connection resource.
 */
union ConnectionType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AzureDataExplorer: "AzureDataExplorer",
}

/**
 * The provisioning state.
 */
union TimeSeriesDatabaseConnectionState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Provisioning: "Provisioning",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Updating: "Updating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Canceled: "Canceled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deleted: "Deleted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Warning: "Warning",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Suspending: "Suspending",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Restoring: "Restoring",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Moving: "Moving",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disabled: "Disabled",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union CleanupConnectionArtifacts {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `true`: "true",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `false`: "false",
}

/**
 * Specifies whether or not to record twin / relationship property and item removals, including removals of indexed or keyed values (such as map entries, array elements, etc.). This feature is de-activated unless explicitly set to 'true'. Setting this property to 'true' will generate an additional column in the property events table in ADX.
 */
union RecordPropertyAndItemRemovals {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `true`: "true",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `false`: "false",
}

/**
 * The properties of a DigitalTwinsInstance.
 */
model DigitalTwinsProperties {
  /**
   * Time when DigitalTwinsInstance was created.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdTime?: utcDateTime;

  /**
   * Time when DigitalTwinsInstance was updated.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdatedTime?: utcDateTime;

  /**
   * The provisioning state.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Api endpoint to work with DigitalTwinsInstance.
   */
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
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
  privateLinkServiceConnectionState?: ConnectionPropertiesPrivateLinkServiceConnectionState;
}

/**
 * The private endpoint property of a private endpoint connection.
 */
model PrivateEndpoint {
  /**
   * The resource identifier.
   */
  @visibility(Lifecycle.Read)
  id?: string;
}

/**
 * The connection state.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ConnectionPropertiesPrivateLinkServiceConnectionState
  extends ConnectionState {}

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
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The resource name.
   */
  @visibility(Lifecycle.Read)
  @pattern("^(?!-)[A-Za-z0-9-]{3,63}(?<!-)$")
  name?: string;

  /**
   * The resource type.
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * The resource location.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location: string;

  /**
   * The resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;

  /**
   * The managed identity for the DigitalTwinsInstance.
   */
  identity?: DigitalTwinsIdentity;

  /**
   * Metadata pertaining to creation and last modification of the DigitalTwinsInstance.
   */
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
  principalId?: string;

  /**
   * The tenant id of the Managed Identity Resource. This will be sent to the RP from ARM via the x-ms-client-tenant-id header in the PUT request if the resource has a systemAssigned(implicit) identity
   */
  @visibility(Lifecycle.Read)
  tenantId?: string;

  /**
   * The list of user identities associated with the resource. The user identity dictionary key references will be ARM resource ids in the form:
   * '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{identityName}'.
   * .
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  userAssignedIdentities?: Record<UserAssignedIdentity>;
}

/**
 * Error definition.
 */
model ErrorDefinition {
  /**
   * Service specific error code which serves as the substatus for the HTTP error code.
   */
  @visibility(Lifecycle.Read)
  code?: string;

  /**
   * Description of the error.
   */
  @visibility(Lifecycle.Read)
  message?: string;

  /**
   * Internal error details.
   */
  @visibility(Lifecycle.Read)
  details?: ErrorDefinition[];
}

/**
 * The description of the DigitalTwins service.
 */
model DigitalTwinsPatchDescription {
  /**
   * Instance patch properties
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
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
   * The type of Digital Twins endpoint
   */
  endpointType: EndpointType;

  /**
   * The provisioning state.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: EndpointProvisioningState;

  /**
   * Time when the Endpoint was added to DigitalTwinsInstance.
   */
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Extension resource name.
   */
  @visibility(Lifecycle.Read)
  @pattern("^(?![0-9]+$)(?!-)[a-zA-Z0-9-]{2,49}[a-zA-Z0-9]$")
  name?: string;

  /**
   * The resource type.
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Metadata pertaining to creation and last modification of the resource.
   */
  @visibility(Lifecycle.Read)
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
 * The available private link resources for a Digital Twin.
 */
model GroupIdInformationResponse {
  /**
   * The list of available private link resources for a Digital Twin.
   */
  value?: GroupIdInformation[];
}

/**
 * The properties for a group information object.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
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
 * The available private link connections for a Digital Twin.
 */
model PrivateEndpointConnectionsResponse {
  /**
   * The list of available private link connections for a Digital Twin.
   */
  value?: PrivateEndpointConnection[];
}

/**
 * Properties of a time series database connection resource.
 */
@discriminator("connectionType")
model TimeSeriesDatabaseConnectionProperties {
  /**
   * The type of time series connection resource.
   */
  connectionType: ConnectionType;

  /**
   * The provisioning state.
   */
  @visibility(Lifecycle.Read)
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
  TopicEndpoint: string;

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
