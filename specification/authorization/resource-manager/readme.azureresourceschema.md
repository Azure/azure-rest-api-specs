## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
# include the azure profile definitions from the standard location
require: ../../../profiles/readme.md

output-folder: $(azureresourceschema-folder)/schemas

# all the input files across all versions
input-file:
  - Microsoft.Authorization/preview/2020-04-01-preview/authorization-RoleAssignmentsCalls.json
  - Microsoft.Authorization/stable/2015-07-01/authorization-RoleDefinitionsCalls.json
  - Microsoft.Authorization/stable/2015-07-01/authorization-ProviderOperationsCalls.json
  - Microsoft.Authorization/stable/2015-07-01/authorization-ElevateAccessCalls.json
  - Microsoft.Authorization/stable/2015-07-01/authorization-RoleAssignmentsCalls.json
  - Microsoft.Authorization/stable/2015-07-01/authorization-ClassicAdminCalls.json
  - Microsoft.Authorization/preview/2015-06-01/authorization-ClassicAdminCalls.json
  - Microsoft.Authorization/preview/2017-10-01-preview/authorization-RoleAssignmentsCalls.json
  - Microsoft.Authorization/preview/2018-01-01-preview/authorization-ProviderOperationsCalls.json
  - Microsoft.Authorization/preview/2018-01-01-preview/authorization-RoleAssignmentsCalls.json
  - Microsoft.Authorization/preview/2018-01-01-preview/authorization-RoleDefinitionsCalls.json
  - Microsoft.Authorization/preview/2018-07-01-preview/authorization-DenyAssignmentGetCalls.json
  - Microsoft.Authorization/preview/2018-09-01-preview/authorization-RoleAssignmentsCalls.json

```