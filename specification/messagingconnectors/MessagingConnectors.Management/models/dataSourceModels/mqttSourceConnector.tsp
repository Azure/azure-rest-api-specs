import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

namespace Microsoft.MessagingConnectors.Models.DataSource.Mqtt;

@doc("Version for Mqtt server")
union MqttVersion {
  @doc("Mqtt v5")
  V5: "V5",

  @doc("Mqtt v3 and below")
  V3AndBelow: "V3AndBelow",

  string,
}

@doc("Configuration for MqttSourceConnector")
model MqttSourceConnectorProperties extends DataSourceProperties {
  @doc("Type of MqttSourceConnector")
  connectorType: Models.Connector.ConnectorType.MqttSource;

  @doc("Mqtt server version.")
  serverVersion: MqttVersion;

  @doc("Topic to subscribe to.")
  topic: string;

  @doc("URL of the broker where to establish the connection.")
  brokerUrl: string;

  @doc("Username to use when connecting to the Mqtt compliant broker.")
  username?: string;

  @doc("Password to use when connecting to the Mqtt compliant broker.")
  @secret
  password?: string;

  @doc("Configuration for ssl.")
  sslConfiguration?: Models.Auth.SslConfiguration;

  @doc("Client certificate for Confluent.")
  clientCertAuthentication?: Models.Auth.CertificateAuthentication;
}
