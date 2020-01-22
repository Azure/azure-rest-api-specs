## CLI

These settings apply only when `--cli` is specified on the command line.

``` yaml $(cli)
cli:
  namespace: azure.mgmt.kusto
  flatten-all: true
  test-scenario:
    - name: KustoClustersCreateOrUpdate
    - name: KustoDatabasesCreateOrUpdate
    - name: KustoDataConnectionsCreateOrUpdate
    - name: AttachedDatabaseConfigurationsCreateOrUpdate
    - name: AttachedDatabaseConfigurationsGet
    - name: KustoDataConnectionsGet
    - name: KustoDatabasesListByCluster
    - name: KustoAttachedDatabaseConfigurationsListByCluster
    - name: KustoDatabasesGet
    - name: KustoDatabasesListByCluster
    - name: KustoClustersListResourceSkus
    - name: KustoClustersGet
    - name: KustoClustersListByResourceGroup
    - name: KustoClustersList
    - name: KustoClustersListSkus
    - name: KustoOperationsList
    - name: KustoDataConnectionsUpdate
    - name: KustoDataConnectionValidation
    - name: KustoDataConnectionsCheckNameAvailability
    - name: KustoDatabaseRemovePrincipals
    - name: KustoDatabaseListPrincipals
    - name: KustoDatabaseAddPrincipals
    - name: KustoDatabasesUpdate
    - name: KustoClusterDetachFollowerDatabases
    - name: KustoDatabaseCheckNameAvailability
    - name: KustoClusterListFollowerDatabases
    - name: KustoClustersStart
    - name: KustoClustersStop
    - name: KustoClustersUpdate
    - name: KustoClustersCheckNameAvailability
    - name: AttachedDatabaseConfigurationsDelete
    - name: KustoDataConnectionsDelete
    - name: KustoDatabasesDelete
    - name: KustoClustersDelete
```
