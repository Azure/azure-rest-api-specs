import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;

@doc("Connector Schema Config")
@discriminator("connectorType")
model ConnectorSchemaConfig {
  @doc("connector Type.")
  connectorType: ConnectorType;
}

@doc("SqlServerSource Schema Config")
model SqlServerSourceConnectorSchemaConfig extends ConnectorSchemaConfig {
  @doc("SqlServerSource Connector")
  connectorType: ConnectorType.SqlServerSource;

  @doc("Servername string")
  serverName: string;

  @doc("Port of Server")
  port: int32;

  @doc("databaseName of Server")
  databaseName: string;

  @doc("username of Server")
  userName: string;

  @doc("password of Server")
  @secret
  password: string;

  @doc("tables of Server")
  tables: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state"
@doc("properties of fetch Schema")
model SchemaRequestProperties {
  @doc("schema config for connector")
  connectorSchemaConfig: ConnectorSchemaConfig;

  @doc("Schema Format")
  format: string;
}

@doc("Schema Properties Types")
union SchemaPropertiesType {
  @doc("change data capture(CDC) Schema Properties Types")
  CDC: "CDC",

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

@doc("cdc connector SchemaProperties")
model CdcSchemaProperties extends SchemaProperties {
  @doc("cdc SchemaProperties type")
  type: SchemaPropertiesType.CDC;

  @doc("cdc table name")
  tableName: string;

  @doc("cdc event type")
  cdcEventType: CdcEventType;

  @doc("cdc database name")
  databaseName: string;
}

@doc("Response item of Schema")
model Schema {
  @doc("Schema format")
  schemaFormat: string;

  @doc("Schema content")
  schemaJson: string;

  @doc("special schema Properties")
  schemaProperties: SchemaProperties;
}

@doc("Properties of Schema results")
model SchemaResult {
  @doc("Content of DataPreview results")
  @OpenAPI.extension("x-ms-identifiers", [])
  schemas: Schema[];
}
