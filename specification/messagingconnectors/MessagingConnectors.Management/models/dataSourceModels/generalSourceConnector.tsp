import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

namespace Microsoft.MessagingConnectors.Models.DataSource.GeneralConnector;

@doc("Property definition for custom connector.")
model GeneralConnectorProperty {
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "not a secret"
  @doc("Property key.")
  key: string;

  @doc("Property value.")
  value: string;

  @doc("Whether this is one secret property, default is false.")
  isSecret?: boolean;
}

@doc("Configuration for CustomSourceConnector")
model GeneralSourceConnectorProperties extends DataSourceProperties {
  @doc("Type of CustomSourceConnector")
  connectorType: Models.Connector.ConnectorType.GeneralConnectorSource;

  @doc("Connector type.")
  type: string;

  @Azure.ResourceManager.identifiers(#[])
  @doc("Array list of properties.")
  properties: GeneralConnectorProperty[];
}
