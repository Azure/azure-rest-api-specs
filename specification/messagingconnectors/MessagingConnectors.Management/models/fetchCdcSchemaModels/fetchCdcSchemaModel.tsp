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

  @doc("networkProperties config.")
  networkProperties?: Models.Network.NetworkProperties;
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
