import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using OpenAPI;
using Azure.ResourceManager;

namespace Microsoft.IoTOperations;

/** ******************* */
/**
 * dataflowEndpoint resource type model details.
 */
@doc("Instance dataflowEndpoint resource")
@parentResource(InstanceResource)
model DataflowEndpointResource is ProxyResource<DataflowEndpointProperties> {
  @doc("Name of Instance dataflowEndpoint resource")
  @pattern("^[a-z0-9][a-z0-9-]*[a-z0-9]$")
  @key("dataflowEndpointName")
  @path
  @minLength(3)
  @maxLength(63)
  @segment("dataflowEndpoints")
  name: string;

  // Extended location is not included in ProxyResource yet
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
  @doc("Edge location of the resource.")
  @visibility("read", "create")
  extendedLocation: ExtendedLocation;
}

@doc("DataflowEndpoint Resource properties. NOTE - Only one type of endpoint is supported for one Resource")
model DataflowEndpointProperties {
  @doc("Endpoint Type.")
  endpointType: EndpointType;

  @doc("Azure Data Explorer endpoint.")
  dataExplorerSettings?: DataflowEndpointDataExplorer;

  @doc("Azure Data Lake endpoint.")
  dataLakeStorageSettings?: DataflowEndpointDataLakeStorage;

  @doc("Microsoft Fabric endpoint.")
  fabricOneLakeSettings?: DataflowEndpointFabricOneLake;

  @doc("Kafka endpoint.")
  kafkaSettings?: DataflowEndpointKafka;

  @doc("Local persistent volume endpoint.")
  localStorageSettings?: DataflowEndpointLocalStorage;

  @doc("Broker endpoint.")
  mqttSettings?: DataflowEndpointMqtt;

  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
}

@doc("DataflowEndpoint Type properties")
union EndpointType {
  string,

  @doc("Azure Data Explorer Type")
  DataExplorer: "DataExplorer",

  @doc("Azure Data Lake Type")
  DataLakeStorage: "DataLakeStorage",

  @doc("Microsoft Fabric Type")
  FabricOneLake: "FabricOneLake",

  @doc("Kafka Type")
  Kafka: "Kafka",

  @doc("Local Storage Type")
  LocalStorage: "LocalStorage",

  @doc("Broker Type")
  Mqtt: "Mqtt",
}

@doc("Azure Data Explorer endpoint properties")
model DataflowEndpointDataExplorer {
  @doc("Authentication configuration. NOTE - only authentication property is allowed per entry.")
  authentication: DataflowEndpointDataExplorerAuthentication;

  @doc("Database name.")
  database: string;

  @doc("Host of the Azure Data Explorer in the form of <cluster>.<region>.kusto.windows.net .")
  @pattern(".+\\..+\\.kusto\\.windows\\.net")
  host: string;

  @doc("Azure Data Explorer endpoint batching configuration.")
  batching?: BatchingConfiguration;
}

@doc("Azure Data Explorer Authentication properties. NOTE - only authentication property is allowed per entry.")
model DataflowEndpointDataExplorerAuthentication {
  @doc("Mode of Authentication.")
  method: DataExplorerAuthMethod;

  ...ManagedIdentity;
}

@doc("DataflowEndpoint Data Explorer Authentication Method properties")
union DataExplorerAuthMethod {
  ManagedIdentityMethod,
}

@doc("Azure Data Lake endpoint properties")
model DataflowEndpointDataLakeStorage {
  @doc("Authentication configuration. NOTE - only authentication property is allowed per entry.")
  authentication: DataflowEndpointDataLakeStorageAuthentication;

  @doc("Host of the Azure Data Lake in the form of <account>.blob.core.windows.net .")
  @pattern(".+\\.blob\\.core\\.windows\\.net")
  host: string;

  @doc("Azure Data Lake endpoint batching configuration.")
  batching?: BatchingConfiguration;
}

@doc("Azure Data Lake endpoint Authentication properties.  NOTE Enum - Only one method is supported for one entry")
model DataflowEndpointDataLakeStorageAuthentication {
  @doc("Mode of Authentication.")
  method: DataLakeStorageAuthMethod;

  // What is accessTokenSecretName now?
  @doc("SAS token authentication.")
  accessTokenSettings?: DataflowEndpointAuthenticationAccessToken;

  ...ManagedIdentity;
}

#suppress "@azure-tools/typespec-autorest/union-unsupported"
@doc("DataflowEndpoint Data Lake Storage Authentication Method properties")
union DataLakeStorageAuthMethod {
  ManagedIdentityMethod,
  AccessTokenMethod,
}

