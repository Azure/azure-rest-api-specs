# ServiceFabric

> see https://aka.ms/autorest

This is the AutoRest configuration file for Service Fabric.



---
## Getting Started
To build the SDK for ServiceFabricManagementClient, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration



### Basic Information
These are the global settings for the ServiceFabricManagementClient API.

``` yaml
title: ServiceFabricManagementClient
description: Service Fabric Management Client
openapi-type: arm
tag: package-2020-03

directive:
  - suppress: ListInOperationName
    reason: Modifying the operation names would break the backwards compatibility of the API.
  - suppress: LongRunningResponseStatusCode
    reason: The validation tools do not properly recognize 202 as a supported response code.
  - suppress: SummaryAndDescriptionMustNotBeSame
    reason: There are a lot of APIs with missing summary content. While it is being worked on disabling this to ensure that we catch and fix other violations.
  - suppress: TrackedResourceListByImmediateParent
    reason: Proxy resources are not properly evaluated by the validation toolset.
  - suppress: DefinitionsPropertiesNamesCamelCase
    reason: Modifying the operation names would break the backwards compatibility of the API.
  - suppress: EnumInsteadOfBoolean
    reason: The boolean properties are actually boolean value in the Service Fabric's application model.
  - suppress: TrackedResourceGetOperation
    reason: Proxy resources are not properly evaluated by the validation toolset.
  - suppress: TrackedResourcePatchOperation
    reason: Proxy resources are not properly evaluated by the validation toolset.
  - suppress: TrackedResourceListByResourceGroup
    reason: Proxy resources are not properly evaluated by the validation toolset.
  - suppress: TrackedResourceListBySubscription
    reason: Proxy resources are not properly evaluated by the validation toolset.
  - suppress: DescriptionAndTitleMissing
    reason: There are a lot of APIs with missing titles. While it is being worked on disabling this to ensure that we catch and fix other violations.
  - suppress: Example Validations
    reason: There are open issues (bugs) in the validator affecting some of the examples and since there is no way to selectively disable the validation for a particular example or paths, all of the example validation is being turned off.
  - suppress: Example Validations
    reason: There are open issues (bugs) in the validator affecting some of the examples and since there is no way to selectively disable the validation for a particular example or paths, all of the example validation is being turned off.

```

### Tag: package-2020-03

These settings apply only when `--tag=package-2020-03` is specified on the command line.

``` yaml $(tag) == 'package-2020-03'
input-file:
- Microsoft.ServiceFabric/stable/2020-03-01/cluster.json
- Microsoft.ServiceFabric/stable/2020-03-01/application.json
- Microsoft.ServiceFabric/preview/2020-01-01-preview/managedcluster.json
- Microsoft.ServiceFabric/preview/2020-01-01-preview/nodetype.json
```

### Tag: package-2020-01-preview

These settings apply only when `--tag=package-2020-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2020-01-preview'
input-file:
- Microsoft.ServiceFabric/preview/2020-01-01-preview/managedcluster.json
- Microsoft.ServiceFabric/preview/2020-01-01-preview/nodetype.json
```

### Tag: package-2019-11-preview

These settings apply only when `--tag=package-2019-11-preview` is specified on the command line.

``` yaml $(tag) == 'package-2019-11-preview'
input-file:
- Microsoft.ServiceFabric/preview/2019-11-01-preview/cluster.json
- Microsoft.ServiceFabric/preview/2019-11-01-preview/application.json
```

### Tag: package-2019-06-preview

These settings apply only when `--tag=package-2019-06-preview` is specified on the command line.

``` yaml $(tag) == 'package-2019-06-preview'
input-file:
- Microsoft.ServiceFabric/preview/2019-06-01-preview/cluster.json
- Microsoft.ServiceFabric/preview/2019-06-01-preview/application.json
```

### Tag: package-2019-03

These settings apply only when `--tag=package-2019-03` is specified on the command line.

``` yaml $(tag) == 'package-2019-03'
input-file:
- Microsoft.ServiceFabric/stable/2019-03-01/cluster.json
- Microsoft.ServiceFabric/stable/2019-03-01/application.json
```

### Tag: package-2019-03-preview

These settings apply only when `--tag=package-2019-03-preview` is specified on the command line.

``` yaml $(tag) == 'package-2019-03-preview'
input-file:
- Microsoft.ServiceFabric/preview/2019-03-01-preview/cluster.json
- Microsoft.ServiceFabric/preview/2019-03-01-preview/application.json
```

### Tag: package-2018-02

These settings apply only when `--tag=package-2018-02` is specified on the command line.

