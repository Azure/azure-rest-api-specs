# Storage

> see https://aka.ms/autorest

This is the AutoRest configuration file for Storage.



---
## Getting Started
To build the SDK for Storage, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration



### Basic Information
These are the global settings for the Storage API.

``` yaml
openapi-type: arm
tag: package-2019-06
```

### Tag: package-2019-06

These settings apply only when `--tag=package-2019-06` is specified on the command line.

``` yaml $(tag) == 'package-2019-06'
input-file:
- Microsoft.Storage/stable/2019-06-01/storage.json
- Microsoft.Storage/stable/2019-06-01/blob.json
- Microsoft.Storage/stable/2019-06-01/file.json
- Microsoft.Storage/stable/2019-06-01/queue.json
- Microsoft.Storage/stable/2019-06-01/table.json

directive:
  - suppress: R3018
    reason: Existing boolean properties
    approved-by: "@fearthecowboy"

  - where:
    - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Storage/storageAccounts/{accountName}/blobServices/default/containers/{containerName}/setLegalHold"].post.operationId
    - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Storage/storageAccounts/{accountName}/blobServices/default/containers/{containerName}/clearLegalHold"].post.operationId
    - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Storage/storageAccounts/{accountName}/regenerateKey"].post.operationId
    suppress: R1003
    reason: APIs return array of values, is not actually a 'list' operation
    approved-by: "@fearthecowboy"

```

### Tag: package-2019-04

These settings apply only when `--tag=package-2019-04` is specified on the command line.

``` yaml $(tag) == 'package-2019-04'
input-file:
- Microsoft.Storage/stable/2019-04-01/storage.json
- Microsoft.Storage/stable/2019-04-01/blob.json
- Microsoft.Storage/stable/2019-04-01/file.json

directive:
  - suppress: R3018
    reason: Existing boolean properties
    approved-by: "@fearthecowboy"

  - where:
    - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Storage/storageAccounts/{accountName}/blobServices/default/containers/{containerName}/setLegalHold"].post.operationId
    - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Storage/storageAccounts/{accountName}/blobServices/default/containers/{containerName}/clearLegalHold"].post.operationId
    - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Storage/storageAccounts/{accountName}/regenerateKey"].post.operationId
    suppress: R1003
    reason: APIs return array of values, is not actually a 'list' operation
    approved-by: "@fearthecowboy"

```

### Tag: package-2018-11

These settings apply only when `--tag=package-2018-11` is specified on the command line.

``` yaml $(tag) == 'package-2018-11'
input-file:
- Microsoft.Storage/stable/2018-11-01/storage.json
- Microsoft.Storage/stable/2018-11-01/blob.json

directive:
  - suppress: R3018
    reason: Existing boolean properties
    approved-by: "@fearthecowboy"

  - where:
    - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Storage/storageAccounts/{accountName}/blobServices/default/containers/{containerName}/setLegalHold"].post.operationId
    - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Storage/storageAccounts/{accountName}/blobServices/default/containers/{containerName}/clearLegalHold"].post.operationId
    - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Storage/storageAccounts/{accountName}/regenerateKey"].post.operationId
    suppress: R1003
    reason: APIs return array of values, is not actually a 'list' operation
    approved-by: "@fearthecowboy"

```

### Tag: package-2018-07

These settings apply only when `--tag=package-2018-07` is specified on the command line.

``` yaml $(tag) == 'package-2018-07'
input-file:
- Microsoft.Storage/stable/2018-07-01/storage.json
- Microsoft.Storage/stable/2018-07-01/blob.json
- Microsoft.Storage/preview/2018-03-01-preview/managementpolicy.json

directive:
  - suppress: R3018
    reason: Existing boolean properties
    approved-by: "@fearthecowboy"

  - where:
    - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Storage/storageAccounts/{accountName}/blobServices/default/containers/{containerName}/setLegalHold"].post.operationId
    - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Storage/storageAccounts/{accountName}/blobServices/default/containers/{containerName}/clearLegalHold"].post.operationId
    - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Storage/storageAccounts/{accountName}/regenerateKey"].post.operationId
    suppress: R1003
    reason: APIs return array of values, is not actually a 'list' operation
    approved-by: "@fearthecowboy"

```

### Tag: package-2018-07-only

These settings apply only when `--tag=package-2018-07-only` is specified on the command line.

``` yaml $(tag) == 'package-2018-07-only'
input-file:
- Microsoft.Storage/stable/2018-07-01/storage.json
- Microsoft.Storage/stable/2018-07-01/blob.json
```

### Tag: package-2018-03

These settings apply only when `--tag=package-2018-03` is specified on the command line.

``` yaml $(tag) == 'package-2018-03'
input-file:
- Microsoft.Storage/preview/2018-03-01-preview/storage.json
- Microsoft.Storage/preview/2018-03-01-preview/blob.json

directive:
  - suppress: R3018
    reason: Existing boolean properties
    approved-by: "@fearthecowboy"

  - where:
    - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Storage/storageAccounts/{accountName}/blobServices/default/containers/{containerName}/setLegalHold"].post.operationId
    - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Storage/storageAccounts/{accountName}/blobServices/default/containers/{containerName}/clearLegalHold"].post.operationId
    - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Storage/storageAccounts/{accountName}/regenerateKey"].post.operationId
    suppress: R1003
    reason: APIs return array of values, is not actually a 'list' operation
    approved-by: "@fearthecowboy"

```

### Tag: package-2018-02

These settings apply only when `--tag=package-2018-02` is specified on the command line.

