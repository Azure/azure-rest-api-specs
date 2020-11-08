## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-authorization-2020-04-01-preview
  - tag: schema-authorization-2018-09-01-preview
  - tag: schema-authorization-2018-07-01-preview
  - tag: schema-authorization-2018-01-01-preview
  - tag: schema-authorization-2017-10-01-preview
  - tag: schema-authorization-2015-07-01
  - tag: schema-authorization-2015-06-01

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-authorization-2020-04-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-authorization-2020-04-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Authorization/preview/2020-04-01-preview/authorization-RoleAssignmentsCalls.json

```

### Tag: schema-authorization-2018-09-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-authorization-2018-09-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Authorization/preview/2018-09-01-preview/authorization-RoleAssignmentsCalls.json

```

### Tag: schema-authorization-2018-07-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-authorization-2018-07-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Authorization/preview/2018-07-01-preview/authorization-DenyAssignmentGetCalls.json

```

### Tag: schema-authorization-2018-01-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-authorization-2018-01-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Authorization/preview/2018-01-01-preview/authorization-ProviderOperationsCalls.json
  - Microsoft.Authorization/preview/2018-01-01-preview/authorization-RoleAssignmentsCalls.json
  - Microsoft.Authorization/preview/2018-01-01-preview/authorization-RoleDefinitionsCalls.json

```

### Tag: schema-authorization-2017-10-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-authorization-2017-10-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Authorization/preview/2017-10-01-preview/authorization-RoleAssignmentsCalls.json

```

### Tag: schema-authorization-2015-07-01 and azureresourceschema

``` yaml $(tag) == 'schema-authorization-2015-07-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Authorization/stable/2015-07-01/authorization-RoleDefinitionsCalls.json
  - Microsoft.Authorization/stable/2015-07-01/authorization-ProviderOperationsCalls.json
  - Microsoft.Authorization/stable/2015-07-01/authorization-ElevateAccessCalls.json
  - Microsoft.Authorization/stable/2015-07-01/authorization-RoleAssignmentsCalls.json
  - Microsoft.Authorization/stable/2015-07-01/authorization-ClassicAdminCalls.json

```

### Tag: schema-authorization-2015-06-01 and azureresourceschema

``` yaml $(tag) == 'schema-authorization-2015-06-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Authorization/preview/2015-06-01/authorization-ClassicAdminCalls.json

```
