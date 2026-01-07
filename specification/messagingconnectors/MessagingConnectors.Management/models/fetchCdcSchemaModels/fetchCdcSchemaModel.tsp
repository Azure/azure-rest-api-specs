import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

namespace Microsoft.MessagingConnectors.Models.FetchSchema;

@doc("Schema format Types")
union SchemaFormatType {
  @doc("Avro format")
  Avro: "Avro",

  @doc("Json format")
  Json: "Json",

  @doc("Protobuf format")
  Protobuf: "Protobuf",

  string,
}

@doc("Schema format")
model SchemaFormat {
  @doc("type of schema")
  type: SchemaFormatType;

  @doc("version of schema")
  version: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state"
@doc("properties of fetch Schema")
model SchemaRequestProperties {
  @doc("Config for DataSource")
  dataSourceProperties: Models.DataSource.DataSourceProperties;

  @doc("Schema Format")
  format: SchemaFormat;
}

@doc("Schema Properties Types")
union SchemaPropertiesType {
  @doc("change data capture(CDC) Schema Properties Types")
  Cdc: "Cdc",

  string,
}

@doc("special connector SchemaProperties")
@discriminator("type")
model SchemaProperties {
  type: SchemaPropertiesType;
}

@doc("change data capture(cdc) event type")
union CdcEventType {
  @doc("DataChange type")
  DataChange: "DataChange",

  @doc("SchemaChange type")
  SchemaChange: "SchemaChange",

  string,
}

@doc("cdc table name")
model TableId {
  @doc("database name of table")
  databaseName: string;

  @doc("schema name of table")
  schemaName: string;

  @doc("table name of table")
  tableName: string;
}

@doc("cdc connector SchemaProperties")
model CdcSchemaProperties extends SchemaProperties {
  @doc("cdc SchemaProperties type")
  type: SchemaPropertiesType.Cdc;

  @doc("cdc event type")
  cdcEventType: CdcEventType;

  @doc("table id")
  tableId: TableId;
}

@doc("Response item of Schema")
model Schema {
  @doc("Schema format")
  schemaFormat: SchemaFormat;

  @doc("Schema content")
  schemaJson: string;

  @doc("special schema Properties")
  schemaProperties: SchemaProperties;
}

@doc("Properties of Schema results")
model SchemaResult {
  @doc("Content of DataPreview results")
  @Azure.ResourceManager.identifiers(#[])
  schemas: Schema[];
}
