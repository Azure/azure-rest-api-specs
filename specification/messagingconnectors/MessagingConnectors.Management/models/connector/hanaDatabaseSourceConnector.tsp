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

@doc("Type of HanaQueryMode")
union HanaQueryMode {
  @doc("Table type")
  Table: "Table",

  @doc("Query type")
  Query: "Query",

  string,
}

@doc("Type of HanaNumericMapping")
union HanaNumericMapping {
  @doc("Table type.")
  None: "None",

  @doc("Query type.")
  BestFit: "BestFit",

  @doc("BestFitEagerDouble type.")
  BestFitEagerDouble: "BestFitEagerDouble",

  string,
}

@doc("Type of HanaNumericMapping")
union HanaMode {
  @doc("Bulk mode")
  Bulk: "Bulk",

  @doc("Incrementing mode")
  Incrementing: "Incrementing",

  string,
}

@doc("Configuration for HanaDatabaseSourceConnector")
model HanaDatabaseSourceConnectorProperties extends DataSourceProperties {
  @doc("Type of HanaDatabaseSourceConnector")
  connectorType: ConnectorType.HanaDatabaseSource;

  @doc("Url of HANA database.")
  connectionUrl: string;

  @doc("User for HANA database.")
  userName: string;

  @doc("Password for HANA database.")
  @secret
  password: string;

  @doc("The query mode in which data should be fetched from SAP DB table.")
  queryMode?: HanaQueryMode;

  @doc("HANA schema to source data from, default as the HANA username..")
  schema?: string;

  @doc("Table name for HANA database.")
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

  @doc("The mode in which data should be fetched from SAP DB table.")
  mode?: HanaMode;

  @doc("In order to fetch data from a SAP DB table when mode is set to incrementing, an incremental (or auto-incremental) column needs to be provided.")
  incrementingColumn?: string;
}
