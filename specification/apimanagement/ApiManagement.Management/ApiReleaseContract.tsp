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
 * ApiRelease details.
 */
@parentResource(ApiContract)
model ApiReleaseContract
  is Azure.ResourceManager.ProxyResource<ApiReleaseContractProperties> {
  ...ResourceNameParameter<
    Resource = ApiReleaseContract,
    KeyName = "releaseId",
    SegmentName = "releases",
    NamePattern = "^[^*#&+:<>?]+$"
  >;
}

@armResourceOperations
interface ApiReleaseContractOps
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

        /** API identifier. Must be unique in the current API Management service instance. */
        @path
        @segment("apis")
        @key
        apiId: string,
      },
      {
        /** Release identifier within an API. Must be unique in the current API Management service instance. */
        @path
        @segment("releases")
        @key
        @pattern("^[^*#&+:<>?]+$")
        releaseId: string,
      }
    > {}

@armResourceOperations
interface ApiReleaseContracts {
  /**
   * Returns the details of an API release.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ApiRelease_Get")
  get is ApiReleaseContractOps.Read<ApiReleaseContract>;

  /**
   * Returns the etag of an API release.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ApiRelease_GetEntityTag")
  getEntityTag is ApiReleaseContractOps.CheckExistence<ApiReleaseContract>;

  /**
   * Creates a new Release for the API.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ApiRelease_CreateOrUpdate")
  createOrUpdate is ApiReleaseContractOps.CreateOrUpdateSync<
    ApiReleaseContract,
    Parameters = {
      /**
       * ETag of the Entity. Not required when creating an entity, but required when updating an entity.
       */
      @header
      `If-Match`?: string;
    }
  >;

  /**
   * Updates the details of the release of the API specified by its identifier.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ApiRelease_Update")
  @patch(#{ implicitOptionality: false })
  update is ApiReleaseContractOps.CustomPatchSync<
    ApiReleaseContract,
    PatchModel = ApiReleaseContract,
    Parameters = {
      /**
       * ETag of the Entity. ETag should match the current entity state from the header response of the GET request or it should be * for unconditional update.
       */
      @header
      `If-Match`: string;
    }
  >;

  /**
   * Deletes the specified release in the API.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ApiRelease_Delete")
  delete is ApiReleaseContractOps.DeleteSync<
    ApiReleaseContract,
    Parameters = {
      /**
       * ETag of the Entity. ETag should match the current entity state from the header response of the GET request or it should be * for unconditional update.
       */
      @header
      `If-Match`: string;
    }
  >;

  /**
   * Lists all releases of an API. An API release is created when making an API Revision current. Releases are also used to rollback to previous revisions. Results will be paged and can be constrained by the $top and $skip parameters.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ApiRelease_ListByService")
  listByService is ApiReleaseContractOps.List<
    ApiReleaseContract,
    Parameters = {
      /**
       * |     Field     |     Usage     |     Supported operators     |     Supported functions     |</br>|-------------|-------------|-------------|-------------|</br>| notes | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>
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
    Response = ArmResponse<ApiReleaseCollection>
  >;
}
@armResourceOperations
interface WorkspaceApiReleaseOps
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

        /** API identifier. Must be unique in the current API Management service instance. */
        @path
        @segment("apis")
        @key
        apiId: string,
      },
      {
        /** Release identifier within an API. Must be unique in the current API Management service instance. */
        @path
        @segment("releases")
        @key
        @pattern("^[^*#&+:<>?]+$")
        releaseId: string,
      }
    > {}

@armResourceOperations
interface WorkspaceApiRelease {
  /**
   * Returns the details of an API release.
   */
  get is WorkspaceApiReleaseOps.Read<ApiReleaseContract>;

  /**
   * Returns the etag of an API release.
   */
  getEntityTag is WorkspaceApiReleaseOps.CheckExistence<ApiReleaseContract>;

  /**
   * Creates a new Release for the API.
   */
  createOrUpdate is WorkspaceApiReleaseOps.CreateOrUpdateSync<
    ApiReleaseContract,
    Parameters = {
      /**
       * ETag of the Entity. Not required when creating an entity, but required when updating an entity.
       */
      @header
      `If-Match`?: string;
    }
  >;

  /**
   * Updates the details of the release of the API specified by its identifier.
   */
  @patch(#{ implicitOptionality: false })
  update is WorkspaceApiReleaseOps.CustomPatchSync<
    ApiReleaseContract,
    PatchModel = ApiReleaseContract,
    Parameters = {
      /**
       * ETag of the Entity. ETag should match the current entity state from the header response of the GET request or it should be * for unconditional update.
       */
      @header
      `If-Match`: string;
    }
  >;

  /**
   * Deletes the specified release in the API.
   */
  delete is WorkspaceApiReleaseOps.DeleteSync<
    ApiReleaseContract,
    Parameters = {
      /**
       * ETag of the Entity. ETag should match the current entity state from the header response of the GET request or it should be * for unconditional update.
       */
      @header
      `If-Match`: string;
    }
  >;

  /**
   * Lists all releases of an API. An API release is created when making an API Revision current. Releases are also used to rollback to previous revisions. Results will be paged and can be constrained by the $top and $skip parameters.
   */
  listByService is WorkspaceApiReleaseOps.List<
    ApiReleaseContract,
    Parameters = {
      /**
       * |     Field     |     Usage     |     Supported operators     |     Supported functions     |</br>|-------------|-------------|-------------|-------------|</br>| notes | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>
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
    Response = ArmResponse<ApiReleaseCollection>
  >;
}

@@maxLength(ApiReleaseContract.name, 80);
@@minLength(ApiReleaseContract.name, 1);
@@doc(ApiReleaseContract.name,
  "Release identifier within an API. Must be unique in the current API Management service instance."
);
@@doc(ApiReleaseContract.properties, "ApiRelease entity contract properties.");
@@doc(ApiReleaseContracts.createOrUpdate::parameters.resource,
  "Create parameters."
);
@@doc(ApiReleaseContracts.update::parameters.properties,
  "API Release Update parameters."
);
@@doc(WorkspaceApiRelease.createOrUpdate::parameters.resource,
  "Create parameters."
);
@@doc(WorkspaceApiRelease.update::parameters.properties,
  "API Release Update parameters."
);
