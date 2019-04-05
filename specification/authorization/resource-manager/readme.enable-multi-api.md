# Multi-API support for AutoRest v3 generators

> see https://aka.ms/autorest

``` yaml $(enable-multi-api)
input-file:
  - $(this-folder)/Microsoft.Authorization/stable/2015-07-01/authorization.json
  - $(this-folder)/Microsoft.Authorization/stable/2015-07-01/authorization-ClassicAdminCalls.json
  - $(this-folder)/Microsoft.Authorization/preview/2015-06-01/authorization-ClassicAdminCalls.json
  - $(this-folder)/Microsoft.Authorization/preview/2015-07-01/authorization.json
  - $(this-folder)/Microsoft.Authorization/preview/2017-10-01-preview/authorization-RACalls.json
  - $(this-folder)/Microsoft.Authorization/preview/2018-01-01-preview/authorization-ProviderOperationsCalls.json
  - $(this-folder)/Microsoft.Authorization/preview/2018-01-01-preview/authorization-RoleAssignmentsCalls.json
  - $(this-folder)/Microsoft.Authorization/preview/2018-01-01-preview/authorization-RoleDefinitionsCalls.json
  - $(this-folder)/Microsoft.Authorization/preview/2018-07-01-preview/authorization-DenyAssignmentGetCalls.json
  - $(this-folder)/Microsoft.Authorization/preview/2018-09-01-preview/authorization-RoleAssignmentsCalls.json
require: $(this-folder)/../../../../profiles/readme.md
```
