# GraphRbac
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for GraphRbac.



---
## Getting Started 
To build the SDK for GraphRbac, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration



### Basic Information 
These are the global settings for the GraphRbac API.

``` yaml
openapi-type: data-plane
tag: 1.6
```


### Tag: 1.6

These settings apply only when `--tag=1.6` is specified on the command line.

``` yaml $(tag) == '1.6'
input-file:
- 1.6/graphrbac.json
```

---
# Code Generation


## C#

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

```yaml $(csharp)
csharp:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: Microsoft.Azure.Graph.RBAC
  output-folder: $(csharp-sdks-folder)/Graph.RBAC/Graph.RBAC/Generated
  clear-output-folder: true
```


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
  namespace: azure.graphrbac
  package-name: azure-graphrbac
  clear-output-folder: true
```
``` yaml $(python) && $(python-mode) == 'update'
python:
  no-namespace-folders: true
  output-folder: $(python-sdks-folder)/azure-graphrbac/azure/graphrbac
```
``` yaml $(python) && $(python-mode) == 'create'
python:
  basic-setup-py: true
  output-folder: $(python-sdks-folder)/azure-graphrbac
```


## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  namespace: graphrbac
  clear-output-folder: true
```

### Tag: 1.6 and go

These settings apply only when `--tag=1.6 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == '1.6' && $(go)
output-folder: $(go-sdk-folder)/services/graphrbac/1.6/graphrbac
```


## Python

These settings apply only when `--python` is specified on the command line.

``` yaml $(python)
python:
  # override the default output folder
  output-folder: $(output-folder)/python
  license-header: MICROSOFT_MIT_NO_VERSION
  payload-flattening-threshold: 2
  namespace: azure.graphrbac
```
