import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.AzureDataTransfer;

/**
 * Direction of data movement
 */
union Direction {
  string,

  /**
   * The direction is on the sending side of a pipeline, connection, or flow.
   */
  Send: "Send",

  /**
   * The direction is on the receiving side side of a pipeline, connection, or flow.
   */
  Receive: "Receive",
}

/**
 * Status of the schema.
 */
union SchemaStatus {
  string,

  /**
   * A schema that has not been approved and is awaiting review.
   */
  New: "New",

  /**
   * A schema that has been approved and is ready for use.
   */
  Approved: "Approved",
}

/**
 * The Schema Type.
 */
union SchemaType {
  string,

  /**
   * The schema represents a single XML schema definition file.
   */
  Xsd: "Xsd",

  /**
   * The schema represents a ZIP file with multiple XML schema definition files within it.
   */
  Zip: "Zip",
}

/**
 * Validation status of the schema
 */
union ValidateSchemaStatus {
  string,

  /**
   * Validation of the schema was successful.
   */
  Succeeded: "Succeeded",

  /**
   * The schema failed validation, whether due to error or an invalid schema.
   */
  Failed: "Failed",
}

/**
 * Status of the connection
 */
union ConnectionStatus {
  string,

  /**
   * This connection has been created but is under review by the pipeline owner.
   */
  InReview: "InReview",

  /**
   * This connection has been approved by the pipeline owner and is ready for use.
   */
  Approved: "Approved",

  /**
   * This connection has been rejected by the pipeline owner and cannot be used.
   */
  Rejected: "Rejected",

  /**
   * Creation of the connection has been accepted.
   */
  Accepted: "Accepted",
}

/**
 * Status of force disablement
 */
union ForceDisabledStatus {
  string,

  /**
   * This Flow has been disabled as the connection has been disabled.
   */
  ConnectionForceDisabled: "ConnectionForceDisabled",

  /**
   * This Flow has been disabled as the flow type this flow uses has been disabled.
   */
  FlowTypeForceDisabled: "FlowTypeForceDisabled",
}

/**
 * Link status of the current pipeline, connection, flow.
 */
union LinkStatus {
  string,

  /**
   * The pipeline, connection, or flow is currently linked with another corresponding pipeline,
   * connection, or flow, and can be used.
   */
  Linked: "Linked",

  /**
   * The pipeline, connection, or flow is not linked with another corresponding pipeline,
   * connection, or flow, and cannot be used.
   */
  Unlinked: "Unlinked",
}

/**
 * Flow type for the specified resource
 */
union FlowType {
  string,

  /**
   * This type of flow is not set.
   */
  Unknown: "Unknown",

  /**
   * This flow sends complex documents, such as Microsoft Office documents of Portable document format files.
   */
  Complex: "Complex",

  /**
   * This flow sends source code files and artifacts.
   */
  DevSecOps: "DevSecOps",

  /**
   * This flow over the Azure Data Transfer low latency messaging subsystem.
   */
  Messaging: "Messaging",

  /**
   * This flow sends data that will not be processed by any security system.
   */
  Mission: "Mission",

  /**
   * This flow is assigned to internal Microsoft use cases.
   */
  MicrosoftInternal: "MicrosoftInternal",

  /**
   * This flow sends blobs that can be used for multiple use cases.
   */
  BasicFiles: "BasicFiles",

  /**
   * This flow sends blobs that can be used for multiple use cases.
   */
  Data: "Data",

  /**
   * This flow sends blobs that can be used for multiple use cases.
   */
  Standard: "Standard",

  /**
   * This flow sends video streams.
   */
  StreamingVideo: "StreamingVideo",

  /**
   * This flow sends blobs that will not be processed by any security system.
   */
  Opaque: "Opaque",

  /**
   * This flow sends Extensible Markup Language that will not be processed by any security system.
   */
  MissionOpaqueXML: "MissionOpaqueXML",

  /**
   * This flow sends blobs that can be used for Virtual Machines.
   */
  DiskImages: "DiskImages",

