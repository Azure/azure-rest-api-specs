import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

namespace Microsoft.MessagingConnectors.Models.FetchSchema;

@doc("PostgreSql table id property.")
model PostgreSqlTableId {
  @doc("database name of table")
  databaseName: string;

  @doc("schema name of table")
  schemaName: string;

  @doc("table name of table")
  tableName: string;
}

@doc("PostgreSql SchemaProperties")
model PostgreSqlSchemaProperties extends SchemaProperties {
  @doc("cdc SchemaProperties type")
  type: SchemaPropertiesType.PostgreSql;

  @doc("PostgreSql table id property.")
  postgreSqlTableId: PostgreSqlTableId;
}