``` yaml $(tag) == 'package-2018-02'
input-file:
- Microsoft.Storage/stable/2018-02-01/storage.json
- Microsoft.Storage/stable/2018-02-01/blob.json

directive:
  - suppress: R3018
    reason: Existing boolean properties
    approved-by: "@fearthecowboy"

  - where:
    - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Storage/storageAccounts/{accountName}/blobServices/default/containers/{containerName}/setLegalHold"].post.operationId
    - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Storage/storageAccounts/{accountName}/blobServices/default/containers/{containerName}/clearLegalHold"].post.operationId
    - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Storage/storageAccounts/{accountName}/regenerateKey"].post.operationId
    suppress: R1003
    reason: APIs return array of values, is not actually a 'list' operation
    approved-by: "@fearthecowboy"

```

### Tag: package-2017-10

These settings apply only when `--tag=package-2017-10` is specified on the command line.

``` yaml $(tag) == 'package-2017-10'
input-file:
- Microsoft.Storage/stable/2017-10-01/storage.json
```

### Tag: package-2017-06

These settings apply only when `--tag=package-2017-06` is specified on the command line.

``` yaml $(tag) == 'package-2017-06'
input-file:
- Microsoft.Storage/stable/2017-06-01/storage.json
```


### Tag: package-2016-12

These settings apply only when `--tag=package-2016-12` is specified on the command line.

``` yaml $(tag) == 'package-2016-12'
input-file:
- Microsoft.Storage/stable/2016-12-01/storage.json
```

### Tag: package-2016-05

These settings apply only when `--tag=package-2016-05` is specified on the command line.

``` yaml $(tag) == 'package-2016-05'
input-file:
- Microsoft.Storage/stable/2016-05-01/storage.json
```

### Tag: package-2016-01

These settings apply only when `--tag=package-2016-01` is specified on the command line.

``` yaml $(tag) == 'package-2016-01'
input-file:
- Microsoft.Storage/stable/2016-01-01/storage.json
```

### Tag: package-2015-06

These settings apply only when `--tag=package-2015-06` is specified on the command line.

``` yaml $(tag) == 'package-2015-06'
input-file:
- Microsoft.Storage/stable/2015-06-15/storage.json
```

### Tag: package-2015-05-preview

These settings apply only when `--tag=package-2015-05-preview` is specified on the command line.

``` yaml $(tag) == 'package-2015-05-preview'
input-file:
- Microsoft.Storage/preview/2015-05-01-preview/storage.json
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
    autorest_options:
      use: "@microsoft.azure/autorest.python@4.0.70"
    after_scripts:
      - python ./scripts/multiapi_init_gen.py azure-mgmt-storage
      - python ./scripts/trim_aio.py ./sdk/storage/azure-mgmt-storage
  - repo: azure-sdk-for-python-track2
  - repo: azure-sdk-for-java
  - repo: azure-sdk-for-go
  - repo: azure-sdk-for-node
  - repo: azure-sdk-for-js
  - repo: azure-sdk-for-ruby
    after_scripts:
      - bundle install && rake arm:regen_all_profiles['azure_mgmt_storage']
  - repo: azure-resource-manager-schemas
    after_scripts:
      - node sdkauto_afterscript.js storage/resource-manager
```

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
  - $(this-folder)/Microsoft.Storage/stable/2019-06-01/storage.json
  - $(this-folder)/Microsoft.Storage/stable/2019-06-01/blob.json
  - $(this-folder)/Microsoft.Storage/stable/2019-06-01/file.json
  - $(this-folder)/Microsoft.Storage/stable/2019-06-01/queue.json
  - $(this-folder)/Microsoft.Storage/stable/2019-06-01/table.json
  - $(this-folder)/Microsoft.Storage/stable/2019-04-01/storage.json
  - $(this-folder)/Microsoft.Storage/stable/2019-04-01/blob.json
  - $(this-folder)/Microsoft.Storage/stable/2019-04-01/file.json
  - $(this-folder)/Microsoft.Storage/stable/2018-11-01/storage.json
  - $(this-folder)/Microsoft.Storage/stable/2018-11-01/blob.json
  - $(this-folder)/Microsoft.Storage/stable/2018-07-01/storage.json
  - $(this-folder)/Microsoft.Storage/stable/2018-07-01/blob.json
  - $(this-folder)/Microsoft.Storage/preview/2018-03-01-preview/managementpolicy.json
  - $(this-folder)/Microsoft.Storage/preview/2018-03-01-preview/storage.json
  - $(this-folder)/Microsoft.Storage/preview/2018-03-01-preview/blob.json
  - $(this-folder)/Microsoft.Storage/stable/2018-02-01/storage.json
  - $(this-folder)/Microsoft.Storage/stable/2018-02-01/blob.json
  - $(this-folder)/Microsoft.Storage/stable/2017-10-01/storage.json
  - $(this-folder)/Microsoft.Storage/stable/2017-06-01/storage.json
  - $(this-folder)/Microsoft.Storage/stable/2016-12-01/storage.json
  - $(this-folder)/Microsoft.Storage/stable/2016-05-01/storage.json
  - $(this-folder)/Microsoft.Storage/stable/2016-01-01/storage.json
  - $(this-folder)/Microsoft.Storage/stable/2015-06-15/storage.json
  - $(this-folder)/Microsoft.Storage/preview/2015-05-01-preview/storage.json

```

If there are files that should not be in the `all-api-versions` set, 
uncomment the  `exclude-file` section below and add the file paths.

``` yaml $(tag) == 'all-api-versions'
#exclude-file: 
#  - $(this-folder)/Microsoft.Example/stable/2010-01-01/somefile.json
```

