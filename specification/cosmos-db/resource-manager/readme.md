# Cosmos-DB
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for Cosmos-DB.



---
## Getting Started 
To build the SDK for Cosmos-DB, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration



### Basic Information 
These are the global settings for the Cosmos-DB API.

``` yaml
openapi-type: arm
tag: package-2015-04
```


### Tag: package-2015-04

These settings apply only when `--tag=package-2015-04` is specified on the command line.

``` yaml $(tag) == 'package-2015-04'
input-file:
- Microsoft.DocumentDB/2015-04-08/cosmos-db.json
```


---
# Code Generation

## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.
Use `--python-mode=update` if you already have a setup.py and just want to update the code itself.

``` yaml $(python)
python-mode: create
python:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  payload-flattening-threshold: 2
  namespace: azure.mgmt.cosmosdb
  package-name: azure-mgmt-cosmosdb
  clear-output-folder: true
```
``` yaml $(python) && $(python-mode) == 'update'
python:
  no-namespace-folders: true
  output-folder: $(python-sdks-folder)/azure-mgmt-cosmosdb/azure/mgmt/cosmosdb
```
``` yaml $(python) && $(python-mode) == 'create'
python:
  basic-setup-py: true
  output-folder: $(python-sdks-folder)/azure-mgmt-cosmosdb
```

## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  namespace: documentdb
  clear-output-folder: true
```

### Tag: package-2015-04 and go

These settings apply only when `--tag=package-2015-04 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2015-04' && $(go)
output-folder: $(go-sdk-folder)/services/cosmos-db/mgmt/2015-04-08/documentdb
```
