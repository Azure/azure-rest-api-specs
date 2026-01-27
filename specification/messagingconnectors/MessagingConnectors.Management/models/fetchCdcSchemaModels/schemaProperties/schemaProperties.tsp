import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

namespace Microsoft.MessagingConnectors.Models.FetchSchema;

@doc("Schema Properties Types")
union SchemaPropertiesType {
  @doc("SqlServer Schema Properties Types")
  SqlServer: "SqlServer",

  @doc("PostgreSql Schema Properties Types")
  PostgreSql: "PostgreSql",

  string,
}

@doc("special connector SchemaProperties")
@discriminator("type")
model SchemaProperties {
  type: SchemaPropertiesType;

  @doc("Id of schema.")
  schemaId: string;

  @doc("Id of message.")
  messageId: string;
}
