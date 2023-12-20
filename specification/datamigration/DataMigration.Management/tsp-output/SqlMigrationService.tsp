import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.DataMigration;
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
  update is ArmTagsPatchAsync<SqlMigrationService>;
  @doc("Delete Database Migration Service.")
  delete is ArmResourceDeleteAsync<SqlMigrationService>;
  @doc("Retrieve all SQL migration services in the resource group.")
  listByResourceGroup is ArmResourceListByParent<SqlMigrationService>;
  @doc("Retrieve all SQL migration services in the subscriptions.")
  listBySubscription is ArmListBySubscription<SqlMigrationService>;
  @doc("Retrieve the List of Authentication Keys for Self Hosted Integration Runtime.")
  listAuthKeys is ArmResourceActionSync<
    SqlMigrationService,
    void,
    AuthenticationKeys
  >;
  @doc("Regenerate a new set of Authentication Keys for Self Hosted Integration Runtime.")
  regenerateAuthKeys is ArmResourceActionSync<
    SqlMigrationService,
    RegenAuthKeys,
    RegenAuthKeys
  >;
  @doc("Delete the integration runtime node.")
  deleteNode is ArmResourceActionSync<
    SqlMigrationService,
    DeleteNode,
    DeleteNode
  >;
  @doc("Retrieve the registered Integration Runtime nodes and their monitoring data for a given Database Migration Service.")
  listMonitoringData is ArmResourceActionSync<
    SqlMigrationService,
    void,
    IntegrationRuntimeMonitoringData
  >;
  @doc("Retrieve the List of database migrations attached to the service.")
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
