import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ApiManagementServiceResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ApiManagement;
/**
 * Global Schema Contract details.
 */
@parentResource(ApiManagementServiceResource)
model GlobalSchemaContract
  is Azure.ResourceManager.ProxyResource<GlobalSchemaContractProperties> {
  ...ResourceNameParameter<
    Resource = GlobalSchemaContract,
    KeyName = "schemaId",
    SegmentName = "schemas",
    NamePattern = ""
  >;
}

@armResourceOperations
interface GlobalSchemaContractOps
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
interface GlobalSchemaContracts {
  /**
   * Gets the details of the Schema specified by its identifier.
   */
  get is GlobalSchemaContractOps.Read<
    GlobalSchemaContract,
    Response = ArmResponse<GlobalSchemaContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Gets the entity state (Etag) version of the Schema specified by its identifier.
   */
  getEntityTag is GlobalSchemaContractOps.CheckExistence<
    GlobalSchemaContract,
    Response = OkResponse & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Creates new or updates existing specified Schema of the API Management service instance.
   */
  createOrUpdate is GlobalSchemaContractOps.CreateOrUpdateAsync<
    GlobalSchemaContract,
    Parameters = {
      /**
       * ETag of the Entity. Not required when creating an entity, but required when updating an entity.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`?: string;
    },
    Response = (ArmResponse<GlobalSchemaContract> &
      ArmCombinedLroHeaders<FinalResult = GlobalSchemaContract> & {
        /**
         * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
         */
        @header("ETag")
        etag: string;
      }) | (ArmResourceCreatedResponse<
      GlobalSchemaContract,
      LroHeaders = ArmCombinedLroHeaders<FinalResult = GlobalSchemaContract>
    > & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    })
  >;

  /**
   * Deletes specific Schema.
   */
  delete is GlobalSchemaContractOps.DeleteSync<
    GlobalSchemaContract,
    Parameters = {
      /**
       * ETag of the Entity. ETag should match the current entity state from the header response of the GET request or it should be * for unconditional update.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`: string;
    }
  >;

  /**
   * Lists a collection of schemas registered with service instance.
   */
  listByService is GlobalSchemaContractOps.List<
    GlobalSchemaContract,
    Parameters = {
      /**
       * |     Field     |     Usage     |     Supported operators     |     Supported functions     |</br>|-------------|-------------|-------------|-------------|</br>| name | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>
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
    Response = ArmResponse<GlobalSchemaCollection>
  >;
}
@armResourceOperations
interface WorkspaceGlobalSchemaOps
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
interface WorkspaceGlobalSchema {
  /**
   * Gets the details of the Schema specified by its identifier.
   */
  get is WorkspaceGlobalSchemaOps.Read<
    GlobalSchemaContract,
    Response = ArmResponse<GlobalSchemaContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Gets the entity state (Etag) version of the Schema specified by its identifier.
   */
  getEntityTag is WorkspaceGlobalSchemaOps.CheckExistence<
    GlobalSchemaContract,
    Response = OkResponse & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Creates new or updates existing specified Schema of the workspace in an API Management service instance.
   */
  createOrUpdate is WorkspaceGlobalSchemaOps.CreateOrUpdateAsync<
    GlobalSchemaContract,
    Parameters = {
      /**
       * ETag of the Entity. Not required when creating an entity, but required when updating an entity.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`?: string;
    },
    Response = (ArmResponse<GlobalSchemaContract> &
      ArmCombinedLroHeaders<FinalResult = GlobalSchemaContract> & {
        /**
         * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
         */
        @header("ETag")
        etag: string;
      }) | (ArmResourceCreatedResponse<
      GlobalSchemaContract,
      LroHeaders = ArmCombinedLroHeaders<FinalResult = GlobalSchemaContract>
    > & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    })
  >;

  /**
   * Deletes specific Schema.
   */
  delete is WorkspaceGlobalSchemaOps.DeleteSync<
    GlobalSchemaContract,
    Parameters = {
      /**
       * ETag of the Entity. ETag should match the current entity state from the header response of the GET request or it should be * for unconditional update.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`: string;
    }
  >;

  /**
   * Lists a collection of schemas registered with workspace in a service instance.
   */
  listByService is WorkspaceGlobalSchemaOps.List<
    GlobalSchemaContract,
    Parameters = {
      /**
       * |     Field     |     Usage     |     Supported operators     |     Supported functions     |</br>|-------------|-------------|-------------|-------------|</br>| name | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>
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
    Response = ArmResponse<GlobalSchemaCollection>
  >;
}

@@maxLength(GlobalSchemaContract.name, 80);
@@minLength(GlobalSchemaContract.name, 1);
@@doc(GlobalSchemaContract.name,
  "Schema id identifier. Must be unique in the current API Management service instance."
);
@@doc(GlobalSchemaContract.properties, "Properties of the Global Schema.");
@@doc(GlobalSchemaContracts.createOrUpdate::parameters.resource,
  "Create or update parameters."
);
@@doc(WorkspaceGlobalSchema.createOrUpdate::parameters.resource,
  "Create or update parameters."
);
