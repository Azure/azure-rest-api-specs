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
 * API Operation details.
 */
@parentResource(ApiContract)
model OperationContract
  is Azure.ResourceManager.ProxyResource<OperationContractProperties> {
  ...ResourceNameParameter<
    Resource = OperationContract,
    KeyName = "operationId",
    SegmentName = "operations",
    NamePattern = ""
  >;
}

@armResourceOperations
interface OperationContractOps
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
        /** Operation identifier within an API. Must be unique in the current API Management service instance. */
        @path
        @segment("operations")
        @key
        @minLength(1)
        @maxLength(80)
        operationId: string,
      }
    > {}

@armResourceOperations
interface OperationContracts {
  /**
   * Gets the details of the API Operation specified by its identifier.
   */
  get is OperationContractOps.Read<
    OperationContract,
    Response = ArmResponse<OperationContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Gets the entity state (Etag) version of the API operation specified by its identifier.
   */
  getEntityTag is OperationContractOps.CheckExistence<
    OperationContract,
    Response = OkResponse & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Creates a new operation in the API or updates an existing one.
   */
  createOrUpdate is OperationContractOps.CreateOrUpdateSync<
    OperationContract,
    Parameters = {
      /**
       * ETag of the Entity. Not required when creating an entity, but required when updating an entity.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`?: string;
    },
    Response = (ArmResponse<OperationContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }) | (ArmResourceCreatedSyncResponse<OperationContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    })
  >;

  /**
   * Updates the details of the operation in the API specified by its identifier.
   */
  @patch(#{ implicitOptionality: false })
  update is OperationContractOps.CustomPatchSync<
    OperationContract,
    PatchModel = OperationUpdateContract,
    Parameters = {
      /**
       * ETag of the Entity. ETag should match the current entity state from the header response of the GET request or it should be * for unconditional update.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`: string;
    },
    Response = ArmResponse<OperationContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Deletes the specified operation in the API.
   */
  delete is OperationContractOps.DeleteSync<
    OperationContract,
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
   * Lists a collection of the operations for the specified API.
   */
  listByApi is OperationContractOps.List<
    OperationContract,
    Parameters = {
      /**
       * |     Field     |     Usage     |     Supported operators     |     Supported functions     |</br>|-------------|-------------|-------------|-------------|</br>| name | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| displayName | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| method | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| description | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| urlTemplate | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>
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
    },
    Response = ArmResponse<OperationCollection>
  >;
}
@armResourceOperations
interface WorkspaceApiOperationOps
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
        /** Operation identifier within an API. Must be unique in the current API Management service instance. */
        @path
        @segment("operations")
        @key
        @minLength(1)
        @maxLength(80)
        operationId: string,
      }
    > {}

@armResourceOperations
interface WorkspaceApiOperation {
  /**
   * Gets the details of the API Operation specified by its identifier.
   */
  get is WorkspaceApiOperationOps.Read<
    OperationContract,
    Response = ArmResponse<OperationContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Gets the entity state (Etag) version of the API operation specified by its identifier.
   */
  getEntityTag is WorkspaceApiOperationOps.CheckExistence<
    OperationContract,
    Response = OkResponse & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Creates a new operation in the API or updates an existing one.
   */
  createOrUpdate is WorkspaceApiOperationOps.CreateOrUpdateSync<
    OperationContract,
    Parameters = {
      /**
       * ETag of the Entity. Not required when creating an entity, but required when updating an entity.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`?: string;
    },
    Response = (ArmResponse<OperationContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }) | (ArmCreatedResponse<OperationContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    })
  >;

  /**
   * Updates the details of the operation in the API specified by its identifier.
   */
  @patch(#{ implicitOptionality: false })
  update is WorkspaceApiOperationOps.CustomPatchSync<
    OperationContract,
    PatchModel = OperationUpdateContract,
    Parameters = {
      /**
       * ETag of the Entity. ETag should match the current entity state from the header response of the GET request or it should be * for unconditional update.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`: string;
    },
    Response = ArmResponse<OperationContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Deletes the specified operation in the API.
   */
  delete is WorkspaceApiOperationOps.DeleteSync<
    OperationContract,
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
   * Lists a collection of the operations for the specified API.
   */
  listByApi is WorkspaceApiOperationOps.List<
    OperationContract,
    Parameters = {
      /**
       * |     Field     |     Usage     |     Supported operators     |     Supported functions     |</br>|-------------|-------------|-------------|-------------|</br>| name | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| displayName | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| method | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| description | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| urlTemplate | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>
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
    },
    Response = ArmResponse<OperationCollection>
  >;
}

@@maxLength(OperationContract.name, 80);
@@minLength(OperationContract.name, 1);
@@doc(OperationContract.name,
  "Operation identifier within an API. Must be unique in the current API Management service instance."
);
@@doc(OperationContract.properties, "Properties of the Operation Contract.");
@@doc(OperationContracts.createOrUpdate::parameters.resource,
  "Create parameters."
);
@@doc(OperationContracts.update::parameters.properties,
  "API Operation Update parameters."
);
@@doc(WorkspaceApiOperation.createOrUpdate::parameters.resource,
  "Create parameters."
);
@@doc(WorkspaceApiOperation.update::parameters.properties,
  "API Operation Update parameters."
);
