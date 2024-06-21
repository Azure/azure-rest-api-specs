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
model DataFlowEndpointResource is TrackedResource<DataFlowEndpointProperties> {
  @doc("Name of Instance dataflowEndpoint resource")
  @pattern("^[a-z0-9][a-z0-9-]*[a-z0-9]$")
  @key("dataflowEndpointName")
  @path
  @minLength(3)
  @maxLength(63)
  @segment("dataflowEndpoints")
  name: string;

  // Extended location is not included in TrackedResource yet
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
  @doc("Edge location of the resource.")
  @visibility("read", "create")
  extendedLocation: ExtendedLocation;
}

@doc("DataFlowEndpoint Resource properties. NOTE - Only one type of endpoint is supported for one Resource")
model DataFlowEndpointProperties {
  @doc("Authentication configuration.")
  authentication: DataFlowEndpointAuthentication;

  @doc("Endpoint Type.")
  endpointType: EndpointType;

  @doc("Azure Data Explorer endpoint.")
  dataExplorerSettings?: DataFlowEndpointDataExplorer;

  @doc("Azure Data Lake endpoint.")
  dataLakeStorageSettings?: DataFlowEndpointDataLakeStorage;

  @doc("Microsoft Fabric endpoint.")
  fabricOneLakeSettings?: DataFlowEndpointFabricOneLake;

  @doc("Kafka endpoint.")
  kafkaSettings?: DataFlowEndpointKafka;

  @doc("Local persistent volume endpoint.")
  localStorageSettings?: DataFlowEndpointLocalStorage;

  @doc("Mqtt endpoint.")
  mqttSettings?: DataFlowEndpointMqtt;

  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
}

@doc("DataFlowEndpoint Type properties")
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

  @doc("Mqtt Type")
  Mqtt: "Mqtt",
}

@doc("Azure Data Explorer endpoint properties")
model DataFlowEndpointDataExplorer {
  @doc("Azure Data Explorer endpoint batching configuration.")
  batching?: BatchingConfiguration;

  @doc("Database name.")
  database: string;

  @doc("Host of the Azure Data Explorer in the form of <cluster>.<region>.kusto.windows.net .")
  @pattern(".+\\..+\\.kusto\\.windows\\.net")
  host: string;
}

@doc("Azure Data Explorer Authentication properties. NOTE - only authentication property is allowed per entry.")
model DataFlowEndpointAuthentication {
  @doc("Mode of Authentication.")
  mode: AuthenticationMode;

  @doc("System-assigned managed identity authentication.")
  systemAssignedManagedIdentity?: DataFlowEndpointAuthenticationSystemAssignedManagedIdentity;

  @doc("User-assigned managed identity authentication.")
  userAssignedManagedIdentity?: DataFlowEndpointAuthenticationUserAssignedManagedIdentity;

  @doc("SAS token authentication.")
  accessTokenSecretName?: string;

  @doc("SASL authentication.")
  sasl?: DataFlowEndpointAuthenticationSasl;

  @doc("Service Account Token authentication.")
  serviceAccountToken?: DataFlowEndpointAuthenticationSasl;

  @doc("X.509 certificate authentication.")
  x509Credentials?: DataFlowEndpointAuthenticationX509;
}

@doc("Authentication Mode properties")
union AuthenticationMode {
  string,

  @doc("SystemAssignedManagedIdentity Option")
  SystemAssignedManagedIdentity: "SystemAssignedManagedIdentity",

  @doc("UserAssignedManagedIdentity Option")
  UserAssignedManagedIdentity: "UserAssignedManagedIdentity",

  @doc("AccessTokenSecretName Option")
  AccessTokenSecretName: "AccessTokenSecretName",

  @doc("Sasl Option")
  Sasl: "Sasl",

  @doc("X509Credentials Option")
  X509Credentials: "X509Credentials",
}

@doc("DataFlowEndpoint Authentication SystemAssignedManagedIdentity properties")
model DataFlowEndpointAuthenticationSystemAssignedManagedIdentity {
  @doc("Audience of the service to authenticate against. Optional; defaults to the audience for Service host configuration.")
  audience: string;
}

