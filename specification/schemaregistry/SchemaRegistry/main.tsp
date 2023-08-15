import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@typespec/openapi";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using OpenAPI;

@useAuth(AzureAuth)
@service({
  title: "Azure.SchemaRegistry",
})

// Supported operations.
//  GET https://{namespaceName}.servicebus.windows.net/$schemaGroups?api-version={apiVersion}
//  GET https://{namespaceName}.servicebus.windows.net/$schemaGroups/$schemas/{id}?api-version={apiVersion}
//  GET https://{namespaceName}.servicebus.windows.net/$schemaGroups/{groupName}/schemas/{name}/versions/?api-version={apiVersion}
//  GET https://{namespaceName}.servicebus.windows.net/$schemaGroups/{groupName}/schemas/{name}/versions/{schemaVersion}?api-version={apiVersion}
//  POST https://{namespaceName}.servicebus.windows.net/$schemaGroups/{groupName}/schemas/{name}/:get-id?api-version={apiVersion}
//  PUT https://{namespaceName}.servicebus.windows.net/$schemaGroups/{groupName}/schemas/{name}?api-version={apiVersion}
@server(
  "{endpoint}",
  "The Schema Registry service endpoint.",
  {
    @doc("The Schema Registry service endpoint, for example 'my-namespace.servicebus.windows.net'.")
    @extension("x-ms-parameter-location", "client")
    @extension("x-ms-skip-url-encoding", true)
    endpoint: url,
  }
)
@versioned(ServiceApiVersions)
namespace Azure.SchemaRegistry;

@doc("Azure Core Version")
enum ServiceApiVersions {
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  @doc("Azure Schema Registry 2022-10 Version")
  v2022_10: "2022-10",
}

@doc("Azure Active Directory OAuth2 Flow")
model AzureAuth
  is OAuth2Auth<[
    {
      type: OAuth2FlowType.implicit;
      authorizationUrl: "https://login.microsoftonline.com/common/oauth2/authorize";
      // add description to below: "impersonate your user account"
      scopes: ["user_impersonation"];
    }
  ]>;

// ROUTES
alias resourceOperations = Azure.Core.StandardResourceOperations;

interface SchemaOperations {
  //  GET https://{namespaceName}.servicebus.windows.net/$schemaGroups?api-version={apiVersion}
  @summary("Get list of schema groups.")
  @doc("Gets the list of schema groups user is authorized to access.")
  @sharedRoute
  op listSchemaGroups is resourceOperations.ResourceList<SchemaGroup>;

  //  GET https://{namespaceName}.servicebus.windows.net/$schemaGroups/$schemas/{id}?api-version={apiVersion}
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Standard read operation w/ SchemaId resource doesn't allow returning binary schema and headers."
  @summary("Get a registered schema by its unique ID reference.")
  @doc("Gets a registered schema by its unique ID.  Azure Schema Registry guarantees that ID is unique within a namespace. Operation response type is based on serialization of schema requested.")
  @route("/$schemaGroups/$schemas/{id}")
  @get
  op getSchemaById is Azure.Core.Foundations.Operation<
    Azure.Core.Foundations.ItemKeysOf<SchemaId>,
    OkResponse & SchemaHeaders & SchemaContent & SchemaContentType
  >;

  //  GET https://{namespaceName}.servicebus.windows.net/$schemaGroups/{groupName}/schemas/{name}/versions/?api-version={apiVersion}
  @summary("List schema versions.")
  @doc("Gets the list of all versions of one schema.")
  op listSchemaVersions is resourceOperations.ResourceList<Version>;

  //  GET https://{namespaceName}.servicebus.windows.net/$schemaGroups/{groupName}/schemas/{name}/versions/{schemaVersion}?api-version={apiVersion}
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Standard read operation w/ Version resource doesn't allow returning non-version response."
  @summary("Get specific schema versions.")
  @doc("Gets one specific version of one schema.")
  @route("/$schemaGroups/{groupName}/schemas/{name}/versions/{schemaVersion}")
  @get
  op getSchemaByVersion is Azure.Core.Foundations.Operation<
    Azure.Core.Foundations.ItemKeysOf<Version>,
    OkResponse & SchemaHeaders & SchemaContent & SchemaContentType
  >;

  //  POST https://{namespaceName}.servicebus.windows.net/$schemaGroups/{groupName}/schemas/{name}:get-id?api-version={apiVersion}
  @summary("Get ID for existing schema.")
  @doc("Gets the ID referencing an existing schema within the specified schema group, as matched by schema content comparison.")
  @action("get-id")
  op getSchemaIdByContent is resourceOperations.ResourceAction<
    Schema,
    {
      ...SchemaContentType;

      @doc("String representation (UTF-8) of the registered schema.")
      @body
      schemaContent: bytes;
    },
    SchemaHeaders
  >;

  //  PUT https://{namespaceName}.servicebus.windows.net/$schemaGroups/{groupName}/schemas/{name}?api-version={apiVersion}
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Register operation does not use create/replace naming"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Standard createOrReplace operation does not allow passing in binary body to request."
  @summary("Register new schema")
  @doc("Register new schema. If schema of specified name does not exist in specified group, schema is created at version 1. If schema of specified name exists already in specified group, schema is created at latest version + 1.")
  @route("/$schemaGroups/{groupName}/schemas/{name}")
  @put
  op registerSchema is Azure.Core.Foundations.Operation<
    Azure.Core.Foundations.ItemKeysOf<Schema> & SchemaContent & SchemaContentType,
    NoContentResponse<SchemaHeaders>
  >;
}

// Models

alias NoContentResponse<T> = TypeSpec.Http.Response<204> & T;

@doc("The content type for given schema. Each schema type has an associated content-type.")
model SchemaContentType {
  @doc("The content type for given schema.")
  @header("content-type")
  contentType: "application/json; serialization=Avro" | "application/json; serialization=json" | "text/plain; charset=utf-8";
}

@doc("Content of the schema.")
model SchemaContent {
  @body
  @doc("String representation (UTF-8) of the schema.")
  content: bytes;
}

@doc("No Content.")
model SchemaHeaders {
  @doc("URL location of schema, identified by schema group, schema name, and version.")
  @header
  location: string;

  @doc("References specific schema in registry namespace.")
  @header
  schemaId: string;

  @doc("URL location of schema, identified by schema ID.")
  @header
  schemaIdLocation: string;

  @doc("References schema group.")
  @header
  schemaGroupName: string;

  @doc("References schema name.")
  @header
  schemaName: string;

  @doc("Version of the returned schema.")
  @header
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

@doc("Schema Group resource.")
@resource("$schemaGroups")
model SchemaGroup {
  @key("groupName")
  @doc("Name of schema group.")
  @visibility("read")
  groupName: string;
}

@doc("Schemas resource.")
@resource("schemas")
@parentResource(SchemaGroup)
model Schema {
  @key("name")
  @doc("Name of schema.")
  @visibility("read")
  @maxLength(50)
  @pattern("^[A-Za-z0-9][^\\\\/$:]*$")
  @extension("x-ms-parameter-location", "method")
  name: string;

  @doc("String representation (UTF-8) of the registered schema.")
  schemaContent: bytes;
}

@doc("Schema versions resource.")
@resource("versions")
@parentResource(Schema)
model Version {
  @key("schemaVersion")
  @doc("Version number of specific schema.")
  @visibility("read")
  @extension("x-ms-parameter-location", "method")
  schemaVersion: int32;
}
