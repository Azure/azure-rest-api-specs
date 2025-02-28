import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Versioning;
using Azure.Core;
using TypeSpec.OpenAPI;

@versioned(Versions)
namespace Microsoft.MessagingConnectors;

@doc("Enum of the SaslMechanism for Confluent connector")
union SaslMechanismForConfluent {
  @doc("The PLAIN sasl mechanism.")
  Plain: "PLAIN",

  @doc("The SCRAM-SHA-256 sasl mechanism.")
  ScramSha256: "SCRAM-SHA-256",

  @doc("The SCRAM-SHA-512 sasl mechanism.")
  ScramSha512: "SCRAM-SHA-512",

  string,
}

@doc("Enum of the SecurityProtocol for Confluent connector")
union SecurityProtocolForConfluent {
  @doc("The SASL_PLAINTEXT security protocol.")
  SaslPlainText: "SASL_PLAINTEXT",

  @doc("The PLAINTEXT security protocol.")
  PlainText: "PLAINTEXT",

  @doc("The SASL_SSL security protocol.")
  SaslSsl: "SASL_SSL",

  @doc("The SSL security protocol.")
  Ssl: "SSL",

  string,
}

@doc("Configuration for ConfluentSourceConnector")
model ConfluentSourceConnectorProperties extends DataSourceProperties {
  @doc("Type of ConfluentSourceConnector")
  connectorType: ConnectorType.ConfluentSource;

  @doc("bootstrapServers of the Confluent server.")
  bootstrapServers: string;

  @doc("Topic of the Confluent.")
  topic: string;

  @doc("ConsumerGroup of the Confluent.")
  consumerGroup: string;

  @doc("AutoOffsetReset policy of the Confluent consume.")
  autoOffsetReset: string;

  @doc("User of the Confluent.")
  user: string;

  @doc("Password of the Confluent.")
  @secret
  password: string;

  @doc("Sasl mechanism of the confluent.")
  saslMechanism: SaslMechanismForConfluent;

  @doc("Security protocol of the confluent.")
  securityProtocol: SecurityProtocolForConfluent;
}