@doc("Microsoft Fabric endpoint properties")
model DataflowEndpointFabricOneLake {
  @doc("Authentication configuration. NOTE - only one authentication property is allowed per entry.")
  authentication: DataflowEndpointFabricOneLakeAuthentication;

  @doc("Names of the workspace and lakehouse.")
  names: DataflowEndpointFabricOneLakeNames;

  @doc("Type of location of the data in the workspace. Can be either tables or files.")
  oneLakePathType: DataflowEndpointFabricPathType;

  @doc("Host of the Microsoft Fabric in the form of https://<host>.fabric.microsoft.com.")
  @pattern(".+\\.fabric\\.microsoft\\.com")
  host: string;

  @doc("Batching configuration.")
  batching?: BatchingConfiguration;
}

@doc("Microsoft Fabric endpoint. Authentication properties. NOTE - Only one method is supported for one entry")
model DataflowEndpointFabricOneLakeAuthentication {
  @doc("Mode of Authentication.")
  method: FabricOneLakeAuthMethod;

  ...ManagedIdentity;
}

#suppress "@azure-tools/typespec-autorest/union-unsupported"
@doc("DataflowEndpoint Fabric One Lake Authentication Method properties")
union FabricOneLakeAuthMethod {
  ManagedIdentityMethod,
}

@doc("Microsoft Fabric endpoint Names properties")
model DataflowEndpointFabricOneLakeNames {
  @doc("Lakehouse name.")
  lakehouseName: string;

  @doc("Workspace name.")
  workspaceName: string;
}

@doc("DataflowEndpoint Fabric Path Type properties")
union DataflowEndpointFabricPathType {
  string,

  @doc("FILES Type")
  Files: "Files",

  @doc("TABLES Type")
  Tables: "Tables",
}

@doc("Kafka endpoint properties")
model DataflowEndpointKafka {
  @doc("Authentication configuration. NOTE - only authentication property is allowed per entry.")
  authentication: DataflowEndpointKafkaAuthentication;

  @doc("Consumer group ID.")
  consumerGroupId?: string;

  @doc("Kafka endpoint host.")
  host: string;

  @doc("Batching configuration.")
  batching?: DataflowEndpointKafkaBatching;

  @doc("Copy Broker properties. No effect if the endpoint is used as a source or if the dataflow doesn't have an Broker source.")
  copyMqttProperties?: OperationalMode = OperationalMode.Enabled;

  @doc("Compression. Can be none, gzip, lz4, or snappy. No effect if the endpoint is used as a source.")
  compression?: DataflowEndpointKafkaCompression = DataflowEndpointKafkaCompression.None;

  @doc("Kafka acks. Can be all, one, or zero. No effect if the endpoint is used as a source.")
  kafkaAcks?: DataflowEndpointKafkaAcks = DataflowEndpointKafkaAcks.All;

  @doc("Partition handling strategy. Can be default or static. No effect if the endpoint is used as a source.")
  partitionStrategy?: DataflowEndpointKafkaPartitionStrategy = DataflowEndpointKafkaPartitionStrategy.Default;

  @doc("TLS configuration.")
  tls?: TlsProperties = #{ mode: OperationalMode.Enabled };

  @doc("Cloud event mapping config.")
  cloudEventAttributes?: CloudEventAttributeType;
}

@doc("Kafka endpoint Authentication properties. NOTE - only authentication property is allowed per entry")
model DataflowEndpointKafkaAuthentication {
  @doc("Mode of Authentication.")
  method: KafkaAuthMethod;

  ...ManagedIdentity;

  @doc("SASL authentication.")
  saslSettings?: DataflowEndpointAuthenticationSasl;

  @doc("X.509 certificate authentication.")
  x509CertificateSettings?: DataflowEndpointAuthenticationX509;
}

@doc("DataflowEndpoint Kafka Authentication Method properties")
union KafkaAuthMethod {
  ManagedIdentityMethod,
  SaslMethod,
  x509CertificateMethod,
  AnonymousMethod,
}

@doc("Kafka endpoint Batching properties")
model DataflowEndpointKafkaBatching {
  @doc("Mode for batching.")
  mode?: OperationalMode = OperationalMode.Enabled;

  @doc("Batching latency in milliseconds.")
  @minValue(0)
  @maxValue(65535)
  latencyMs?: int32 = 5;

  @doc("Maximum number of bytes in a batch.")
  @minValue(0)
  @maxValue(4294967295)
  maxBytes?: int32 = 1000000;

  @doc("Maximum number of messages in a batch.")
  @minValue(0)
  @maxValue(4294967295)
  maxMessages?: int32 = 100000;
}

