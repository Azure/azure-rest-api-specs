## CLI

These settings don't need to apply `--cli` on the command line.

``` yaml
cli:
  cli-name: authorization
  package-name: azure-mgmt-authorization
  namespace: azure.mgmt.authorization
  test-scenario:
    - name: /RoleAssignments/put/GetConfigurations
    - name: /RoleDefinitions/put/GetConfigurations
    - name: /RoleAssignments/put/GetConfigurations
    - name: /DenyAssignments/get/GetConfigurations
    - name: /RoleAssignments/get/GetConfigurations
    - name: /Permissions/get/GetConfigurations
    - name: /DenyAssignments/get/GetConfigurations
    - name: /RoleAssignments/get/GetConfigurations
    - name: /Permissions/get/GetConfigurations
    - name: /ClassicAdministrators/get/GetConfigurations
    - name: /ProviderOperationsMetadata/get/GetConfigurations
    - name: /DenyAssignments/get/GetConfigurations
    - name: /RoleAssignments/get/GetConfigurations
    - name: /RoleAssignments/get/GetConfigurations
    - name: /RoleDefinitions/get/GetConfigurations
    - name: /DenyAssignments/get/GetConfigurations
    - name: /RoleDefinitions/get/GetConfigurations
    - name: /DenyAssignments/get/GetConfigurations
    - name: /RoleAssignments/get/GetConfigurations
    - name: /ProviderOperationsMetadata/get/GetConfigurations
    - name: /DenyAssignments/get/GetConfigurations
    - name: /RoleDefinitions/get/GetConfigurations
    - name: /RoleAssignments/get/GetConfigurations
    - name: /GlobalAdministrator/post/GetConfigurations
    - name: /RoleAssignments/delete/GetConfigurations
    - name: /RoleDefinitions/delete/GetConfigurations
    - name: /RoleAssignments/delete/GetConfigurations
```
