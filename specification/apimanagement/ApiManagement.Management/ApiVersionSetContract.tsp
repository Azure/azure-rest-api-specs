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
 * API Version Set Contract details.
 */
@parentResource(ApiManagementServiceResource)
model ApiVersionSetContract
  is Azure.ResourceManager.ProxyResource<ApiVersionSetContractProperties> {
  ...ResourceNameParameter<
    Resource = ApiVersionSetContract,
    KeyName = "versionSetId",
    SegmentName = "apiVersionSets",
    NamePattern = "^[^*#&+:<>?]+$"
  >;
}

@armResourceOperations
interface ApiVersionSetContractOps
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
      },
      {
        /** Api Version Set identifier. Must be unique in the current API Management service instance. */
        @path
        @segment("apiVersionSets")
        @key
        @pattern("^[^*#&+:<>?]+$")
        versionSetId: string,
      }
    > {}

@armResourceOperations
interface ApiVersionSetContracts {
  /**
   * Gets the details of the Api Version Set specified by its identifier.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ApiVersionSet_Get")
  get is ApiVersionSetContractOps.Read<ApiVersionSetContract>;

  /**
   * Gets the entity state (Etag) version of the Api Version Set specified by its identifier.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ApiVersionSet_GetEntityTag")
  getEntityTag is ApiVersionSetContractOps.CheckExistence<ApiVersionSetContract>;

  /**
   * Creates or Updates a Api Version Set.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ApiVersionSet_CreateOrUpdate")
  createOrUpdate is ApiVersionSetContractOps.CreateOrUpdateSync<
    ApiVersionSetContract,
    Parameters = {
      /**
       * ETag of the Entity. Not required when creating an entity, but required when updating an entity.
       */
      @header
      `If-Match`?: string;
    }
  >;

  /**
   * Updates the details of the Api VersionSet specified by its identifier.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ApiVersionSet_Update")
  @patch(#{ implicitOptionality: false })
  update is ApiVersionSetContractOps.CustomPatchSync<
    ApiVersionSetContract,
    PatchModel = ApiVersionSetUpdateParameters,
    Parameters = {
      /**
       * ETag of the Entity. ETag should match the current entity state from the header response of the GET request or it should be * for unconditional update.
       */
      @header
      `If-Match`: string;
    }
  >;

  /**
   * Deletes specific Api Version Set.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ApiVersionSet_Delete")
  delete is ApiVersionSetContractOps.DeleteSync<
    ApiVersionSetContract,
    Parameters = {
      /**
       * ETag of the Entity. ETag should match the current entity state from the header response of the GET request or it should be * for unconditional update.
       */
      @header
      `If-Match`: string;
    }
  >;

  /**
   * Lists a collection of API Version Sets in the specified service instance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ApiVersionSet_ListByService")
  listByService is ApiVersionSetContractOps.List<
    ApiVersionSetContract,
    Parameters = {
      /**
       * |     Field     |     Usage     |     Supported operators     |     Supported functions     |</br>|-------------|-------------|-------------|-------------|</br>
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
    Response = ArmResponse<ApiVersionSetCollection>
  >;
}
@armResourceOperations
interface WorkspaceApiVersionSetOps
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
      },
      {
        /** Api Version Set identifier. Must be unique in the current API Management service instance. */
        @path
        @segment("apiVersionSets")
        @key
        @pattern("^[^*#&+:<>?]+$")
        versionSetId: string,
      }
    > {}

@armResourceOperations
interface WorkspaceApiVersionSet {
  /**
   * Gets the details of the Api Version Set specified by its identifier.
   */
  get is WorkspaceApiVersionSetOps.Read<ApiVersionSetContract>;

  /**
   * Gets the entity state (Etag) version of the Api Version Set specified by its identifier.
   */
  getEntityTag is WorkspaceApiVersionSetOps.CheckExistence<ApiVersionSetContract>;

  /**
   * Creates or Updates a Api Version Set.
   */
  createOrUpdate is WorkspaceApiVersionSetOps.CreateOrUpdateSync<
    ApiVersionSetContract,
    Parameters = {
      /**
       * ETag of the Entity. Not required when creating an entity, but required when updating an entity.
       */
      @header
      `If-Match`?: string;
    }
  >;

  /**
   * Updates the details of the Api VersionSet specified by its identifier.
   */
  @patch(#{ implicitOptionality: false })
  update is WorkspaceApiVersionSetOps.CustomPatchSync<
    ApiVersionSetContract,
    PatchModel = ApiVersionSetUpdateParameters,
    Parameters = {
      /**
       * ETag of the Entity. ETag should match the current entity state from the header response of the GET request or it should be * for unconditional update.
       */
      @header
      `If-Match`: string;
    }
  >;

  /**
   * Deletes specific Api Version Set.
   */
  delete is WorkspaceApiVersionSetOps.DeleteSync<
    ApiVersionSetContract,
    Parameters = {
      /**
       * ETag of the Entity. ETag should match the current entity state from the header response of the GET request or it should be * for unconditional update.
       */
      @header
      `If-Match`: string;
    }
  >;

  /**
   * Lists a collection of API Version Sets in the specified workspace with a service instance.
   */
  listByService is WorkspaceApiVersionSetOps.List<
    ApiVersionSetContract,
    Parameters = {
      /**
       * |     Field     |     Usage     |     Supported operators     |     Supported functions     |</br>|-------------|-------------|-------------|-------------|</br>
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
    Response = ArmResponse<ApiVersionSetCollection>
  >;
}

@@maxLength(ApiVersionSetContract.name, 80);
@@minLength(ApiVersionSetContract.name, 1);
@@doc(ApiVersionSetContract.name,
  "Api Version Set identifier. Must be unique in the current API Management service instance."
);
@@doc(ApiVersionSetContract.properties, "API VersionSet contract properties.");
@@doc(ApiVersionSetContracts.createOrUpdate::parameters.resource,
  "Create or update parameters."
);
@@doc(ApiVersionSetContracts.update::parameters.properties,
  "Update parameters."
);
@@doc(WorkspaceApiVersionSet.createOrUpdate::parameters.resource,
  "Create or update parameters."
);
@@doc(WorkspaceApiVersionSet.update::parameters.properties,
  "Update parameters."
);