@doc("Kafka endpoint Compression properties")
union DataflowEndpointKafkaCompression {
  string,

  @doc("NONE Option")
  None: "None",

  @doc("Gzip Option")
  Gzip: "Gzip",

  @doc("SNAPPY Option")
  Snappy: "Snappy",

  @doc("LZ4 Option")
  Lz4: "Lz4",
}

@doc("DataflowEndpoint Kafka Acks properties")
union DataflowEndpointKafkaAcks {
  string,

  @doc("ZERO Option")
  Zero: "Zero",

  @doc("ONE Option")
  One: "One",

  @doc("ALL Option")
  All: "All",
}

@doc("DataflowEndpoint Kafka Partition Strategy properties")
union DataflowEndpointKafkaPartitionStrategy {
  string,

  @doc("Default: Assigns messages to random partitions, using a round-robin algorithm.")
  Default: "Default",

  @doc("Static: Assigns messages to a fixed partition number that's derived from the instance ID of the dataflow.")
  Static: "Static",

  @doc("TOPIC Option")
  Topic: "Topic",

  @doc("PROPERTY Option")
  Property: "Property",
}

@doc("Local persistent volume endpoint properties")
model DataflowEndpointLocalStorage {
  @doc("Persistent volume claim name.")
  persistentVolumeClaimRef: string;
}

@doc("Broker endpoint properties")
model DataflowEndpointMqtt {
  @doc("authentication properties. DEFAULT: kubernetes.audience=aio-mq-internal. NOTE - Enum field only property is allowed")
  authentication: DataflowEndpointMqttAuthentication;

  @doc("Client ID prefix. Client ID generated by the dataflow is <prefix>-TBD. Optional; no prefix if omitted.")
  clientIdPrefix?: string;

  @doc("Host of the Broker in the form of <hostname>:<port>. Optional; connects to Broker if omitted.")
  host?: string;

  @doc("Enable or disable websockets.")
  protocol?: BrokerProtocolType = BrokerProtocolType.Mqtt;

  @doc("Broker KeepAlive for connection in seconds.")
  @minValue(0)
  keepAliveSeconds?: int32 = 60;

  @doc("Whether or not to keep the retain setting.")
  retain?: MqttRetainType = MqttRetainType.Keep;

  @doc("The max number of messages to keep in flight. For subscribe, this is the receive maximum. For publish, this is the maximum number of messages to send before waiting for an ack.")
  @minValue(0)
  maxInflightMessages?: int32 = 100;

  @doc("Qos for Broker connection.")
  @minValue(0)
  @maxValue(1)
  qos?: int32 = 1;

  @doc("Session expiry in seconds.")
  @minValue(0)
  sessionExpirySeconds?: int32 = 3600;

  @doc("TLS configuration.")
  tls?: TlsProperties = #{ mode: OperationalMode.Enabled };

  @doc("Cloud event mapping config.")
  cloudEventAttributes?: CloudEventAttributeType;
}

@doc("Mqtt endpoint Authentication properties. NOTE - only authentication property is allowed per entry.")
model DataflowEndpointMqttAuthentication {
  @doc("Mode of Authentication.")
  method: MqttAuthMethod;

  ...ManagedIdentity;

  @doc("Kubernetes service account token authentication. Default audience if not set is aio-mq-internal")
  serviceAccountTokenSettings?: DataflowEndpointAuthenticationServiceAccountToken;

  @doc("X.509 certificate authentication.")
  x509CertificateSettings?: DataflowEndpointAuthenticationX509;
}

@doc("DataflowEndpoint Mqtt Authentication Method properties")
union MqttAuthMethod {
  ManagedIdentityMethod,
  ServiceAccountTokenMethod,
  x509CertificateMethod,
  AnonymousMethod,
}

@doc("Broker Retain types")
union MqttRetainType {
  string,

  @doc("Retain the messages.")
  Keep: "Keep",

  @doc("Never retain messages.")
  Never: "Never",
}

@doc("How to map events to the cloud.")
union CloudEventAttributeType {
  string,

  @doc("Propagate type")
  Propagate: "Propagate",

  @doc("CreateOrRemap type")
  CreateOrRemap: "CreateOrRemap",
}
