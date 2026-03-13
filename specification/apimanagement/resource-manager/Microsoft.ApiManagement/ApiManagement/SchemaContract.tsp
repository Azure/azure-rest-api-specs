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
        @minLength(1)
        @maxLength(50)
        serviceName: string,

        /** API revision identifier. Must be unique in the current API Management service instance. Non-current revision has ;rev=n as a suffix where n is the revision number. */
        @path
        @segment("apis")
        @key
        @pattern("^[^*#&+:<>?]+$")
        @minLength(1)
        @maxLength(256)
        apiId: string,
      },
      {
        /** Schema id identifier. Must be unique in the current API Management service instance. */
        @path
        @segment("schemas")
        @key
        @minLength(1)
        @maxLength(80)
        schemaId: string,
      }
    > {}

@armResourceOperations
interface SchemaContracts {
  /**
   * Get the schema configuration at the API level.
   */
  get is SchemaContractOps.Read<
    SchemaContract,
    Response = ArmResponse<SchemaContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Gets the entity state (Etag) version of the schema specified by its identifier.
   */
  getEntityTag is SchemaContractOps.CheckExistence<
    SchemaContract,
    Response = OkResponse & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Creates or updates schema configuration for the API.
   */
  createOrUpdate is SchemaContractOps.CreateOrUpdateAsync<
    SchemaContract,
    Parameters = {
      /**
       * ETag of the Entity. Not required when creating an entity, but required when updating an entity.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`?: string;
    },
    Response = (ArmResponse<SchemaContract> &
      ArmCombinedLroHeaders<FinalResult = SchemaContract> & {
        /**
         * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
         */
        @header("ETag")
        etag: string;
      }) | (ArmCreatedResponse<SchemaContract> &
      ArmCombinedLroHeaders<FinalResult = SchemaContract> & {
        /**
         * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
         */
        @header("ETag")
        etag: string;
      })
  >;

  /**
   * Deletes the schema configuration at the Api.
   */
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
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`: string;
    }
  >;

  /**
   * Get the schema configuration at the API level.
   */
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
      @minValue(0)
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
        @minLength(1)
        @maxLength(50)
        serviceName: string,

        /** Workspace identifier. Must be unique in the current API Management service instance. */
        @path
        @segment("workspaces")
        @key
        @pattern("^[^*#&+:<>?]+$")
        @minLength(1)
        @maxLength(80)
        workspaceId: string,

        /** API revision identifier. Must be unique in the current API Management service instance. Non-current revision has ;rev=n as a suffix where n is the revision number. */
        @path
        @segment("apis")
        @key
        @pattern("^[^*#&+:<>?]+$")
        @minLength(1)
        @maxLength(256)
        apiId: string,
      },
      {
        /** Schema id identifier. Must be unique in the current API Management service instance. */
        @path
        @segment("schemas")
        @key
        @minLength(1)
        @maxLength(80)
        schemaId: string,
      }
    > {}

@armResourceOperations
interface WorkspaceApiSchema {
  /**
   * Get the schema configuration at the API level.
   */
  get is WorkspaceApiSchemaOps.Read<
    SchemaContract,
    Response = ArmResponse<SchemaContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Gets the entity state (Etag) version of the schema specified by its identifier.
   */
  getEntityTag is WorkspaceApiSchemaOps.CheckExistence<
    SchemaContract,
    Response = OkResponse & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Creates or updates schema configuration for the API.
   */
  createOrUpdate is WorkspaceApiSchemaOps.CreateOrUpdateAsync<
    SchemaContract,
    Parameters = {
      /**
       * ETag of the Entity. Not required when creating an entity, but required when updating an entity.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`?: string;
    },
    Response = (ArmResponse<SchemaContract> &
      ArmCombinedLroHeaders<FinalResult = SchemaContract> & {
        /**
         * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
         */
        @header("ETag")
        etag: string;
      }) | (ArmResourceCreatedResponse<SchemaContract> &
      ArmCombinedLroHeaders<FinalResult = SchemaContract> & {
        /**
         * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
         */
        @header("ETag")
        etag: string;
      })
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
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
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
      @minValue(0)
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
