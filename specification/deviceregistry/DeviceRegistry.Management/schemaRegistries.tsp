import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./common/provisioningState.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.DeviceRegistry;

@added(Versions.v2024_09_01_preview)
@doc("Schema registry definition.")
model SchemaRegistry is TrackedResource<SchemaRegistryProperties> {
  @doc("Schema registry name parameter.")
  @key("schemaRegistryName")
  @segment("schemaRegistries")
  @pattern("^[a-z0-9][a-z0-9-]*[a-z0-9]$")
  @path
  @minLength(3)
  @maxLength(63)
  name: string;

  ...ManagedSystemAssignedIdentityProperty;
}

@added(Versions.v2024_09_01_preview)
@doc("Defines the schema registry properties.")
model SchemaRegistryProperties {
  @doc("Globally unique, immutable, non-reusable id.")
  @visibility("read")
  uuid?: string;

  @doc("Schema registry namespace. Uniquely identifies a schema registry within a tenant.")
  @visibility("read", "create")
  @pattern("^[a-z0-9][a-z0-9-]*[a-z0-9]$")
  @maxLength(32)
  `namespace`: string;

  @doc("Human-readable display name.")
  displayName?: string;

  @doc("Human-readable description of the schema registry.")
  description?: string;

  @doc("The Storage Account's Container URL where schemas will be stored.")
  @visibility("read", "create")
  storageAccountContainerUrl: string;

  @doc("Provisioning state of the resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@added(Versions.v2024_09_01_preview)
@parentResource(SchemaRegistry)
@doc("Schema definition.")
model Schema is ProxyResource<SchemaProperties> {
  @doc("Schema name parameter.")
  @key("schemaName")
  @segment("schemas")
  @pattern("^[a-z0-9][a-z0-9-]*[a-z0-9]$")
  @path
  @minLength(3)
  @maxLength(64)
  name: string;
}

@added(Versions.v2024_09_01_preview)
@doc("Defines the schema properties.")
model SchemaProperties {
  @doc("Globally unique, immutable, non-reusable id.")
  @visibility("read")
  uuid?: string;

  @doc("Human-readable display name.")
  displayName?: string;

  @doc("Human-readable description of the schema.")
  description?: string;

  @doc("Format of the schema.")
  @visibility("read", "create")
  format: Format;

  @doc("Type of the schema.")
  @visibility("read", "create")
  schemaType: SchemaType;

  @doc("Provisioning state of the resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" ""
  @doc("Schema tags.")
  // Allowed scenario as per user-defined tags: https://github.com/Azure/azure-openapi-validator/blob/main/docs/avoid-additional-properties.md
  tags?: Record<string>;
}

@added(Versions.v2024_09_01_preview)
@doc("Defines the schema format.")
union Format {
  @doc("JSON Schema version draft 7 format")
  JsonSchema_draft7: "JsonSchema/draft-07",

  @doc("Delta format")
  Delta_1_0: "Delta/1.0",

  string,
}

@added(Versions.v2024_09_01_preview)
@doc("Defines the schema type.")
union SchemaType {
  @doc("Message Schema schema type")
  MessageSchema: "MessageSchema",

  string,
}

@added(Versions.v2024_09_01_preview)
@parentResource(Schema)
@doc("Schema version's definition.")
model SchemaVersion is ProxyResource<SchemaVersionProperties> {
  @doc("Schema version name parameter.")
  @key("schemaVersionName")
  @segment("schemaVersions")
  @pattern("^[0-9]*$")
  @path
  @minLength(1)
  @maxLength(10)
  name: string;
}

@added(Versions.v2024_09_01_preview)
@doc("Defines the schema version properties.")
model SchemaVersionProperties {
  @doc("Globally unique, immutable, non-reusable id.")
  @visibility("read")
  uuid?: string;

  @doc("Human-readable description of the schema.")
  description?: string;

  @doc("Schema content.")
  @visibility("read", "create")
  schemaContent: string;

  @doc("Hash of the schema content.")
  @visibility("read")
  hash?: string;

  @doc("Provisioning state of the resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

// The updateable properties of the Schema Registry.
// This is a workaround to fix the patch payload that otherwise will expose the 'location' field (not present in patch),
// since otherwise it extends the ARM TrackedResource type.
alias SchemaRegistriesPropertiesUpdate = {
  ...OptionalProperties<UpdateableProperties<SchemaRegistryProperties>>;
};

@added(Versions.v2024_09_01_preview)
@armResourceOperations
interface SchemaRegistries {
  get is ArmResourceRead<SchemaRegistry>;
  createOrReplace is ArmResourceCreateOrReplaceAsync<SchemaRegistry>;
  // Using 'ArmCustomPatchAsync' instead of 'ArmResourcePatchAsync' to define the correct patch payload for the resource.
  // This is a workaround to fix the patch payload that otherwise will expose the 'location' field (not present in patch),
  // since otherwise it extends the ARM TrackedResource type.
  update is ArmCustomPatchAsync<
    SchemaRegistry,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      SchemaRegistry,
      SchemaRegistriesPropertiesUpdate
    >
  >;
  delete is ArmResourceDeleteWithoutOkAsync<SchemaRegistry>;
  listByResourceGroup is ArmResourceListByParent<SchemaRegistry>;
  listBySubscription is ArmListBySubscription<SchemaRegistry>;
}

@added(Versions.v2024_09_01_preview)
@armResourceOperations
interface Schemas {
  get is ArmResourceRead<Schema>;
  createOrReplace is ArmResourceCreateOrReplaceSync<Schema>;
  delete is ArmResourceDeleteSync<Schema>;
  listBySchemaRegistry is ArmResourceListByParent<Schema>;
}

@added(Versions.v2024_09_01_preview)
@armResourceOperations
interface SchemaVersions {
  get is ArmResourceRead<SchemaVersion>;
  createOrReplace is ArmResourceCreateOrReplaceSync<SchemaVersion>;
  delete is ArmResourceDeleteSync<SchemaVersion>;
  listBySchema is ArmResourceListByParent<SchemaVersion>;
}
