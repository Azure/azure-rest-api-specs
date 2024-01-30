import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-client-generator-core";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ClientGenerator.Core;

@useAuth(
  OAuth2Auth<[
    {
      type: OAuth2FlowType.implicit;
      authorizationUrl: "https://login.microsoftonline.com/common/oauth2/authorize";

      // add description to below: "impersonate your user account"
      scopes: ["https://eventhubs.azure.net/.default"];
    }
  ]>;
)
@service({
  title: "Azure Schema Registry",
})

// Supported operations.
//  GET https://{namespaceName}.servicebus.windows.net/$schemaGroups?api-version={apiVersion}
//  GET https://{namespaceName}.servicebus.windows.net/$schemaGroups/$schemas/{id}?api-version={apiVersion}
//  GET https://{namespaceName}.servicebus.windows.net/$schemaGroups/{groupName}/schemas/{name}/versions/?api-version={apiVersion}
//  GET https://{namespaceName}.servicebus.windows.net/$schemaGroups/{groupName}/schemas/{name}/versions/{version}?api-version={apiVersion}
//  POST https://{namespaceName}.servicebus.windows.net/$schemaGroups/{groupName}/schemas/{name}/:get-id?api-version={apiVersion}
//  PUT https://{namespaceName}.servicebus.windows.net/$schemaGroups/{groupName}/schemas/{name}?api-version={apiVersion}
@server(
  "{fullyQualifiedNamespace}",
  "The Schema Registry service endpoint.",
  {
    @doc("The Schema Registry service endpoint, for example 'https://my-namespace.servicebus.windows.net'.")
    fullyQualifiedNamespace: url,
  }
)
@versioned(ServiceApiVersions)
@doc("SchemaRegistryClient is a client for registering and retrieving schemas from the Azure Schema Registry service.")
namespace SchemaRegistry;

@doc("Represents the Schema Registry API version to use for requests.")
enum ServiceApiVersions {
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
@client({
  name: "SchemaRegistryClient",
  service: SchemaRegistry,
})
interface SchemaOperations {
  //  GET https://{namespaceName}.servicebus.windows.net/$schemaGroups?api-version={apiVersion}
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Standard read operation w/ SchemaId resource doesn't allow returning binary schema and headers."
  @summary("Get list of schema groups.")
  @doc("Gets the list of schema groups user is authorized to access.")
  @route("/$schemaGroups")
  listSchemaGroups is Azure.Core.Foundations.Operation<
    {},
    StringsList,
    {}
  >;

  //  GET https://{namespaceName}.servicebus.windows.net/$schemaGroups/$schemas/{id}?api-version={apiVersion}
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Standard read operation w/ SchemaId resource doesn't allow returning binary schema and headers."
  @summary("Get a registered schema by its unique ID reference.")
  @doc("Gets a registered schema by its unique ID.  Azure Schema Registry guarantees that ID is unique within a namespace. Operation response type is based on serialization of schema requested.")
  @route("/$schemaGroups/$schemas/{id}")
  @get
  getSchemaById is Azure.Core.Foundations.Operation<
    Azure.Core.Foundations.ItemKeysOf<SchemaId>,
    OkResponse & SchemaHeaders & SchemaContent & SchemaContentType
  >;

  //  GET https://{namespaceName}.servicebus.windows.net/$schemaGroups/{groupName}/schemas/{name}/versions?api-version={apiVersion}
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Standard read operation w/ Version resource doesn't allow returning non-version response."
  @summary("List schema versions.")
  @doc("Gets the list of all versions of one schema.")
  @route("/$schemaGroups/{groupName}/schemas/{name}/versions")
  listSchemaVersions  is Azure.Core.Foundations.Operation<
    Azure.Core.Foundations.ItemKeysOf<SchemaName>,
    Int32sList,
    {}
  >;

  //  GET https://{namespaceName}.servicebus.windows.net/$schemaGroups/{groupName}/schemas/{name}/versions/{version}?api-version={apiVersion}
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Standard read operation w/ Version resource doesn't allow returning non-version response."
  @summary("Get specific schema versions.")
  @doc("Gets one specific version of one schema.")
  @route("/$schemaGroups/{groupName}/schemas/{name}/versions/{version}")
  @get
  getSchemaByVersion is Azure.Core.Foundations.Operation<
    Azure.Core.Foundations.ItemKeysOf<SchemaVersion>,
    OkResponse & SchemaHeaders & SchemaContent & SchemaContentType
  >;

