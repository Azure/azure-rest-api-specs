import "@azure-tools/typespec-client-generator-core";
import "@typespec/versioning";
import "./main.tsp";

using TypeSpec.Versioning;
using Azure.ClientGenerator.Core;
using SchemaRegistry;

@@access(SchemaVersion, Access.internal);
@@access(SchemaGroup, Access.internal);

@doc("Represents the format of the schema to be stored by the Schema Registry service.")
enum SchemaFormat {
  @doc("Represents the Apache Avro schema format.")
  avro: "Avro",

  @doc("Represents the JSON schema format.")
  @added(ServiceApiVersions.V2022_10)
  json: "Json",

  @doc("Represents a custom schema format.")
  @added(ServiceApiVersions.V2022_10)
  custom: "Custom",

  @added(ServiceApiVersions.V2023_07_01)
  @doc("Represents a protobuf schema format.")
  protobuf: "Protobuf",
}

@doc("Meta properties of a schema.")
model SchemaProperties {
  @doc("References a specific schema in the registry namespace.")
  id: string;

  @doc("Format for the schema being stored.")
  format: SchemaFormat;

  @doc("Schema group under which schema is stored.")
  groupName: string;

  @doc("Name of schema.")
  name: string;

  @doc("Version of schema.")
  version: int32;
}

@doc("The schema content of a schema, along with id and meta properties.")
model Schema {
  @doc("The content of the schema.")
  definition: string;

  @doc("The properties of the schema.")
  properties: SchemaProperties;
}

// csharp modifications
@doc("The content type for the schema.")
enum ContentTypeEnum {
  @doc("The Avro schema content type.")
  avro: "application/json; serialization=Avro",

  @doc("The JSON schema content type.")
  @added(ServiceApiVersions.V2022_10)
  json: "application/json; serialization=Json",

  @doc("The custom schema content type.")
  @added(ServiceApiVersions.V2022_10)
  custom: "text/plain; charset=utf-8",

  @doc("The protobuf schema content type.")
  @added(ServiceApiVersions.V2023_07_01)
  protobuf: "text/vnd.ms.protobuf",
}

@@access(ContentTypeEnum, Access.internal);
@@usage(ContentTypeEnum, Usage.input | Usage.output);
@@projectedName(ContentTypeEnum, "csharp", "ContentType");

// operations
@@access(SchemaOperations.listSchemaGroups, Access.internal);
@@access(SchemaOperations.getSchemaById, Access.internal);
@@access(SchemaOperations.getSchemaByVersion, Access.internal);
@@access(SchemaOperations.listSchemaVersions, Access.internal);
@@access(SchemaOperations.getSchemaIdByContent, Access.internal);
@@access(SchemaOperations.registerSchema, Access.internal);

// models
@@access(SchemaFormat, Access.internal);
@@usage(SchemaFormat, Usage.input | Usage.output);
@@access(SchemaProperties, Access.internal);
@@usage(SchemaProperties, Usage.input | Usage.output);
@@access(Schema, Access.internal);
@@usage(Schema, Usage.input | Usage.output);
