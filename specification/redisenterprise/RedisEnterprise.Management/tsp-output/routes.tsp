import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace RedisEnterpriseManagementClient;

interface OperationsOperations {
  @doc("Lists all of the available REST API operations of the Microsoft.Cache provider.")
  @route("/providers/Microsoft.Cache/operations")
  @get
  List is Azure.Core.Foundations.Operation<{}, OperationListResult>;
}

interface OperationsStatusOperations {
  @doc("Gets the status of operation.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Cache/locations/{location}/operationsStatus/{operationId}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The name of Azure region.")
      @path
      location: string;

      @doc("The ID of an ongoing async operation.")
      @path
      operationId: string;

      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;
    },
    OperationStatus
  >;
}

interface RedisEnterpriseOperations {
  @doc("""
Creates or updates an existing (overwrite/recreate, with potential downtime)
cache cluster
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Cache/redisEnterprise/{clusterName}")
  @put
  Create is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the RedisEnterprise cluster.")
      @path
      clusterName: string;

      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("Parameters supplied to the Create RedisEnterprise operation.")
      @body
      parameters: Cluster;
    },
    Cluster
  >;

  @doc("Updates an existing RedisEnterprise cluster")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Cache/redisEnterprise/{clusterName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the RedisEnterprise cluster.")
      @path
      clusterName: string;

      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("Parameters supplied to the Update RedisEnterprise operation.")
      @body
      parameters: ClusterUpdate;
    },
    Cluster | void
  >;

  @doc("Deletes a RedisEnterprise cache cluster.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Cache/redisEnterprise/{clusterName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the RedisEnterprise cluster.")
      @path
      clusterName: string;

      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;
    },
    void
  >;

  @doc("Gets information about a RedisEnterprise cluster")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Cache/redisEnterprise/{clusterName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the RedisEnterprise cluster.")
      @path
      clusterName: string;

      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;
    },
    Cluster
  >;

  @doc("Lists all RedisEnterprise clusters in a resource group.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Cache/redisEnterprise")
  @get
  ListByResourceGroup is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;
    },
    ClusterList
  >;

  @doc("Gets all RedisEnterprise clusters in the specified subscription.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Cache/redisEnterprise")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;
    },
    ClusterList
  >;
}

interface DatabasesOperations {
  @doc("Gets all databases in the specified RedisEnterprise cluster.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Cache/redisEnterprise/{clusterName}/databases")
  @get
  ListByCluster is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the RedisEnterprise cluster.")
      @path
      clusterName: string;
    },
    DatabaseList
  >;

  @doc("Creates a database")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Cache/redisEnterprise/{clusterName}/databases/{databaseName}")
  @put
  Create is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the RedisEnterprise cluster.")
      @path
      clusterName: string;

      @doc("The name of the database.")
      @path
      databaseName: string;

      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("Parameters supplied to the create or update database operation.")
      @body
      parameters: Database;
    },
    Database
  >;

  @doc("Updates a database")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Cache/redisEnterprise/{clusterName}/databases/{databaseName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the RedisEnterprise cluster.")
      @path
      clusterName: string;

      @doc("The name of the database.")
      @path
      databaseName: string;

      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("Parameters supplied to the create or update database operation.")
      @body
      parameters: DatabaseUpdate;
    },
    Database | void
  >;

  @doc("Gets information about a database in a RedisEnterprise cluster.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Cache/redisEnterprise/{clusterName}/databases/{databaseName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the RedisEnterprise cluster.")
      @path
      clusterName: string;

      @doc("The name of the database.")
      @path
      databaseName: string;

      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;
    },
    Database
  >;

  @doc("Deletes a single database")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Cache/redisEnterprise/{clusterName}/databases/{databaseName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the RedisEnterprise cluster.")
      @path
      clusterName: string;

      @doc("The name of the database.")
      @path
      databaseName: string;

      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;
    },
    void
  >;

  @doc("Retrieves the access keys for the RedisEnterprise database.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Cache/redisEnterprise/{clusterName}/databases/{databaseName}/listKeys")
  @post
  ListKeys is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the RedisEnterprise cluster.")
      @path
      clusterName: string;

      @doc("The name of the database.")
      @path
      databaseName: string;

      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;
    },
    AccessKeys
  >;

  @doc("Regenerates the RedisEnterprise database's access keys.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Cache/redisEnterprise/{clusterName}/databases/{databaseName}/regenerateKey")
  @post
  RegenerateKey is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the RedisEnterprise cluster.")
      @path
      clusterName: string;

      @doc("The name of the database.")
      @path
      databaseName: string;

      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("Specifies which key to regenerate.")
      @body
      parameters: RegenerateKeyParameters;
    },
    AccessKeys | void
  >;

  @doc("Imports database files to target database.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Cache/redisEnterprise/{clusterName}/databases/{databaseName}/import")
  @post
  Import is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the RedisEnterprise cluster.")
      @path
      clusterName: string;

      @doc("The name of the database.")
      @path
      databaseName: string;

      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("Storage information for importing into the cluster")
      @body
      parameters: ImportClusterParameters;
    },
    void
  >;

  @doc("Exports a database file from target database.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Cache/redisEnterprise/{clusterName}/databases/{databaseName}/export")
  @post
  Export is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the RedisEnterprise cluster.")
      @path
      clusterName: string;

      @doc("The name of the database.")
      @path
      databaseName: string;

      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("Storage information for exporting into the cluster")
      @body
      parameters: ExportClusterParameters;
    },
    void
  >;

  @doc("Forcibly removes the link to the specified database resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Cache/redisEnterprise/{clusterName}/databases/{databaseName}/forceUnlink")
  @post
  ForceUnlink is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the RedisEnterprise cluster.")
      @path
      clusterName: string;

      @doc("The name of the database.")
      @path
      databaseName: string;

      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("Information identifying the database to be unlinked.")
      @body
      parameters: ForceUnlinkParameters;
    },
    void
  >;

  @doc("Flushes all the keys in this database and also from its linked databases.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Cache/redisEnterprise/{clusterName}/databases/{databaseName}/flush")
  @post
  Flush is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the RedisEnterprise cluster.")
      @path
      clusterName: string;

      @doc("The name of the database.")
      @path
      databaseName: string;

      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("Information identifying the databases to be flushed")
      @body
      parameters: FlushParameters;
    },
    void
  >;
}

interface PrivateEndpointConnectionsOperations {
  @doc("""
Lists all the private endpoint connections associated with the RedisEnterprise
cluster.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Cache/redisEnterprise/{clusterName}/privateEndpointConnections")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the RedisEnterprise cluster.")
      @path
      clusterName: string;

      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;
    },
    PrivateEndpointConnectionListResult
  >;

  @doc("""
Gets the specified private endpoint connection associated with the
RedisEnterprise cluster.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Cache/redisEnterprise/{clusterName}/privateEndpointConnections/{privateEndpointConnectionName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the RedisEnterprise cluster.")
      @path
      clusterName: string;

      @doc("The name of the private endpoint connection associated with the Azure resource")
      @path
      privateEndpointConnectionName: string;

      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;
    },
    PrivateEndpointConnection
  >;

  @doc("""
Updates the state of the specified private endpoint connection associated with
the RedisEnterprise cluster.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Cache/redisEnterprise/{clusterName}/privateEndpointConnections/{privateEndpointConnectionName}")
  @put
  Put is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the RedisEnterprise cluster.")
      @path
      clusterName: string;

      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the private endpoint connection associated with the Azure resource")
      @path
      privateEndpointConnectionName: string;

      @doc("The private endpoint connection properties.")
      @body
      properties: PrivateEndpointConnection;
    },
    PrivateEndpointConnection
  >;

  @doc("""
Deletes the specified private endpoint connection associated with the
RedisEnterprise cluster.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Cache/redisEnterprise/{clusterName}/privateEndpointConnections/{privateEndpointConnectionName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the RedisEnterprise cluster.")
      @path
      clusterName: string;

      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the private endpoint connection associated with the Azure resource")
      @path
      privateEndpointConnectionName: string;
    },
    void
  >;
}

interface PrivateLinkResourcesOperations {
  @doc("""
Gets the private link resources that need to be created for a RedisEnterprise
cluster.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Cache/redisEnterprise/{clusterName}/privateLinkResources")
  @get
  ListByCluster is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the RedisEnterprise cluster.")
      @path
      clusterName: string;

      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;
    },
    PrivateLinkResourceListResult
  >;
}

interface SkusOperations {
  @doc("Gets information about skus in specified location for the given subscription id")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Cache/locations/{location}/skus")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of Azure region.")
      @path
      location: string;
    },
    RegionSkuDetails
  >;
}