  /**
   * This flow sends data via an Application Programmer Interface.
   */
  API: "API",
}

/**
 * Provisioning state of the pipeline, connection, flow.
 */
union ProvisioningState {
  string,

  /**
   * Resource has been created.
   */
  Succeeded: "Succeeded",

  /**
   * Resource creation failed.
   */
  Failed: "Failed",

  /**
   * Resource creation was canceled.
   */
  Canceled: "Canceled",

  /**
   * Resource has been accepted for creation.
   */
  Accepted: "Accepted",
}

/**
 * Type of managed service identity (where both SystemAssigned and UserAssigned types are allowed).
 */
union ManagedServiceIdentityType {
  string,
  None: "None",
  SystemAssigned: "SystemAssigned",
  UserAssigned: "UserAssigned",
  `SystemAssigned,UserAssigned`: "SystemAssigned,UserAssigned",
}

/**
 * Operation status for the last patch request for this connection.
 */
union OperationStatusEnum {
  string,

  /**
   * The last patch request for this connection completed with an error.
   */
  Failed: "Failed",

  /**
   * The last patch request for this connection completed.
   */
  Succeeded: "Succeeded",
}

/**
 * Status of the current pipeline
 */
union PipelineStatus {
  string,

  /**
   * The pipeline is currently enabled and all child connection and flow resources below able to send or receive data.
   */
  Enabled: "Enabled",

  /**
   * The pipeline is currently disabled and all child connection and flow resources below are unable to send or receive data.
   */
  Disabled: "Disabled",
}

/**
 * Status of the current flow.
 */
union FlowStatus {
  string,

  /**
   * The flow is currently enabled and able to send or receive data.
   */
  Enabled: "Enabled",

  /**
   * The flow is currently disabled and cannot send or receive data.
   */
  Disabled: "Disabled",
}

/**
 * Transfer Storage Blobs or Tables
 */
union DataType {
  string,

  /**
   * The flow uses Azure Storage blobs to send or receive data.
   */
  Blob: "Blob",

  /**
   * The flow uses Azure Storage tables to send or receive data.
   */
  Table: "Table",
}

/**
 * Billing tier for this messaging flow.
 */
union FlowBillingTier {
  string,

  /**
   * Billing tier for messaging processing that charges based on how much data is transferred.
   */
  BlobTransport: "BlobTransport",

  /**
   * Billing tier for standard messaging processing that charges based on having the messaging resource allocated.
   */
  Standard: "Standard",

  /**
   * Billing tier for premium messaging processing that charges based on having the messaging resource allocated.
   */
  Premium: "Premium",
}

/**
 * Remote Calling Mode in the Azure Data Transfer API Flow, which describes how the API Flow will be invoked
 */
union ApiMode {
  string,

  /**
   * The API flow will forward calls to a custom Software Development Kit implementation.
   */
  SDK: "SDK",

  /**
   * The API flow will forward calls to a specified endpoint.
   */
  Endpoint: "Endpoint",
}

/**
 * Flag for if Azure Data Transfer API Flow should extract the user token
 */
union IdentityTranslation {
  string,

  /**
   * The API flow will make use of the user identity that called this API flow, and pass that token
   * through the boundary.
   */
  UserIdentity: "UserIdentity",

  /**
   * The API flow will make use of the Azure Data Transfer Flow managed identity on the other side of the boundary.
   */
  ServiceIdentity: "ServiceIdentity",
}

/**
 * The protocol of the stream
 */
union StreamProtocol {
  string,

  /**
   * This Flow is using User Datagram Protocol for the video stream.
   */
  UDP: "UDP",

  /**
   * This Flow is using Secure Reliable Transfer for the video stream.
   */
  SRT: "SRT",

  /**
   * This Flow is using Real-time Transport Protocol for the video stream.
   */
  RTP: "RTP",
}

/**
 * Type of target to execute the action on
 */
union TargetType {
  string,

