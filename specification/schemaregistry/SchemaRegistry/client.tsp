import "@azure-tools/typespec-client-generator-core";
import "@typespec/versioning";
import "./main.tsp";

using TypeSpec.Versioning;
using Azure.ClientGenerator.Core;
using SchemaRegistry;

@TypeSpec.Versioning.useDependency(ServiceApiVersions.V2023_07_01)
namespace ClientCustomizations;

@client({
  name: "SchemaRegistryClient",
  service: SchemaRegistry,
})
interface SchemaOperations {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Standard read operation w/ SchemaId resource doesn't allow returning binary schema and headers."
  listSchemaGroups is SchemaRegistry.listSchemaGroups;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Standard read operation w/ Version resource doesn't allow returning non-version response."
  listSchemaVersions is SchemaRegistry.listSchemaVersions;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Standard read operation w/ SchemaId resource doesn't allow returning binary schema and headers."
  getSchemaById is SchemaRegistry.getSchemaById;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Standard read operation w/ Version resource doesn't allow returning non-version response."
  getSchemaByVersion is SchemaRegistry.getSchemaByVersion;
  #suppress "@azure-tools/typespec-azure-core/byos" "storage service is not used"
  getSchemaPropertiesByContent is SchemaRegistry.getSchemaPropertiesByContent;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Standard createOrReplace operation does not allow passing in binary body to request."
  #suppress "@azure-tools/typespec-azure-core/byos" "storage service is not used"
  registerSchema is SchemaRegistry.registerSchema;
}

@@access(SchemaGroup, Access.internal);

// csharp modifications
@doc("The content type for the schema.")
union ContentTypeEnum {
  @doc("The Avro schema content type.")
  avro: "application/json; serialization=Avro",

  @doc("The JSON schema content type.")
  json: "application/json; serialization=Json",

  @doc("The custom schema content type.")
  custom: "text/plain; charset=utf-8",

  @doc("The protobuf schema content type.")
  @added(ServiceApiVersions.V2023_07_01)
  protobuf: "text/vnd.ms.protobuf",

  string,
}

@@access(ContentTypeEnum, Access.internal);
@@usage(ContentTypeEnum, Usage.input | Usage.output);
@@projectedName(ContentTypeEnum, "csharp", "ContentType");

// operations
@@access(listSchemaGroups, Access.internal);
@@access(getSchemaById, Access.internal);
@@access(getSchemaByVersion, Access.internal);
@@access(listSchemaVersions, Access.internal);
@@access(getSchemaPropertiesByContent, Access.internal);
@@access(registerSchema, Access.internal);
