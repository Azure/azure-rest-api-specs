## CLI

These settings don't need to apply `--cli` on the command line.

``` yaml
cli:
  cli-name: postgresqlhsc
  package-name: azure-mgmt-rdbms-postgresqlhsc
  namespace: azure.mgmt.rdbms.postgresqlhsc
  test-scenario:
    - name: Create a new server group
    - name: Create a new server group as a point in time restore
    - name: Update the server group
    - name: Get the server group
    - name: Delete the server group
    - name: Scale compute
    - name: Scale storage
    - name: Add new worker nodes
    - name: Update customer maintenance window
    - name: List servers of the server group
    - name: Get the server of server group
    - name: List configurations of the server that in the server group
    - name: Update configurations of the server group
    - name: List configurations of the server group
    - name: Update single configuration of the server group
    - name: Get single configuration of the server group
    - name: Create a firewall rule of the server group
    - name: Delete the firewall rule of the server group
    - name: Get the firewall rule of the server group
    - name: List firewall rules of the server group
    - name: RoleCreate
    - name: RoleDelete
    - name: RoleList
    - name: Restart all servers in the server group
    - name: Start all servers in the server group
    - name: Stop all servers in the server group
    - name: Check name availability
    - name: List all available operations
```