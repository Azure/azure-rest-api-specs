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

@added(Versions.v2025_05_01_preview)
@doc("Sample Data Type")
union DataType {
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

  string,
}

@added(Versions.v2025_05_01_preview)
@doc("Configuration for SampleDataSourceConnector")
model SampleDataSourceConnectorProperties extends DataSourceProperties {
  @doc("Type of SampleDataSourceConnector")
  connectorType: ConnectorType.SampleDataSource;

  @doc("Sample Data Type")
  type: DataType;
}
