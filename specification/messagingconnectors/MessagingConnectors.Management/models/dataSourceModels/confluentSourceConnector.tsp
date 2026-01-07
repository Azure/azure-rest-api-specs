import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

namespace Microsoft.MessagingConnectors.Models.DataSource.Confluent;

@doc("Enum of the SecurityProtocol for Confluent connector")
union ConfluentSecurityProtocol {
  @doc("The SASL_PLAINTEXT security protocol.")
  SaslPlaintext: "SASL_PLAINTEXT",

  @doc("The PLAINTEXT security protocol.")
  Plaintext: "PLAINTEXT",

  @doc("The SASL_SSL security protocol.")
  SaslSsl: "SASL_SSL",

  @doc("The SSL security protocol.")
  Ssl: "SSL",

  string,
}

@doc("Enum of the SaslMechanism for Confluent connector")
union ConfluentSaslMechanism {
  @doc("The PLAIN sasl mechanism.")
  Plain: "PLAIN",

  @doc("The SCRAM-SHA-256 sasl mechanism.")
  ScramSha256: "SCRAM-SHA-256",

  @doc("The SCRAM-SHA-512 sasl mechanism.")
  ScramSha512: "SCRAM-SHA-512",

  string,
}

@doc("What to do when there is no initial offset in ZooKeeper or if an offset is out of range.")
union ConfluentAutoOffsetReset {
  @doc("Automatically reset the offset to the latest offset.")
  Latest: "Latest",

  @doc("Automatically reset the offset to the earliest offset.")
  Earliest: "Earliest",

  @doc("None reset.")
  None: "None",

  string,
}

@doc("Configuration for ConfluentSourceConnector")
model ConfluentSourceConnectorProperties extends DataSourceProperties {
  @doc("Type of ConfluentSourceConnector")
  connectorType: Models.Connector.ConnectorType.ConfluentSource;

  @doc("bootstrapServers of the Confluent server.")
  bootstrapServers: string;

  @doc("Topic of the Confluent.")
  topic: string;

  @doc("ConsumerGroup of the Confluent.")
  consumerGroup: string;

  @doc("What to do when there is no initial offset in ZooKeeper or if an offset is out of range.")
  autoOffsetReset: ConfluentAutoOffsetReset;

  @doc("Authentication for Confluent.")
  authentication?: Models.Auth.Authentication;

  @doc("Client certificate for Confluent.")
  clientCertAuthentication?: Models.Auth.CertificateAuthentication;

  @doc("Security protocol of the confluent.")
  securityProtocol?: ConfluentSecurityProtocol;

  @doc("Sasl mechanism of the confluent.")
  saslMechanism?: ConfluentSaslMechanism;

  @doc("OffsetStartTime in utcDateTime zone.")
  offsetStartTime?: utcDateTime;

  @doc("Configuration for ssl.")
  sslConfiguration?: Models.Auth.SslConfiguration;
}