``` yaml $(tag) == 'package-2018-02'
input-file:
- Microsoft.ServiceFabric/stable/2018-02-01/cluster.json
- Microsoft.ServiceFabric/preview/2017-07-01-preview/application.json
```

### Tag: package-2017-07

These settings apply only when `--tag=package-2017-07` is specified on the command line.

``` yaml $(tag) == 'package-2017-07'
input-file:
- Microsoft.ServiceFabric/preview/2017-07-01-preview/servicefabric.json
```

### Tag: package-2016-09

These settings apply only when `--tag=package-2016-09` is specified on the command line.

``` yaml $(tag) == 'package-2016-09'
input-file:
- Microsoft.ServiceFabric/stable/2016-09-01/servicefabric.json
```

### Tag: package-2018-02-only

These settings apply only when `--tag=package-2018-02-only` is specified on the command line.

``` yaml $(tag) == 'package-2018-02-only'
input-file:
- Microsoft.ServiceFabric/stable/2018-02-01/cluster.json
```

---
# Code Generation


## Swagger to SDK

This section describes what SDK should be generated by the automatic system.
This is not used by Autorest itself.

``` yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-net
  - repo: azure-sdk-for-python
  - repo: azure-sdk-for-java
  - repo: azure-sdk-for-go
  - repo: azure-sdk-for-node
  - repo: azure-sdk-for-ruby
    after_scripts:
      - bundle install && rake arm:regen_all_profiles['azure_mgmt_service_fabric']
  - repo: azure-resource-manager-schemas
    after_scripts:
      - node sdkauto_afterscript.js servicefabric/resource-manager
```


## C#

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

``` yaml $(csharp)
csharp:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: Microsoft.Azure.Management.ServiceFabric
  payload-flattening-threshold: 1
  output-folder: $(csharp-sdks-folder)/servicefabric/Microsoft.Azure.Management.ServiceFabric/src/Generated
  clear-output-folder: true
```


## Go

See configuration in [readme.go.md](./readme.go.md)

## Java

See configuration in [readme.java.md](./readme.java.md)

## AzureResourceSchema

See configuration in [readme.azureresourceschema.md](./readme.azureresourceschema.md)

## Multi-API/Profile support for AutoRest v3 generators 

AutoRest V3 generators require the use of `--tag=all-api-versions` to select api files.

This block is updated by an automatic script. Edits may be lost!

``` yaml $(tag) == 'all-api-versions' /* autogenerated */
# include the azure profile definitions from the standard location
require: $(this-folder)/../../../profiles/readme.md

# all the input files across all versions
input-file:
  - $(this-folder)/Microsoft.ServiceFabric/stable/2020-03-01/cluster.json
  - $(this-folder)/Microsoft.ServiceFabric/stable/2020-03-01/application.json
  - $(this-folder)/Microsoft.ServiceFabric/preview/2020-01-01-preview/managedcluster.json
  - $(this-folder)/Microsoft.ServiceFabric/preview/2020-01-01-preview/nodetype.json
  - $(this-folder)/Microsoft.ServiceFabric/preview/2019-11-01-preview/cluster.json
  - $(this-folder)/Microsoft.ServiceFabric/preview/2019-11-01-preview/application.json
  - $(this-folder)/Microsoft.ServiceFabric/preview/2019-06-01-preview/cluster.json
  - $(this-folder)/Microsoft.ServiceFabric/preview/2019-06-01-preview/application.json
  - $(this-folder)/Microsoft.ServiceFabric/stable/2019-03-01/cluster.json
  - $(this-folder)/Microsoft.ServiceFabric/stable/2019-03-01/application.json
  - $(this-folder)/Microsoft.ServiceFabric/preview/2019-03-01-preview/cluster.json
  - $(this-folder)/Microsoft.ServiceFabric/preview/2019-03-01-preview/application.json
  - $(this-folder)/Microsoft.ServiceFabric/stable/2018-02-01/cluster.json
  - $(this-folder)/Microsoft.ServiceFabric/preview/2017-07-01-preview/application.json
  - $(this-folder)/Microsoft.ServiceFabric/preview/2017-07-01-preview/servicefabric.json
  - $(this-folder)/Microsoft.ServiceFabric/stable/2016-09-01/servicefabric.json

```

If there are files that should not be in the `all-api-versions` set, 
uncomment the  `exclude-file` section below and add the file paths.

``` yaml $(tag) == 'all-api-versions'
#exclude-file: 
#  - $(this-folder)/Microsoft.Example/stable/2010-01-01/somefile.json
```

