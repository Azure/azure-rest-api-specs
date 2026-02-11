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

  /**
   * Kind of resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  kind?: string;
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
  @summary("Returns overview of a database connection for a static site build by name")
  getBuildDatabaseConnection is DatabaseConnectionOps.Read<
    DatabaseConnection,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Create or update a database connection for a static site build
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Create or update a database connection for a static site build")
  createOrUpdateBuildDatabaseConnection is DatabaseConnectionOps.CreateOrUpdateSync<
    DatabaseConnection,
    Response = ArmResourceUpdatedResponse<DatabaseConnection>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Create or update a database connection for a static site build
   */
  @summary("Create or update a database connection for a static site build")
  @patch(#{ implicitOptionality: false })
  updateBuildDatabaseConnection is DatabaseConnectionOps.CustomPatchSync<
    DatabaseConnection,
    PatchModel = DatabaseConnectionPatchRequest,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Delete a database connection for a static site build
   */
  @summary("Delete a database connection for a static site build")
  deleteBuildDatabaseConnection is DatabaseConnectionOps.DeleteSync<
    DatabaseConnection,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Returns overviews of database connections for a static site build
   */
  @summary("Returns overviews of database connections for a static site build")
  getBuildDatabaseConnections is DatabaseConnectionOps.List<
    DatabaseConnection,
    Response = ArmResponse<DatabaseConnectionCollection>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Returns details of a database connection for a static site build by name
   */
  @summary("Returns details of a database connection for a static site build by name")
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
  @summary("Returns overview of a database connection for a static site by name")
  getDatabaseConnection is DatabaseConnectionOperationGroupOps.Read<
    DatabaseConnection,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Create or update a database connection for a static site
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Create or update a database connection for a static site")
  createOrUpdateDatabaseConnection is DatabaseConnectionOperationGroupOps.CreateOrUpdateSync<
    DatabaseConnection,
    Response = ArmResourceUpdatedResponse<DatabaseConnection>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Create or update a database connection for a static site
   */
  @summary("Create or update a database connection for a static site")
  @patch(#{ implicitOptionality: false })
  updateDatabaseConnection is DatabaseConnectionOperationGroupOps.CustomPatchSync<
    DatabaseConnection,
    PatchModel = DatabaseConnectionPatchRequest,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Delete a database connection for a static site
   */
  @summary("Delete a database connection for a static site")
  deleteDatabaseConnection is DatabaseConnectionOperationGroupOps.DeleteSync<
    DatabaseConnection,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Returns overviews of database connections for a static site
   */
  @summary("Returns overviews of database connections for a static site")
  getDatabaseConnections is DatabaseConnectionOperationGroupOps.List<
    DatabaseConnection,
    Response = ArmResponse<DatabaseConnectionCollection>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Returns details of a database connection for a static site by name
   */
  @summary("Returns details of a database connection for a static site by name")
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
