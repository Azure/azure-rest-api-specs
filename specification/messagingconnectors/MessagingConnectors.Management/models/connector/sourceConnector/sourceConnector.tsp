import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

namespace Microsoft.MessagingConnectors.Models.Connector.SourceConnector;

@doc("Base properties for Source Connector")
model SourceConnectorProperties extends Models.Connector.ConnectorProperties {
  @doc("Source Connector")
  direction: Models.Connector.Direction.Source;

  @doc("Type of the Connector.")
  converterConfig: Models.ConverterConfig.ConverterConfig;

  @doc("connectionString of the EventHub.")
  eventHubConfig: Models.EventHubConfig.EventHubConfig;

  @doc("Data format of the data source")
  sourceDataFormat?: Models.Connector.SourceConnector.SourceDataFormat.SourceDataFormat;

  @doc("Cloud events config")
  cloudEventsConfig?: Models.Connector.SourceConnector.CloudEventsConfig.CloudEventsConfig;

  @doc("Special properties for source.")
  dataSourceProperties: Models.DataSource.DataSourceProperties;
}
