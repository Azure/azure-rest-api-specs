import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";

import "./base.tsp";
import "./mq.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using OpenAPI;
using Azure.ResourceManager;

namespace Microsoft.IoTOperationsMQ;

/**
 * MQ kafkaconnector resource type model details.
 *
 * Azure Resource - mq/kafkaConnector
 * CRD - KafkaConnector
 * CRD Version - v1alpha4
 */
@doc("MQ kafkaConnector resource")
@parentResource(MqResource)
model KafkaConnectorResource is TrackedResource<KafkaConnectorProperties> {
  @doc("Name of MQ kafkaConnector resource")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("kafkaConnectorName")
  @path
  @segment("kafkaConnector")
  name: string;

  ...ExtendedLocation;
}

@doc("KafkaConnector Properties")
model KafkaConnectorProperties {
  @doc("The client id prefix of the dynamically generated client ids.")
  clientIdPrefix?: string;

  @doc("The details of KafkaConnector Docker Image.")
  image?: ContainerImage;

  @doc("The number of KafkaConnector pods to spin up.")
  @minValue(0)
  @maxValue(65535)
  instances?: int32;

  @doc("The details for connecting with Remote Kafka Broker.")
  kafkaConnection: KafkaRemoteBrokerConnectionSpec;

  @doc("The details for connecting with Local Broker.")
  localBrokerConnection?: LocalBrokerConnectionSpec;

  @doc("The log level of the Bridge Connector instances.")
  logLevel?: string = "info";

  @doc("The Node Tolerations for the Bridge Connector pods.")
  nodeTolerations?: NodeTolerations;

  @visibility(Lifecycle.Read)
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
}

@doc("Kafka RemoteBrokerConnectionSpec details")
model KafkaRemoteBrokerConnectionSpec {
  @doc("The remote broker authentication methods.")
  authentication: KafkaRemoteBrokerAuthenticationProperties;

  @doc("The endpoint of remote broker to connect to.")
  endpoint: string;

  @doc("TLS details for Remote broker Connection.")
  tls: KafkaRemoteBrokerConnectionTls;
}

@doc("Kafka RemoteBrokerConnection Authentication methods")
model KafkaRemoteBrokerAuthenticationProperties {
  @doc("The type of authentication to use for Kafka remote broker.")
  authType?: KafkaRemoteBrokerAuthenticationTypes;

  @doc("If authentication is enabled for Kafka remote broker.")
  enabled: boolean;
}

// Add RemoteBrokerAuthenticationTypes properties.
// GENERATION FIX TEMP - add "minProperties": 1 and "maxProperties": 1 to this property after creation.
@doc("Kafka RemoteBrokerConnection Authentication types. NOTE - Enum only one method is allowed to be passed.")
model KafkaRemoteBrokerAuthenticationTypes {
  @doc("Sasl remote broker authentication method.")
  sasl?: SaslRemoteBrokerBasicAuthentication;

  @doc("Managed identity remote broker authentication method.")
  systemAssignedManagedIdentity?: ManagedIdentityAuthentication;

  @doc("X509 remote broker authentication method.")
  x509?: KafkaX509Authentication;
}

// Add SaslRemoteBrokerBasicAuthentication properties.
@doc("Kafka RemoteBrokerConnection Sasl Authentication properties.")
model SaslRemoteBrokerBasicAuthentication {
  @doc("Sasl Mechanism for remote broker authentication.")
  saslType: KafkaSaslType;

  @doc("Sasl token for remote broker authentication.")
  token: SaslRemoteBrokerBasicAuthenticationToken;
}

// Add KafkaSaslType properties.
@doc("Kafka Sasl Authentication types")
union KafkaSaslType {
  string,

  @doc("Sasl Plain authentication.")
  "plain",

  @doc("Sasl ScramSha256 authentication.")
  "scramSha256",

  @doc("Sasl ScramSha512 authentication.")
  "scramSha512",
}

// Add SaslRemoteBrokerBasicAuthenticationToken properties.
@doc("Kafka RemoteBrokerConnection Sasl Authentication token properties. NOTE - Enum only one method is allowed to be passed.")
model SaslRemoteBrokerBasicAuthenticationToken {
  @doc("Keyvault token keyvault secret properties.")
  keyVault?: KafkaTokenKeyVaultProperties;

  @doc("Secret where cert details are stored.")
  secretName?: string;
}

// Add KafkaTokenKeyVaultProperties properties.
@doc("Kafka Token KeyVault properties.")
model KafkaTokenKeyVaultProperties {
  @doc("Username to connect with.")
  username?: string;

  @doc("KeyVault properties.")
  vault: KeyVaultConnectionProperties;

  @doc("KeyVault secret details.")
  vaultSecret: KeyVaultSecretObject;
}

// Add KafkaX509Authentication properties.
@doc("Kafka RemoteBrokerConnection X509 Authentication properties.")
model KafkaX509Authentication {
  @doc("Keyvault X509 secret properties.")
  keyVault?: KeyVaultCertificateProperties;

  @doc("Secret where cert details are stored.")
  secretName?: string;
}

@doc("Kafka RemoteBrokerConnection TLS details")
model KafkaRemoteBrokerConnectionTls {
  @doc("Tls Enabled on Remote Broker Connection.")
  tlsEnabled: boolean;

  @doc("Trusted CA certificate name for Remote Broker.")
  trustedCaCertificateConfigMap?: string;
}

