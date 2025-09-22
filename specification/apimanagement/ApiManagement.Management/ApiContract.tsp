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
 * API details.
 */
@parentResource(ApiManagementServiceResource)
model ApiContract
  is Azure.ResourceManager.ProxyResource<ApiContractProperties> {
  ...ResourceNameParameter<
    Resource = ApiContract,
    KeyName = "apiId",
    SegmentName = "apis",
    NamePattern = "^[^*#&+:<>?]+$"
  >;
}

@armResourceOperations
interface ApiContractOps
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
        /** API revision identifier. Must be unique in the current API Management service instance. Non-current revision has ;rev=n as a suffix where n is the revision number. */
        @path
        @segment("apis")
        @key
        @pattern("^[^*#&+:<>?]+$")
        apiId: string,
      }
    > {}

@armResourceOperations
interface ApiContracts {
  /**
   * Gets the details of the API specified by its identifier.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Api_Get")
  get is ApiContractOps.Read<ApiContract>;

  /**
   * Gets the entity state (Etag) version of the API specified by its identifier.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Api_GetEntityTag")
  getEntityTag is ApiContractOps.CheckExistence<ApiContract>;

  /**
   * Creates new or updates existing specified API of the API Management service instance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Api_CreateOrUpdate")
  createOrUpdate is ApiContractOps.CreateOrUpdateAsync<
    ApiContract,
    Parameters = {
      /**
       * ETag of the Entity. Not required when creating an entity, but required when updating an entity.
       */
      @header
      `If-Match`?: string;
    },
    LroHeaders = ArmLroLocationHeader<FinalResult = ApiContract> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Updates the specified API of the API Management service instance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Api_Update")
  @patch(#{ implicitOptionality: false })
  update is ApiContractOps.CustomPatchSync<
    ApiContract,
    PatchModel = ApiUpdateContract,
    Parameters = {
      /**
       * ETag of the Entity. ETag should match the current entity state from the header response of the GET request or it should be * for unconditional update.
       */
      @header
      `If-Match`: string;
    }
  >;

  /**
   * Deletes the specified API of the API Management service instance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Api_Delete")
  delete is ApiContractOps.DeleteWithoutOkAsync<
    ApiContract,
    Parameters = {
      /**
       * Delete all revisions of the Api.
       */
      @query("deleteRevisions")
      deleteRevisions?: boolean;

      /**
       * ETag of the Entity. ETag should match the current entity state from the header response of the GET request or it should be * for unconditional update.
       */
      @header
      `If-Match`: string;
    }
  >;

  /**
   * Lists all APIs of the API Management service instance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Api_ListByService")
  listByService is ApiContractOps.List<
    ApiContract,
    Parameters = {
      /**
       * |     Field     |     Usage     |     Supported operators     |     Supported functions     |</br>|-------------|-------------|-------------|-------------|</br>| name | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| displayName | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| description | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| serviceUrl | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| path | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| isCurrent | filter | eq, ne |  |</br>
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

      /**
       * Include tags in the response.
       */
      @query("tags")
      tags?: string;

      /**
       * Include full ApiVersionSet resource in response
       */
      @query("expandApiVersionSet")
      expandApiVersionSet?: boolean;
    },
    Response = ArmResponse<ApiCollection>
  >;

  /**
   * Lists all revisions of an API.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ApiRevision_ListByService")
  @get
  @action("revisions")
  apiRevisionListByService is ApiContractOps.ActionSync<
    ApiContract,
    void,
    ArmResponse<ApiRevisionCollection>,
    Parameters = {
      /**
       * |     Field     |     Usage     |     Supported operators     |     Supported functions     |</br>|-------------|-------------|-------------|-------------|</br>| apiRevision | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>
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
    }
  >;

  /**
   * Lists all Products, which the API is part of.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ApiProduct_ListByApis")
  @get
  @action("products")
  listByApis is ApiContractOps.ActionSync<
    ApiContract,
    void,
    ArmResponse<ProductCollection>,
    Parameters = {
      /**
       * |     Field     |     Usage     |     Supported operators     |     Supported functions     |</br>|-------------|-------------|-------------|-------------|</br>| displayName | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>
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
    }
  >;

  /**
   * Lists a collection of operations associated with tags.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Operation_ListByTags")
  @get
  @action("operationsByTags")
  listByTags is ApiContractOps.ActionSync<
    ApiContract,
    void,
    ArmResponse<TagResourceCollection>,
    Parameters = {
      /**
       * |     Field     |     Usage     |     Supported operators     |     Supported functions     |</br>|-------------|-------------|-------------|-------------|</br>| name | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| displayName | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| apiName | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| description | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| method | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| urlTemplate | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>
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

      /**
       * Include not tagged Operations.
       */
      @query("includeNotTaggedOperations")
      includeNotTaggedOperations?: boolean;
    }
  >;
}
@armResourceOperations
interface WorkspaceApiOps
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
        /** API revision identifier. Must be unique in the current API Management service instance. Non-current revision has ;rev=n as a suffix where n is the revision number. */
        @path
        @segment("apis")
        @key
        @pattern("^[^*#&+:<>?]+$")
        apiId: string,
      }
    > {}

