import "./connection.tsp";
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Oracle.Database;

@added(Versions.v20260301_preview)
@doc("Allowed values for Kafka technology type.")
union KafkaConnectionTechnologyType {
  @doc("The Apache Kafka type.")
  ApacheKafka: "APACHE_KAFKA",

  @doc("The Azure Event Hubs type.")
  AzureEventHubs: "AZURE_EVENT_HUBS",

  @doc("The Confluent Kafka type.")
  ConfluentKafka: "CONFLUENT_KAFKA",

  @doc("The OCI Streaming type.")
  OciStreaming: "OCI_STREAMING",

  string,
}

@added(Versions.v20260301_preview)
@doc("The Kafka bootstrap server with host name, and an optional port.")
model KafkaBootstrapServer {
  @doc("The name or address of a host.")
  @minLength(1)
  @maxLength(800)
  host: string;

  @doc("The port of an endpoint usually specified for a connection.")
  @minValue(0)
  @maxValue(65536)
  port?: int32;
}

@added(Versions.v20260301_preview)
@doc("The metadata of a Kafka Connection.")
model KafkaConnectionDetails extends ConnectionBaseProperties {
  connectionType: ConnectionType.Kafka;

  @doc("The Kafka technology type.")
  technologyType: KafkaConnectionTechnologyType;

  @doc("The list of KafkaBootstrapServer objects specified by host/port.")
  @identifiers(#[])
  bootstrapServers?: KafkaBootstrapServer[];

  @doc("The Kafka security protocol used to connect to the broker.")
  securityProtocol?: string;

  @doc("The username used to authenticate to Kafka.")
  username?: string;

  @doc("The OCID of the Secret where the password is stored.")
  passwordSecretId?: Ocid;

  @doc("The OCID of the Secret where the truststore is stored.")
  trustStoreSecretId?: Ocid;

  @doc("The OCID of the Secret where the truststore password is stored.")
  trustStorePasswordSecretId?: Ocid;

  @doc("The OCID of the Secret where the keystore is stored.")
  keyStoreSecretId?: Ocid;

  @doc("The OCID of the Secret where the keystore password is stored.")
  keyStorePasswordSecretId?: Ocid;

  @doc("The OCID of the Secret where the SSL key password is stored.")
  sslKeyPasswordSecretId?: Ocid;

  @doc("The additional consumer properties in string format.")
  consumerProperties?: string;

  @doc("The additional producer properties in string format.")
  producerProperties?: string;

  @doc("The OCID of the stream pool being referenced.")
  streamPoolId?: Ocid;

  @doc("The OCID of the Kafka cluster being referenced.")
  clusterId?: Ocid;

  @doc("Indicates if resource principal should be used for authentication.")
  shouldUseResourcePrincipal?: boolean;
}
