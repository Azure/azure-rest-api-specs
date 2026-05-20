import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ApiManagementServiceResource.tsp";

using Azure.ClientGenerator.Core;
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
        @minLength(1)
        @maxLength(50)
        serviceName: string,
      },
      {
        /** API revision identifier. Must be unique in the current API Management service instance. Non-current revision has ;rev=n as a suffix where n is the revision number. */
        @path
        @segment("apis")
        @key
        @minLength(1)
        @maxLength(80)
        @pattern("^[^*#&+:<>?]+$")
        apiId: string,
      }
    > {}

@armResourceOperations
interface ApiContracts {
  /**
   * Gets the details of the API specified by its identifier.
   */
  get is ApiContractOps.Read<
    ApiContract,
    Response = ArmResponse<ApiContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Gets the entity state (Etag) version of the API specified by its identifier.
   */
  getEntityTag is ApiContractOps.CheckExistence<
    ApiContract,
    Response = OkResponse & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Creates new or updates existing specified API of the API Management service instance.
   */
  createOrUpdate is ApiContractOps.CreateOrUpdateAsync<
    ApiContract,
    Request = ApiCreateOrUpdateParameter,
    Parameters = {
      /**
       * ETag of the Entity. Not required when creating an entity, but required when updating an entity.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`?: string;
    },
    Response = (ArmResponse<ApiContract> &
      ArmCombinedLroHeaders<FinalResult = ApiContract> & {
        /**
         * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
         */
        @header("ETag")
        etag: string;
      }) | (ArmResourceCreatedResponse<
      ApiContract,
      LroHeaders = ArmCombinedLroHeaders<FinalResult = ApiContract>
    > & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    })
  >;

  /**
   * Updates the specified API of the API Management service instance.
   */
  @patch(#{ implicitOptionality: false })
  update is ApiContractOps.CustomPatchSync<
    ApiContract,
    PatchModel = ApiUpdateContract,
    Parameters = {
      /**
       * ETag of the Entity. ETag should match the current entity state from the header response of the GET request or it should be * for unconditional update.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`: string;
    },
    Response = ArmResponse<ApiContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Deletes the specified API of the API Management service instance.
   */
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
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`: string;
    },
    Response = ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = void>> | ArmNoContentResponse
  >;

  /**
   * Lists all APIs of the API Management service instance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/azure/api-management/api-management-howto-create-apis")
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
      @minValue(0)
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
      @apiVersion(false)
      @query("expandApiVersionSet")
      expandApiVersionSet?: boolean;
    },
    Response = ArmResponse<ApiCollection>
  >;

  /**
   * Lists all revisions of an API.
   */
  @get
  @action("revisions")
  @list
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
      @minValue(0)
      @query("$skip")
      $skip?: int32;
    }
  >;

  /**
   * Lists all Products, which the API is part of.
   */
  @get
  @action("products")
  @list
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
      @minValue(0)
      @query("$skip")
      $skip?: int32;
    }
  >;

  /**
   * Lists a collection of operations associated with tags.
   */
  @get
  @action("operationsByTags")
  @list
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
      @minValue(0)
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
        /** API revision identifier. Must be unique in the current API Management service instance. Non-current revision has ;rev=n as a suffix where n is the revision number. */
        @path
        @segment("apis")
        @key
        @pattern("^[^*#&+:<>?]+$")
        @minLength(1)
        @maxLength(256)
        apiId: string,
      }
    > {}

@armResourceOperations
interface WorkspaceApi {
  /**
   * Gets the details of the API specified by its identifier.
   */
  get is WorkspaceApiOps.Read<
    ApiContract,
    Response = ArmResponse<ApiContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Gets the entity state (Etag) version of the API specified by its identifier.
   */
  getEntityTag is WorkspaceApiOps.CheckExistence<
    ApiContract,
    Response = OkResponse & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Creates new or updates existing specified API of the workspace in an API Management service instance.
   */
  createOrUpdate is WorkspaceApiOps.CreateOrUpdateAsync<
    ApiContract,
    Request = ApiCreateOrUpdateParameter,
    Parameters = {
      /**
       * ETag of the Entity. Not required when creating an entity, but required when updating an entity.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`?: string;
    },
    Response = (ArmResponse<ApiContract> &
      ArmCombinedLroHeaders<FinalResult = ApiContract> & {
        /**
         * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
         */
        @header("ETag")
        etag: string;
      }) | (ArmResourceCreatedResponse<
      ApiContract,
      LroHeaders = ArmCombinedLroHeaders<FinalResult = ApiContract>
    > & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    })
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
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`: string;
    },
    Response = ArmResponse<ApiContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
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
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`: string;
    }
  >;

  /**
   * Lists all APIs of the workspace in an API Management service instance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/azure/api-management/api-management-howto-create-apis")
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
      @minValue(0)
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
      @apiVersion(false)
      @query("expandApiVersionSet")
      expandApiVersionSet?: boolean;
    },
    Response = ArmResponse<ApiCollection>
  >;

  /**
   * Lists all revisions of an API.
   */
  @get
  @action("revisions")
  @list
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
      @minValue(0)
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
