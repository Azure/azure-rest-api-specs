## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go) && !$(track2)
go:
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: authorization
  clear-output-folder: true
```

``` yaml $(go) && $(track2)
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/resourcemanager/authorization/armauthorization
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
azure-arm: true
directive:
  - from: authorization-RoleAssignmentsCalls.json
    where: $.definitions
    transform: |
      $["RoleAssignmentPropertiesWithScope"] = {
        "allOf": [
          {
            "$ref": "#/definitions/RoleAssignmentProperties"
          }
        ]
      }
  - from: authorization-RoleAssignmentsCalls.json
    where: $.definitions.RoleAssignment.properties
    transform: |
      $["properties"] = {
        "$ref": "#/definitions/RoleAssignmentPropertiesWithScope",
        "description": "Role assignment properties."
      }
  - rename-operation:
      from: RoleAssignments_ListForSubscription
      to: RoleAssignments_List
  - from: authorization-RoleAssignmentsCalls.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}/providers/Microsoft.Authorization/roleAssignments"].get.parameters
    transform: >-
      $.splice(3,0,{
        "name": "parentResourcePath",
        "in": "path",
        "required": true,
        "type": "string",
        "description": "The parent resource identity.",
        "x-ms-skip-url-encoding": true
      });
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-2015-07-01
  - tag: package-2017-10-01-preview
  - tag: package-2018-01-01-preview
  - tag: package-2018-07-01-preview
  - tag: package-2018-09-01-preview
  - tag: package-2020-04-01-preview
  - tag: package-2020-10-01-preview
  - tag: package-2020-10-01
```

### Tag: package-2015-07-01 and go

These settings apply only when `--tag=package-2015-07-01 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2015-07-01' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2015-07-01/$(namespace)
```

### Tag: package-2017-10-01-preview and go

These settings apply only when `--tag=package-2017-10-01-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2017-10-01-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2017-10-01-preview/$(namespace)
```

### Tag: package-2018-01-01-preview and go

These settings apply only when `--tag=package-2018-01-01-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2018-01-01-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2018-01-01-preview/$(namespace)
```

### Tag: package-2018-07-01-preview and go

These settings apply only when `--tag=package-2018-07-01-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2018-07-01-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2018-07-01-preview/$(namespace)
```

### Tag: package-2018-09-01-preview and go

These settings apply only when `--tag=package-2018-09-01-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2018-09-01-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2018-09-01-preview/$(namespace)
```

### Tag: package-2020-04-01-preview and go

These settings apply only when `--tag=package-2020-04-01-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2020-04-01-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2020-04-01-preview/$(namespace)
```

### Tag: package-2020-10-01-preview and go

These settings apply only when `--tag=package-2020-10-01-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2020-10-01-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2020-10-01-preview/$(namespace)
```

### Tag: package-2020-10-01 and go

These settings apply only when `--tag=package-2020-10-01 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2020-10-01' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2020-10-01/$(namespace)
```
