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

namespace Microsoft.CertificateRegistration;
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
        ...KeysOf<ResourceNameParameter<
          Resource = StaticSiteARMResource,
          KeyName = "name",
          SegmentName = "staticSites",
          NamePattern = ""
        >>,
        ...KeysOf<ResourceNameParameter<
          Resource = StaticSiteBuildARMResource,
          KeyName = "environmentName",
          SegmentName = "builds",
          NamePattern = "^[a-zA-Z0-9]+$"
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = DatabaseConnection,
        KeyName = "databaseConnectionName",
        SegmentName = "databaseConnections",
        NamePattern = "^[a-zA-Z0-9]+$"
      >>
    > {}

@armResourceOperations
interface DatabaseConnections {
  /**
   * Returns overview of a database connection for a static site build by name
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("StaticSites_GetBuildDatabaseConnection")
  getBuildDatabaseConnection is DatabaseConnectionOps.Read<DatabaseConnection>;

  /**
   * Description for Create or update a database connection for a static site build
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("StaticSites_CreateOrUpdateBuildDatabaseConnection")
  createOrUpdateBuildDatabaseConnection is DatabaseConnectionOps.CreateOrUpdateSync<
    DatabaseConnection,
    Response = ArmResourceUpdatedResponse<DatabaseConnection>
  >;

  /**
   * Description for Create or update a database connection for a static site build
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @patch(#{ implicitOptionality: false })
  @operationId("StaticSites_UpdateBuildDatabaseConnection")
  updateBuildDatabaseConnection is DatabaseConnectionOps.CustomPatchSync<
    DatabaseConnection,
    PatchModel = DatabaseConnectionPatchRequest
  >;

  /**
   * Delete a database connection for a static site build
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("StaticSites_DeleteBuildDatabaseConnection")
  deleteBuildDatabaseConnection is DatabaseConnectionOps.DeleteSync<DatabaseConnection>;

  /**
   * Returns overviews of database connections for a static site build
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("StaticSites_GetBuildDatabaseConnections")
  getBuildDatabaseConnections is DatabaseConnectionOps.List<
    DatabaseConnection,
    Response = ArmResponse<DatabaseConnectionCollection>
  >;

  /**
   * Returns details of a database connection for a static site build by name
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("show")
  @operationId("StaticSites_GetBuildDatabaseConnectionWithDetails")
  getBuildDatabaseConnectionWithDetails is DatabaseConnectionOps.ActionSync<
    DatabaseConnection,
    void,
    ArmResponse<DatabaseConnection>
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
        ...KeysOf<ResourceNameParameter<
          Resource = StaticSiteARMResource,
          KeyName = "name",
          SegmentName = "staticSites",
          NamePattern = ""
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = DatabaseConnection,
        KeyName = "databaseConnectionName",
        SegmentName = "databaseConnections",
        NamePattern = "^[a-zA-Z0-9]+$"
      >>
    > {}

@armResourceOperations
interface DatabaseConnectionOperationGroup {
  /**
   * Returns overview of a database connection for a static site by name
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("StaticSites_GetDatabaseConnection")
  getDatabaseConnection is DatabaseConnectionOperationGroupOps.Read<DatabaseConnection>;

  /**
   * Description for Create or update a database connection for a static site
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("StaticSites_CreateOrUpdateDatabaseConnection")
  createOrUpdateDatabaseConnection is DatabaseConnectionOperationGroupOps.CreateOrUpdateSync<
    DatabaseConnection,
    Response = ArmResourceUpdatedResponse<DatabaseConnection>
  >;

  /**
   * Description for Create or update a database connection for a static site
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @patch(#{ implicitOptionality: false })
  @operationId("StaticSites_UpdateDatabaseConnection")
  updateDatabaseConnection is DatabaseConnectionOperationGroupOps.CustomPatchSync<
    DatabaseConnection,
    PatchModel = DatabaseConnectionPatchRequest
  >;

  /**
   * Delete a database connection for a static site
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("StaticSites_DeleteDatabaseConnection")
  deleteDatabaseConnection is DatabaseConnectionOperationGroupOps.DeleteSync<DatabaseConnection>;

  /**
   * Returns overviews of database connections for a static site
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("StaticSites_GetDatabaseConnections")
  getDatabaseConnections is DatabaseConnectionOperationGroupOps.List<
    DatabaseConnection,
    Response = ArmResponse<DatabaseConnectionCollection>
  >;

  /**
   * Returns details of a database connection for a static site by name
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("show")
  @operationId("StaticSites_GetDatabaseConnectionWithDetails")
  getDatabaseConnectionWithDetails is DatabaseConnectionOperationGroupOps.ActionSync<
    DatabaseConnection,
    void,
    ArmResponse<DatabaseConnection>
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
