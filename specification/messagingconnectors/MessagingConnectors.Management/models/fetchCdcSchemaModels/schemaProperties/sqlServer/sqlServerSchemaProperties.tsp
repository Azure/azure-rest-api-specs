import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

namespace Microsoft.MessagingConnectors.Models.FetchSchema;

@doc("sqlServer table id property.")
model SqlServerTableId {
  @doc("database name of table")
  databaseName: string;

  @doc("schema name of table")
  schemaName: string;

  @doc("table name of table")
  tableName: string;
}

@doc("SqlServer SchemaProperties")
model SqlServerSchemaProperties extends SchemaProperties {
  @doc("cdc SchemaProperties type")
  type: SchemaPropertiesType.SqlServer;

  @doc("sqlServer table id property.")
  sqlServerTableId: SqlServerTableId;
}
