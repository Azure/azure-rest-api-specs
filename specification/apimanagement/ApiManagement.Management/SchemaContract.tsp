import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ApiContract.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ApiManagement;
/**
 * API Schema Contract details.
 */
@parentResource(ApiContract)
model SchemaContract
  is Azure.ResourceManager.ProxyResource<SchemaContractProperties> {
  ...ResourceNameParameter<
    Resource = SchemaContract,
    KeyName = "schemaId",
    SegmentName = "schemas",
    NamePattern = ""
  >;
}

@armResourceOperations
interface SchemaContractOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** The name of the API Management service. */
        @path
        @segment("service")
        @key
        @pattern("^[a-zA-Z](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?$")
        serviceName: string,

        /** API revision identifier. Must be unique in the current API Management service instance. Non-current revision has ;rev=n as a suffix where n is the revision number. */
        @path
        @segment("apis")
        @key
        @pattern("^[^*#&+:<>?]+$")
        apiId: string,
      },
      {
        /** Schema id identifier. Must be unique in the current API Management service instance. */
        @path
        @segment("schemas")
        @key
        schemaId: string,
      }
    > {}

@armResourceOperations
interface SchemaContracts {
  /**
   * Get the schema configuration at the API level.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ApiSchema_Get")
  get is SchemaContractOps.Read<SchemaContract>;

  /**
   * Gets the entity state (Etag) version of the schema specified by its identifier.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ApiSchema_GetEntityTag")
  getEntityTag is SchemaContractOps.CheckExistence<SchemaContract>;

  /**
   * Creates or updates schema configuration for the API.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ApiSchema_CreateOrUpdate")
  createOrUpdate is SchemaContractOps.CreateOrUpdateAsync<
    SchemaContract,
    Parameters = {
      /**
       * ETag of the Entity. Not required when creating an entity, but required when updating an entity.
       */
      @header
      `If-Match`?: string;
    },
    LroHeaders = ArmLroLocationHeader<FinalResult = SchemaContract> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Deletes the schema configuration at the Api.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ApiSchema_Delete")
  delete is SchemaContractOps.DeleteSync<
    SchemaContract,
    Parameters = {
      /**
       * If true removes all references to the schema before deleting it.
       */
      @query("force")
      force?: boolean;

      /**
       * ETag of the Entity. ETag should match the current entity state from the header response of the GET request or it should be * for unconditional update.
       */
      @header
      `If-Match`: string;
    }
  >;

  /**
   * Get the schema configuration at the API level.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ApiSchema_ListByApi")
  listByApi is SchemaContractOps.List<
    SchemaContract,
    Parameters = {
      /**
       * |     Field     |     Usage     |     Supported operators     |     Supported functions     |</br>|-------------|-------------|-------------|-------------|</br>| contentType | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>
       */
      @query("$filter")
      $filter?: string;

      /**
       * Number of records to return.
       */
      @minValue(1)
      @query("$top")
      $top?: int32;

      /**
       * Number of records to skip.
       */
      @query("$skip")
      $skip?: int32;
    },
    Response = ArmResponse<SchemaCollection>
  >;
}
@armResourceOperations
interface WorkspaceApiSchemaOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** The name of the API Management service. */
        @path
        @segment("service")
        @key
        @pattern("^[a-zA-Z](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?$")
        serviceName: string,

        /** Workspace identifier. Must be unique in the current API Management service instance. */
        @path
        @segment("workspaces")
        @key
        @pattern("^[^*#&+:<>?]+$")
        workspaceId: string,

        /** API revision identifier. Must be unique in the current API Management service instance. Non-current revision has ;rev=n as a suffix where n is the revision number. */
        @path
        @segment("apis")
        @key
        @pattern("^[^*#&+:<>?]+$")
        apiId: string,
      },
      {
        /** Schema id identifier. Must be unique in the current API Management service instance. */
        @path
        @segment("schemas")
        @key
        schemaId: string,
      }
    > {}

@armResourceOperations
interface WorkspaceApiSchema {
  /**
   * Get the schema configuration at the API level.
   */
  get is WorkspaceApiSchemaOps.Read<SchemaContract>;

  /**
   * Gets the entity state (Etag) version of the schema specified by its identifier.
   */
  getEntityTag is WorkspaceApiSchemaOps.CheckExistence<SchemaContract>;

  /**
   * Creates or updates schema configuration for the API.
   */
  createOrUpdate is WorkspaceApiSchemaOps.CreateOrUpdateAsync<
    SchemaContract,
    Parameters = {
      /**
       * ETag of the Entity. Not required when creating an entity, but required when updating an entity.
       */
      @header
      `If-Match`?: string;
    },
    LroHeaders = ArmLroLocationHeader<FinalResult = SchemaContract> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Deletes the schema configuration at the Api.
   */
  delete is WorkspaceApiSchemaOps.DeleteSync<
    SchemaContract,
    Parameters = {
      /**
       * If true removes all references to the schema before deleting it.
       */
      @query("force")
      force?: boolean;

      /**
       * ETag of the Entity. ETag should match the current entity state from the header response of the GET request or it should be * for unconditional update.
       */
      @header
      `If-Match`: string;
    }
  >;

  /**
   * Get the schema configuration at the API level.
   */
  listByApi is WorkspaceApiSchemaOps.List<
    SchemaContract,
    Parameters = {
      /**
       * |     Field     |     Usage     |     Supported operators     |     Supported functions     |</br>|-------------|-------------|-------------|-------------|</br>| contentType | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>
       */
      @query("$filter")
      $filter?: string;

      /**
       * Number of records to return.
       */
      @minValue(1)
      @query("$top")
      $top?: int32;

      /**
       * Number of records to skip.
       */
      @query("$skip")
      $skip?: int32;
    },
    Response = ArmResponse<SchemaCollection>
  >;
}

@@maxLength(SchemaContract.name, 80);
@@minLength(SchemaContract.name, 1);
@@doc(SchemaContract.name,
  "Schema id identifier. Must be unique in the current API Management service instance."
);
@@doc(SchemaContract.properties, "Properties of the API Schema.");
@@doc(SchemaContracts.createOrUpdate::parameters.resource,
  "The schema contents to apply."
);
@@doc(WorkspaceApiSchema.createOrUpdate::parameters.resource,
  "The schema contents to apply."
);
