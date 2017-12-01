# Managed Service Identity
> see https://aka.ms/autorest

This is the AutoRest configuration file for Managed Service Identity.

---
## Getting Started
To build the SDK for Managed Service Identity, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration


### Basic Information
These are the global settings for the Managed Service Identity API.

``` yaml
openapi-type: arm
tag: package-2015-08-31-preview
```


### Tag: package-2015-08-31-preview

These settings apply only when `--tag=package-2015-08-31-preview` is specified on the command line.

``` yaml $(tag) == 'package-2015-08-31-preview'
input-file:
- Microsoft.ManagedIdentity/2015-08-31-preview/ManagedIdentity.json
```

---
# Code Generation


## C#

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

``` yaml $(csharp)
csharp:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: Microsoft.Azure.Management.ManagedServiceIdentity
  output-folder: $(csharp-sdks-folder)/ManagedServiceIdentity/Management.ManagedServiceIdentity/Generated
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
  namespace: azure.mgmt.msi
  package-name: azure-mgmt-msi
  clear-output-folder: true
```
``` yaml $(python) && $(python-mode) == 'update'
python:
  no-namespace-folders: true
  output-folder: $(python-sdks-folder)/azure-mgmt-msi/azure/mgmt/msi
```
``` yaml $(python) && $(python-mode) == 'create'
python:
  basic-setup-py: true
  output-folder: $(python-sdks-folder)/azure-mgmt-msi
```