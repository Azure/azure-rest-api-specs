import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

namespace Microsoft.MessagingConnectors.Models.DataSource.Hana;

@doc("Specify the mode in which data should be fetched from SAP DB table")
union HanaMode {
  @doc("Bulk mode to fetch from SAP table.")
  Bulk: "Bulk",

  @doc("Incrementing mode to fetch from SAP table.")
  Incrementing: "Incrementing",

  string,
}

@doc("Specify the query mode in which data should be fetched from SAP DB table")
union HanaQueryMode {
  @doc("Query HANA by Schema and Table.")
  Table: "Table",

  @doc("Query HANA by specific SQL query.")
  Query: "Query",

  string,
}

@doc("Control whether the DECIMAL column types are mapped to the default decimal type or one of the primitive types.")
union HanaNumericMapping {
  @doc("HanaNumericMapping of none.")
  None: "None",

  @doc("HanaNumericMapping of best_fit.")
  BestFit: "BestFit",

  @doc("HanaNumericMapping of best_fit_eager_double.")
  BestFitEagerDouble: "BestFitEagerDouble",

  string,
}

@doc("Configuration for HanaDatabaseSourceConnector")
model HanaDatabaseSourceConnectorProperties extends DataSourceProperties {
  @doc("Type of HanaDatabaseSourceConnector")
  connectorType: Models.Connector.ConnectorType.HanaDatabaseSource;

  @doc("HANA JDBC connection URI, e.g. jdbc:sap://127.0.0.1:30015.")
  connectionUrl: string;

  @doc("HANA JDBC connection username.")
  userName: string;

  @doc("HANA JDBC connection password.")
  @secret
  password: string;

  @doc("HANA schema to source data from.")
  schema?: string;

  @doc("The mode in which data should be fetched from SAP DB table. Default is bulk. And supported values are bulk, incrementing. ")
  mode?: HanaMode;

  @doc("In order to fetch data from a SAP DB table when mode is set to incrementing, an incremental (or auto-incremental) column needs to be provided.")
  incrementingColumn?: string;

  @doc("The query mode in which data should be fetched from SAP DB table.")
  queryMode?: HanaQueryMode;

  @doc("the SAP DB table name where the data needs to be read from.")
  table?: string;

  @doc("The query statement when queryMode is set to query.")
  query?: string;

  @doc("Max rows to include in a single batch call. Should be an integer.")
  batch?: int32;

  @doc("The poll interval at which the data should be fetched from SAP DB table, the default value in server end is 60000 with millisecond unit.")
  interval?: int32;

  @doc("The number of topic partitions that the Source connector can use to publish the data.")
  partitions?: int32;

  @doc("Whether the DECIMAL column types are mapped to the default decimal type or one of the primitive types.")
  numericMapping?: HanaNumericMapping;
}
