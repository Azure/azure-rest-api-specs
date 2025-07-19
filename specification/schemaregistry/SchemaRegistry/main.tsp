import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;

@useAuth(
  OAuth2Auth<[
    {
      type: OAuth2FlowType.implicit,
      authorizationUrl: "https://login.microsoftonline.com/common/oauth2/authorize",

      // add description to below: "impersonate your user account"
      scopes: ["https://eventhubs.azure.net/.default"],
    }
  ]>
)
@service(#{ title: "Azure Schema Registry" })

// Supported operations.
//  GET https://{namespaceName}.servicebus.windows.net/$schemaGroups?api-version={apiVersion}
//  GET https://{namespaceName}.servicebus.windows.net/$schemaGroups/$schemas/{id}?api-version={apiVersion}
//  GET https://{namespaceName}.servicebus.windows.net/$schemaGroups/{groupName}/schemas/{schemaName}/versions/?api-version={apiVersion}
//  GET https://{namespaceName}.servicebus.windows.net/$schemaGroups/{groupName}/schemas/{schemaName}/versions/{schemaVersion}?api-version={apiVersion}
//  POST https://{namespaceName}.servicebus.windows.net/$schemaGroups/{groupName}/schemas/{schemaName}/:get-id?api-version={apiVersion}
//  PUT https://{namespaceName}.servicebus.windows.net/$schemaGroups/{groupName}/schemas/{schemaName}?api-version={apiVersion}
@server(
  "https://{fullyQualifiedNamespace}",
  "The Schema Registry service endpoint.",
  {
    @doc("The Schema Registry service endpoint, for example 'my-namespace.servicebus.windows.net'.")
    fullyQualifiedNamespace: string,
  }
)
@versioned(ServiceVersion)
@doc("SchemaRegistryClient is a client for registering and retrieving schemas from the Azure Schema Registry service.")
namespace SchemaRegistry;

@doc("Represents the Schema Registry API version to use for requests.")
enum ServiceVersion {
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @doc("Azure Schema Registry 2021-10 Version")
  V2021_10: "2021-10",

  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @doc("Azure Schema Registry 2022-10 Version")
  V2022_10: "2022-10",

  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @doc("Azure Schema Registry 2023-07-01 Version. This is the default version.")
  V2023_07_01: "2023-07-01",
}

// ROUTES
alias resourceOperations = Azure.Core.StandardResourceOperations;

//  GET https://{namespaceName}.servicebus.windows.net/$schemaGroups?api-version={apiVersion}
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Non-standard operation."
@summary("Get list of schema groups.")
@doc("Gets the list of schema groups user is authorized to access.")
@route("/$schemaGroups")
@list
op listSchemaGroups is Azure.Core.Foundations.Operation<{}, SchemaGroups, {}>;

//  GET https://{namespaceName}.servicebus.windows.net/$schemaGroups/{groupName}/schemas/{schemaName}/versions?api-version={apiVersion}
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Non-standard operation."
@summary("List schema versions.")
@doc("Gets the list of all versions of one schema.")
@route("/$schemaGroups/{groupName}/schemas/{schemaName}/versions")
@list
op listSchemaVersions is Azure.Core.Foundations.Operation<
  {
    @doc("Name of schema group.")
    @path
    groupName: string;

    @doc("Name of schema.")
    @path
    @maxLength(50)
    @pattern("^[A-Za-z0-9][^\\\\/$:]*$")
    schemaName: string;
  },
  SchemaVersions,
  {}
>;

//  GET https://{namespaceName}.servicebus.windows.net/$schemaGroups/$schemas/{id}?api-version={apiVersion}
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Non-standard operation."
@summary("Get a registered schema by its unique ID reference.")
@doc("Gets a registered schema by its unique ID.  Azure Schema Registry guarantees that ID is unique within a namespace. Operation response type is based on serialization of schema requested.")
@route("/$schemaGroups/$schemas/{id}")
@get
op getSchemaById is Azure.Core.Foundations.Operation<
  {
    @doc("Schema ID that uniquely identifies a schema in the registry namespace.")
    @path
    id: string;
  },
  OkResponse & Schema
>;

//  GET https://{namespaceName}.servicebus.windows.net/$schemaGroups/{groupName}/schemas/{schemaName}/versions/{schemaVersion}?api-version={apiVersion}
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Non-standard operation."
@summary("Get specific schema versions.")
@doc("Gets one specific version of one schema.")
@route("/$schemaGroups/{groupName}/schemas/{schemaName}/versions/{schemaVersion}")
@get
op getSchemaByVersion is Azure.Core.Foundations.Operation<
  {
    @doc("Name of schema group.")
    @path
    groupName: string;

    @doc("Name of schema.")
    @path
    @maxLength(50)
    @pattern("^[A-Za-z0-9][^\\\\/$:]*$")
    schemaName: string;

    @doc("Version number of specific schema.")
    @path
    schemaVersion: int32;
  },
  OkResponse & Schema
>;

//  POST https://{namespaceName}.servicebus.windows.net/$schemaGroups/{groupName}/schemas/{schemaName}:get-id?api-version={apiVersion}
// Operation name more accurately reflects the return value than the action
#suppress "@azure-tools/typespec-azure-core/byos" "storage service is not used"
@summary("Get properties for existing schema.")
@doc("Gets the properties referencing an existing schema within the specified schema group, as matched by schema content comparison.")
@action("get-id")
op getSchemaPropertiesByContent is resourceOperations.ResourceAction<
  SchemasName,
  {
    ...SchemaContentType;
    ...SchemasContent;
  },
  Http.NoContentResponse & SchemaProperties
>;

//  PUT https://{namespaceName}.servicebus.windows.net/$schemaGroups/{groupName}/schemas/{schemaName}?api-version={apiVersion}
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Non-standard operation."
#suppress "@azure-tools/typespec-azure-core/byos" "storage service is not used"
@summary("Register new schema")
@doc("Register new schema. If schema of specified name does not exist in specified group, schema is created at version 1. If schema of specified name exists already in specified group, schema is created at latest version + 1.")
@route("/$schemaGroups/{groupName}/schemas/{schemaName}")
@put
op registerSchema is Azure.Core.Foundations.Operation<
  {
    @doc("Name of schema group.")
    @path
    groupName: string;

    @doc("Name of schema.")
    @path
    @maxLength(50)
    @pattern("^[A-Za-z0-9][^\\\\/$:]*$")
    schemaName: string;

    ...SchemasContent;
    ...SchemaContentType;
  },
  NoContentResponse<SchemaProperties>
>;

// Models
alias NoContentResponse<T> = TypeSpec.Http.Response<204> & T;

// TODO: Leaving as closed set of values for now, as we're blocked by https://github.com/microsoft/typespec/issues/2853.
// Need to update once issue is fixed.
/** Describes closed list of schema content type values. */
#suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "This union cannot be open"
union SchemaContentTypeValues {
  /** Avro encoding. */
  avro: "application/json; serialization=Avro",

  /** JSON encoding */
  @added(ServiceVersion.V2022_10)
  json: "application/json; serialization=Json",

  /** Plain text custom encoding. */
  @added(ServiceVersion.V2022_10)
  custom: "text/plain; charset=utf-8",

  /** Protobuf encoding. */
  @added(ServiceVersion.V2023_07_01)
  protobuf: "text/vnd.ms.protobuf",
}

alias SchemaContentType = {
  @doc("The content type for given schema.")
  @header("Content-Type")
  contentType: SchemaContentTypeValues;
};

alias SchemasContent = {
  @bodyRoot
  @doc("String representation (UTF-8) of the schema.")
  schemaContent: bytes;
};

@doc("Metadata of a schema.")
model SchemaProperties {
  @doc("URL location of schema, identified by schema group, schema name, and version.")
  @header("Location")
  location: string;

  @doc("References specific schema in registry namespace.")
  @header("Schema-Id")
  schemaId: string;

  @doc("URL location of schema, identified by schema ID.")
  @header("Schema-Id-Location")
  schemaIdLocation: string;

  @doc("References schema group.")
  @header("Schema-Group-Name")
  schemaGroupName: string;

  @doc("References schema name.")
  @header("Schema-Name")
  schemaName: string;

  @doc("Version of the returned schema.")
  @header("Schema-Version")
  schemaVersion: int32;
}

@doc("The schema, including its metadata and content.")
model Schema {
  ...SchemaProperties;
  ...SchemasContent;
  ...SchemaContentType;
}

/**
 * The list of schema group names with server paging support.
 */
model SchemaGroups {
  /** The collection of pageable schema group name items. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Already public casing from service is not camelCase."
  @pageItems
  Value: string[];

  /** The link to the next page of items */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Already public casing from service is not camelCase."
  @nextLink
  NextLink?: url;
}

/**
 * The list of schema versions with server paging support.
 */
model SchemaVersions {
  /** The collection of schema version pageable items. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Already public casing from service is not camelCase."
  @pageItems
  Value: int32[];

  /** The link to the next page of items */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Already public casing from service is not camelCase."
  @nextLink
  NextLink?: url;
}

// Resource Models
@doc("Schema Group resource.")
@resource("$schemaGroups")
model SchemaGroup {
  @key("groupName")
  @doc("Name of schema group.")
  @visibility(Lifecycle.Read)
  groupName: string;
}

@doc("Schemas resource.")
@parentResource(SchemaGroup)
@resource("schemas")
model SchemasName {
  @key("schemaName")
  @doc("Name of schema.")
  @visibility(Lifecycle.Read)
  @maxLength(50)
  @pattern("^[A-Za-z0-9][^\\\\/$:]*$")
  schemaName: string;
}