  /**
   * The action executing is targeting a pipeline.
   */
  Pipeline: "Pipeline",

  /**
   * The action executing is targeting a connection.
   */
  Connection: "Connection",

  /**
   * The action executing is targeting a flow type.
   */
  FlowType: "FlowType",
}

/**
 * The request used to list approved schemas within the resource provider.
 */
model ListApprovedSchemasRequest {
  /**
   * The name of the pipeline to filter approved schemas.
   */
  pipeline?: string;

  /**
   * The direction pipeline to filter approved schemas.
   */
  direction?: Direction;
}

/**
 * The schemas list result.
 */
model SchemasListResult {
  /**
   * Schemas array.
   */
  value?: Schema[];
}

/**
 * The schema object.
 */
model Schema {
  /**
   * ID associated with this schema
   */
  id?: string;

  /**
   * Connection ID associated with this schema
   */
  connectionId?: string;

  /**
   * Status of the schema
   */
  status?: SchemaStatus;

  /**
   * Name of the schema
   */
  name?: string;

  /**
   * Content of the schema
   */
  content?: string;

  /**
   * The direction of the schema.
   */
  direction?: Direction;

  /**
   * Uri containing SAS token for the zipped schema
   */
  schemaUri?: url;

  /**
   * The Schema Type
   */
  schemaType?: SchemaType;
}

/**
 * Result of the schema validation.
 */
model ValidateSchemaResult {
  /**
   * Validation status of the schema
   */
  status?: ValidateSchemaStatus;

  /**
   * Message describing the schema validation
   */
  message?: string;
}

/**
 * Properties of connection
 */
model ConnectionProperties {
  /**
   * Pipeline to use to transfer data
   */
  pipeline: string;

  /**
   * Direction of data movement
   */
  direction?: Direction;

  /**
   * Justification for the connection request
   */
  justification?: string;

  /**
   * Status of the connection
   */
  @visibility(Lifecycle.Read)
  status?: ConnectionStatus;

  /**
   * Force disablement status of the current connection
   */
  @visibility(Lifecycle.Read)
  forceDisabledStatus?: ForceDisabledStatus[];

  /**
   * Reason for status
   */
  @visibility(Lifecycle.Read)
  statusReason?: string;

  /**
   * Link status of the current connection
   */
  @visibility(Lifecycle.Read)
  linkStatus?: LinkStatus;

  /**
   * Resource ID of the linked connection
   */
  @visibility(Lifecycle.Read)
  linkedConnectionId?: string;

  /**
   * The flow types being requested for this connection
   */
  flowTypes?: FlowType[];

  /**
   * Requirement ID of the connection
   */
  requirementId?: string;

  /**
   * Subscription ID to link cloud subscriptions together
   */
  remoteSubscriptionId?: string;

  /**
   * Approver of this connection request
   */
  @visibility(Lifecycle.Read)
  approver?: string;

  /**
   * PIN to link requests together
   */
  pin?: string;

  /**
   * The timestamp that this connection request was submitted at
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  dateSubmitted?: utcDateTime;

  /**
   * The primary contact for this connection request
   */
  primaryContact?: string;

  /**
   * The secondary contacts for this connection request
   */
  secondaryContacts?: string[];

  /**
   * Provisioning state of the connection
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The policies for this connection
   */
  policies?: string[];

  /**
   * The schemas for this connection
   */
  schemas?: Schema[];

  /**
   * The schema URIs for this connection
   */
  schemaUris?: url[];
}

/**
 * Managed service identity (system assigned and/or user assigned identities)
 */
model ManagedServiceIdentity {
  /**
   * The service principal ID of the system assigned identity. This property will only be provided for a system assigned identity.
   */
  @visibility(Lifecycle.Read)
  @format("uuid")
  principalId?: string;

  /**
   * The tenant ID of the system assigned identity. This property will only be provided for a system assigned identity.
   */
  @visibility(Lifecycle.Read)
  @format("uuid")
  tenantId?: string;

  /**
   * Type of managed service identity (where both SystemAssigned and UserAssigned types are allowed).
   */
  type: ManagedServiceIdentityType;

  /**
   * The set of user assigned identities associated with the resource. The userAssignedIdentities dictionary keys will be ARM resource ids in the form: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{identityName}. The dictionary values can be empty objects ({}) in requests.
   */
  userAssignedIdentities?: Record<UserAssignedIdentity>;
}