/** ******************* */
/**
 * MQ kafkaConnector/topicMap resource type model details.
 *
 * Azure Resource - mq/kafkaConnector/topicMap
 * CRD - KafkaTopicMap
 * CRD Version - v1alpha4
 */
@doc("MQ kafkaConnector/topicMap resource")
@parentResource(KafkaConnectorResource)
model KafkaTopicMapResource is TrackedResource<KafkaTopicMapProperties> {
  @doc("Name of MQ kafka/topicMap resource")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("topicMapName")
  @path
  @segment("topicMap")
  name: string;

  ...ExtendedLocation;
}

@doc("KafkaTopicMap Properties")
model KafkaTopicMapProperties {
  @doc("The batching settings for kafka messages.")
  batching?: KafkaTopicMapBatching;

  @doc("The compression to use for kafka messages.")
  compression?: KafkaMessageCompressionType = KafkaMessageCompressionType.none;

  @doc("The flag to copy Mqtt properties.")
  copyMqttProperties?: string;

  @doc("The kafkaConnector CRD it refers to.")
  kafkaConnectorRef: string;

  @doc("The partition to use for Kafka.")
  partitionKeyProperty?: string;

  @doc("The partition strategy to use for Kafka.")
  partitionStrategy?: KafkaPartitionStrategy = KafkaPartitionStrategy.default;

  @doc("The route details for Kafka connector.")
  @identifiers(#[])
  routes: KafkaRoutes[];

  @visibility(Lifecycle.Read)
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
}

// Add KafkaTopicMapBatching properties.
@doc("Kafka TopicMap Batching properties")
model KafkaTopicMapBatching {
  @doc("The setting to enable or disable batching.")
  enabled?: boolean = false;

  @doc("The latency of message batching.")
  @minValue(0)
  @maxValue(65535)
  latencyMs?: int32 = 5;

  @doc("The maximum bytes to send in a batch.")
  @minValue(0)
  @maxValue(4294967295)
  maxBytes?: int64 = 1000000;

  @doc("The maximum messages to send in a batch.")
  @minValue(0)
  @maxValue(4294967295)
  maxMessages?: int64 = 100000;
}

// Add Kafka Message compression
@doc("Kafka Message compression enum properties")
union KafkaMessageCompressionType {
  string,

  @doc("No Kafka message compression.")
  none: "none",

  @doc("Gzip Kafka message compression.")
  gzip: "gzip",

  @doc("Snappy Kafka message compression.")
  snappy: "snappy",

  @doc("Lz4 Kafka message compression.")
  lz4: "lz4",
}

// Add Kafka Partition Strategy
@doc("Kafka Partition Strategy enum properties")
union KafkaPartitionStrategy {
  string,

  @doc("Default partition strategy.")
  default: "default",

  @doc("Static partition strategy.")
  static: "static",

  @doc("Topic partition strategy.")
  topic: "topic",

  @doc("Property partition strategy.")
  property: "property",
}

// Add Kafka Routes properties.
@doc("Kafka Routes properties. NOTE - Enum only one method is allowed to be passed.")
model KafkaRoutes {
  @doc("Kafka to Mqtt route.")
  kafkaToMqtt?: KafkaToMqttRoutes;

  @doc("Mqtt to Kafka route.")
  mqttToKafka?: MqttToKafkaRoutes;
}

// Add KafkaToMqttRoutes properties.
@doc("Kafka to Mqtt route properties")
model KafkaToMqttRoutes {
  @doc("The consumer group id to use.")
  consumerGroupId?: string;

  @doc("The kafka topic to pull from.")
  kafkaTopic: string;

  @doc("The mqtt topic to publish to.")
  mqttTopic: string;

  @doc("The name of the route.")
  name: string;

  @doc("The qos to use for mqtt.")
  @minValue(0)
  @maxValue(1)
  qos?: int32 = 1;
}

// Add MqttToKafkaRoutes properties.
@doc("Mqtt to Kafka route properties")
model MqttToKafkaRoutes {
  @doc("The kafka acks to use.")
  kafkaAcks: KafkaAcks;

  @doc("The kafka topic to publish to.")
  kafkaTopic: string;

  @doc("The mqtt topic to pull from.")
  mqttTopic: string;

  @doc("The name of the route.")
  name: string;

  @doc("The qos to use for mqtt.")
  @minValue(0)
  @maxValue(1)
  qos?: int32 = 1;

  @doc("The properties for shared subscription.")
  sharedSubscription?: KafkaSharedSubscriptionProperties;
}

// Add KafkaAcks properties.
@doc("Kafka Acks enum properties")
union KafkaAcks {
  string,

  @doc("Kafka acks zero.")
  "zero",

  @doc("Kafka acks one.")
  "one",

  @doc("Kafka acks all.")
  "all",
}

// Add SharedSubscriptionProperties properties.
@doc("Kafka Shared Subscription properties")
model KafkaSharedSubscriptionProperties {
  @doc("The minimum number to use in a group for subscription.")
  @minValue(0)
  @maxValue(255)
  groupMinimumShareNumber: int32;

  @doc("The name of the shared subscription.")
  groupName: string;
}
