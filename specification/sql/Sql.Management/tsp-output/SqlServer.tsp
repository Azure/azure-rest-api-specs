import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Sql;
@doc("An Azure SQL Database server.")
model SqlServer is TrackedResource<ServerProperties> {
  @doc("The name of the server.")
  @path
  @key("serverName")
  @segment("servers")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
  ...Azure.ResourceManager.ResourceKind;
}

@armResourceOperations
interface SqlServers {
  @doc("Gets a server.")
  get is ArmResourceRead<
    SqlServer,
    {
      ...BaseParameters<SqlServer>;

      @doc("The child resources to include in the response.")
      @query("$expand")
      $expand?: string;
    }
  >;
  @doc("Creates or updates a server.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<SqlServer>;
  @doc("Updates a server.")
  update is ArmResourcePatchAsync<SqlServer, ServerProperties>;
  @doc("Deletes a server.")
  delete is ArmResourceDeleteAsync<SqlServer>;
  @doc("Gets a list of servers in a resource groups.")
  listByResourceGroup is ArmResourceListByParent<
    SqlServer,
    {
      ...BaseParameters<SqlServer>;

      @doc("The child resources to include in the response.")
      @query("$expand")
      $expand?: string;
    }
  >;
  @doc("Gets a list of all servers in the subscription.")
  list is ArmListBySubscription<SqlServer>;
  @doc("Creates a TDE certificate for a given server.")
  create is ArmResourceActionAsync<SqlServer, TdeCertificate, void>;
  @doc("Imports a bacpac into a new database.")
  importDatabase is ArmResourceActionAsync<
    SqlServer,
    ImportNewDatabaseDefinition,
    ImportExportOperationResult
  >;
  @doc("Refresh external governance enablement status.")
  refreshStatus is ArmResourceActionAsync<
    SqlServer,
    void,
    RefreshExternalGovernanceStatusOperationResult
  >;
  @doc("Returns server usages.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/usages")
  @get
  ListByServer is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.")
      @path
      resourceGroupName: string;

      @doc("The name of the server.")
      @path
      serverName: string;
    },
    ServerUsageListResult
  >;

  @doc("Gets a list of operations performed on the server.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/operations")
  @get
  ListByServer is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.")
      @path
      resourceGroupName: string;

      @doc("The name of the server.")
      @path
      serverName: string;

      @doc("The subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;
    },
    ServerOperationListResult
  >;

  @doc("Gets a list of replication links.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/replicationLinks")
  @get
  ListByServer is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.")
      @path
      resourceGroupName: string;

      @doc("The name of the server.")
      @path
      serverName: string;

      @doc("The subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;
    },
    ReplicationLinkListResult
  >;

  @doc("Gets a list of inaccessible databases in a logical server")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/inaccessibleDatabases")
  @get
  ListInaccessibleByServer is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.")
      @path
      resourceGroupName: string;

      @doc("The name of the server.")
      @path
      serverName: string;

      @doc("The subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;
    },
    DatabaseListResult
  >;
}