/**
 * Common fields that are returned in the response for all Azure Resource Manager resources
 */
model Resource {
  /**
   * Fully qualified resource ID for the resource. E.g. "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}"
   */
  @visibility(Lifecycle.Read)
  id?: Azure.Core.armResourceIdentifier;

  /**
   * The name of the resource
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The type of the resource. E.g. "Microsoft.Compute/virtualMachines" or "Microsoft.Storage/storageAccounts"
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Azure Resource Manager metadata containing createdBy and modifiedBy information.
   */
  @visibility(Lifecycle.Read)
  systemData?: SystemData;
}

/**
 * Properties of pipeline
 */
model PipelineProperties {
  /**
   * Remote cloud of the data to be transferred or received
   */
  remoteCloud: string;

  /**
   * Display name of this pipeline
   */
  displayName?: string;

  /**
   * Connections associated with pipeline
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #["id"])
  connections?: PipelineConnection[];

  /**
   * Subscribers of this resource
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  subscribers?: Subscriber[];

  /**
   * Provisioning state of the pipeline
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The policies for this pipeline
   */
  policies?: string[];

  /**
   * The flow types allowed for this pipeline
   */
  flowTypes?: FlowType[];

  /**
   * The flow types that are disabled for this pipeline
   */
  disabledFlowTypes?: FlowType[];

  /**
   * Quarantine Download Storage Account
   */
  quarantineDownloadStorageAccount?: string;

  /**
   * Quarantine Download Storage Container
   */
  quarantineDownloadStorageContainer?: string;

  /**
   * Status of the current pipeline
   */
  status?: PipelineStatus;
}

/**
 * Connection body inside a pipeline
 */
model PipelineConnection {
  ...Record<unknown>;

  /**
   * Connection id inside pipeline
   */
  id: string;

  /**
   * Connection name inside pipeline
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Connection type inside pipeline
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Connection location inside pipeline
   */
  @visibility(Lifecycle.Read)
  location?: string;

  /**
   * Connection etag inside pipeline
   */
  @visibility(Lifecycle.Read)
  etag?: string;

  /**
   * Metadata pertaining to creation and last modification of the resource.
   */
  @visibility(Lifecycle.Read)
  systemData?: SystemData;

  /**
   * Connection properties inside pipeline
   */
  properties?: PipelineConnectionProperties;
}

/**
 * Connection properties inside pipeline
 */
model PipelineConnectionProperties {
  ...Record<unknown>;

  /**
   * Internal metadata of the connection inside pipeline.
   */
  internalMetadata?: InternalMetadataProperties;
}

/**
 * Internal metadata of the connection inside pipeline.
 */
model InternalMetadataProperties {
  ...Record<unknown>;

  /**
   * Operation status associated with the last patch request
   */
  operationStatus?: OperationStatusProperties;

  /**
   * User that last set the approved status for this connection
   */
  @visibility(Lifecycle.Read)
  statusSetBy?: string;
}

/**
 * Operation status associated with the last patch request
 */
model OperationStatusProperties {
  /**
   * Operation status for the last patch request for this connection.
   */
  @visibility(Lifecycle.Read)
  status?: OperationStatusEnum;

  /**
   * Operation status ID of the last patch request for this connection.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Message for the operation for the last patch request for this connection.
   */
  @visibility(Lifecycle.Read)
  message?: string;
}

/**
 * An individual that would like to subscribe to events that occur on a pipeline.
 */
model Subscriber {
  /**
   * Email of the subscriber
   */
  email?: string;

  /**
   * Number specifying what notifications to receive
   */
  notifications?: int64;
}