@armResourceOperations
interface WorkspaceApi {
  /**
   * Gets the details of the API specified by its identifier.
   */
  get is WorkspaceApiOps.Read<ApiContract>;

  /**
   * Gets the entity state (Etag) version of the API specified by its identifier.
   */
  getEntityTag is WorkspaceApiOps.CheckExistence<ApiContract>;

  /**
   * Creates new or updates existing specified API of the workspace in an API Management service instance.
   */
  createOrUpdate is WorkspaceApiOps.CreateOrUpdateAsync<
    ApiContract,
    Parameters = {
      /**
       * ETag of the Entity. Not required when creating an entity, but required when updating an entity.
       */
      @header
      `If-Match`?: string;
    },
    LroHeaders = ArmLroLocationHeader<FinalResult = ApiContract> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Updates the specified API of the workspace in an API Management service instance.
   */
  @patch(#{ implicitOptionality: false })
  update is WorkspaceApiOps.CustomPatchSync<
    ApiContract,
    PatchModel = ApiUpdateContract,
    Parameters = {
      /**
       * ETag of the Entity. ETag should match the current entity state from the header response of the GET request or it should be * for unconditional update.
       */
      @header
      `If-Match`: string;
    }
  >;

  /**
   * Deletes the specified API of the workspace in an API Management service instance.
   */
  delete is WorkspaceApiOps.DeleteSync<
    ApiContract,
    Parameters = {
      /**
       * Delete all revisions of the Api.
       */
      @query("deleteRevisions")
      deleteRevisions?: boolean;

      /**
       * ETag of the Entity. ETag should match the current entity state from the header response of the GET request or it should be * for unconditional update.
       */
      @header
      `If-Match`: string;
    }
  >;

  /**
   * Lists all APIs of the workspace in an API Management service instance.
   */
  listByService is WorkspaceApiOps.List<
    ApiContract,
    Parameters = {
      /**
       * |     Field     |     Usage     |     Supported operators     |     Supported functions     |</br>|-------------|-------------|-------------|-------------|</br>| name | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| displayName | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| description | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| serviceUrl | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| path | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| isCurrent | filter | eq, ne |  |</br>
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

      /**
       * Include tags in the response.
       */
      @query("tags")
      tags?: string;

      /**
       * Include full ApiVersionSet resource in response
       */
      @query("expandApiVersionSet")
      expandApiVersionSet?: boolean;
    },
    Response = ArmResponse<ApiCollection>
  >;

  /**
   * Lists all revisions of an API.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WorkspaceApiRevision_ListByService")
  @get
  @action("revisions")
  workspaceApiRevisionListByService is WorkspaceApiOps.ActionSync<
    ApiContract,
    void,
    ArmResponse<ApiRevisionCollection>,
    Parameters = {
      /**
       * |     Field     |     Usage     |     Supported operators     |     Supported functions     |</br>|-------------|-------------|-------------|-------------|</br>| apiRevision | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>
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
    }
  >;
}

@@maxLength(ApiContract.name, 256);
@@minLength(ApiContract.name, 1);
@@doc(ApiContract.name,
  "API revision identifier. Must be unique in the current API Management service instance. Non-current revision has ;rev=n as a suffix where n is the revision number."
);
@@doc(ApiContract.properties, "API entity contract properties.");
@@doc(ApiContracts.createOrUpdate::parameters.resource,
  "Create or update parameters."
);
@@doc(ApiContracts.update::parameters.properties,
  "API Update Contract parameters."
);
@@doc(WorkspaceApi.createOrUpdate::parameters.resource,
  "Create or update parameters."
);
@@doc(WorkspaceApi.update::parameters.properties,
  "API Update Contract parameters."
);
