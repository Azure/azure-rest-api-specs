## CLI

These settings apply only when `--cli` is specified on the command line.

``` yaml $(cli)
cli:
  cli-name: mysql
  package-name: azure-mgmt-rdbms-mysql
  namespace: azure.mgmt.rdbms.mysql
  test-scenario:
    - name: Create a new server
    - name: Create a server as a geo restore
    - name: Create a replica server
    - name: Create a database as a point in time restore
    - name: DatabaseCreate
    - name: FirewallRuleCreate
    - name: ConfigurationCreateOrUpdate
    - name: Create or update a virtual network rule
    - name: Update a server's threat detection policy with all parameters
    - name: Update a server's threat detection policy with minimal parameters
    - name: Get a server's threat detection policy
    - name: Gets a virtual network rule
    - name: ConfigurationGet
    - name: FirewallRuleGet
    - name: DatabaseGet
    - name: List virtual network rules
    - name: ConfigurationList
    - name: FirewallRuleList
    - name: DatabaseList
    - name: LogFileList
    - name: ReplicasListByServer
    - name: ServerGet
    - name: PerformanceTiersList
    - name: ServerListByResourceGroup
    - name: ServerList
    - name: OperationList
    - name: ServerRestart
    - name: ServerUpdate
    - name: NameAvailability
    - name: Delete a virtual network rule
    - name: FirewallRuleDelete
    - name: DatabaseDelete
    - name: ServerDelete
    - name: ServerStart
    - name: ServerStop
```