/**
 * The connections resource patch definition.
 */
model ConnectionsPatch {
  /**
   * The managed service identities assigned to this resource.
   */
  identity?: ManagedServiceIdentity;

  /**
   * Resource tags.
   */
  tags?: Record<string>;
}

/**
 * Properties of flow
 */
model FlowProperties {
  /**
   * The connection associated with this flow
   */
  connection?: SelectedResource;

  /**
   * Dataflow GUID associated with this flow
   */
  @visibility(Lifecycle.Read)
  flowId?: string;

  /**
   * AME, PME, or TORUS only! AKV Chain Containing SAS Token
   */
  keyVaultUri?: string;

  /**
   * Link status of the current flow
   */
  @visibility(Lifecycle.Read)
  linkStatus?: LinkStatus;

  /**
   * Resource ID of the linked flow
   */
  @visibility(Lifecycle.Read)
  linkedFlowId?: string;

  /**
   * Status of the current flow
   */
  status?: FlowStatus;

  /**
   * Force disablement status of the current flow
   */
  @visibility(Lifecycle.Read)
  forceDisabledStatus?: ForceDisabledStatus[];

  /**
   * Storage Account
   */
  storageAccountName?: string;

  /**
   * Storage Account ID
   */
  storageAccountId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Storage/storageAccounts";
    }
  ]>;

  /**
   * Storage Container Name
   */
  storageContainerName?: string;

  /**
   * Storage Table Name
   */
  storageTableName?: string;

  /**
   * Service Bus Queue ID
   */
  serviceBusQueueId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Storage/namespaces/queues";
    }
  ]>;

  /**
   * The flow type for this flow
   */
  flowType?: FlowType;

  /**
   * Transfer Storage Blobs or Tables
   */
  dataType?: DataType;

  /**
   * Provisioning state of the flow
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The policies for this flow
   */
  policies?: string[];

  /**
   * The selected schema for this flow
   */
  schema?: Schema;

  /**
   * The messaging options for this flow
   */
  messagingOptions?: MessagingOptions;

  /**
   * The API Flow configuration options for Azure Data Transfer API Flow type.
   */
  apiFlowOptions?: ApiFlowOptions;

  /**
   * The URI to the customer managed key for this flow
   */
  customerManagedKeyVaultUri?: url;

  /**
   * The flow stream identifier
   */
  streamId?: string;

  /**
   * The protocol of the stream
   */
  streamProtocol?: StreamProtocol;

  /**
   * The latency of the stream in milliseconds
   */
  streamLatency?: int64;

  /**
   * The passphrase used for SRT streams
   */
  passphrase?: string;

  /**
   * The source IP address and CIDR ranges of the stream
   */
  sourceAddresses?: StreamSourceAddresses;

  /**
   * The destination endpoints of the stream
   */
  destinationEndpoints?: string[];

  /**
   * The destination endpoint ports of the stream
   */
  destinationEndpointPorts?: int64[];

  /**
   * Event Hub ID
   */
  eventHubId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.EventHub/namespaces/eventhubs";
    }
  ]>;

  /**
   * Event Hub Consumer Group
   */
  consumerGroup?: string;
}

/**
 * A resource selected from ARM
 */
model SelectedResource {
  /**
   * Name of the connection
   */
  name?: string;

  /**
   * Id of the connection
   */
  id: string;

  /**
   * Location of the connection
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location?: string;

  /**
   * Name of the subscription with the connection
   */
  subscriptionName?: string;
}

/**
 * The option associated with messaging flows.
 */
model MessagingOptions {
  /**
   * Billing tier for this messaging flow
   */
  billingTier?: FlowBillingTier;
}

/**
 * Properties specific to API Flow Type
 */