@doc("DataFlowEndpoint Authentication UserAssignedManagedIdentity properties")
model DataFlowEndpointAuthenticationUserAssignedManagedIdentity {
  @doc("Client ID for the user-assigned managed identity.")
  clientId: string;

  @doc("Resource identifier (application ID URI) of the resource, affixed with the .default suffix.")
  scope: string;

  @doc("Tenant ID.")
  tenantId: string;
}

@doc("Azure Data Lake endpoint properties")
model DataFlowEndpointDataLakeStorage {
  @doc("Azure Data Lake endpoint batching configuration.")
  batching?: BatchingConfiguration;

  @doc("Host of the Azure Data Lake in the form of <account>.blob.core.windows.net .")
  @pattern(".+\\.blob\\.core\\.windows\\.net")
  host: string;
}

@doc("Microsoft Fabric endpoint properties")
model DataFlowEndpointFabricOneLake {
  @doc("Batching configuration.")
  batching?: DataFlowEndpointFabricBatching;

  @doc("Host of the Microsoft Fabric in the form of https://<host>.fabric.microsoft.com.")
  @pattern(".+\\.fabric\\.microsoft\\.com")
  host: string;

  @doc("Names of the workspace and lakehouse.")
  names: DataFlowEndpointFabricOneLakeNames;

  @doc("Type of location of the data in the workspace. Can be either tables or files.")
  oneLakePathType: DataFlowEndpointFabricPathType;
}
@doc("Microsoft Fabric endpoint Batching properties")
model DataFlowEndpointFabricBatching {
  @doc("Batching latency in seconds.")
  @minValue(0)
  @maxValue(65535)
  latencySecs?: int32 = 60;

  @doc("Maximum number of messages in a batch.")
  @minValue(0)
  @maxValue(4294967295)
  maxMessages?: int32 = 100000;
}

@doc("Microsoft Fabric endpoint Names properties")
model DataFlowEndpointFabricOneLakeNames {
  @doc("Lakehouse name.")
  lakehouseName: string;

  @doc("Workspace name.")
  workspaceName: string;
}

@doc("DataFlowEndpoint Fabric Path Type properties")
union DataFlowEndpointFabricPathType {
  string,

  @doc("FILES Type")
  Files: "Files",

  @doc("TABLES Type")
  Tables: "Tables",
}

@doc("Kafka endpoint properties")
model DataFlowEndpointKafka {
  @doc("Batching configuration.")
  batching?: DataFlowEndpointKafkaBatching;

  @doc("Compression. Can be none, gzip, lz4, or snappy. No effect if the endpoint is used as a source.")
  compression?: DataFlowEndpointKafkaCompression = DataFlowEndpointKafkaCompression.None;

  @doc("Consumer group ID.")
  consumerGroupId?: string;

  @doc("Copy MQTT properties. No effect if the endpoint is used as a source or if the dataflow doesn't have an MQTT source.")
  copyMqttProperties?: Mode;

  @doc("Kafka endpoint host.")
  host?: string;

  @doc("Kafka acks. Can be all, one, or zero. No effect if the endpoint is used as a source.")
  kafkaAcks?: DataFlowEndpointKafkaAcks = DataFlowEndpointKafkaAcks.All;

  @doc("Partition handling strategy. Can be default or static. No effect if the endpoint is used as a source.")
  partitionStrategy?: DataFlowEndpointKafkaPartitionStrategy = DataFlowEndpointKafkaPartitionStrategy.Default;

  @doc("TLS configuration.")
  tls: DataFlowEndpointKafkaTls;
}

@doc("DataFlowEndpoint Authentication Sasl properties")
model DataFlowEndpointAuthenticationSasl {
  @doc("Type of SASL authentication. Can be PLAIN, SCRAM-SHA-256, or SCRAM-SHA-512.")
  saslType: DataFlowEndpointAuthenticationSaslType;

  @doc("Token secret name.")
  tokenSecretName: string;
}

@doc("DataFlowEndpoint Authentication Sasl Type properties")
union DataFlowEndpointAuthenticationSaslType {
  string,