  //  POST https://{namespaceName}.servicebus.windows.net/$schemaGroups/{groupName}/schemas/{name}:get-id?api-version={apiVersion}
  @summary("Get ID for existing schema.")
  @doc("Gets the ID referencing an existing schema within the specified schema group, as matched by schema content comparison.")
  @action("get-id")
  getSchemaIdByContent is resourceOperations.ResourceAction<
    SchemaName,
    {
      ...SchemaContentType;

      @doc("String representation (UTF-8) of the registered schema.")
      @body
      schemaContent: bytes;
    },
    SchemaHeaders
  >;

  //  PUT https://{namespaceName}.servicebus.windows.net/$schemaGroups/{groupName}/schemas/{name}?api-version={apiVersion}
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Standard createOrReplace operation does not allow passing in binary body to request."
  @summary("Register new schema")
  @doc("Register new schema. If schema of specified name does not exist in specified group, schema is created at version 1. If schema of specified name exists already in specified group, schema is created at latest version + 1.")
  @route("/$schemaGroups/{groupName}/schemas/{name}")
  @put
  registerSchema is Azure.Core.Foundations.Operation<
    Azure.Core.Foundations.ItemKeysOf<SchemaName> &
      SchemaContent &
      SchemaContentType,
    NoContentResponse<SchemaHeaders>
  >;
}

// Models

alias NoContentResponse<T> = TypeSpec.Http.Response<204> & T;

union SchemaContentTypeValues {
  @added(ServiceApiVersions.V2022_10)
  customBinary: "application/octet-stream",
  @added(ServiceApiVersions.V2022_10)
  custom: "text/plain; charset=utf-8",
  avro: "application/json; serialization=Avro",
  @added(ServiceApiVersions.V2022_10)
  json: "application/json; serialization=Json",
  @added(ServiceApiVersions.V2023_07_01)
  protobuf: "text/vnd.ms.protobuf",
}

@doc("The content type for given schema. Each schema type has an associated content-type.")
model SchemaContentType {
  @doc("The content type for given schema.")
  @header("Content-Type")
  contentType: SchemaContentTypeValues;
}

@doc("Content of the schema.")
model SchemaContent {
  @body
  @doc("String representation (UTF-8) of the schema.")
  content: bytes;
}

@doc("Headers for metadata of a schema.")
model SchemaHeaders {
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

@doc("Object received from the registry containing schema identifiers.")
@resource("$schemaGroups/$schemas")
model SchemaId {
  @key("id")
  @doc("Schema ID that uniquely identifies a schema in the registry namespace.")
  @visibility("read")
  id: string;
}

/**
 * The list of strings with server paging support.
 */
@Azure.Core.pagedResult
model StringsList {
  /** The collection of pageable items. */
  @Azure.Core.items
  value: string[];

  /** The link to the next page of items */
  @Azure.Core.nextLink
  nextLink?: string;
}

/**
 * The list of int32s with server paging support.
 */
@Azure.Core.pagedResult
model Int32sList {
  /** The collection of pageable items. */
  @Azure.Core.items
  value: int32[];

  /** The link to the next page of items */
  @Azure.Core.nextLink
  nextLink?: string;
}

@doc("Schema Group resource.")
@resource("$schemaGroups")
model SchemaGroup {
  @key("groupName")
  @doc("Name of schema group.")
  @visibility("read")
  groupName: string;
}

@doc("Schemas resource.")
@parentResource(SchemaGroup)
@resource("schemas")
model SchemaName {
  @key("name")
  @doc("Name of schema.")
  @visibility("read")
  @maxLength(50)
  @pattern("^[A-Za-z0-9][^\\\\/$:]*$")
  name: string;
}

@doc("Schema versions resource.")
@resource("versions")
@parentResource(SchemaName)
model SchemaVersion {
  @key("version")
  @doc("Version number of specific schema.")
  @visibility("read")
  version: int32;
}