model ApiFlowOptions {
  /**
   * Remote host to which communication needs to be made
   */
  remoteEndpoint?: string;

  /**
   * Unique CNAME to represent the Azure Data Transfer API Flow instance
   */
  cname?: string;

  /**
   * Remote Calling Mode in the Azure Data Transfer API Flow, which describes how the API Flow will be invoked
   */
  apiMode?: ApiMode;

  /**
   * Flag for if Azure Data Transfer API Flow should extract the user token
   */
  identityTranslation?: IdentityTranslation;

  /**
   * Sender's app user assigned Manage Identity client ID
   */
  senderClientId?: string;

  /**
   * Remote stub app registration Client ID
   */
  remoteCallingModeClientId?: string;

  /**
   * Optional field to override the audience of the remote endpoint
   */
  audienceOverride?: string;
}

/**
 * The source IP address and CIDR ranges of the stream
 */
model StreamSourceAddresses {
  /**
   * A source IP address or CIDR range
   */
  sourceAddresses?: string[];
}

/**
 * Plan for the resource.
 */
model Plan {
  /**
   * A user defined name of the 3rd Party Artifact that is being procured.
   */
  name: string;

  /**
   * The publisher of the 3rd Party Artifact that is being bought. E.g. NewRelic
   */
  publisher: string;

  /**
   * The 3rd Party artifact that is being procured. E.g. NewRelic. Product maps to the OfferID specified for the artifact at the time of Data Market onboarding.
   */
  product: string;

  /**
   * A publisher provided promotion code as provisioned in Data Market for the said product/artifact.
   */
  promotionCode?: string;

  /**
   * The version of the desired product/artifact.
   */
  version?: string;
}

/**
 * The flows resource patch definition.
 */
model FlowsPatch {
  /**
   * The managed service identities assigned to this resource.
   */
  identity?: ManagedServiceIdentity;

  /**
   * Resource tags.
   */
  tags?: Record<string>;
}

/**
 * List of destination endpoint ports for the flow stream
 */
model GetDestinationEndpointPortsResult {
  /**
   * The destination endpoint port for the flow stream
   */
  ports?: int64[];
}

/**
 * List of destination endpoints for the flow stream
 */
model GetDestinationEndpointsResult {
  /**
   * The destination endpoints for the flow stream
   */
  endpoints?: string[];
}

/**
 * The connection string for the specified streaming flow
 */
model GetStreamConnectionStringResult {
  /**
   * The connection string for the specified streaming flow
   */
  connectionString?: string;
}

/**
 * The resource to reference.
 */
model ResourceBody {
  /**
   * ID of the resource.
   */
  id: string;

  /**
   * Reason for resource operation.
   */
  statusReason?: string;
}

/**
 * Set the destination endpoint ports for the specified stream ID
 */
model SetDestinationEndpointPorts {
  /**
   * The specified stream ID destination endpoint ports
   */
  ports?: int64[];
}

/**
 * Set the destination endpoints for the specified stream ID
 */
model SetDestinationEndpoints {
  /**
   * The specified stream ID destination endpoints
   */
  endpoints?: string[];
}

/**
 * Set the passphrase used for SRT streams
 */
model SetStreamPassphrase {
  /**
   * The passphrase used for SRT streams
   */
  value?: string;
}

/**
 * Set the source addresses for the specified stream ID
 */
model SetSourceAddresses {
  /**
   * Source addresses
   */
  values?: string[];
}

/**
 * Pending connection object
 */
