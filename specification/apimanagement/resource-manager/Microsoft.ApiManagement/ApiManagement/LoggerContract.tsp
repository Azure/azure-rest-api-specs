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
 * Logger details.
 */
@parentResource(ApiManagementServiceResource)
model LoggerContract
  is Azure.ResourceManager.ProxyResource<LoggerContractProperties> {
  ...ResourceNameParameter<
    Resource = LoggerContract,
    KeyName = "loggerId",
    SegmentName = "loggers",
    NamePattern = "^[^*#&+:<>?]+$"
  >;
}

@armResourceOperations
interface LoggerContractOps
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
        /** Logger identifier. Must be unique in the API Management service instance. */
        @path
        @segment("loggers")
        @key
        @pattern("^[^*#&+:<>?]+$")
        @maxLength(256)
        loggerId: string,
      }
    > {}

@armResourceOperations
interface LoggerContracts {
  /**
   * Gets the details of the logger specified by its identifier.
   */
  get is LoggerContractOps.Read<
    LoggerContract,
    Response = ArmResponse<LoggerContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag?: string;
    }
  >;

  /**
   * Gets the entity state (Etag) version of the logger specified by its identifier.
   */
  getEntityTag is LoggerContractOps.CheckExistence<
    LoggerContract,
    Response = OkResponse & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag?: string;
    }
  >;

  /**
   * Creates or Updates a logger.
   */
  createOrUpdate is LoggerContractOps.CreateOrUpdateSync<
    LoggerContract,
    Parameters = {
      /**
       * ETag of the Entity. Not required when creating an entity, but required when updating an entity.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`?: string;
    },
    Response = (ArmResponse<LoggerContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag?: string;
    }) | (ArmResourceCreatedSyncResponse<LoggerContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag?: string;
    })
  >;

  /**
   * Updates an existing logger.
   */
  @patch(#{ implicitOptionality: false })
  update is LoggerContractOps.CustomPatchSync<
    LoggerContract,
    PatchModel = LoggerUpdateContract,
    Parameters = {
      /**
       * ETag of the Entity. ETag should match the current entity state from the header response of the GET request or it should be * for unconditional update.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`: string;
    },
    Response = ArmResponse<LoggerContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag?: string;
    }
  >;

  /**
   * Deletes the specified logger.
   */
  delete is LoggerContractOps.DeleteSync<
    LoggerContract,
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
   * Lists a collection of loggers in the specified service instance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/azure/api-management/api-management-howto-log-event-hubs")
  listByService is LoggerContractOps.List<
    LoggerContract,
    Parameters = {
      /**
       * |     Field     |     Usage     |     Supported operators     |     Supported functions     |</br>|-------------|-------------|-------------|-------------|</br>| name | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| description | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| loggerType | filter | eq |     |</br>| resourceId | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>
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
    Response = ArmResponse<LoggerCollection>
  >;
}
@armResourceOperations
interface WorkspaceLoggerOps
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
        /** Logger identifier. Must be unique in the API Management service instance. */
        @path
        @segment("loggers")
        @key
        @pattern("^[^*#&+:<>?]+$")
        @maxLength(256)
        loggerId: string,
      }
    > {}

@armResourceOperations
interface WorkspaceLogger {
  /**
   * Gets the details of the logger specified by its identifier.
   */
  get is WorkspaceLoggerOps.Read<
    LoggerContract,
    Response = ArmResponse<LoggerContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Gets the entity state (Etag) version of the logger specified by its identifier.
   */
  getEntityTag is WorkspaceLoggerOps.CheckExistence<
    LoggerContract,
    Response = OkResponse & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Creates or Updates a logger.
   */
  createOrUpdate is WorkspaceLoggerOps.CreateOrUpdateSync<
    LoggerContract,
    Parameters = {
      /**
       * ETag of the Entity. Not required when creating an entity, but required when updating an entity.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`?: string;
    },
    Response = (ArmResponse<LoggerContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }) | (ArmResourceCreatedSyncResponse<LoggerContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    })
  >;

  /**
   * Updates an existing logger.
   */
  @patch(#{ implicitOptionality: false })
  update is WorkspaceLoggerOps.CustomPatchSync<
    LoggerContract,
    PatchModel = LoggerUpdateContract,
    Parameters = {
      /**
       * ETag of the Entity. ETag should match the current entity state from the header response of the GET request or it should be * for unconditional update.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`: string;
    },
    Response = ArmResponse<LoggerContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Deletes the specified logger.
   */
  delete is WorkspaceLoggerOps.DeleteSync<
    LoggerContract,
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
   * Lists a collection of loggers in the specified workspace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/azure/api-management/api-management-howto-log-event-hubs")
  listByWorkspace is WorkspaceLoggerOps.List<
    LoggerContract,
    Parameters = {
      /**
       * |     Field     |     Usage     |     Supported operators     |     Supported functions     |</br>|-------------|-------------|-------------|-------------|</br>| name | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| description | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| loggerType | filter | eq |     |</br>| resourceId | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>
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
    Response = ArmResponse<LoggerCollection>
  >;
}

@@maxLength(LoggerContract.name, 256);
@@doc(LoggerContract.name,
  "Logger identifier. Must be unique in the API Management service instance."
);
@@doc(LoggerContract.properties, "Logger entity contract properties.");
@@doc(LoggerContracts.createOrUpdate::parameters.resource,
  "Create parameters."
);
@@doc(LoggerContracts.update::parameters.properties, "Update parameters.");
@@doc(WorkspaceLogger.createOrUpdate::parameters.resource,
  "Create parameters."
);
@@doc(WorkspaceLogger.update::parameters.properties, "Update parameters.");
