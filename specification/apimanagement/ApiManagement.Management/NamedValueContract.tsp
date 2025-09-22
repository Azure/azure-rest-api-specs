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
        serviceName: string,
      },
      {
        /** Identifier of the NamedValue. */
        @path
        @segment("namedValues")
        @key
        @pattern("^[^*#&+:<>?]+$")
        namedValueId: string,
      }
    > {}

@armResourceOperations
interface NamedValueContracts {
  /**
   * Gets the details of the named value specified by its identifier.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("NamedValue_Get")
  get is NamedValueContractOps.Read<NamedValueContract>;

  /**
   * Gets the entity state (Etag) version of the named value specified by its identifier.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("NamedValue_GetEntityTag")
  getEntityTag is NamedValueContractOps.CheckExistence<NamedValueContract>;

  /**
   * Creates or updates named value.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("NamedValue_CreateOrUpdate")
  createOrUpdate is NamedValueContractOps.CreateOrUpdateAsync<
    NamedValueContract,
    Parameters = {
      /**
       * ETag of the Entity. Not required when creating an entity, but required when updating an entity.
       */
      @header
      `If-Match`?: string;
    },
    LroHeaders = ArmLroLocationHeader<FinalResult = NamedValueContract> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Updates the specific named value.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("NamedValue_Update")
  @patch(#{ implicitOptionality: false })
  update is NamedValueContractOps.CustomPatchAsync<
    NamedValueContract,
    PatchModel = NamedValueUpdateParameters,
    Parameters = {
      /**
       * ETag of the Entity. ETag should match the current entity state from the header response of the GET request or it should be * for unconditional update.
       */
      @header
      `If-Match`: string;
    }
  >;

  /**
   * Deletes specific named value from the API Management service instance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("NamedValue_Delete")
  delete is NamedValueContractOps.DeleteSync<
    NamedValueContract,
    Parameters = {
      /**
       * ETag of the Entity. ETag should match the current entity state from the header response of the GET request or it should be * for unconditional update.
       */
      @header
      `If-Match`: string;
    }
  >;

  /**
   * Lists a collection of named values defined within a service instance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("NamedValue_ListByService")
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("NamedValue_ListValue")
  listValue is NamedValueContractOps.ActionSync<
    NamedValueContract,
    void,
    ArmResponse<NamedValueSecretContract>
  >;

  /**
   * Refresh the secret of the named value specified by its identifier.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("NamedValue_RefreshSecret")
  refreshSecret is NamedValueContractOps.ActionAsync<
    NamedValueContract,
    void,
    ArmResponse<NamedValueContract>
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
        serviceName: string,

        /** Workspace identifier. Must be unique in the current API Management service instance. */
        @path
        @segment("workspaces")
        @key
        @pattern("^[^*#&+:<>?]+$")
        workspaceId: string,
      },
      {
        /** Identifier of the NamedValue. */
        @path
        @segment("namedValues")
        @key
        @pattern("^[^*#&+:<>?]+$")
        namedValueId: string,
      }
    > {}

@armResourceOperations
interface WorkspaceNamedValue {
  /**
   * Gets the details of the named value specified by its identifier.
   */
  get is WorkspaceNamedValueOps.Read<NamedValueContract>;

  /**
   * Gets the entity state (Etag) version of the named value specified by its identifier.
   */
  getEntityTag is WorkspaceNamedValueOps.CheckExistence<NamedValueContract>;

  /**
   * Creates or updates named value.
   */
  createOrUpdate is WorkspaceNamedValueOps.CreateOrUpdateAsync<
    NamedValueContract,
    Parameters = {
      /**
       * ETag of the Entity. Not required when creating an entity, but required when updating an entity.
       */
      @header
      `If-Match`?: string;
    },
    LroHeaders = ArmLroLocationHeader<FinalResult = NamedValueContract> &
      Azure.Core.Foundations.RetryAfterHeader
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
      @header
      `If-Match`: string;
    }
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
      @header
      `If-Match`: string;
    }
  >;

  /**
   * Lists a collection of named values defined within a workspace in a service instance.
   */
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
    ArmResponse<NamedValueSecretContract>
  >;

  /**
   * Refresh the secret of the named value specified by its identifier.
   */
  refreshSecret is WorkspaceNamedValueOps.ActionAsync<
    NamedValueContract,
    void,
    ArmResponse<NamedValueContract>
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
