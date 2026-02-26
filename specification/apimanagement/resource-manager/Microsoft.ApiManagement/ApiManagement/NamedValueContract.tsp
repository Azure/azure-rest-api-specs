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
 * NamedValue details.
 */
@parentResource(ApiManagementServiceResource)
model NamedValueContract
  is Azure.ResourceManager.ProxyResource<NamedValueContractProperties> {
  ...ResourceNameParameter<
    Resource = NamedValueContract,
    KeyName = "namedValueId",
    SegmentName = "namedValues",
    NamePattern = "^[^*#&+:<>?]+$"
  >;
}

@armResourceOperations
interface NamedValueContractOps
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
        /** Identifier of the NamedValue. */
        @path
        @segment("namedValues")
        @key
        @pattern("^[^*#&+:<>?]+$")
        @maxLength(256)
        namedValueId: string,
      }
    > {}

@armResourceOperations
interface NamedValueContracts {
  /**
   * Gets the details of the named value specified by its identifier.
   */
  get is NamedValueContractOps.Read<
    NamedValueContract,
    Response = ArmResponse<NamedValueContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag?: string;
    }
  >;

  /**
   * Gets the entity state (Etag) version of the named value specified by its identifier.
   */
  getEntityTag is NamedValueContractOps.CheckExistence<
    NamedValueContract,
    Response = OkResponse & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag?: string;
    }
  >;

  /**
   * Creates or updates named value.
   */
  createOrUpdate is NamedValueContractOps.CreateOrUpdateAsync<
    NamedValueContract,
    Request = NamedValueCreateContract,
    Parameters = {
      /**
       * ETag of the Entity. Not required when creating an entity, but required when updating an entity.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`?: string;
    },
    Response = (ArmResponse<NamedValueContract> &
      ArmCombinedLroHeaders<FinalResult = NamedValueContract> & {
        /**
         * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
         */
        @header("ETag")
        etag: string;
      }) | (ArmResourceCreatedResponse<
      NamedValueContract,
      LroHeaders = ArmCombinedLroHeaders<FinalResult = NamedValueContract>
    > & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    })
  >;

  /**
   * Updates the specific named value.
   */
  @patch(#{ implicitOptionality: false })
  update is NamedValueContractOps.CustomPatchAsync<
    NamedValueContract,
    PatchModel = NamedValueUpdateParameters,
    Parameters = {
      /**
       * ETag of the Entity. ETag should match the current entity state from the header response of the GET request or it should be * for unconditional update.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`: string;
    },
    Response = (ArmResponse<NamedValueContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }) | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = NamedValueContract>>
  >;

  /**
   * Deletes specific named value from the API Management service instance.
   */
  delete is NamedValueContractOps.DeleteSync<
    NamedValueContract,
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
   * Lists a collection of named values defined within a service instance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/azure/api-management/api-management-howto-properties")
  listByService is NamedValueContractOps.List<
    NamedValueContract,
    Parameters = {
      /**
       * |     Field     |     Usage     |     Supported operators     |     Supported functions     |</br>|-------------|-------------|-------------|-------------|</br>| tags | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith, any, all |</br>| displayName | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>
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
       * When set to true, the response contains only named value entities which failed refresh.
       */
      @query("isKeyVaultRefreshFailed")
      isKeyVaultRefreshFailed?: boolean;
    },
    Response = ArmResponse<NamedValueCollection>
  >;

  /**
   * Gets the secret of the named value specified by its identifier.
   */
  listValue is NamedValueContractOps.ActionSync<
    NamedValueContract,
    void,
    Response = ArmResponse<NamedValueSecretContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Refresh the secret of the named value specified by its identifier.
   */
  refreshSecret is NamedValueContractOps.ActionAsync<
    NamedValueContract,
    Request = void,
    Result = void,
    Response = (ArmResponse<NamedValueContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }) | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = NamedValueContract>>
  >;
}
@armResourceOperations
interface WorkspaceNamedValueOps
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
        /** Identifier of the NamedValue. */
        @path
        @segment("namedValues")
        @key
        @pattern("^[^*#&+:<>?]+$")
        @maxLength(256)
        namedValueId: string,
      }
    > {}