model PendingConnection {
  /**
   * Pipeline to use to transfer data
   */
  pipeline: string;

  /**
   * Direction of data movement
   */
  direction?: Direction;

  /**
   * Justification for the connection request
   */
  justification?: string;

  /**
   * Status of the connection
   */
  @visibility(Lifecycle.Read)
  status?: ConnectionStatus;

  /**
   * Force disablement status of the current connection
   */
  @visibility(Lifecycle.Read)
  forceDisabledStatus?: ForceDisabledStatus[];

  /**
   * Reason for status
   */
  @visibility(Lifecycle.Read)
  statusReason?: string;

  /**
   * Link status of the current connection
   */
  @visibility(Lifecycle.Read)
  linkStatus?: LinkStatus;

  /**
   * Resource ID of the linked connection
   */
  @visibility(Lifecycle.Read)
  linkedConnectionId?: string;

  /**
   * The flow types being requested for this connection
   */
  flowTypes?: FlowType[];

  /**
   * Requirement ID of the connection
   */
  requirementId?: string;

  /**
   * Subscription ID to link cloud subscriptions together
   */
  remoteSubscriptionId?: string;

  /**
   * Approver of this connection request
   */
  @visibility(Lifecycle.Read)
  approver?: string;

  /**
   * PIN to link requests together
   */
  pin?: string;

  /**
   * The timestamp that this connection request was submitted at
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  dateSubmitted?: utcDateTime;

  /**
   * The primary contact for this connection request
   */
  primaryContact?: string;

  /**
   * The secondary contacts for this connection request
   */
  secondaryContacts?: string[];

  /**
   * Provisioning state of the connection
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The policies for this connection
   */
  policies?: string[];

  /**
   * The schemas for this connection
   */
  schemas?: Schema[];

  /**
   * The schema URIs for this connection
   */
  schemaUris?: url[];

  /**
   * The resource-specific properties for this resource.
   */
  properties?: Connection;

  /**
   * Resource tags.
   */
  tags?: Record<string>;

  /**
   * The geo-location where the resource lives
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location: string;

  /**
   * Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}
   */
  @visibility(Lifecycle.Read)
  id?: Azure.Core.armResourceIdentifier;

  /**
   * The name of the resource
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The type of the resource. E.g. "Microsoft.Compute/virtualMachines" or "Microsoft.Storage/storageAccounts"
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Azure Resource Manager metadata containing createdBy and modifiedBy information.
   */
  @visibility(Lifecycle.Read)
  systemData?: SystemData;

  /**
   * Subscription ID of the pending connection.
   */
  @visibility(Lifecycle.Read)
  subscriptionId?: string;
}

/**
 * Pending flow object
 */
model PendingFlow {
  /**
   * The connection associated with this flow
   */
  connection?: SelectedResource;

  /**
   * Dataflow GUID associated with this flow
   */
  @visibility(Lifecycle.Read)
  flowId?: string;

  /**
   * AME, PME, or TORUS only! AKV Chain Containing SAS Token
   */
  keyVaultUri?: string;

  /**
   * Link status of the current flow
   */
  @visibility(Lifecycle.Read)
  linkStatus?: LinkStatus;

  /**
   * Resource ID of the linked flow
   */
  @visibility(Lifecycle.Read)
  linkedFlowId?: string;

  /**
   * Status of the current flow
   */
  status?: FlowStatus;

  /**
   * Force disablement status of the current flow
   */
  @visibility(Lifecycle.Read)
  forceDisabledStatus?: ForceDisabledStatus[];

  /**
   * Storage Account
   */
  storageAccountName?: string;

  /**
   * Storage Account ID
   */
  storageAccountId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Storage/storageAccounts";
    }
  ]>;

  /**
   * Storage Container Name
   */
  storageContainerName?: string;

  /**
   * Storage Table Name
   */
  storageTableName?: string;

  /**
   * Service Bus Queue ID
   */
  serviceBusQueueId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Storage/namespaces/queues";
    }
  ]>;

  /**
   * The flow type for this flow
   */
  flowType?: FlowType;

  /**
   * Transfer Storage Blobs or Tables
   */
  dataType?: DataType;

  /**
   * Provisioning state of the flow
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The policies for this flow
   */
  policies?: string[];

  /**
   * The selected schema for this flow
   */
  schema?: Schema;

  /**
   * The messaging options for this flow
   */
  messagingOptions?: MessagingOptions;

  /**
   * The API Flow configuration options for Azure Data Transfer API Flow type.
   */
  apiFlowOptions?: ApiFlowOptions;

  /**
   * The URI to the customer managed key for this flow
   */
  customerManagedKeyVaultUri?: url;

  /**
   * The flow stream identifier
   */
  streamId?: string;

  /**
   * The protocol of the stream
   */
  streamProtocol?: StreamProtocol;

  /**
   * The latency of the stream in milliseconds
   */
  streamLatency?: int64;

  /**
   * The passphrase used for SRT streams
   */
  passphrase?: string;

  /**
   * The source IP address and CIDR ranges of the stream
   */
  sourceAddresses?: StreamSourceAddresses;

  /**
   * The destination endpoints of the stream
   */
  destinationEndpoints?: string[];

  /**
   * The destination endpoint ports of the stream
   */
  destinationEndpointPorts?: int64[];

  /**
   * Event Hub ID
   */
  eventHubId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.EventHub/namespaces/eventhubs";
    }
  ]>;

  /**
   * Event Hub Consumer Group
   */
  consumerGroup?: string;

  /**
   * The resource-specific properties for this resource.
   */
  properties?: Flow;

  /**
   * Resource tags.
   */
  tags?: Record<string>;

  /**
   * The geo-location where the resource lives
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location: string;

  /**
   * Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}
   */
  @visibility(Lifecycle.Read)
  id?: Azure.Core.armResourceIdentifier;

  /**
   * The name of the resource
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The type of the resource. E.g. "Microsoft.Compute/virtualMachines" or "Microsoft.Storage/storageAccounts"
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Azure Resource Manager metadata containing createdBy and modifiedBy information.
   */
  @visibility(Lifecycle.Read)
  systemData?: SystemData;

  /**
   * Subscription ID of the pending flow.
   */
  @visibility(Lifecycle.Read)
  subscriptionId?: string;

  /**
   * Connection ID of the pending flow.
   */
  @visibility(Lifecycle.Read)
  connectionId?: string;
}

