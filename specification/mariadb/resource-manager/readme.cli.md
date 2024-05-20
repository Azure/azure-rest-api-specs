## CLI

These settings don't need to apply `--cli` on the command line.

``` yaml
cli:
  cli-name: mariadb
  package-name: azure-mgmt-rdbms-mariadb
  namespace: azure.mgmt.rdbms.mariadb
  test-scenario:
    - name: Create a new server
    - name: Create a replica server
    - name: Create a database as a point in time restore
    - name: Create a server as a geo restore
    - name: DatabaseCreate
    - name: FirewallRuleCreate
    - name: ConfigurationCreateOrUpdate
    - name: Create or update a virtual network rule
    - name: Update a server's threat detection policy with all parameters
    - name: Update a server's threat detection policy with minimal parameters
    - name: Approve or reject a private endpoint connection with a given name.
    - name: RecommendedActionsGet
    - name: RecommendedActionSessionOperationStatus
    - name: Gets private endpoint connection.
    - name: RecommendedActionSessionResult
    - name: Get a server's threat detection policy
    - name: Gets a private link resource for MariaDB.
    - name: Gets a virtual network rule
    - name: TopQueryStatisticsGet
    - name: RecommendedActionsListByServer
    - name: WaitStatisticsGet
    - name: ConfigurationGet
    - name: FirewallRuleGet
    - name: QueryTextsGet
    - name: DatabaseGet
    - name: AdvisorsGet
    - name: Gets list of private endpoint connections on a server.
    - name: Gets private link resources for MariaDB.
    - name: List virtual network rules
    - name: TopQueryStatisticsListByServer
    - name: WaitStatisticsListByServer
    - name: ConfigurationList
    - name: FirewallRuleList
    - name: QueryTextsListByServer
    - name: DatabaseList
    - name: LogFileList
    - name: AdvisorsListByServer
    - name: ReplicasListByServer
    - name: ServerGet
    - name: PerformanceTiersList
    - name: ServerListByResourceGroup
    - name: ServerList
    - name: OperationList
    - name: Update private endpoint connection Tags
    - name: RecommendedActionSessionCreate
    - name: ServerRestart
    - name: ServerUpdate
    - name: NameAvailability
    - name: Deletes a private endpoint connection with a given name.
    - name: Delete a virtual network rule
    - name: FirewallRuleDelete
    - name: DatabaseDelete
    - name: ServerDelete
    - name: ServerStart
    - name: ServerStop
```