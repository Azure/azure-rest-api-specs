import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

namespace Microsoft.MessagingConnectors.Models.DataSource.SampleData;

@doc("Sample Data Type")
union SampleDataDataType {
  @doc("Bicycles data type")
  Bicycles: "Bicycles",

  @doc("Yellow Taxi  data type")
  YellowTaxi: "YellowTaxi",

  @doc("Stock Market  data type")
  StockMarket: "StockMarket",

  @doc("Buses data type")
  Buses: "Buses",

  @doc("SP500Stocks data type")
  SP500Stocks: "SP500Stocks",

  @doc("Semantic Model Logs data type")
  SemanticModelLogs: "SemanticModelLogs",

  string,
}

@doc("Configuration for SampleDataSourceConnector")
model SampleDataSourceConnectorProperties extends DataSourceProperties {
  @doc("Type of SampleDataSourceConnector")
  connectorType: Models.Connector.ConnectorType.SampleDataSource;

  @doc("Sample Data Type")
  type: SampleDataDataType;
}