/**
 * The pipelines resource patch definition.
 */
model PipelinesPatch {
  /**
   * Properties of pipelines patch body.
   */
  properties?: PipelinesPatchProperties;

  /**
   * Resource tags.
   */
  tags?: Record<string>;

  /**
   * The managed service identities assigned to this resource.
   */
  identity?: ManagedServiceIdentity;
}

/**
 * Properties of pipelines patch body.
 */
model PipelinesPatchProperties {
  /**
   * Connections associated with pipeline
   */
  @OpenAPI.extension("x-ms-identifiers", #["id"])
  connections?: PipelineConnection[];

  /**
   * The flow types allowed for this pipeline
   */
  flowTypes?: FlowType[];
}

/**
 * The action to be executed.
 */
model Action {
  /**
   * Type of action to be executed
   */
  actionType: ActionType;

  /**
   * Type of target to execute the action on
   */
  targetType: TargetType;

  /**
   * Targets for the action
   */
  targets: string[];

  /**
   * Business justification for the action
   */
  justification?: string;
}

/**
 * An array of connection id resources.
 */
model ConnectionIdList {
  /**
   * Connection ID to target
   */
  value?: string[];
}

/**
 * An array of flow resources.
 */
model ListFlowsByPipelineResult {
  /**
   * List flows by pipeline result by connection
   */
  @OpenAPI.extension("x-ms-identifiers", #["id"])
  value?: ListFlowsByPipelineConnection[];
}

/**
 * A connection resource id in addition to all child flow resources under this connection.
 */
model ListFlowsByPipelineConnection {
  /**
   * ID of the connection.
   */
  id?: string;

  /**
   * List of flows associated with the connection.
   */
  flows?: Flow[];
}

/**
 * Azure operation completed successfully.
 */
model AzureResourceManagerArmResponseConnection {
  /**
   * The body type of the operation request or response.
   */
  body: Connection;
}

/**
 * Azure operation completed successfully.
 */
model AzureResourceManagerArmResponseFlow {
  /**
   * The body type of the operation request or response.
   */
  body: Flow;
}

/**
 * Azure operation completed successfully.
 */
model AzureResourceManagerArmResponsePipeline {
  /**
   * The body type of the operation request or response.
   */
  body: Pipeline;
}