  @doc("PLAIN Type")
  Plain: "Plain",

  @doc("SCRAM_SHA_256 Type")
  ScramSha256: "ScramSha256",

  @doc("SCRAM_SHA_512 Type")
  ScramSha512: "ScramSha512",
}

@doc("DataFlowEndpoint Authentication X509 properties")
model DataFlowEndpointAuthenticationX509 {
  @doc("Secret name of the X.509 certificate.")
  secretName: string;
}

@doc("Kafka endpoint Batching properties")
model DataFlowEndpointKafkaBatching {
  @doc("Mode for batching.")
  mode?: Mode = Mode.Enabled;

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
union DataFlowEndpointKafkaCompression {
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

@doc("DataFlowEndpoint Kafka Acks properties")
union DataFlowEndpointKafkaAcks {
  string,

  @doc("ZERO Option")
  Zero: "Zero",

  @doc("ONE Option")
  One: "One",

  @doc("ALL Option")
  All: "All",
}

@doc("DataFlowEndpoint Kafka Partition Strategy properties")
union DataFlowEndpointKafkaPartitionStrategy {
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

@doc("DataFlowEndpoint Kafka Tls properties")
model DataFlowEndpointKafkaTls {
  @doc("Mode for TLS.")
  mode?: Mode = Mode.Enabled;

  @doc("Trusted CA certificate config map.")
  trustedCaCertificateConfigMap?: string;
}

@doc("Local persistent volume endpoint properties")
model DataFlowEndpointLocalStorage {
  @doc("Persistent volume claim name.")
  persistentVolumeClaimName: string;
}

@doc("Mqtt endpoint properties")
model DataFlowEndpointMqtt {
  @doc("Client ID prefix. Client ID generated by the dataflow is <prefix>-TBD. Optional; no prefix if omitted.")
  clientIdPrefix?: string;

  @doc("Enable or disable websockets.")
  protocol?: MqttProtocolType = MqttProtocolType.Mqtt;

  @doc("Host of the MQTT broker in the form of <hostname>:<port>. Optional; connects to IoT MQ if omitted.")
  host?: string = "aio-mq-dmqtt-frontend:1883";

  @doc("MQTT KeepAlive for connection in seconds.")
  @minValue(0)
  keepAliveSeconds?: int32 = 60;

  @doc("Whether or not to keep the retain setting.")
  retain?: MqttRetainType = MqttRetainType.Keep;

  @doc("The max number of messages to keep in flight. For subscribe, this is the receive maximum. For publish, this is the maximum number of messages to send before waiting for an ack.")
  @minValue(0)
  maxInflightMessages?: int32 = 100;

  @doc("Qos for MQTT connection.")
  @minValue(0)
  @maxValue(2)
  qos?: int32 = 1;

  @doc("Session expiry in seconds.")
  @minValue(0)
  sessionExpirySeconds?: int32 = 3600;

  @doc("Shared subscription configuration.")
  sharedSubscription?: DataFlowEndpointMqttSessionExpirySeconds;

  @doc("TLS configuration.")
  tls?: DataFlowEndpointMqttTls;
}

@doc("Mqtt Protocol types")
union MqttProtocolType {
  string,

  @doc("protocol mqtt")
  Mqtt: "Mqtt",

  @doc("protocol websocket")
  WebSockets: "WebSockets",
}

@doc("Mqtt Retain types")
union MqttRetainType {
  string,

  @doc("Retain the messages.")
  Keep: "Keep",

  @doc("Never retain messages.")
  Never: "Never",
}
@doc("Mqtt endpoint Session Expiry Seconds properties")
model DataFlowEndpointMqttSessionExpirySeconds {
  @doc("Number of clients to use for shared subscription.")
  @minValue(0)
  @maxValue(255)
  groupShareNumber: int32;

  @doc("Shared subscription group name.")
  groupName: string;
}

@doc("Mqtt endpoint Tls properties")
model DataFlowEndpointMqttTls {
  @doc("Mode for TLS.")
  mode?: Mode = Mode.Enabled;

  @doc("Trusted CA certificate config map.")
  trustedCaCertificateConfigMap?: string;
}
