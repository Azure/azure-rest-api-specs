import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";
import "./common_models.tsp";

using Azure.ResourceManager;

namespace Microsoft.AzureDataTransfer;

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
 * The source IP address and CIDR ranges of the stream
 */
model StreamSourceAddresses {
  /**
   * A source IP address or CIDR range
   */
  sourceAddresses?: string[];
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
 * The flows resource patch definition.
 */
model FlowsPatch {
  ...ManagedServiceIdentityProperty;
  ...Azure.ResourceManager.Foundations.ArmTagsProperty;
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