@armResourceOperations
interface WorkspaceNamedValue {
  /**
   * Gets the details of the named value specified by its identifier.
   */
  get is WorkspaceNamedValueOps.Read<
    NamedValueContract,
    Response = ArmResponse<NamedValueContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Gets the entity state (Etag) version of the named value specified by its identifier.
   */
  getEntityTag is WorkspaceNamedValueOps.CheckExistence<
    NamedValueContract,
    Response = OkResponse & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Creates or updates named value.
   */
  createOrUpdate is WorkspaceNamedValueOps.CreateOrUpdateAsync<
    NamedValueContract,
    Request = NamedValueCreateContract,
    Parameters = {
      /**
       * ETag of the Entity. Not required when creating an entity, but required when updating an entity.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`?: string;
    },
    Response = (ArmResponse<NamedValueContract> &
      ArmCombinedLroHeaders<FinalResult = NamedValueContract> & {
        /**
         * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
         */
        @header("ETag")
        etag: string;
      }) | (ArmResourceCreatedResponse<NamedValueContract> &
      ArmCombinedLroHeaders<FinalResult = NamedValueContract> & {
        /**
         * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
         */
        @header("ETag")
        etag: string;
      })
  >;

  /**
   * Updates the specific named value.
   */
  @patch(#{ implicitOptionality: false })
  update is WorkspaceNamedValueOps.CustomPatchAsync<
    NamedValueContract,
    PatchModel = NamedValueUpdateParameters,
    Parameters = {
      /**
       * ETag of the Entity. ETag should match the current entity state from the header response of the GET request or it should be * for unconditional update.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`: string;
    },
    Response = (ArmResponse<NamedValueContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }) | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = NamedValueContract>>
  >;

  /**
   * Deletes specific named value from the workspace in an API Management service instance.
   */
  delete is WorkspaceNamedValueOps.DeleteSync<
    NamedValueContract,
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
   * Lists a collection of named values defined within a workspace in a service instance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/azure/api-management/api-management-howto-properties")
  listByService is WorkspaceNamedValueOps.List<
    NamedValueContract,
    Parameters = {
      /**
       * |     Field     |     Usage     |     Supported operators     |     Supported functions     |</br>|-------------|-------------|-------------|-------------|</br>| tags | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith, any, all |</br>| displayName | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>
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
       * Query parameter to fetch named value entities based on refresh status.
       */
      @query("isKeyVaultRefreshFailed")
      isKeyVaultRefreshFailed?: KeyVaultRefreshState;
    },
    Response = ArmResponse<NamedValueCollection>
  >;

  /**
   * Gets the secret of the named value specified by its identifier.
   */
  listValue is WorkspaceNamedValueOps.ActionSync<
    NamedValueContract,
    void,
    ArmResponse<NamedValueSecretContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Refresh the secret of the named value specified by its identifier.
   */
  refreshSecret is WorkspaceNamedValueOps.ActionAsync<
    NamedValueContract,
    Request = void,
    Result = void,
    Response = (ArmResponse<NamedValueContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }) | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = NamedValueContract>>
  >;
}

@@maxLength(NamedValueContract.name, 256);
@@doc(NamedValueContract.name, "Identifier of the NamedValue.");
@@doc(NamedValueContract.properties, "NamedValue entity contract properties.");
@@doc(NamedValueContracts.createOrUpdate::parameters.resource,
  "Create parameters."
);
@@doc(NamedValueContracts.update::parameters.properties, "Update parameters.");
@@doc(WorkspaceNamedValue.createOrUpdate::parameters.resource,
  "Create parameters."
);
@@doc(WorkspaceNamedValue.update::parameters.properties, "Update parameters.");
