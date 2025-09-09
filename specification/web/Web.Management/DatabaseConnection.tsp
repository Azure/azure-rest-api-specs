import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./StaticSiteBuildARMResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Web;
/**
 * Static Site Database Connection resource.
 */
@parentResource(StaticSiteBuildARMResource)
model DatabaseConnection
  is Azure.ResourceManager.ProxyResource<DatabaseConnectionProperties> {
  ...ResourceNameParameter<
    Resource = DatabaseConnection,
    KeyName = "databaseConnectionName",
    SegmentName = "databaseConnections",
    NamePattern = "^[a-zA-Z0-9]+$"
  >;
}

@armResourceOperations
interface DatabaseConnectionOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** Name of the static site */
        @path
        @segment("staticSites")
        @key
        name: string,

        /** The stage site identifier. */
        @path
        @segment("builds")
        @key
        @pattern("^[a-zA-Z0-9]+$")
        environmentName: string,
      },
      {
        /** Name of the database connection. */
        @path
        @segment("databaseConnections")
        @key
        @pattern("^[a-zA-Z0-9]+$")
        databaseConnectionName: string,
      }
    > {}

@armResourceOperations
interface DatabaseConnections {
  /**
   * Returns overview of a database connection for a static site build by name
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("StaticSites_GetBuildDatabaseConnection")
  getBuildDatabaseConnection is DatabaseConnectionOps.Read<
    DatabaseConnection,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Create or update a database connection for a static site build
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("StaticSites_CreateOrUpdateBuildDatabaseConnection")
  createOrUpdateBuildDatabaseConnection is DatabaseConnectionOps.CreateOrUpdateSync<
    DatabaseConnection,
    Response = ArmResourceUpdatedResponse<DatabaseConnection>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Create or update a database connection for a static site build
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("StaticSites_UpdateBuildDatabaseConnection")
  @patch(#{ implicitOptionality: false })
  updateBuildDatabaseConnection is DatabaseConnectionOps.CustomPatchSync<
    DatabaseConnection,
    PatchModel = DatabaseConnectionPatchRequest,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Delete a database connection for a static site build
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("StaticSites_DeleteBuildDatabaseConnection")
  deleteBuildDatabaseConnection is DatabaseConnectionOps.DeleteSync<
    DatabaseConnection,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Returns overviews of database connections for a static site build
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("StaticSites_GetBuildDatabaseConnections")
  getBuildDatabaseConnections is DatabaseConnectionOps.List<
    DatabaseConnection,
    Response = ArmResponse<DatabaseConnectionCollection>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Returns details of a database connection for a static site build by name
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("StaticSites_GetBuildDatabaseConnectionWithDetails")
  @action("show")
  getBuildDatabaseConnectionWithDetails is DatabaseConnectionOps.ActionSync<
    DatabaseConnection,
    void,
    ArmResponse<DatabaseConnection>,
    OverrideErrorType = DefaultErrorResponse
  >;
}
@armResourceOperations
interface DatabaseConnectionOperationGroupOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** Name of the static site */
        @path
        @segment("staticSites")
        @key
        name: string,
      },
      {
        /** Name of the database connection. */
        @path
        @segment("databaseConnections")
        @key
        @pattern("^[a-zA-Z0-9]+$")
        databaseConnectionName: string,
      }
    > {}

@armResourceOperations
interface DatabaseConnectionOperationGroup {
  /**
   * Returns overview of a database connection for a static site by name
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("StaticSites_GetDatabaseConnection")
  getDatabaseConnection is DatabaseConnectionOperationGroupOps.Read<
    DatabaseConnection,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Create or update a database connection for a static site
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("StaticSites_CreateOrUpdateDatabaseConnection")
  createOrUpdateDatabaseConnection is DatabaseConnectionOperationGroupOps.CreateOrUpdateSync<
    DatabaseConnection,
    Response = ArmResourceUpdatedResponse<DatabaseConnection>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Create or update a database connection for a static site
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("StaticSites_UpdateDatabaseConnection")
  @patch(#{ implicitOptionality: false })
  updateDatabaseConnection is DatabaseConnectionOperationGroupOps.CustomPatchSync<
    DatabaseConnection,
    PatchModel = DatabaseConnectionPatchRequest,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Delete a database connection for a static site
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("StaticSites_DeleteDatabaseConnection")
  deleteDatabaseConnection is DatabaseConnectionOperationGroupOps.DeleteSync<
    DatabaseConnection,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Returns overviews of database connections for a static site
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("StaticSites_GetDatabaseConnections")
  getDatabaseConnections is DatabaseConnectionOperationGroupOps.List<
    DatabaseConnection,
    Response = ArmResponse<DatabaseConnectionCollection>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Returns details of a database connection for a static site by name
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("StaticSites_GetDatabaseConnectionWithDetails")
  @action("show")
  getDatabaseConnectionWithDetails is DatabaseConnectionOperationGroupOps.ActionSync<
    DatabaseConnection,
    void,
    ArmResponse<DatabaseConnection>,
    OverrideErrorType = DefaultErrorResponse
  >;
}

@@doc(DatabaseConnection.name, "Name of the database connection.");
@@doc(DatabaseConnection.properties,
  "DatabaseConnection resource specific properties"
);
@@doc(DatabaseConnections.createOrUpdateBuildDatabaseConnection::parameters.resource,
  "A JSON representation of the database connection request properties"
);
@@doc(DatabaseConnections.updateBuildDatabaseConnection::parameters.properties,
  "A JSON representation of the database connection request properties"
);
@@doc(DatabaseConnectionOperationGroup.createOrUpdateDatabaseConnection::parameters.resource,
  "A JSON representation of the database connection request properties"
);
@@doc(DatabaseConnectionOperationGroup.updateDatabaseConnection::parameters.properties,
  "A JSON representation of the database connection request properties"
);
