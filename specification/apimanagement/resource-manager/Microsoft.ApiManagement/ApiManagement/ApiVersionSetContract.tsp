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
        @minLength(1)
        @maxLength(50)
        serviceName: string,
      },
      {
        /** Api Version Set identifier. Must be unique in the current API Management service instance. */
        @path
        @segment("apiVersionSets")
        @key
        @pattern("^[^*#&+:<>?]+$")
        @minLength(1)
        @maxLength(80)
        versionSetId: string,
      }
    > {}

@armResourceOperations
interface ApiVersionSetContracts {
  /**
   * Gets the details of the Api Version Set specified by its identifier.
   */
  get is ApiVersionSetContractOps.Read<
    ApiVersionSetContract,
    Response = ArmResponse<ApiVersionSetContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Gets the entity state (Etag) version of the Api Version Set specified by its identifier.
   */
  getEntityTag is ApiVersionSetContractOps.CheckExistence<
    ApiVersionSetContract,
    Response = OkResponse & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Creates or Updates a Api Version Set.
   */
  createOrUpdate is ApiVersionSetContractOps.CreateOrUpdateSync<
    ApiVersionSetContract,
    Parameters = {
      /**
       * ETag of the Entity. Not required when creating an entity, but required when updating an entity.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`?: string;
    },
    Response = (ArmResponse<ApiVersionSetContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }) | (ArmResourceCreatedSyncResponse<ApiVersionSetContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    })
  >;

  /**
   * Updates the details of the Api VersionSet specified by its identifier.
   */
  @patch(#{ implicitOptionality: false })
  update is ApiVersionSetContractOps.CustomPatchSync<
    ApiVersionSetContract,
    PatchModel = ApiVersionSetUpdateParameters,
    Parameters = {
      /**
       * ETag of the Entity. ETag should match the current entity state from the header response of the GET request or it should be * for unconditional update.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`: string;
    },
    Response = ArmResponse<ApiVersionSetContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Deletes specific Api Version Set.
   */
  delete is ApiVersionSetContractOps.DeleteSync<
    ApiVersionSetContract,
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
   * Lists a collection of API Version Sets in the specified service instance.
   */
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
      @minValue(0)
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
        /** Api Version Set identifier. Must be unique in the current API Management service instance. */
        @path
        @segment("apiVersionSets")
        @key
        @pattern("^[^*#&+:<>?]+$")
        @minLength(1)
        @maxLength(80)
        versionSetId: string,
      }
    > {}

@armResourceOperations
interface WorkspaceApiVersionSet {
  /**
   * Gets the details of the Api Version Set specified by its identifier.
   */
  get is WorkspaceApiVersionSetOps.Read<
    ApiVersionSetContract,
    Response = ArmResponse<ApiVersionSetContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Gets the entity state (Etag) version of the Api Version Set specified by its identifier.
   */
  getEntityTag is WorkspaceApiVersionSetOps.CheckExistence<
    ApiVersionSetContract,
    Response = OkResponse & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Creates or Updates a Api Version Set.
   */
  createOrUpdate is WorkspaceApiVersionSetOps.CreateOrUpdateSync<
    ApiVersionSetContract,
    Parameters = {
      /**
       * ETag of the Entity. Not required when creating an entity, but required when updating an entity.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`?: string;
    },
    Response = (ArmResponse<ApiVersionSetContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }) | (ArmResourceCreatedSyncResponse<ApiVersionSetContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    })
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
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`: string;
    },
    Response = ArmResponse<ApiVersionSetContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
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
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
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
      @minValue(0)
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
