import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataMigration;
/**
 * A SQL Migration Service.
 */
model SqlMigrationService is TrackedResource<SqlMigrationServiceProperties> {
  /**
   * Name of the SQL Migration Service.
   */
  @path
  @key("sqlMigrationServiceName")
  @segment("sqlMigrationServices")
  name: string;
}

@armResourceOperations
interface SqlMigrationServices {
  /**
   * Retrieve the Database Migration Service
   */
  get is ArmResourceRead<SqlMigrationService>;

  /**
   * Create or Update Database Migration Service.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<SqlMigrationService>;

  /**
   * Update Database Migration Service.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<SqlMigrationService, SqlMigrationServiceUpdate>;

  /**
   * Delete Database Migration Service.
   */
  delete is ArmResourceDeleteAsync<SqlMigrationService>;

  /**
   * Retrieve all SQL migration services in the resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SqlMigrationServices_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<SqlMigrationService>;

  /**
   * Retrieve all SQL migration services in the subscriptions.
   */
  listBySubscription is ArmListBySubscription<SqlMigrationService>;

  /**
   * Retrieve the List of Authentication Keys for Self Hosted Integration Runtime.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SqlMigrationServices_listAuthKeys")
  listAuthKeys is ArmResourceActionSync<
    SqlMigrationService,
    void,
    AuthenticationKeys
  >;

  /**
   * Regenerate a new set of Authentication Keys for Self Hosted Integration Runtime.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SqlMigrationServices_regenerateAuthKeys")
  regenerateAuthKeys is ArmResourceActionSync<
    SqlMigrationService,
    RegenAuthKeys,
    RegenAuthKeys
  >;

  /**
   * Delete the integration runtime node.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SqlMigrationServices_deleteNode")
  deleteNode is ArmResourceActionSync<
    SqlMigrationService,
    DeleteNode,
    DeleteNode
  >;

  /**
   * Retrieve the registered Integration Runtime nodes and their monitoring data for a given Database Migration Service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SqlMigrationServices_listMonitoringData")
  listMonitoringData is ArmResourceActionSync<
    SqlMigrationService,
    void,
    IntegrationRuntimeMonitoringData
  >;

  /**
   * Retrieve the List of database migrations attached to the service.
   */
  // FIXME: SqlMigrationServices_listMigrations could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SqlMigrationServices_listMigrations")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataMigration/sqlMigrationServices/{sqlMigrationServiceName}/listMigrations")
  @get
  listMigrations is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.
       */
      @path
      resourceGroupName: string;

      /**
       * Name of the SQL Migration Service.
       */
      @path
      sqlMigrationServiceName: string;

      /**
       * Subscription ID that identifies an Azure subscription.
       */
      @path
      subscriptionId: string;
    },
    DatabaseMigrationListResult
  >;
}

@@projectedName(SqlMigrationServices.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(SqlMigrationServices.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(SqlMigrationServices.createOrUpdate::parameters.resource,
  "Details of SqlMigrationService resource."
);
@@projectedName(SqlMigrationServices.update::parameters.properties,
  "json",
  "parameters"
);
@@extension(SqlMigrationServices.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(SqlMigrationServices.update::parameters.properties,
  "Details of SqlMigrationService resource."
);
@@projectedName(SqlMigrationServices.regenerateAuthKeys::parameters.body,
  "json",
  "parameters"
);
@@extension(SqlMigrationServices.regenerateAuthKeys::parameters.body,
  "x-ms-client-name",
  "parameters"
);
@@doc(SqlMigrationServices.regenerateAuthKeys::parameters.body,
  "Details of SqlMigrationService resource."
);
@@projectedName(SqlMigrationServices.deleteNode::parameters.body,
  "json",
  "parameters"
);
@@extension(SqlMigrationServices.deleteNode::parameters.body,
  "x-ms-client-name",
  "parameters"
);
@@doc(SqlMigrationServices.deleteNode::parameters.body,
  "Details of SqlMigrationService resource."
);
