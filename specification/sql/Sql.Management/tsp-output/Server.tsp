import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.Sql;
@doc("An Azure SQL Database server.")
model Server is TrackedResource<ServerProperties> {
  @doc("The name of the server.")
  @key("serverName")
  @segment("servers")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
  ...Azure.ResourceManager.ResourceKind;
}

@armResourceOperations
interface Servers {
  @doc("Gets a server.")
  get is ArmResourceRead<
    Server,
    {
      ...BaseParameters<Server>;

      @doc("The child resources to include in the response.")
      @query("$expand")
      $expand?: string;
    }
  >;

  @doc("Creates or updates a server.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<Server>;

  @doc("Updates a server.")
  update is ArmCustomPatchAsync<Server, ServerUpdate>;

  @doc("Deletes a server.")
  delete is ArmResourceDeleteAsync<Server>;

  @doc("Gets a list of servers in a resource groups.")
  listByResourceGroup is ArmResourceListByParent<
    Server,
    {
      ...BaseParameters<Server>;

      @doc("The child resources to include in the response.")
      @query("$expand")
      $expand?: string;
    }
  >;

  @doc("Gets a list of all servers in the subscription.")
  list is ArmListBySubscription<Server>;

  @doc("Imports a bacpac into a new database.")
  importDatabase is ArmResourceActionAsync<
    Server,
    ImportNewDatabaseDefinition,
    ImportExportOperationResult
  >;

  @doc("Refresh external governance enablement status.")
  refreshStatus is ArmResourceActionAsync<
    Server,
    void,
    RefreshExternalGovernanceStatusOperationResult
  >;
}

@armResourceOperations
@projectedName("client", "TdeCertificates")
interface Servers_TdeCertificates {
  @doc("Creates a TDE certificate for a given server.")
  create is ArmResourceActionAsync<Server, TdeCertificate, void>;
}

@armResourceOperations
@projectedName("client", "ServerUsages")
interface Servers_ServerUsages {
  @doc("Returns server usages.")
  // FIXME: ServerUsages_ListByServer could not be converted to a resource operation
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
}

@armResourceOperations
@projectedName("client", "ServerOperations")
interface Servers_ServerOperations {
  @doc("Gets a list of operations performed on the server.")
  // FIXME: ServerOperations_ListByServer could not be converted to a resource operation
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
}

@armResourceOperations
@projectedName("client", "ReplicationLinks")
interface Servers_ReplicationLinks {
  @doc("Gets a list of replication links.")
  // FIXME: ReplicationLinks_ListByServer could not be converted to a resource operation
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
    ResourceListResult<ReplicationLink>
  >;
}

@armResourceOperations
@projectedName("client", "Databases")
interface Servers_Databases {
  @doc("Gets a list of inaccessible databases in a logical server")
  // FIXME: Databases_ListInaccessibleByServer could not be converted to a resource operation
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
    ResourceListResult<Database>
  >;
}
