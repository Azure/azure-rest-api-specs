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
@doc("A SQL Migration Service.")
model SqlMigrationService is TrackedResource<SqlMigrationServiceProperties> {
  @doc("Name of the SQL Migration Service.")
  @path
  @key("sqlMigrationServiceName")
  @segment("sqlMigrationServices")
  name: string;
}

@armResourceOperations
interface SqlMigrationServices {
  @doc("Retrieve the Database Migration Service")
  get is ArmResourceRead<SqlMigrationService>;

  @doc("Create or Update Database Migration Service.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<SqlMigrationService>;

  @doc("Update Database Migration Service.")
  update is ArmCustomPatchAsync<SqlMigrationService, SqlMigrationServiceUpdate>;

  @doc("Delete Database Migration Service.")
  delete is ArmResourceDeleteAsync<SqlMigrationService>;

  @doc("Retrieve all SQL migration services in the resource group.")
  listByResourceGroup is ArmResourceListByParent<SqlMigrationService>;

  @doc("Retrieve all SQL migration services in the subscriptions.")
  listBySubscription is ArmListBySubscription<SqlMigrationService>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Retrieve the List of Authentication Keys for Self Hosted Integration Runtime.")
  @operationId("SqlMigrationServices_listAuthKeys")
  listAuthKeys is ArmResourceActionSync<
    SqlMigrationService,
    void,
    AuthenticationKeys
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Regenerate a new set of Authentication Keys for Self Hosted Integration Runtime.")
  @operationId("SqlMigrationServices_regenerateAuthKeys")
  regenerateAuthKeys is ArmResourceActionSync<
    SqlMigrationService,
    RegenAuthKeys,
    RegenAuthKeys
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Delete the integration runtime node.")
  @operationId("SqlMigrationServices_deleteNode")
  deleteNode is ArmResourceActionSync<
    SqlMigrationService,
    DeleteNode,
    DeleteNode
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Retrieve the registered Integration Runtime nodes and their monitoring data for a given Database Migration Service.")
  @operationId("SqlMigrationServices_listMonitoringData")
  listMonitoringData is ArmResourceActionSync<
    SqlMigrationService,
    void,
    IntegrationRuntimeMonitoringData
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SqlMigrationServices_listMigrations")
  @doc("Retrieve the List of database migrations attached to the service.")
  // FIXME: SqlMigrationServices_listMigrations could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataMigration/sqlMigrationServices/{sqlMigrationServiceName}/listMigrations")
  @get
  listMigrations is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.")
      @path
      resourceGroupName: string;

      @doc("Name of the SQL Migration Service.")
      @path
      sqlMigrationServiceName: string;

      @doc("Subscription ID that identifies an Azure subscription.")
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
